Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUCINFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 08:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbUCINFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 08:05:33 -0500
Received: from witte.sonytel.be ([80.88.33.193]:39301 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261907AbUCINFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 08:05:05 -0500
Date: Tue, 9 Mar 2004 14:04:52 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux/PPC on APUS development 
	<linux-apus-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] New Permedia2 framebuffer driver.
In-Reply-To: <Pine.LNX.4.44.0403032220410.30666-100000@phoenix.infradead.org>
Message-ID: <Pine.GSO.4.58.0403091400530.28127@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0403032220410.30666-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2004, James Simmons wrote:
> This patch fixes the permedia2 framebuffer driver. Currently it doesn't
> event compile. This patch only touches the current permedia driver.
> Regular patch is valiable at
>
> http://phoenix.infradead.org/~jsimmons/pm2fb.diff

I suggest the following changes:
  - Mark FB_PM2 broken on Amiga, until somebody fixes it (pm2fb.c explicitly
    tests for CONFIG_PCI right now)
  - Always use the standard barrier macros (they do exist on m68k, and map to
    barrier())
  - Fix set_aperture() on big endian (pm2fb_par->depth doesn't exist)

--- linux-2.6.4-rc2/drivers/video/Kconfig	2004-03-04 11:31:17.000000000 +0100
+++ linux-m68k-2.6.4-rc2/drivers/video/Kconfig	2004-03-04 16:35:00.000000000 +0100
@@ -55,7 +55,7 @@

 config FB_PM2
 	tristate "Permedia2 support"
-	depends on FB && (AMIGA || PCI)
+	depends on FB && ((AMIGA && BROKEN) || PCI)
 	help
 	  This is the frame buffer device driver for the Permedia2 AGP frame
 	  buffer card from ASK, aka `Graphic Blaster Exxtreme'.  There is a
--- linux-2.6.4-rc2/drivers/video/pm2fb.c	2004-03-04 11:31:17.000000000 +0100
+++ linux-m68k-2.6.4-rc2/drivers/video/pm2fb.c	2004-03-04 16:30:48.000000000 +0100
@@ -62,17 +62,6 @@
 #define DPRINTK(a,b...)
 #endif

-/* Memory barriers. */
-#ifdef __mc68000__
-#define DEFW()
-#define DEFR()
-#define DEFRW()
-#else
-#define DEFW()		wmb()
-#define DEFR()		rmb()
-#define DEFRW()		mb()
-#endif
-
 /*
  * Driver data
  */
@@ -182,7 +171,7 @@
 		index = PM2VR_RD_INDEXED_DATA;
 		break;
 	}
-	DEFRW();
+	mb();
 	return pm2_RD(p, index);
 }

@@ -198,21 +187,21 @@
 		index = PM2VR_RD_INDEXED_DATA;
 		break;
 	}
-	DEFRW();
+	mb();
 	pm2_WR(p, index, v);
 }

 inline static u32 pm2v_RDAC_RD(struct pm2fb_par* p, s32 idx)
 {
 	pm2_WR(p, PM2VR_RD_INDEX_LOW, idx & 0xff);
-	DEFRW();
+	mb();
 	return pm2_RD(p, PM2VR_RD_INDEXED_DATA);
 }

 inline static void pm2v_RDAC_WR(struct pm2fb_par* p, s32 idx, u32 v)
 {
 	pm2_WR(p, PM2VR_RD_INDEX_LOW, idx & 0xff);
-	DEFRW();
+	mb();
 	pm2_WR(p, PM2VR_RD_INDEXED_DATA, v);
 }

@@ -222,7 +211,7 @@
 inline static void WAIT_FIFO(struct pm2fb_par* p, u32 a)
 {
 	while( pm2_RD(p, PM2R_IN_FIFO_SPACE) < a );
-	DEFRW();
+	mb();
 }
 #endif

@@ -342,7 +331,7 @@

 	WAIT_FIFO(p, 1);
 	pm2_WR(p, PM2R_RD_PALETTE_WRITE_ADDRESS, 0);
-	DEFW();
+	wmb();
 	while (i--) {
 		WAIT_FIFO(p, 3);
 		pm2_WR(p, PM2R_RD_PALETTE_DATA, 0);
@@ -366,14 +355,14 @@
 	if (p->type == PM2_TYPE_PERMEDIA2V)
 		pm2_WR(p, PM2VR_RD_INDEX_HIGH, 0);
 	pm2_WR(p, PM2R_RESET_STATUS, 0);
-	DEFRW();
+	mb();
 	while (pm2_RD(p, PM2R_RESET_STATUS) & PM2F_BEING_RESET)
 		;
-	DEFRW();
+	mb();
 #ifdef CONFIG_FB_PM2_FIFO_DISCONNECT
 	DPRINTK("FIFO disconnect enabled\n");
 	pm2_WR(p, PM2R_FIFO_DISCON, 1);
-	DEFRW();
+	mb();
 #endif
 }
 #endif
@@ -434,14 +423,14 @@
 	pm2_RDAC_WR(p, PM2I_RD_BLUE_KEY, 0);
 }

-static void set_aperture(struct pm2fb_par* p)
+static void set_aperture(struct pm2fb_par *p, u32 depth)
 {
 	WAIT_FIFO(p, 4);
 #ifdef __LITTLE_ENDIAN
 	pm2_WR(p, PM2R_APERTURE_ONE, 0);
 	pm2_WR(p, PM2R_APERTURE_TWO, 0);
 #else
-	switch (p->depth) {
+	switch (depth) {
 	case 8:
 	case 24:
 		pm2_WR(p, PM2R_APERTURE_ONE, 0);
@@ -464,11 +453,11 @@
 {
 	WAIT_FIFO(p, 4);
 	pm2_WR(p, PM2R_RD_PALETTE_WRITE_ADDRESS, regno);
-	DEFW();
+	wmb();
 	pm2_WR(p, PM2R_RD_PALETTE_DATA, r);
-	DEFW();
+	wmb();
 	pm2_WR(p, PM2R_RD_PALETTE_DATA, g);
-	DEFW();
+	wmb();
 	pm2_WR(p, PM2R_RD_PALETTE_DATA, b);
 }

@@ -482,14 +471,14 @@
 		pm2_mnp(clk, &m, &n, &p);
 		WAIT_FIFO(par, 8);
 		pm2_RDAC_WR(par, PM2I_RD_PIXEL_CLOCK_A3, 0);
-		DEFW();
+		wmb();
 		pm2_RDAC_WR(par, PM2I_RD_PIXEL_CLOCK_A1, m);
 		pm2_RDAC_WR(par, PM2I_RD_PIXEL_CLOCK_A2, n);
-		DEFW();
+		wmb();
 		pm2_RDAC_WR(par, PM2I_RD_PIXEL_CLOCK_A3, 8|p);
-		DEFW();
+		wmb();
 		pm2_RDAC_RD(par, PM2I_RD_PIXEL_CLOCK_STATUS);
-		DEFR();
+		rmb();
 		for (i = 256;
 		     i && !(pm2_RD(par, PM2R_RD_INDEXED_DATA) & PM2F_PLL_LOCKED);
 		     i--)
@@ -744,9 +733,9 @@
 		pm2_WR(par, PM2VR_RD_INDEX_HIGH, 0);
 	}

-	set_aperture(par);
+	set_aperture(par, depth);

-	DEFRW();
+	mb();
 	WAIT_FIFO(par, 19);
 	pm2_RDAC_WR(par, PM2I_RD_COLOR_KEY_CONTROL,
 		    ( depth == 8 ) ? 0 : PM2F_COLOR_KEY_TEST_OFF);
@@ -794,13 +783,13 @@
 	pm2_WR(par, PM2R_VS_END, vsend);
 	pm2_WR(par, PM2R_VB_END, vbend);
 	pm2_WR(par, PM2R_SCREEN_STRIDE, stride);
-	DEFW();
+	wmb();
 	pm2_WR(par, PM2R_WINDOW_ORIGIN, 0);
 	pm2_WR(par, PM2R_SCREEN_SIZE, (height << 16) | width);
 	pm2_WR(par, PM2R_SCISSOR_MODE, PM2F_SCREEN_SCISSOR_ENABLE);
-	DEFW();
+	wmb();
 	pm2_WR(par, PM2R_SCREEN_BASE, base);
-	DEFW();
+	wmb();
 	set_video(par, video);
 	WAIT_FIFO(par, 4);
 	switch (par->type) {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
