Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268087AbRG0VNV>; Fri, 27 Jul 2001 17:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268973AbRG0VNN>; Fri, 27 Jul 2001 17:13:13 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:19932 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S268087AbRG0VMq>; Fri, 27 Jul 2001 17:12:46 -0400
Date: Fri, 27 Jul 2001 22:14:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] hang on /dev/kmem
Message-ID: <Pine.LNX.4.21.0107272210260.1242-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

read_kmem() gets stuck in silly loop after reading last vmalloc area.
Patch below against 2.4.8-pre1 or 2.4.7-ac1: please apply.

Hugh

--- linux-2.4.8-pre1/drivers/char/mem.c	Wed Jul 11 00:07:46 2001
+++ linux/drivers/char/mem.c	Fri Jul 27 21:40:05 2001
@@ -260,7 +260,9 @@
 			if (len > PAGE_SIZE)
 				len = PAGE_SIZE;
 			len = vread(kbuf, (char *)p, len);
-			if (len && copy_to_user(buf, kbuf, len)) {
+			if (!len)
+				break;
+			if (copy_to_user(buf, kbuf, len)) {
 				free_page((unsigned long)kbuf);
 				return -EFAULT;
 			}

