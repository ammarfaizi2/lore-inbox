Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264288AbUDWC1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbUDWC1f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 22:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264656AbUDWC1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 22:27:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:43484
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264288AbUDWC12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 22:27:28 -0400
Date: Fri, 23 Apr 2004 04:27:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Alexander Y. Fomichev" <gluk@php4.ru>
Cc: admin@list.net.ru, linux-kernel@vger.kernel.org
Subject: Re: Similar behaviour without BUG() message(was: Re: 2.6.5-aa3: kernel BUG at mm/objrmap.c:137!)
Message-ID: <20040423022732.GU29954@dualathlon.random>
References: <200404141257.16731.gluk@php4.ru> <200404141539.49757.gluk@php4.ru> <20040414114731.GJ2150@dualathlon.random> <200404191632.53565.gluk@php4.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404191632.53565.gluk@php4.ru>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 04:32:53PM +0400, Alexander Y. Fomichev wrote:
> On Wednesday 14 April 2004 15:47, Andrea Arcangeli wrote:
> > ok so there are good chances that 2.6.5-aa5 will fix it, if not then
> > please notify me again, thanks.
> 
>   I've noticed a behaviour today very similar to mentioned in previous report
>   (on 14   Apr 2004) except for message from BUG() (kernel 2.6.5-aa5) i.e.
>   system remained accessible but procps(ps,pkill) appears to be locked and
>   Sysrq-T is similar to previous one - some of apache2 & all of procps 
>   have been blocked.
> 
>   Here is a traces:
>   
>   http://sysadminday.org.ru/2.6.5-ps-lockup/sysrq-M
>   http://sysadminday.org.ru/2.6.5-ps-lockup/full_trace

following your trace I got to some futex issue (likely invoked by NPTL),
and following the futex code I noticed a race with threads in
expand_stack and likely the futex is effectively calling expand_stack
too. Then I found a race in expand_stack with threads.

here the details:

in 2.6-aa expand_stack is moving down vm_start and vm_end with only the
read semaphore held. this means this thing can even run in parallel in
both cpus, the latter will corrupt vm_pgoff which generate malfunction
with anon-vma:

        vma->vm_start = address;
        vma->vm_pgoff -= grow;

this isn't an issue for the file mappings because only anon vmas can be
growsdown (the filemappings could never work right in filemap_nopage if
expand_stack would mess with pgoff and vm_start without holding the
mmap_sem in write mode).

serializing this with anon-vma is easy and scalable with the
anon_vma_lock (not an mm-wide lock like the page_table_lock).
This will also serialize perfectly with the objrmap. objrmap should be
the only thing that cares about vm_pgoff and vm_start being coherent at
the same time for anon-mappings in anon-vma, and the anon_vma_lock
provides perfect locking for that.

One of the scalability and simplicity locking beauty of anon-vma is the
total avoidance of page_table_lock for vma merging and all other vma
operations in general, and true usage of page_table_lock only for the
pagetables (and future usage of vma->page_table_lock only for pagetables
too). I wouldn't really like to giveup on this and to reintroduce the
whole mess of page_table_lock in the vma merging and in expand stack
that all other implementations like 2.6 mainline and anonmm are
suffering from, and I hope my fix will be enough. Could you test if this
patch helps?

(there was also an ancient page_table_lock in split_vma, I forgot to
delete that previously)

