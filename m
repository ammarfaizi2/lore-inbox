Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288914AbSBZPHu>; Tue, 26 Feb 2002 10:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287874AbSBZPHb>; Tue, 26 Feb 2002 10:07:31 -0500
Received: from basket.ball.reliam.net ([213.91.6.7]:62738 "HELO
	basket.ball.reliam.net") by vger.kernel.org with SMTP
	id <S288800AbSBZPHP>; Tue, 26 Feb 2002 10:07:15 -0500
Date: Tue, 26 Feb 2002 16:06:45 +0100
From: Urs Ganse <ursg@uni.de>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Patch: sstfb support for interlace / doublescan modes.
Message-ID: <20020226150645.GA1157@interblob>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone!

This patch adds support for interlace and doublescan modes to the sstfb
(voodoo 1 /2) framebuffer driver.

I have been trying to get in touch with this driver's maintainer
(Ghozlane Toumi) for quite some time now, but I won't get any replies,
neither from the eMail-address supplied in the kernel source, nor from
another one that I found on the web. Does anybody know how he is
reachable now?

Sincerely,
	Urs Ganse
-- 
 Urs Ganse
                                                             ursg@uni.de
______________________________________________________FIDO: 2:2432/700.2

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sstfb-patch

--- linux/drivers/video/sstfb.c	Sat Dec 22 18:26:16 2001
+++ linux/drivers/video/sstfb.c	Tue Feb 26 14:23:05 2002
@@ -5,12 +5,16 @@
  *
  *     Created 15 Jan 2000 by Ghozlane Toumi
  *
+ *     NOTE: I have been unable to reach Ghozlane through the eMail-address
+ *     given above for more than 3 months, same with another address of him
+ *     which I found on the web. - Urs
+ *
  * Contributions (and many thanks) :
  *
  * 03/2001 James Simmons   <jsimmons@linux-fbdev.org>
  * 04/2001 Paul Mundt      <lethal@chaoticdreams.org>
- * 05/2001 Urs Ganse       <urs.ganse@t-online.de>
- *     (initial work on voodoo2 port)
+ * 05/2001 Urs Ganse       <ursg@uni.de>
+ *     (initial work on voodoo2 port, added interlace support)
  *
  *
  * $Id: sstfb.c,v 1.26.4.1 2001/08/29 01:30:37 ghoz Exp $
@@ -59,6 +63,8 @@
 -TODO: change struct sst_info fb_info from static to array/dynamic
   TTT comments is for code i've put there for debuging the "weird peinguin 
   	syndrome", it should disapear soon
+-FIXME: Some uninitialized variable causes sporadic crashes when setting a video
+       mode for the first time.
 
  *
  */
@@ -208,7 +214,7 @@
 
 /********/
 
-/* Interface to ze oueurld  */
+/* Interface to the world  */
 int sstfb_init(void);
 int sstfb_setup(char *options);
 
@@ -599,9 +605,8 @@
 		         var->xres, var->yres);
 		return -EINVAL;
 	}
-	if ((var->vmode & FB_VMODE_MASK) !=  FB_VMODE_NONINTERLACED) {
-		eprintk("Interlace non supported %#x\n",
-			(var->vmode & FB_VMODE_MASK));
+	if((var->vmode & FB_VMODE_MASK) && !sst_info->is_voodoo2 ){
+		eprintk ("Interlace modes not supported on Voodoo 1 hardware.\n");
 		return -EINVAL;
 	}
 
@@ -615,7 +620,17 @@
 	par->vSyncOn    = var->vsync_len;
 	par->vSyncOff   = var->yres + var->lower_margin + var->upper_margin;
 	par->vBackPorch = var->upper_margin;
-
+	
+	par->flags      = 0;
+	if (var->vmode & FB_VMODE_INTERLACED) {
+//		printk(KERN_DEBUG "sstfb: This is an interlace mode.\n");
+		par->flags|=FB_VMODE_INTERLACED;
+	}
+	if(var->vmode & FB_VMODE_DOUBLE) {
+//		printk(KERN_DEBUG "sstfb: This is a doublescan mode.\n");
+		par->flags|=FB_VMODE_DOUBLE;
+	}
+		
 	switch (var->bits_per_pixel) {
 	case 0 ... 16 :
 		par->bpp = 16;
@@ -685,7 +700,7 @@
 	var->lower_margin   = par->vSyncOff - par->yDim - par->vBackPorch;
 	var->hsync_len      = par->hSyncOn;
 	var->vsync_len      = par->vSyncOn;
-	var->vmode          = FB_VMODE_NONINTERLACED;
+	var->vmode          = par->flags;
 
 	/*
 	 * correct the color bit fields
@@ -1375,6 +1390,17 @@
 	sst_write(HSYNC,         (par->hSyncOff-1) << 16 | (par->hSyncOn-1));
 	sst_write(VSYNC,             par->vSyncOff << 16 | par->vSyncOn);
 
+	/* Interlace or Doublescan */
+	if(par->flags & FB_VMODE_INTERLACED)
+		sst_set_bits(FBIINIT5,1>>26);
+	else
+		sst_unset_bits(FBIINIT5,1>>26);
+	
+	if(par->flags & FB_VMODE_DOUBLE)
+		sst_set_bits(FBIINIT5,1>>20);
+	else
+		sst_unset_bits(FBIINIT5,1>>20);
+	
 	fbiinit2=sst_read(FBIINIT2);
 	fbiinit3=sst_read(FBIINIT3);

--- linux/drivers/video/sstfb.h	Sat Dec 22 18:26:21 2001
+++ linux/drivers/video/sstfb.h	Tue Feb 26 13:16:01 2002
@@ -317,6 +317,7 @@
 	unsigned int vSyncOn;
 	unsigned int vSyncOff;
 	unsigned int vBackPorch;
+	unsigned int flags;	/* Doublescan, Interlace etc. */
 	unsigned int freq;	/* freq in picoseconds */
 	unsigned int tiles_in_X; /* num of tiles in X res */
 };

--EeQfGwPcQSOJBaQU--
