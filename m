Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278967AbRKAOOm>; Thu, 1 Nov 2001 09:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278970AbRKAOOe>; Thu, 1 Nov 2001 09:14:34 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:54795 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S278967AbRKAOOT>; Thu, 1 Nov 2001 09:14:19 -0500
Subject: [PATCH] LDM bugfix - 2.4.13-ac5
From: Richard Russon <rich@flatcap.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.31.06.29 (Preview Release)
Date: 01 Nov 2001 14:14:16 +0000
Message-Id: <1004624056.1015.11.camel@home.flatcap.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Please can you apply this patch to 2.4.13-ac5.
It fixes a minor mistake when reading the LDM database.

Cheers,
  FlatCap (Rich)
  ntfs@flatcap.org


diff -urN linux-2.4.13-ac5/fs/partitions/ldm.c linux-2.4.13-ac5-ldm/fs/partitions/ldm.c
--- linux-2.4.13-ac5/fs/partitions/ldm.c	Tue Oct 30 19:58:29 2001
+++ linux-2.4.13-ac5-ldm/fs/partitions/ldm.c	Thu Nov  1 04:34:53 2001
@@ -1,7 +1,7 @@
 /*
  * ldm - Part of the Linux-NTFS project.
  *
- * Copyright (C) 2001 Richard Russon <ntfs@flatcap.org>
+ * Copyright (C) 2001 Richard Russon <ldm@flatcap.org>
  * Copyright (C) 2001 Anton Altaparmakov <antona@users.sf.net> (AIA)
  *
  * Documentation is available at http://linux-ntfs.sf.net/ldm
@@ -453,7 +453,10 @@
 			delta = vblk * vsize + 0x18;
 			if (delta >= 512)
 				goto brelse_out;
-			if (block[0x13] != VBLK_DISK)
+			if (block[0x0D] != 0)	/* Extended VBLK, ignore */
+				continue;
+			if ((block[0x13] != VBLK_DSK1) &&
+			    (block[0x13] != VBLK_DSK2))
 				continue;
 			/* Calculate relative offsets. */
 			rel_objid = 1 + block[0x18];
diff -urN linux-2.4.13-ac5/fs/partitions/ldm.h linux-2.4.13-ac5-ldm/fs/partitions/ldm.h
--- linux-2.4.13-ac5/fs/partitions/ldm.h	Tue Oct 30 19:58:29 2001
+++ linux-2.4.13-ac5-ldm/fs/partitions/ldm.h	Thu Nov  1 05:39:01 2001
@@ -1,11 +1,9 @@
 #ifndef _FS_PT_LDM_H_
 #define _FS_PT_LDM_H_
 /*
- * $Id: ldm.h,v 1.13 2001/07/23 19:49:49 antona Exp $
- *
  * ldm - Part of the Linux-NTFS project.
  *
- * Copyright (C) 2001 Richard Russon <ntfs@flatcap.org>
+ * Copyright (C) 2001 Richard Russon <ldm@flatcap.org>
  * Copyright (C) 2001 Anton Altaparmakov <antona@users.sf.net>
  *
  * Documentation is available at http://linux-ntfs.sf.net/ldm
@@ -25,7 +23,7 @@
  * in the file COPYING); if not, write to the Free Software Foundation,
  * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <asm/types.h>
+#include <linux/types.h>
 #include <asm/unaligned.h>
 #include <asm/byteorder.h>
 #include <linux/genhd.h>
@@ -45,8 +43,10 @@
 /* The defined vblk types. */
 #define VBLK_COMP		0x32		/* Component */
 #define VBLK_PART		0x33		/* Partition */
-#define VBLK_DISK		0x34		/* Disk */
-#define VBLK_DGRP		0x45		/* Disk Group */
+#define VBLK_DSK1		0x34		/* Disk */
+#define VBLK_DSK2		0x44		/* Disk */
+#define VBLK_DGR1		0x35		/* Disk Group */
+#define VBLK_DGR2		0x45		/* Disk Group */
 #define VBLK_VOLU		0x51		/* Volume */
 
 /* Other constants. */