--- 2.6.5-aa3/mm/mmap.c.~1~	2004-04-14 11:51:33.000000000 +0200
+++ 2.6.5-aa3/mm/mmap.c	2004-04-23 04:04:31.258066752 +0200
@@ -977,6 +977,15 @@ int expand_stack(struct vm_area_struct *
 		return -EFAULT;
 
 	/*
+	 * We must make sure the anon-vma is allocated
+	 * to make sure the anon-vma locking is not a noop.
+	 */
+	if (unlikely(anon_vma_prepare(vma)))
+		return -ENOMEM;
+
+	anon_vma_lock(vma);
+
+	/*
 	 * vma->vm_start/vm_end cannot change under us because the caller
 	 * is required to hold the mmap_sem in read mode. We need to get
 	 * the spinlock only before relocating the vma range ourself.
@@ -986,13 +995,15 @@ int expand_stack(struct vm_area_struct *
 	grow = (address - vma->vm_end) >> PAGE_SHIFT;
 
 	/* Overcommit.. */
-	if (security_vm_enough_memory(grow)) {
+	if (unlikely(security_vm_enough_memory(grow))) {
+		anon_vma_unlock(vma);
 		return -ENOMEM;
 	}
 	
-	if (address - vma->vm_start > current->rlim[RLIMIT_STACK].rlim_cur ||
-			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
-			current->rlim[RLIMIT_AS].rlim_cur) {
+	if (unlikely(address - vma->vm_start > current->rlim[RLIMIT_STACK].rlim_cur ||
+		     ((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
+		     current->rlim[RLIMIT_AS].rlim_cur)) {
+		anon_vma_unlock(vma);
 		vm_unacct_memory(grow);
 		return -ENOMEM;
 	}
@@ -1000,6 +1011,9 @@ int expand_stack(struct vm_area_struct *
 	vma->vm_mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
+
+	anon_vma_unlock(vma);
+
 	return 0;
 }
 
@@ -1028,6 +1042,24 @@ int expand_stack(struct vm_area_struct *
 	unsigned long grow;
 
 	/*
+	 * We must make sure the anon-vma is allocated
+	 * to make sure the anon-vma locking is not a noop.
+	 */
+	if (unlikely(anon_vma_prepare(vma)))
+		return -ENOMEM;
+
+	/*
+	 * We must serialize against other thread and against
+	 * objrmap while moving the vm_start/vm_pgoff of anon-vmas.
+	 * The total_vm/locked_vm as well needs serialization
+	 * against other threads, the serialization of
+	 * locked_vm/total_vm against syscalls is provided by
+	 * the mmap_sem that we hold in read mode here (all
+	 * syscalls holds it in write mode).
+	 */
+	anon_vma_lock(vma);
+
+	/*
 	 * vma->vm_start/vm_end cannot change under us because the caller
 	 * is required to hold the mmap_sem in read mode. We need to get
 	 * the spinlock only before relocating the vma range ourself.
@@ -1036,13 +1068,15 @@ int expand_stack(struct vm_area_struct *
 	grow = (vma->vm_start - address) >> PAGE_SHIFT;
 
 	/* Overcommit.. */
-	if (security_vm_enough_memory(grow)) {
+	if (unlikely(security_vm_enough_memory(grow))) {
+		anon_vma_unlock(vma);
 		return -ENOMEM;
 	}
 	
-	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
-			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
-			current->rlim[RLIMIT_AS].rlim_cur) {
+	if (unlikely(vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
+		     ((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
+		     current->rlim[RLIMIT_AS].rlim_cur)) {
+		anon_vma_unlock(vma);
 		vm_unacct_memory(grow);
 		return -ENOMEM;
 	}
@@ -1051,6 +1085,9 @@ int expand_stack(struct vm_area_struct *
 	vma->vm_mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
+
+	anon_vma_unlock(vma);
+
 	return 0;
 }
 
@@ -1289,7 +1326,6 @@ int split_vma(struct mm_struct * mm, str
 
 	if (mapping)
 		down(&mapping->i_shared_sem);
-	spin_lock(&mm->page_table_lock);
 	anon_vma_lock(vma);
 
 	if (new_below)
@@ -1301,7 +1337,6 @@ int split_vma(struct mm_struct * mm, str
 	__insert_vm_struct(mm, new);
 
 	anon_vma_unlock(vma);
-	spin_unlock(&mm->page_table_lock);
 	if (mapping)
 		up(&mapping->i_shared_sem);
 

