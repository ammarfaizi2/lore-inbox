Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbRCRJ5a>; Sun, 18 Mar 2001 04:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131221AbRCRJ5V>; Sun, 18 Mar 2001 04:57:21 -0500
Received: from www.wen-online.de ([212.223.88.39]:50184 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131219AbRCRJ5H>;
	Sun, 18 Mar 2001 04:57:07 -0500
Date: Sun, 18 Mar 2001 10:56:16 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-mm@kvack.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: changing mm->mmap_sem  (was: Re: system call for process
 information?)
In-Reply-To: <Pine.LNX.4.21.0103180419550.13050-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0103181050020.878-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Mar 2001, Rik van Riel wrote:

> On Fri, 16 Mar 2001, Stephen C. Tweedie wrote:
>
> > Right, I'm not suggesting removing that: making the mmap_sem
> > read/write is fine, but yes, we still need that semaphore.
>
> Initial patch (against 2.4.2-ac20) is available at
> http://www.surriel.com/patches/
>
> > But as for the "page faults would use an extra lock to protect against
> > each other" bit --- we already have another lock, the page table lock,
> > which can be used in this way, so ANOTHER lock should be unnecessary.
>
> Tomorrow I'll take a look at the various ->nopage
> functions and do_swap_page to see if these functions
> would be able to take simultaneous faults at the same
> address (from multiple threads).  If not, either we'll
> need to modify these functions, or we could add a (few?)
> extra lock to prevent these functions from faulting at
> the same address at the same time in multiple threads.

Hi Rik,

I gave this patch a try, and the initial results are extremely encouraging.
Not only do I have vmstat (SCHED_RR) info in realtime with zero delays :))
I also have a _nice_ throughput improvement.  There are some worrisome
warnings below along with the compile changes I made here, but for an
initial patch, things look pretty darn wonderful.

	Cheers,

	-Mike

--- ./include/linux/sched.h.org	Sun Mar 18 10:20:42 2001
+++ ./include/linux/sched.h	Sun Mar 18 10:27:48 2001
@@ -238,7 +238,7 @@
 	mm_users:	ATOMIC_INIT(2), 		\
 	mm_count:	ATOMIC_INIT(1), 		\
 	map_count:	1, 				\
-	mmap_sem:	__MUTEX_INITIALIZER(name.mmap_sem), \
+	mmap_sem:	__RWSEM_INITIALIZER(name.mmap_sem, RW_LOCK_BIAS), \
 	page_table_lock: SPIN_LOCK_UNLOCKED, 		\
 	mmlist:		LIST_HEAD_INIT(name.mmlist),	\
 }
--- ./include/linux/mm.h.org	Sun Mar 18 09:56:55 2001
+++ ./include/linux/mm.h	Sun Mar 18 10:27:59 2001
@@ -533,13 +533,13 @@
 	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
 	    ((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) > current->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
-	spin_lock(&mm->page_table_lock);
+	spin_lock(&vma->vm_mm->page_table_lock);
 	vma->vm_start = address;
 	vma->vm_pgoff -= grow;
 	vma->vm_mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
-	spin_unlock(&mm->page_table_lock);
+	spin_unlock(&vma->vm_mm->page_table_lock);
 	return 0;
 }

...
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 196k freed
Adding Swap: 265064k swap-space (priority 2)
VM: Bad swap entry 00011e00
VM: Bad swap entry 00058d00
Unused swap offset entry in swap_dup 00058d00
Unused swap offset entry in swap_dup 00011e00
VM: Bad swap entry 00011e00
VM: Bad swap entry 00058d00
Unused swap offset entry in swap_dup 00058d00
VM: Bad swap entry 00058d00
Unused swap offset entry in swap_dup 00011e00
Unused swap offset entry in swap_dup 00058d00
VM: Bad swap entry 00011e00
VM: Bad swap entry 00058d00
Unused swap offset entry in swap_dup 00011e00
Unused swap offset entry in swap_dup 00058d00
VM: Bad swap entry 00011e00
VM: Bad swap entry 00058d00
Unused swap offset entry in swap_dup 008f4e00
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_dup 006ef700
Unused swap offset entry in swap_dup 008f4e00
VM: Bad swap entry 006ef700
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_dup 006ef700
Unused swap offset entry in swap_dup 008f4e00
VM: Bad swap entry 006ef700
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_dup 006ef700
Unused swap offset entry in swap_dup 008f4e00
VM: Bad swap entry 006ef700
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_dup 006ef700
Unused swap offset entry in swap_dup 008f4e00
VM: Bad swap entry 006ef700
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_dup 006ef700
Unused swap offset entry in swap_dup 008f4e00
VM: Bad swap entry 006ef700
Unused swap offset entry in swap_dup 006ef700
VM: Bad swap entry 006ef700
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_dup 006ef700
Unused swap offset entry in swap_dup 008f4e00
VM: Bad swap entry 006ef700
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_count 00011e00
Unused swap offset entry in swap_dup 006ef700
Unused swap offset entry in swap_dup 008f4e00
VM: Bad swap entry 006ef700
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_dup 008f4e00
Unused swap offset entry in swap_dup 006ef700
VM: Bad swap entry 006ef700
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_dup 006ef700
Unused swap offset entry in swap_dup 008f4e00
VM: Bad swap entry 006ef700
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_dup 006ef700
Unused swap offset entry in swap_dup 008f4e00
VM: Bad swap entry 006ef700
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_dup 006ef700
Unused swap offset entry in swap_dup 008f4e00
VM: Bad swap entry 006ef700
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_dup 006ef700
Unused swap offset entry in swap_dup 008f4e00
VM: Bad swap entry 006ef700
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_dup 008f4e00
Unused swap offset entry in swap_dup 006ef700
VM: Bad swap entry 006ef700
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_dup 006ef700
Unused swap offset entry in swap_dup 008f4e00
Unused swap offset entry in swap_dup 00011e00
VM: Bad swap entry 006ef700
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_dup 006ef700
Unused swap offset entry in swap_dup 008f4e00
VM: Bad swap entry 00011e00
Unused swap offset entry in swap_count 00011e00
VM: Bad swap entry 006ef700
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_dup 006ef700
Unused swap offset entry in swap_dup 008f4e00
VM: Bad swap entry 006ef700
VM: Bad swap entry 008f4e00
Unused swap offset entry in swap_dup 008f4e00
Unused swap offset entry in swap_dup 006ef700

