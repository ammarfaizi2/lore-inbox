Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269350AbRHLPzN>; Sun, 12 Aug 2001 11:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269351AbRHLPzD>; Sun, 12 Aug 2001 11:55:03 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:27403 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S269350AbRHLPy7>; Sun, 12 Aug 2001 11:54:59 -0400
Subject: [PATCH] 2.4.8 -- LDM build fix
From: Richard Russon <ntfs@flatcap.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 12 Aug 2001 16:55:07 +0100
Message-Id: <997631708.5538.8.camel@home.flatcap.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The LDM code (Windows Dynamic Disks) has been broken for a few
revisions now.  Please apply this patch to fix it.

Cheers,
  FlatCap (Rich)
  ntfs@flatcap.org

--

diff -urN linux-2.4.8/fs/partitions/ldm.c linux-2.4.8-ldm/fs/partitions/ldm.c
--- linux-2.4.8/fs/partitions/ldm.c	Sun Aug 12 16:45:00 2001
+++ linux-2.4.8-ldm/fs/partitions/ldm.c	Sun Aug 12 16:44:53 2001
@@ -141,7 +141,8 @@
 		printk(LDM_CRIT "Cannot find VBLK, database may be corrupt.\n");
 		return -1;
 	}
-	if (BE16(buffer + 0x0E) == 0)	/* Record is not in use. */
+	if ((BE16(buffer + 0x0E) == 0) ||       /* Record is not in use. */
+	    (BE16(buffer + 0x0C) != 0))         /* Part 2 of an ext. record */
 		return 0;
 
 	/* FIXME: What about extended VBLKs? */
diff -urN linux-2.4.8/fs/partitions/ldm.h linux-2.4.8-ldm/fs/partitions/ldm.h
--- linux-2.4.8/fs/partitions/ldm.h	Sun Aug 12 14:57:56 2001
+++ linux-2.4.8-ldm/fs/partitions/ldm.h	Sun Aug 12 16:18:27 2001
@@ -81,13 +81,13 @@
 #define TOC_BITMAP2		"log"		/* bitmaps in the TOCBLOCK. */
 
 /* Borrowed from msdos.c */
-#define SYS_IND(p)		(get_unaligned(&p->sys_ind))
-#define NR_SECTS(p)		({ __typeof__(p->nr_sects) __a =	\
-					get_unaligned(&p->nr_sects);	\
+#define SYS_IND(p)		(get_unaligned(&(p)->sys_ind))
+#define NR_SECTS(p)		({ __typeof__((p)->nr_sects) __a =	\
+					get_unaligned(&(p)->nr_sects);	\
 					le32_to_cpu(__a);		\
 				})
-#define START_SECT(p)		({ __typeof__(p->start_sect) __a =	\
-					get_unaligned(&p->start_sect);	\
+#define START_SECT(p)		({ __typeof__((p)->start_sect) __a =	\
+					get_unaligned(&(p)->start_sect);\
 					le32_to_cpu(__a);		\
 				})
 


