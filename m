Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267134AbSLKNXX>; Wed, 11 Dec 2002 08:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267137AbSLKNXX>; Wed, 11 Dec 2002 08:23:23 -0500
Received: from [66.70.28.20] ([66.70.28.20]:3339 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267134AbSLKNXW>; Wed, 11 Dec 2002 08:23:22 -0500
Date: Wed, 11 Dec 2002 14:32:46 +0100
From: DervishD <raul@pleyades.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, davem@redhat.com
Subject: [PATCH] mmap.c - do_mmap_pgoff() small correction
Message-ID: <20021211133246.GE48@DervishD>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

    Hi Linus :)

    This is a correction for a patch I sent you that you included in
the 2.5.x tree. The patch I sent you fixed a corner case for the
mmap() syscall, where the requested size was too big (namely, bigger
than SIZE_MAX-PAGE_SIZE). Unfortunately, the patch did a wrong
assumption that is not true in some archs where TASK_SIZE is the full
address space available, as sparc64. So, the patch didn't fix
anything on those archs :((

    David S. Miller <davem@redhat.com> pointed this and made this new
patch that fixes the spot. Now it should work in all archs.

    If you have any doubt, just tell.

    Raúl

--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=iso-8859-1
Content-Description: mmap.c.diff
Content-Disposition: attachment; filename="mmap.c.2.5.51.diff"

--- linux/mm/mmap.c.orig	2002-12-11 14:27:04.000000000 +0100
+++ linux/mm/mmap.c	2002-12-11 14:28:09.000000000 +0100
@@ -421,14 +421,14 @@
 	if (file && (!file->f_op || !file->f_op->mmap))
 		return -ENODEV;
 
-	if (!len)
+	if (len == 0)
 		return addr;
 
-	if (len > TASK_SIZE)
-		return -EINVAL;
-
 	len = PAGE_ALIGN(len);
 
+	if (len > TASK_SIZE || len == 0)
+		return -EINVAL;
+
 	/* offset overflow? */
 	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
 		return -EINVAL;

--6zdv2QT/q3FMhpsV--
