Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUDHDZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 23:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUDHDZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 23:25:35 -0400
Received: from ozlabs.org ([203.10.76.45]:31976 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261498AbUDHDZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 23:25:29 -0400
Date: Thu, 8 Apr 2004 13:22:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       PPC64 External List <linuxppc64-dev@lists.linuxppc.org>
Subject: Re: RFC: COW for hugepages
Message-ID: <20040408032227.GB29551@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
	PPC64 External List <linuxppc64-dev@lists.linuxppc.org>
References: <20040407074239.GG18264@zax> <1081351270.9207.3551.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081351270.9207.3551.camel@nighthawk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 08:21:11AM -0700, Dave Hansen wrote:
> On Wed, 2004-04-07 at 00:42, David Gibson wrote:
> > +	/* XXX are there races with checking cpu_vm_mask? - Anton */
> > +	tmp = cpumask_of_cpu(smp_processor_id());
> > +	if (cpus_equal(vma->vm_mm->cpu_vm_mask, tmp))
> > +		local = 1;
> > +
> > +	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
> 
> You're under the pagetable lock for that mm, so you at least don't have
> to worry about preemption.  But, that definitely at least deserves a
> comment on why you didn't disable preemption.
> 
> Also, for racing with other users of cpu_vm_mask, there aren't any other
> users that clear other cpus' bits other than initialization.  

Yes.  That comment was actually copied from code in the analagous
normal page path (from where it has since been removed).  I've altered
it appropriately.

> One thing that's I didn't see in this patch is any check of capabilities
> or permissions.  What if a privileged user sets up a single page huge
> page, then does a setuid() to a lower privilege level?  Is that not a
> valid way to get hugetlb pages to an unprivileged user?  That other user
> is free to go fork and write to the pages to their heart's content,
> consuming as many huge pages as are present in the system.

That seems to me like a "don't do that" situation (you can avoid the
security problem by only giving MAP_SHARED pages to the unprivileged
process).  I don't see a better way to solve this without implementing
some sort of rlimit system for hugepages, which seems like overkill:
As far as I can tell all the real applications (huge databases, HPC,
benchmarks) for hugepages tend to be the sorts of cases where the
hugepage-using program is the only thing you really care about on the
system .

> It looks to me like dup_mmap() drops VM_LOCKED on mlock()'d VMAs at fork
> time.  Do we need to do the same for hugetlb pages?  

Given that all huge pages are unswappable and therefore effectively
mlock()ed, I don't think so.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
