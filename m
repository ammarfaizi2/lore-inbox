Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUDMIkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbUDMIis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:38:48 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:29772 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S263213AbUDMIiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:38:08 -0400
Date: Tue, 13 Apr 2004 10:38:05 +0200
Message-Id: <200404130838.i3D8c5ZL018436@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 426] pm2fb barrier cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Permedia2: Always use the standard barrier macros (they do exist on m68k, and
map to barrier())

--- linux-2.6.5-rc2/drivers/video/pm2fb.c	2004-03-21 10:44:13.000000000 +0100
+++ linux-m68k-2.6.5-rc2/drivers/video/pm2fb.c	2004-03-21 12:05:38.000000000 +0100
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
@@ -746,7 +735,7 @@
     
 	set_aperture(par, depth);
     
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
