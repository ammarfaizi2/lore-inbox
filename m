Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUEQSI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUEQSI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 14:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbUEQSI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 14:08:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:1243 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262006AbUEQSI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 14:08:26 -0400
Date: Mon, 17 May 2004 11:07:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       agl@us.ibm.com, david@gibson.dropbear.id.au, mbligh@aracnet.com
Subject: Re: do_page_fault() mm->mmap_sem deadlocks
Message-Id: <20040517110745.18a32b73.akpm@osdl.org>
In-Reply-To: <247360000.1084809527@[192.168.100.2]>
References: <247360000.1084809527@[192.168.100.2]>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> Whilst trying to debug a bug in PPC64 unmap handling we noticed that it is
> relatively easy for a kernel bug to lead to a deadlock trying to
> down(mm->mmap_sem) when trying to categorise a fault for handling.  The
> fault handlers grab the mmap_sem lock to scan the VMA list to see if this
> fault is against a valid segment of the task address space.  This deadlocks
> if this task is in a system call which also manipulates the virtual
> address, such as munmap().  This is very undesirable as it prevents the
> kernel from detecting the fault and reporting it as an oops severely
> hampering debug.

Yes.  The "oops deadlocks when mmap_sem is held" problem is rather
irritating, and would be nice to fix.

> Most kernel code should not access any area which leads to a fault.  Indeed
> the only code which should trigger faults from kernel space are routines
> dealing with copying data to and from user space.

And vmalloc faults on x86: we fault in those 4k pte's on-demand.  Your
patch seems to cover that OK.

>  Fault originating
> outside of these specific routines are not valid and could be 'failed'
> without the need to reference current->mm, thereby preventing deadlock and
> ensuring the failure is reported.

Think so.


> ...
> I have assumed that faults triggered by kernel space are going
> to be rare relative to user space as most pointers will have been recently
> referenced by the calling application, but this search is of concern for
> performance.

These kernel-mode faults are by no means uncommon - probably the most
frequent scenario is:

	p = malloc(...);
	read(fd, p, n);

Here, generic_file_read() will take a copy_to_user() fault for each page to
COW it.

Which makes one wonder why we aren't caching the result of the previous
exception table search.  I bet that would get a nice hit rate, and would
fix up any overhead which your change introduces.

> 
> Do people think this is something which is worth pursuing.

I do.

>  The patches
> attached are minimal and there are definatly optimisations to be made (such
> as sharing the result of the exception lookup).  I guess this might even be
> something which is worth having as a config option for when hangs is there
> is deemed to be any degradation?  If people think this is something worth
> looking at I'll come back with cleaner, better tested and benchmarked
> patches.

Please.  Also please consider (and instrument) a last-hit cache in
search_exception_tables().  Maybe it should be per-task.
