Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVATP3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVATP3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVATP2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:28:02 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:10404 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262157AbVATPZM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:25:12 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 20 Jan 2005 16:23:47 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Michael Geng <linux@MichaelGeng.de>
Subject: [patch] videotext: ioctls changed to use _IO macros
Message-ID: <20050120152347.GA12820@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linux@MichaelGeng.de (Michael Geng)

This patch switches the videotext drivers over to use the _IO
macros for ioctls.  video_usercopy() works correctly then.
The drivers will also map the old to the new ioctl numbers to
make sure old apps don't break.

The patch also updates Documentation/ioctl.h to reflect that change.
and deletes a unused struct in include/linux/videotext.h.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 Documentation/ioctl-number.txt |    3 -
 drivers/media/video/saa5246a.c |   49 +++++++++++++++++++
 drivers/media/video/saa5246a.h |    2 
 drivers/media/video/saa5249.c  |   54 ++++++++++++++++++++
 include/linux/videotext.h      |   85 ++++++++++++---------------------
 5 files changed, 138 insertions(+), 55 deletions(-)

Index: linux-2004-12-08/Documentation/ioctl-number.txt
===================================================================
--- linux-2004-12-08.orig/Documentation/ioctl-number.txt	2004-12-09 14:18:34.000000000 +0100
+++ linux-2004-12-08/Documentation/ioctl-number.txt	2004-12-14 13:18:03.988861152 +0100
@@ -145,7 +145,7 @@ Code	Seq#	Include File		Comments
 'p'	40-7F	linux/nvram.h
 'p'	80-9F				user-space parport
 					<mailto:tim@cyberelk.net>
-'q'	00-1F	linux/videotext.h	conflict!
+'q'	00-1F	linux/serio.h
 'q'	80-FF				Internet PhoneJACK, Internet LineJACK
 					<http://www.quicknet.net>
 'r'	00-1F	linux/msdos_fs.h
@@ -163,6 +163,7 @@ Code	Seq#	Include File		Comments
 'z'	40-7F				CAN bus card
 					<mailto:oe@port.de>
 0x80	00-1F	linux/fb.h
+0x81	00-1F	linux/videotext.h
 0x89	00-06	asm-i386/sockios.h
 0x89	0B-DF	linux/sockios.h
 0x89	E0-EF	linux/sockios.h		SIOCPROTOPRIVATE range
