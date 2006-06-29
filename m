Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWF2D0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWF2D0y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 23:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWF2D0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 23:26:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59531 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750980AbWF2D0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 23:26:52 -0400
Date: Wed, 28 Jun 2006 20:17:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: eranian@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       perfmon@napali.hpl.hp.com
Subject: Re: perfmon2 vector argument question
Message-Id: <20060628201708.08af034c.akpm@osdl.org>
In-Reply-To: <20060619204012.GE26378@frankl.hpl.hp.com>
References: <20060619204012.GE26378@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 13:40:12 -0700
Stephane Eranian <eranian@hpl.hp.com> wrote:

> Hello,
> 
> The current perfmon2 API allows applications to pass vectors of arguments to
> certain calls, in particular to the 3 functions to read/write PMU registers. 
> This approach was chosen because it is very flexible and allows applications
> to modify either multiple or a single register in one call. It is extensible
> because there is no implicit knowledge of the actual number of registers supported
> by the underlying hardware.
> 
> Before entering the actual system call, the argument vector must be copied
> into a kernel buffer. This is required by convention for security and also
> fault reasons. The famous copy_from_user() and copy_to_user() are invoked.
> This must be done before interrupts are masked.
> 
> Vectors can have different sizes depending on the measurement, the PMU model.
> Yet, the vector must be copied into a kernel-level buffer. Today, we allocate
> the kernel-memory on demand based on the size of the vector. We use
> kmalloc/kfree. Of course, to avoid any abuse, we limit the size of the
> allocated region via a perfmon2 tunable in sysfs. By default, it is set
> to a page.
> 
> This implementation has worked fairly well, yet it costs some performance
> because kmalloc/kfree are expensive (especially kfree). Also it may seem
> overkill to malloc a page for small vectors.
> 
> I have run some experiments lately and they verified that kmalloc/kfree and
> copy to/from user account for a very large portion of the cost of calls with
> multiple registers (I tried with 4). For the copies it is hard to avoid
> them. One thing we could do is to try and reduce the size of the structs.
> Today, both struct pfarg_pmd and struct pfarg_pmc have reserved fields
> for future extensions so that we can extend without breaking the ABI.
> It may be possible to reduce those a little bit.
> 
> There are several ways to amortize or eliminate the kmalloc/kfree. First of
> all, it is important to understand that multiple threads may call into a 
> particular context at any time. All they need is access to the file descriptor.
> 
> An alternative that I have explored is to start from the hypothesis that
> most vectors are small. If they are small enough, we could avoid the
> kmalloc/kfree by using a buffer allocated on the stack. One could say
> if the vector is less than 8 elements, then use the stack buffer. If not, then
> go down the expensive path of kmalloc/kfree. I tried this experiment and got
> over 20% improvement for pfm_read_pmds(). I chose 8 as the threshold. The
> downside of this approach is that kernel stack space is limited and we should
> avoid allocating large buffers on it. The pfarg_pmd struct is about 176 bytes
> whereas pfarg_pmc_t is about 48 bytes. With 8 elements we reach 1408 bytes and
> this is true for all architectures including i386 where default kernel stack
> is 2 pages (8kB). Of course, the stack buffer could be adjusted per object
> type and per-architecture. The downside is that if you need to use kmalloc
> the stack space is still consumed.
> 
> It is important to note that we cannot use a kernel buffer of one element and simply
> loop over the vector. Because the copy_from/copy_to must be done without locks nor
> interrupt masked. So one  would have to copy, lock, do the perfmon call, unlock, copy
> and loop for the next element.
> 
> Another approach that was suggested to me is to allocate on demand but not kfree
> systematically when the call terminates. In other words, we amortize the cost
> of the allocation by keeping the buffer around for the next caller. To make
> this work, we would have to decompose the spin_lock_irq*() into spin_*lock()
> and local_irq_*able() to avoid a race condition. For the first caller the
> buffer would be allocated to fit the size (up to a certain limit like today).
> When the call terminates, the buffer is kept via a pointer in the perfmon
> context. The next caller, would check the pointer and size, if the buffer
> is big enough, copy_user could proceed directly, otherwise a new buffer would
> be allocated. That would also work assuming it is OKAY to copy_user with some locks
> held. I can see one issue with this approach as some malicious user could create
> lots of contexts and make one call for each to max out the argument vector limit for
> each. If you have 1024 descriptors and the limit is 1 page/context, it could allocate
> 1024 kernel pages (non-pageable) for nothing. Today, we do not have a global tuneable
> for the argument vector size limit. Adding one would be costly because multiple threads
> could potentially contend for it and therefore we would need yet another lock.
> 
> I do not see another approach at this point.
> 
> Does someone have something else to propose?
> 
> If not, what is your opinion of the two approaches above?
> 

The first approach should be fine - we do that in lots of places, such as
in core_sys_select().

Applications mut be calling this thing at a heck of a rate for kfree()
overhead to matter.  I trust CONFIG_DEBUG_SLAB wasn't turned on...
