Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268203AbUJJI4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268203AbUJJI4J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 04:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268207AbUJJI4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 04:56:08 -0400
Received: from us1.server44secre01.de ([80.190.243.163]:37032 "EHLO
	us1.server44secre01.de") by vger.kernel.org with ESMTP
	id S268203AbUJJIzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 04:55:49 -0400
Date: Sun, 10 Oct 2004 10:55:41 +0200
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: video_usercopy() enforces change of VideoText IOCTLs since 2.6.8
Message-ID: <20041010085541.GA1642@t-online.de>
References: <20041007165410.GA2306@t-online.de> <20041008105219.GA24842@bytesex> <20041008140056.72b177d9.akpm@osdl.org> <20041009092801.GC3482@bytesex> <20041009112839.GA2908@t-online.de> <20041009121845.GE3482@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041009121845.GE3482@bytesex>
User-Agent: Mutt/1.3.28i
From: linux@MichaelGeng.de (Michael Geng)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2004 at 02:18:45PM +0200, Gerd Knorr wrote:
> > I would prefer redefining them with respect
> > to the arguments passed to the IOCTLs.
> 
> Thats possible as well.
> 
> > Nevertheless there is one big disadvantage: The userspace programs 
> > have to be recompiled because they of course have to use the same IOCTL 
> > definitions. 
> 
> You can just keep the old ones and map them, so both old and new ones
> will work (and internally only the new ones are used).
> video_fix_command() does that for a number of v4l2 ioctls which
> initially got a _IO* define with wrong read/write bits.  You can either
> just add the videotext ones there or translate them in the drivers right
> before calling video_usercopy().

That's a good idea. The patch below maps old IOCTLs to new ones in the
functions vtx_fix_command() in saa5246a.c and saa5249.c. The drivers now 
internally use the new IOCTLs but old userspace programs will still work
without recompiling them.

For the new IOCTLs I need an identifying letter. According to 
Documentation/ioctl-number.txt the letter 'q', seq# 0-0x1F is presently
allocated to the videotext drivers. I want to change this because 
linux/serio.h also uses the letter 'q', seq# 0.

I now allocated 0x81 (the major number of /dev/vtx<n>), seq# 0-0x1F
to linux/videotext.h. I also added 'q', seq# 0-0x1F to linux/serio.h.
In the present ioctl-number.txt only a conflict is indicated but the
allocation for linux/serio.h is missing. I hope that's ok. Who else
must I ask for this change in Documentation/ioctl-number.txt?

In include/linux/videotext.h I additionally cleaned up some definitions 
for a tuner because these definitions are not used any more anywhere in 
the kernel. 

Michael

----------------------

diff -u -N -r linux-2.6.8.1/Documentation/ioctl-number.txt linux/Documentation/ioctl-number.txt
--- linux-2.6.8.1/Documentation/ioctl-number.txt	Sat Aug 14 12:56:22 2004
+++ linux/Documentation/ioctl-number.txt	Sun Oct 10 08:34:44 2004
@@ -144,7 +144,7 @@
 'p'	40-7F	linux/nvram.h
 'p'	80-9F				user-space parport
 					<mailto:tim@cyberelk.net>
-'q'	00-1F	linux/videotext.h	conflict!
+'q'	00-1F	linux/serio.h
 'q'	80-FF				Internet PhoneJACK, Internet LineJACK
 					<http://www.quicknet.net>
 'r'	00-1F	linux/msdos_fs.h
@@ -162,6 +162,7 @@
 'z'	40-7F				CAN bus card
 					<mailto:oe@port.de>
 0x80	00-1F	linux/fb.h
+0x81	00-1F	linux/videotext.h
 0x89	00-06	asm-i386/sockios.h
 0x89	0B-DF	linux/sockios.h
 0x89	E0-EF	linux/sockios.h		SIOCPROTOPRIVATE range
diff -u -N -r linux-2.6.8.1/drivers/media/video/saa5246a.c linux/drivers/media/video/saa5246a.c
--- linux-2.6.8.1/drivers/media/video/saa5246a.c	Sat Aug 14 12:55:22 2004
+++ linux/drivers/media/video/saa5246a.c	Sun Oct 10 09:40:29 2004
@@ -682,6 +682,54 @@
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
@@ -691,6 +739,7 @@
 	struct saa5246a_device *t = vd->priv;
 	int err;
 
+	cmd = vtx_fix_command(cmd);
 	down(&t->lock);
 	err = video_usercopy(inode, file, cmd, arg, do_saa5246a_ioctl);
 	up(&t->lock);
diff -u -N -r linux-2.6.8.1/drivers/media/video/saa5246a.h linux/drivers/media/video/saa5246a.h
--- linux-2.6.8.1/drivers/media/video/saa5246a.h	Sat Aug 14 12:55:48 2004
+++ linux/drivers/media/video/saa5246a.h	Sun Oct 10 08:34:13 2004
@@ -23,7 +23,7 @@
 #define __SAA5246A_H__
 
 #define MAJOR_VERSION 1		/* driver major version number */
-#define MINOR_VERSION 7		/* driver minor version number */
+#define MINOR_VERSION 8		/* driver minor version number */
 
 #define IF_NAME "SAA5246A"
 
diff -u -N -r linux-2.6.8.1/drivers/media/video/saa5249.c linux/drivers/media/video/saa5249.c
--- linux-2.6.8.1/drivers/media/video/saa5249.c	Sat Aug 14 12:55:48 2004
+++ linux/drivers/media/video/saa5249.c	Sun Oct 10 09:40:33 2004
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
 
 
 
@@ -579,6 +582,54 @@
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
  
@@ -589,6 +640,7 @@
 	struct saa5249_device *t=vd->priv;
 	int err;
 	
+	cmd = vtx_fix_command(cmd);
 	down(&t->lock);
 	err = video_usercopy(inode,file,cmd,arg,do_saa5249_ioctl);
 	up(&t->lock);
diff -u -N -r linux-2.6.8.1/include/linux/videotext.h linux/include/linux/videotext.h
--- linux-2.6.8.1/include/linux/videotext.h	Sat Aug 14 12:56:23 2004
+++ linux/include/linux/videotext.h	Sun Oct 10 08:34:33 2004
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
@@ -102,43 +121,5 @@
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
