Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUDGPWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 11:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUDGPWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 11:22:39 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:38881 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263720AbUDGPWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 11:22:18 -0400
Subject: Re: RFC: COW for hugepages
From: Dave Hansen <haveblue@us.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       PPC64 External List <linuxppc64-dev@lists.linuxppc.org>
In-Reply-To: <20040407074239.GG18264@zax>
References: <20040407074239.GG18264@zax>
Content-Type: text/plain
Message-Id: <1081351270.9207.3551.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Apr 2004 08:21:11 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-07 at 00:42, David Gibson wrote:
> +	/* XXX are there races with checking cpu_vm_mask? - Anton */
> +	tmp = cpumask_of_cpu(smp_processor_id());
> +	if (cpus_equal(vma->vm_mm->cpu_vm_mask, tmp))
> +		local = 1;
> +
> +	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;

You're under the pagetable lock for that mm, so you at least don't have
to worry about preemption.  But, that definitely at least deserves a
comment on why you didn't disable preemption.

Also, for racing with other users of cpu_vm_mask, there aren't any other
users that clear other cpus' bits other than initialization.  

One thing that's I didn't see in this patch is any check of capabilities
or permissions.  What if a privileged user sets up a single page huge
page, then does a setuid() to a lower privilege level?  Is that not a
valid way to get hugetlb pages to an unprivileged user?  That other user
is free to go fork and write to the pages to their heart's content,
consuming as many huge pages as are present in the system.

It looks to me like dup_mmap() drops VM_LOCKED on mlock()'d VMAs at fork
time.  Do we need to do the same for hugetlb pages?  

-- Dave

