Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267149AbSLKNi2>; Wed, 11 Dec 2002 08:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267144AbSLKNhr>; Wed, 11 Dec 2002 08:37:47 -0500
Received: from [66.70.28.20] ([66.70.28.20]:9739 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267149AbSLKNgd>; Wed, 11 Dec 2002 08:36:33 -0500
Date: Wed, 11 Dec 2002 14:23:38 +0100
From: DervishD <raul@pleyades.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, davem@redhat.com
Subject: [PATCH] mmap.c (do_mmap_pgoff) 'repatched'.
Message-ID: <20021211132338.GD48@DervishD>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

    Hi Alan :))

    The patch I sent you for mmap.c, correcting a corner case,
namely the case where the requested size on a call to 'mmap()' was
greater than SIZE_MAX-PAGE_SIZE, because the size was incorrectly
page-aligned to size '0', does nothing if TASK_SIZE is the full
address space for the task. This happens, for example, under sparc64.

    This new patch covers this case and works even if TASK_SIZE is
very huge. My patch was completed by David S. Miller <davem@redhat.com>
and now should work for all cases.

    The patch is against your 2.4.20-ac1 tree. If you have any doubt,
please tell.

    Thanks ;)

    Raúl

--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=iso-8859-1
Content-Description: mmap.c.diff
Content-Disposition: attachment; filename="mmap.c.2.4.20-ac1.diff"

--- linux/mm/mmap.c.orig	2002-12-11 14:08:39.000000000 +0100
+++ linux/mm/mmap.c	2002-12-11 14:09:54.000000000 +0100
@@ -473,10 +473,6 @@
 }
 
 
-/*
- *	NOTE: in this function we rely on TASK_SIZE being lower than
- *	SIZE_MAX-PAGE_SIZE at least. I'm pretty sure that it is.
- */
 
 unsigned long do_mmap_pgoff(struct file * file, unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags, unsigned long pgoff)
@@ -493,14 +489,14 @@
 	if (file && (!file->f_op || !file->f_op->mmap))
 		return -ENODEV;
 
-	if (!len)
+	if (len == 0)
 		return addr;
+	
+	len = PAGE_ALIGN(len);
 
-	if (len > TASK_SIZE)
+	if (len > TASK_SIZE || len == 0)
 		return -EINVAL;
 
-	len = PAGE_ALIGN(len);  /* This cannot be zero now */
-
 	/* offset overflow? */
 	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
 		return -EINVAL;

--CUfgB8w4ZwR/yMy5--