Index: linux-2004-12-08/drivers/media/video/saa5246a.c
===================================================================
--- linux-2004-12-08.orig/drivers/media/video/saa5246a.c	2004-12-09 14:16:45.000000000 +0100
+++ linux-2004-12-08/drivers/media/video/saa5246a.c	2004-12-14 13:18:04.062847242 +0100
@@ -682,6 +682,54 @@ static int do_saa5246a_ioctl(struct inod
 }
 
 /*
+ * Translates old vtx IOCTLs to new ones
+ *
+ * This keeps new kernel versions compatible with old userspace programs.
+ */
+static inline unsigned int vtx_fix_command(unsigned int cmd)
+{
+	switch (cmd) {
+	case VTXIOCGETINFO_OLD:
+		cmd = VTXIOCGETINFO;
+		break;
+	case VTXIOCCLRPAGE_OLD:
+		cmd = VTXIOCCLRPAGE;
+		break;
+	case VTXIOCCLRFOUND_OLD:
+		cmd = VTXIOCCLRFOUND;
+		break;
+	case VTXIOCPAGEREQ_OLD:
+		cmd = VTXIOCPAGEREQ;
+		break;
+	case VTXIOCGETSTAT_OLD:
+		cmd = VTXIOCGETSTAT;
+		break;
+	case VTXIOCGETPAGE_OLD:
+		cmd = VTXIOCGETPAGE;
+		break;
+	case VTXIOCSTOPDAU_OLD:
+		cmd = VTXIOCSTOPDAU;
+		break;
+	case VTXIOCPUTPAGE_OLD:
+		cmd = VTXIOCPUTPAGE;
+		break;
+	case VTXIOCSETDISP_OLD:
+		cmd = VTXIOCSETDISP;
+		break;
+	case VTXIOCPUTSTAT_OLD:
+		cmd = VTXIOCPUTSTAT;
+		break;
+	case VTXIOCCLRCACHE_OLD:
+		cmd = VTXIOCCLRCACHE;
+		break;
+	case VTXIOCSETVIRT_OLD:
+		cmd = VTXIOCSETVIRT;
+		break;
+	}
+	return cmd;
+}
+
+/*
  *	Handle the locking
  */
 static int saa5246a_ioctl(struct inode *inode, struct file *file,
@@ -691,6 +739,7 @@ static int saa5246a_ioctl(struct inode *
 	struct saa5246a_device *t = vd->priv;
 	int err;
 
+	cmd = vtx_fix_command(cmd);
 	down(&t->lock);
 	err = video_usercopy(inode, file, cmd, arg, do_saa5246a_ioctl);
 	up(&t->lock);
Index: linux-2004-12-08/drivers/media/video/saa5246a.h
===================================================================
--- linux-2004-12-08.orig/drivers/media/video/saa5246a.h	2004-12-09 14:17:58.000000000 +0100
+++ linux-2004-12-08/drivers/media/video/saa5246a.h	2004-12-14 13:18:04.083843294 +0100
@@ -23,7 +23,7 @@
 #define __SAA5246A_H__
 
 #define MAJOR_VERSION 1		/* driver major version number */
-#define MINOR_VERSION 7		/* driver minor version number */
+#define MINOR_VERSION 8		/* driver minor version number */
 
 #define IF_NAME "SAA5246A"
 
Index: linux-2004-12-08/drivers/media/video/saa5249.c
===================================================================
--- linux-2004-12-08.orig/drivers/media/video/saa5249.c	2004-12-09 14:17:56.000000000 +0100
+++ linux-2004-12-08/drivers/media/video/saa5249.c	2004-12-14 13:18:04.094841227 +0100
@@ -1,4 +1,7 @@
 /*
+ * Modified in order to keep it compatible both with new and old videotext IOCTLs by
+ * Michael Geng <linux@MichaelGeng.de>
+ *
  *	Cleaned up to use existing videodev interface and allow the idea
  *	of multiple teletext decoders on the video4linux iface. Changed i2c
  *	to cover addressing clashes on device busses. It's also rebuilt so
@@ -58,7 +61,7 @@
 #include <asm/uaccess.h>
 
 #define VTX_VER_MAJ 1
-#define VTX_VER_MIN 7
+#define VTX_VER_MIN 8
 
 
 
@@ -578,6 +581,54 @@ static int do_saa5249_ioctl(struct inode
 }
 
 /*
+ * Translates old vtx IOCTLs to new ones
+ *
+ * This keeps new kernel versions compatible with old userspace programs.
+ */
+static inline unsigned int vtx_fix_command(unsigned int cmd)
+{
+	switch (cmd) {
+	case VTXIOCGETINFO_OLD:
+		cmd = VTXIOCGETINFO;
+		break;
+	case VTXIOCCLRPAGE_OLD:
+		cmd = VTXIOCCLRPAGE;
+		break;
+	case VTXIOCCLRFOUND_OLD:
+		cmd = VTXIOCCLRFOUND;
+		break;
+	case VTXIOCPAGEREQ_OLD:
+		cmd = VTXIOCPAGEREQ;
+		break;
+	case VTXIOCGETSTAT_OLD:
+		cmd = VTXIOCGETSTAT;
+		break;
+	case VTXIOCGETPAGE_OLD:
+		cmd = VTXIOCGETPAGE;
+		break;
+	case VTXIOCSTOPDAU_OLD:
+		cmd = VTXIOCSTOPDAU;
+		break;
+	case VTXIOCPUTPAGE_OLD:
+		cmd = VTXIOCPUTPAGE;
+		break;
+	case VTXIOCSETDISP_OLD:
+		cmd = VTXIOCSETDISP;
+		break;
+	case VTXIOCPUTSTAT_OLD:
+		cmd = VTXIOCPUTSTAT;
+		break;
+	case VTXIOCCLRCACHE_OLD:
+		cmd = VTXIOCCLRCACHE;
+		break;
+	case VTXIOCSETVIRT_OLD:
+		cmd = VTXIOCSETVIRT;
+		break;
+	}
+	return cmd;
+}
+
+/*
  *	Handle the locking
  */
  
@@ -588,6 +639,7 @@ static int saa5249_ioctl(struct inode *i
 	struct saa5249_device *t=vd->priv;
 	int err;
 	
+	cmd = vtx_fix_command(cmd);
 	down(&t->lock);
 	err = video_usercopy(inode,file,cmd,arg,do_saa5249_ioctl);
 	up(&t->lock);
Index: linux-2004-12-08/include/linux/videotext.h
===================================================================
--- linux-2004-12-08.orig/include/linux/videotext.h	2004-12-09 14:18:44.000000000 +0100
+++ linux-2004-12-08/include/linux/videotext.h	2004-12-14 13:18:04.132834083 +0100
@@ -1,7 +1,13 @@
 #ifndef _VTX_H
 #define _VTX_H
 
-/* $Id: videotext.h,v 1.1 1998/03/30 22:26:39 alan Exp $
+/* 
+ * Teletext (=Videotext) hardware decoders using interface /dev/vtx
+ * Do not confuse with drivers using /dev/vbi which decode videotext by software
+ * 
+ * Videotext IOCTLs changed in order to use _IO() macros defined in <linux/ioctl.h>,
+ * unused tuner IOCTLs cleaned up by
+ * Michael Geng <linux@MichaelGeng.de>
  *
  * Copyright (c) 1994-97 Martin Buck  <martin-2.buck@student.uni-ulm.de>
  * Read COPYING for more information
@@ -12,19 +18,32 @@
 /*
  *	Videotext ioctls
  */
-#define VTXIOCGETINFO  0x7101  /* get version of driver & capabilities of vtx-chipset */
-#define VTXIOCCLRPAGE  0x7102  /* clear page-buffer */
-#define VTXIOCCLRFOUND 0x7103  /* clear bits indicating that page was found */
-#define VTXIOCPAGEREQ  0x7104  /* search for page */
-#define VTXIOCGETSTAT  0x7105  /* get status of page-buffer */
-#define VTXIOCGETPAGE  0x7106  /* get contents of page-buffer */
-#define VTXIOCSTOPDAU  0x7107  /* stop data acquisition unit */
-#define VTXIOCPUTPAGE  0x7108  /* display page on TV-screen */
-#define VTXIOCSETDISP  0x7109  /* set TV-mode */
-#define VTXIOCPUTSTAT  0x710a  /* set status of TV-output-buffer */
-#define VTXIOCCLRCACHE 0x710b  /* clear cache on VTX-interface (if avail.) */
-#define VTXIOCSETVIRT  0x710c  /* turn on virtual mode (this disables TV-display) */
-
+#define VTXIOCGETINFO	_IOR  (0x81,  1, vtx_info_t)
+#define VTXIOCCLRPAGE	_IOW  (0x81,  2, vtx_pagereq_t)
+#define VTXIOCCLRFOUND	_IOW  (0x81,  3, vtx_pagereq_t)
+#define VTXIOCPAGEREQ	_IOW  (0x81,  4, vtx_pagereq_t)
+#define VTXIOCGETSTAT	_IOW  (0x81,  5, vtx_pagereq_t)
+#define VTXIOCGETPAGE	_IOW  (0x81,  6, vtx_pagereq_t)
+#define VTXIOCSTOPDAU	_IOW  (0x81,  7, vtx_pagereq_t)
+#define VTXIOCPUTPAGE	_IO   (0x81,  8)
+#define VTXIOCSETDISP	_IO   (0x81,  9)
+#define VTXIOCPUTSTAT	_IO   (0x81, 10)
+#define VTXIOCCLRCACHE	_IO   (0x81, 11)
+#define VTXIOCSETVIRT	_IOW  (0x81, 12, long)
+
+/* for compatibility, will go away some day */
+#define VTXIOCGETINFO_OLD  0x7101  /* get version of driver & capabilities of vtx-chipset */
+#define VTXIOCCLRPAGE_OLD  0x7102  /* clear page-buffer */
+#define VTXIOCCLRFOUND_OLD 0x7103  /* clear bits indicating that page was found */
+#define VTXIOCPAGEREQ_OLD  0x7104  /* search for page */
+#define VTXIOCGETSTAT_OLD  0x7105  /* get status of page-buffer */
+#define VTXIOCGETPAGE_OLD  0x7106  /* get contents of page-buffer */
+#define VTXIOCSTOPDAU_OLD  0x7107  /* stop data acquisition unit */
+#define VTXIOCPUTPAGE_OLD  0x7108  /* display page on TV-screen */
+#define VTXIOCSETDISP_OLD  0x7109  /* set TV-mode */
+#define VTXIOCPUTSTAT_OLD  0x710a  /* set status of TV-output-buffer */
+#define VTXIOCCLRCACHE_OLD 0x710b  /* clear cache on VTX-interface (if avail.) */
+#define VTXIOCSETVIRT_OLD  0x710c  /* turn on virtual mode (this disables TV-display) */
 
 /* 
  *	Definitions for VTXIOCGETINFO
@@ -102,43 +121,5 @@ typedef struct 
 	unsigned hamming : 1;		/* hamming-error occurred */
 }
 vtx_pageinfo_t;
-
-
-/*
- *	Definitions for VTXIOCSETDISP
- */
- 
-typedef enum { 
-	DISPOFF, DISPNORM, DISPTRANS, DISPINS, INTERLACE_OFFSET 
-} vtxdisp_t;
-
-
-
-/*
- *	Tuner ioctls
- */
  
-#define TUNIOCGETINFO  0x7201  /* get version of driver & capabilities of tuner */
-#define TUNIOCRESET    0x7202  /* reset tuner */
-#define TUNIOCSETFREQ  0x7203  /* set tuning frequency (unit: kHz) */
-#define TUNIOCGETFREQ  0x7204  /* get tuning frequency (unit: kHz) */
-#define TUNIOCSETCHAN  0x7205  /* set tuning channel */
-#define TUNIOCGETCHAN  0x7206  /* get tuning channel */
-
-
-typedef struct 
-{
-	int version_major, version_minor;	/* version of driver; if version_major changes, driver */
-						/* is not backward compatible!!! CHECK THIS!!! */  
-	unsigned freq : 1;			/* tuner can be set to given frequency */
-	unsigned chan : 1;			/* tuner stores several channels */
-	unsigned scan : 1;			/* tuner supports scanning */
-	unsigned autoscan : 1;		/* tuner supports scanning with automatic stop */
-	unsigned afc : 1;			/* tuner supports AFC */
-	unsigned dummy1, dummy2, dummy3, dummy4, dummy5, dummy6, dummy7, dummy8, dummy9, dummy10,
- 		dummy11 : 1;
-	int dummy12, dummy13, dummy14, dummy15, dummy16, dummy17, dummy18, dummy19;
-} tuner_info_t;
-
-
 #endif /* _VTX_H */

-- 
#define printk(args...) fprintf(stderr, ## args)
