Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVAUHFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVAUHFS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVAUHFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:05:18 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:62298
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262291AbVAUHEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:04:30 -0500
Date: Fri, 21 Jan 2005 08:04:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: OOM fixes 2/5
Message-ID: <20050121070429.GE17050@dualathlon.random>
References: <20050121054840.GA12647@dualathlon.random> <20050121054916.GB12647@dualathlon.random> <20050120222056.61b8b1c3.akpm@osdl.org> <1106289375.5171.7.camel@npiggin-nld.site> <20050120224645.3351d22c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120224645.3351d22c.akpm@osdl.org>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 10:46:45PM -0800, Andrew Morton wrote:
> Thus empirically, it appears that the number of machines which need a
> non-zero protection ratio is exceedingly small.  Why change the setting on
> all machines for the benefit of the tiny few?  Seems weird.  Especially
> when this problem could be solved with a few-line initscript.  Ho hum.

It's up to you, IMHO you're doing a mistake, but I don't mind as long as our
customers aren't at risk of early oom kills (or worse kernel crashes)
with some db load (especially without swap the risk is huge for all
users, since all anonymous memory will be pinned like ptes, but with ~3G
of pagetables they're at risk even with swap).  At least you *must*
admit that without my patch applied as I posted, there's a >0 probabity
of running out of normal zone which will lead to an oom-kill or a
deadlock despite 10G of highmem might still be freeeable (like with
clean cache). And my patch obviously cannot make it impossible to run
out of normal zone, since there's only 800m of normal zone and one can
open more files than what fits in normal zone, but at least it gives the
user the security that a certain workload can run reliably. Without this
patch there's no guarantee at all that any workload will run when >1G of
ptes is allocated.

This below fix as well is needed and you won't find reports of people
reproducing this race condition. Please apply. CC'ed Hugh. Sorry Hugh, I
know you were working on it (you said not in the weekend IIRC), but I've
been upgraded to latest bk so I had to fixup quickly or I would have to
run the racy code on my smp systems to test new kernels.

From: Andrea Arcangeli <andrea@suse.de>
Subject: fixup smp race introduced in 2.6.11-rc1

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- x/mm/memory.c.~1~	2005-01-21 06:58:14.747335048 +0100
+++ x/mm/memory.c	2005-01-21 07:16:15.318063328 +0100
@@ -1555,8 +1555,17 @@ void unmap_mapping_range(struct address_
 
 	spin_lock(&mapping->i_mmap_lock);
 
+	/* serialize i_size write against truncate_count write */
+	smp_wmb(); 
 	/* Protect against page faults, and endless unmapping loops */
 	mapping->truncate_count++;
+	/*
+	 * For archs where spin_lock has inclusive semantics like ia64
+	 * this smp_mb() will prevent to read pagetable contents
+	 * before the truncate_count increment is visible to
+	 * other cpus.
+	 */
+	smp_mb();
 	if (unlikely(is_restart_addr(mapping->truncate_count))) {
 		if (mapping->truncate_count == 0)
 			reset_vma_truncate_counts(mapping);
@@ -1864,10 +1873,18 @@ do_no_page(struct mm_struct *mm, struct 
 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
 		sequence = mapping->truncate_count;
+		smp_rmb(); /* serializes i_size against truncate_count */
 	}
 retry:
 	cond_resched();
 	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, &ret);
+	/*
+	 * No smp_rmb is needed here as long as there's a full
+	 * spin_lock/unlock sequence inside the ->nopage callback
+	 * (for the pagecache lookup) that acts as an implicit
+	 * smp_mb() and prevents the i_size read to happen
+	 * after the next truncate_count read.
+	 */
 
 	/* no page was available -- either SIGBUS or OOM */
 	if (new_page == NOPAGE_SIGBUS)

