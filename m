Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRCRJgU>; Sun, 18 Mar 2001 04:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131175AbRCRJgL>; Sun, 18 Mar 2001 04:36:11 -0500
Received: from colorfullife.com ([216.156.138.34]:15631 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131158AbRCRJgA>;
	Sun, 18 Mar 2001 04:36:00 -0500
Message-ID: <001701c0af8e$bd590ac0$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: changing mm->mmap_sem  (was: Re: system call for process information?)
Date: Sun, 18 Mar 2001 10:34:38 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> The problem is that mmap_sem seems to be protecting the list
> of VMAs, so taking _only_ the page_table_lock could let a VMA
> change under us while a page fault is underway ...

No, that can't happen.
VMA changes only happen if both the mmap_sem and the page table lock is
acquired. (check insert_vm() at the end of mm/mmap.c)
The page fault path uses the map_sem, kswaps uses page_table_lock.

<< from your patch:
--- linux-2.4.2-ac20-vm/mm/vmscan.c.orig	Sat Mar 17 11:30:49 2001
+++ linux-2.4.2-ac20-vm/mm/vmscan.c	Sat Mar 17 20:53:10 2001
@@ -231,6 +231,7 @@
 	 * Find the proper vm-area after freezing the vma chain
 	 * and ptes.
 	 */
+	down_read(&mm->mmap_sem);
                spin_lock(&mm->page_table_lock);
 >>>>

Why do you acquire the mmap semaphore in swapout_mm()? The old rule was
that kswapd should never sleep on the mmap semaphore. Isn't there a
deadlock if mmap sem is already acquired? I don't remember the details.

>
> The problem is that mmap_sem seems to be protecting the list
> of VMAs, so taking _only_ the page_table_lock could let a VMA
> change under us while a page fault is underway ...

I remember that the pmd_alloc() and pte_alloc() functions need
additional locking.

--
    Manfred

