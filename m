Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136846AbRAHFOc>; Mon, 8 Jan 2001 00:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136893AbRAHFOW>; Mon, 8 Jan 2001 00:14:22 -0500
Received: from cc493382-b.whmh1.md.home.com ([24.3.58.253]:56357 "EHLO
	legion.wienholt.net") by vger.kernel.org with ESMTP
	id <S136846AbRAHFOG>; Mon, 8 Jan 2001 00:14:06 -0500
From: "Robert Wienholt, Jr." <rwienholt@legiontech.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/mmap.c find_vma(), kernel 2.4.0
Message-ID: <Pine.SGI.4.30.0101072347130.1511-100000@legion.wienholt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Date: Mon, 8 Jan 2001 00:03:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gentlemen,

	I was looking through some of the memory management code today and
came across something that may provide a minor performance boost.  I have
included a patch below for the 2.4.0 source.

	In the find_vma function a cached vma is checked and if that is
not the requested vma, the linked list (unless there's an avl tree) is
traversed from the beginning.  My thought was that if the cached vma is
somewhere in the middle of a "long" list, and the memory address we are
looking for is past the vm_end of the cached vma, well, the traversal can
just start at the next vma after the one that was cached.

	I put in some code to count the number of times my change took the
vma after the cached one and the number of times it went the other way.
Through these simple counts I determined that the requested vma was after
the cached one about 46% of the time.

	Anyway, this is a simple patch and may not make that much of a
difference in performance but hey, this is my first time submitting a
patch and I decided to start small.  I would be interested in hearing any
feedback from the mm gurus out there.

-- 
+----------------------------------+----------------------------------+
| Robert Wienholt, Jr.             | Legion Technologies, LLC         |
| Lead Programmer                  | 8910 Whitetail Ct.               |
| rwienholt@legiontech.com         | Perry Hall, MD 21128             |
+----------------------------------+----------------------------------+


--- linux-2.4.0/mm/mmap.c       Sat Dec 30 12:35:19 2000
+++ linux/mm/mmap.c     Sun Jan  7 20:35:59 2001
@@ -413,7 +413,20 @@
                if (!(vma && vma->vm_end > addr && vma->vm_start <= addr))
{
                        if (!mm->mmap_avl) {
                                /* Go through the linear list. */
-                               vma = mm->mmap;
+
+                               /*
+                                       If we missed the cache, check to see if the memory area
+                                       would be after the cached one and start the list walk
+                                       from there.
+
+                                       RGW -- 01/07/2001
+                               */
+
+                               if (vma && vma->vm_end <= addr)
+                                       vma = vma->vm_next;
+                               else
+                                       vma = mm->mmap;
+
                                while (vma && vma->vm_end <= addr)
                                        vma = vma->vm_next;
                        } else {


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
