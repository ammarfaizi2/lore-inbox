Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274028AbRISJv6>; Wed, 19 Sep 2001 05:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273350AbRISJvr>; Wed, 19 Sep 2001 05:51:47 -0400
Received: from t2.redhat.com ([199.183.24.243]:11253 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S274028AbRISJvj>; Wed, 19 Sep 2001 05:51:39 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Howells <dhowells@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrea Arcangeli <andrea@suse.de>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem 
In-Reply-To: Message from Linus Torvalds <torvalds@transmeta.com> 
   of "Tue, 18 Sep 2001 09:49:42 PDT." <Pine.LNX.4.33.0109180948260.2077-100000@penguin.transmeta.com> 
Date: Wed, 19 Sep 2001 10:51:57 +0100
Message-ID: <9326.1000893117@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looking through the do_page_fault(), I noticed there's a race in expand stack
because expand_stack() expects the caller to have the mm-sem write-locked.

I've attached a patch that might fix it appropriately. Alternatively, it may
be worth applying Andrea's 00_silent-stack-overflow-10 patch which fixes this
and something else too.

David


diff -uNr linux-2.4.10-pre12/include/linux/mm.h linux-rwsem/include/linux/mm.h
--- linux-2.4.10-pre12/include/linux/mm.h	Wed Sep 19 10:39:23 2001
+++ linux-rwsem/include/linux/mm.h	Wed Sep 19 10:40:48 2001
@@ -586,11 +586,11 @@
 	 * before relocating the vma range ourself.
 	 */
 	address &= PAGE_MASK;
+	spin_lock(&vma->vm_mm->page_table_lock);
 	grow = (vma->vm_start - address) >> PAGE_SHIFT;
 	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
 	    ((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) > current->rlim[RLIMIT_AS].rlim_cur)
-		return -ENOMEM;
-	spin_lock(&vma->vm_mm->page_table_lock);
+		goto nomem;
 	vma->vm_start = address;
 	vma->vm_pgoff -= grow;
 	vma->vm_mm->total_vm += grow;
@@ -598,6 +598,9 @@
 		vma->vm_mm->locked_vm += grow;
 	spin_unlock(&vma->vm_mm->page_table_lock);
 	return 0;
+ nomem:
+	spin_unlock(&vma->vm_mm->page_table_lock);
+	return -ENOMEM;
 }
 
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
