Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262734AbUKRLJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbUKRLJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 06:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbUKRLJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 06:09:36 -0500
Received: from mail.renesas.com ([202.234.163.13]:34300 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262732AbUKRLHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 06:07:08 -0500
Date: Thu, 18 Nov 2004 20:06:50 +0900 (JST)
Message-Id: <20041118.200650.1059965981.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rddunlap@osdl.org, takata@linux-m32r.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc2-bk1] media: Update drivers/media/video/arv.c
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <419B7D9B.9050302@osdl.org>
References: <20041117.153201.27776357.takata.hirokazu@renesas.com>
	<419B7D9B.9050302@osdl.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made an additional patch for drivers/media/video/arv.c
based on Randy's comment.
  # Many thanks for kind comment, Randy.

Please apply.

 	* drivers/media/video/arv.c:
	- Fix color correction parameters.
	- Add inline functions; wait_for_vsync(), wait_acknowledge(),
	  disable_dma(), enable_dma() and clear_dma_status().
	- Change c++-style comments to c-style comment.
	- Add cpu_relax() to "for" and "while" busy loops.
 	- Fix more white-space damages.
	- Fix typos.

Regards,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arv.c |  294 +++++++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 166 insertions(+), 128 deletions(-)


diff -ruNp a/drivers/media/video/arv.c b/drivers/media/video/arv.c
--- a/drivers/media/video/arv.c	2004-11-17 15:11:17.000000000 +0900
+++ b/drivers/media/video/arv.c	2004-11-18 19:09:18.000000000 +0900
@@ -54,7 +54,7 @@
  */
 #define USE_INT		0	/* Don't modify */
 
-#define VERSION	"0.02"
+#define VERSION	"0.03"
 
 #define ar_inl(addr) 		inl((unsigned long)(addr))
 #define ar_outl(val, addr)	outl((unsigned long)(val),(unsigned long)(addr))
@@ -89,12 +89,12 @@ extern struct cpuinfo_m32r	boot_cpu_data
 #define MAX_AR_LINE_BYTES	AR_LINE_BYTES_VGA
 
 /* frame size & type */
-#define AR_FRAME_BYTES_VGA	(AR_WIDTH_VGA * AR_HEIGHT_VGA * \
-				 AR_BYTES_PER_PIXEL)
-#define AR_FRAME_BYTES_QVGA	(AR_WIDTH_QVGA * AR_HEIGHT_QVGA * \
-				 AR_BYTES_PER_PIXEL)
-#define MAX_AR_FRAME_BYTES	(MAX_AR_WIDTH * MAX_AR_HEIGHT * \
-				 AR_BYTES_PER_PIXEL)
+#define AR_FRAME_BYTES_VGA \
+	(AR_WIDTH_VGA * AR_HEIGHT_VGA * AR_BYTES_PER_PIXEL)
+#define AR_FRAME_BYTES_QVGA \
+	(AR_WIDTH_QVGA * AR_HEIGHT_QVGA * AR_BYTES_PER_PIXEL)
+#define MAX_AR_FRAME_BYTES \
+	(MAX_AR_WIDTH * MAX_AR_HEIGHT * AR_BYTES_PER_PIXEL)
 
 #define AR_MAX_FRAME		15
 
@@ -108,13 +108,13 @@ extern struct cpuinfo_m32r	boot_cpu_data
 
 struct ar_device {
 	struct video_device *vdev;
-	unsigned int start_capture;		// duaring capture in INT. mode.
+	unsigned int start_capture;	/* duaring capture in INT. mode. */
 #if USE_INT
-	unsigned char *line_buff;		// DMA line buffer
+	unsigned char *line_buff;	/* DMA line buffer */
 #endif
-	unsigned char *frame[MAX_AR_HEIGHT];	// frame data
-	short size;				// capture size
-	short mode;				// capture mode
+	unsigned char *frame[MAX_AR_HEIGHT];	/* frame data */
+	short size;			/* capture size */
+	short mode;			/* capture mode */
 	int width, height;
 	int frame_bytes, line_bytes;
 	wait_queue_head_t wait;
@@ -126,7 +126,7 @@ static unsigned char	yuv[MAX_AR_FRAME_BY
 
 /* module parameters */
 /* default frequency */
-#define DEFAULT_FREQ	50	// 50 or 75 (MHz) is available as BCLK
+#define DEFAULT_FREQ	50	/* 50 or 75 (MHz) is available as BCLK */
 static int freq = DEFAULT_FREQ;	/* BCLK: available 50 or 75 (MHz) */
 static int vga = 0;		/* default mode(0:QVGA mode, other:VGA mode) */
 static int vga_interlace = 0;	/* 0 is normal mode for, else interlace mode */
@@ -136,64 +136,68 @@ module_param(vga_interlace, bool, 0644);
 
 static int ar_initialize(struct video_device *dev);
 
+static inline void wait_for_vsync(void)
+{
+	while (ar_inl(ARVCR0) & ARVCR0_VDS)	/* wait for VSYNC */
+		cpu_relax();
+	while (!(ar_inl(ARVCR0) & ARVCR0_VDS))	/* wait for VSYNC */
+		cpu_relax();
+}
+
+static inline void wait_acknowledge(void)
+{
+	int i;
+
+	for (i = 0; i < 1000; i++)
+		cpu_relax();
+	while (ar_inl(PLDI2CSTS) & PLDI2CSTS_NOACK)
+		cpu_relax();
+}
+
 /*******************************************************************
  * I2C functions
  *******************************************************************/
-void iic(int n, unsigned long addr, unsigned long data1, unsigned long data2, unsigned long data3)
+void iic(int n, unsigned long addr, unsigned long data1, unsigned long data2,
+	 unsigned long data3)
 {
 	int i;
 
 	/* Slave Address */
 	ar_outl(addr, PLDI2CDATA);
+	wait_for_vsync();
 
-	while ( ar_inl(ARVCR0) & ARVCR0_VDS ); 	  // wait for VSYNC
-	while ( !(ar_inl(ARVCR0) & ARVCR0_VDS) ); // wait for VSYNC
 	/* Start */
 	ar_outl(1, PLDI2CCND);
+	wait_acknowledge();
 
-	for(i=0; i<1000; i++);
-	while( ar_inl(PLDI2CSTS) & PLDI2CSTS_NOACK );
-
-	/* Trasfer data 1 */
+	/* Transfer data 1 */
 	ar_outl(data1, PLDI2CDATA);
-	while ( ar_inl(ARVCR0) & ARVCR0_VDS ); 	  // wait for VSYNC
-	while ( !(ar_inl(ARVCR0) & ARVCR0_VDS) ); // wait for VSYNC
+	wait_for_vsync();
 	ar_outl(PLDI2CSTEN_STEN, PLDI2CSTEN);
+	wait_acknowledge();
 
-	/* Ack wait */
-	for(i=0; i<1000; i++);
-	while( ar_inl(PLDI2CSTS) & PLDI2CSTS_NOACK );
-
-	/* Trasfer data 2 */
+	/* Transfer data 2 */
 	ar_outl(data2, PLDI2CDATA);
-	while ( ar_inl(ARVCR0) & ARVCR0_VDS ); 	  // wait for VSYNC
-	while ( !(ar_inl(ARVCR0) & ARVCR0_VDS) ); // wait for VSYNC
+	wait_for_vsync();
 	ar_outl(PLDI2CSTEN_STEN, PLDI2CSTEN);
+	wait_acknowledge();
 
-	/* Ack wait */
-	for(i=0; i<1000; i++);
-
-	while( ar_inl(PLDI2CSTS) & PLDI2CSTS_NOACK );
-
-	if(n==3){
-		/* Trasfer data 3 */
+	if (n == 3) {
+		/* Transfer data 3 */
 		ar_outl(data3, PLDI2CDATA);
-		while ( ar_inl(ARVCR0) & ARVCR0_VDS );    // wait for VSYNC
-		while ( !(ar_inl(ARVCR0) & ARVCR0_VDS) ); // wait for VSYNC
+		wait_for_vsync();
 		ar_outl(PLDI2CSTEN_STEN, PLDI2CSTEN);
-
-		/* Ack wait */
-		for(i=0; i<10000; i++);
-
-		while( ar_inl(PLDI2CSTS) & PLDI2CSTS_NOACK );
+		wait_acknowledge();
 	}
 
 	/* Stop */
-	for(i=0; i<100; i++);
+	for (i = 0; i < 100; i++)
+		cpu_relax();
 	ar_outl(2, PLDI2CCND);
 	ar_outl(2, PLDI2CCND);
 
-	while( ar_inl(PLDI2CSTS) & PLDI2CSTS_BB );
+	while (ar_inl(PLDI2CSTS) & PLDI2CSTS_BB)
+		cpu_relax();
 }
 
 
@@ -216,7 +220,7 @@ void init_iic(void)
 	} else if (freq == 50) {
 		ar_outl(244, PLDI2CFREQ);	/* BCLK = 50MHz */
 	} else {
-		ar_outl(244, PLDI2CFREQ);	/* default:BCLK = 50MHz */
+		ar_outl(244, PLDI2CFREQ);	/* default: BCLK = 50MHz */
 	}
 	ar_outl(0x1, PLDI2CCR); 		/* I2CCR Enable */
 }
@@ -226,6 +230,22 @@ void init_iic(void)
  * Video4Linux Interface functions
  *
  **************************************************************************/
+
+static inline void disable_dma(void)
+{
+	ar_outl(0x8000, M32R_DMAEN_PORTL);	/* disable DMA0 */
+}
+
+static inline void enable_dma(void)
+{
+	ar_outl(0x8080, M32R_DMAEN_PORTL);	/* enable DMA0 */
+}
+
+static inline void clear_dma_status(void)
+{
+	ar_outl(0x8000, M32R_DMAEDET_PORTL);	/* clear status */
+}
+
 static inline void wait_for_vertical_sync(int exp_line)
 {
 #if CHECK_LOST
@@ -233,16 +253,18 @@ static inline void wait_for_vertical_syn
 	int l;
 
 	/*
-	 * check HCOUNT because we can not check vertual sync.
+	 * check HCOUNT because we cannot check vertical sync.
 	 */
 	for (; tmout >= 0; tmout--) {
 		l = ar_inl(ARVHCOUNT);
-		if (l == exp_line) break;
+		if (l == exp_line)
+			break;
 	}
 	if (tmout < 0)
 		printk("arv: lost %d -> %d\n", exp_line, l);
 #else
-	while (ar_inl(ARVHCOUNT) != exp_line) ;
+	while (ar_inl(ARVHCOUNT) != exp_line)
+		cpu_relax();
 #endif
 }
 
@@ -262,24 +284,26 @@ static ssize_t ar_read(struct file *file
 
 	DEBUG(1, "ar_read()\n");
 
-	if (ar->size == AR_SIZE_QVGA) arvcr1 |= ARVCR1_QVGA;
-	if (ar->mode == AR_MODE_NORMAL) arvcr1 |= ARVCR1_NORMAL;
+	if (ar->size == AR_SIZE_QVGA)
+		arvcr1 |= ARVCR1_QVGA;
+	if (ar->mode == AR_MODE_NORMAL)
+		arvcr1 |= ARVCR1_NORMAL;
 
 	down(&ar->lock);
 
 #if USE_INT
 	local_irq_save(flags);
-	ar_outl(0x80000, M32R_DMAEN_PORTL);		// disable DMA0
+	disable_dma();
 	ar_outl(0xa1871300, M32R_DMA0CR0_PORTL);
 	ar_outl(0x01000000, M32R_DMA0CR1_PORTL);
 
-	// set AR FIFO address as source(BSEL5)
-	ar_outl(ARDATA32, M32R_DMA0CSA_PORTL);		//
-	ar_outl(ARDATA32, M32R_DMA0RSA_PORTL);		//
-	ar_outl(ar->line_buff, M32R_DMA0CDA_PORTL);	// destination address
-	ar_outl(ar->line_buff, M32R_DMA0RDA_PORTL); 	// reload address
-	ar_outl(ar->line_bytes, M32R_DMA0CBCUT_PORTL); 	// byte count(bytes)
-	ar_outl(ar->line_bytes, M32R_DMA0RBCUT_PORTL); 	// reload count (bytes)
+	/* set AR FIFO address as source(BSEL5) */
+	ar_outl(ARDATA32, M32R_DMA0CSA_PORTL);
+	ar_outl(ARDATA32, M32R_DMA0RSA_PORTL);
+	ar_outl(ar->line_buff, M32R_DMA0CDA_PORTL);	/* destination addr. */
+	ar_outl(ar->line_buff, M32R_DMA0RDA_PORTL); 	/* reload address */
+	ar_outl(ar->line_bytes, M32R_DMA0CBCUT_PORTL); 	/* byte count (bytes) */
+	ar_outl(ar->line_bytes, M32R_DMA0RBCUT_PORTL); 	/* reload count (bytes) */
 
 	/*
 	 * Okey , kicks AR LSI to invoke an interrupt
@@ -297,7 +321,7 @@ static ssize_t ar_read(struct file *file
 #else	/* ! USE_INT */
 	/* polling */
 	ar_outl(arvcr1, ARVCR1);
-	ar_outl(0x80000, M32R_DMAEN_PORTL);		// disable DMA0
+	disable_dma();
 	ar_outl(0x8000, M32R_DMAEDET_PORTL);
 	ar_outl(0xa0861300, M32R_DMA0CR0_PORTL);
 	ar_outl(0x01000000, M32R_DMA0CR1_PORTL);
@@ -307,7 +331,8 @@ static ssize_t ar_read(struct file *file
 	ar_outl(ar->line_bytes, M32R_DMA0RBCUT_PORTL);
 
 	local_irq_save(flags);
-	while (ar_inl(ARVHCOUNT) != 0) ; // wait for 0
+	while (ar_inl(ARVHCOUNT) != 0)		/* wait for 0 */
+		cpu_relax();
 	if (ar->mode == AR_MODE_INTERLACE && ar->size == AR_SIZE_VGA) {
 		for (h = 0; h < ar->height; h++) {
 			wait_for_vertical_sync(h);
@@ -316,20 +341,22 @@ static ssize_t ar_read(struct file *file
 			else
 				l = (((h - (AR_HEIGHT_VGA/2)) << 1) + 1);
 			ar_outl(virt_to_phys(ar->frame[l]), M32R_DMA0CDA_PORTL);
-			ar_outl(0x8080, M32R_DMAEN_PORTL);	// enable DMA0
-			while (!(ar_inl(M32R_DMAEDET_PORTL) & 0x8000)) ;
-			ar_outl(0x80000, M32R_DMAEN_PORTL);	// disable DMA0
-			ar_outl(0x8000, M32R_DMAEDET_PORTL);	// clear status
+			enable_dma();
+			while (!(ar_inl(M32R_DMAEDET_PORTL) & 0x8000))
+				cpu_relax();
+			disable_dma();
+			clear_dma_status();
 			ar_outl(0xa0861300, M32R_DMA0CR0_PORTL);
 		}
 	} else {
 		for (h = 0; h < ar->height; h++) {
 			wait_for_vertical_sync(h);
 			ar_outl(virt_to_phys(ar->frame[h]), M32R_DMA0CDA_PORTL);
-			ar_outl(0x8080, M32R_DMAEN_PORTL);	// enable DMA0
-			while (!(ar_inl(M32R_DMAEDET_PORTL) & 0x8000)) ;
-			ar_outl(0x80000, M32R_DMAEN_PORTL);	// disable DMA0
-			ar_outl(0x8000, M32R_DMAEDET_PORTL);	// clear status
+			enable_dma();
+			while (!(ar_inl(M32R_DMAEDET_PORTL) & 0x8000))
+				cpu_relax();
+			disable_dma();
+			clear_dma_status();
 			ar_outl(0xa0861300, M32R_DMA0CR0_PORTL);
 		}
 	}
@@ -426,8 +453,8 @@ static int ar_do_ioctl(struct inode *ino
 	{
 		struct video_window *w = arg;
 		DEBUG(1, "VIDIOCSWIN:\n");
-		if(w->width != AR_WIDTH_QVGA && w->height != AR_HEIGHT_QVGA)
-			if(w->width != AR_WIDTH_VGA && w->height != AR_HEIGHT_VGA)
+		if ((w->width != AR_WIDTH_VGA || w->height != AR_HEIGHT_VGA) &&
+		    (w->width != AR_WIDTH_QVGA || w->height != AR_HEIGHT_QVGA))
 				return -EINVAL;
 
 		down(&ar->lock);
@@ -514,7 +541,8 @@ static int ar_do_ioctl(struct inode *ino
 	return 0;
 }
 
-static int ar_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+static int ar_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		    unsigned long arg)
 {
 	return video_usercopy(inode, file, cmd, arg, ar_do_ioctl);
 }
@@ -530,7 +558,7 @@ static void ar_interrupt(int irq, void *
 	unsigned int line_number;
 	unsigned int arvcr1;
 
-	line_count = ar_inl(ARVHCOUNT);			// line number
+	line_count = ar_inl(ARVHCOUNT);			/* line number */
 	if (ar->mode == AR_MODE_INTERLACE && ar->size == AR_SIZE_VGA) {
 		/* operations for interlace mode */
 		if ( line_count < (AR_HEIGHT_VGA/2) )	/* even line */
@@ -547,17 +575,21 @@ static void ar_interrupt(int irq, void *
 		 * It is an interrupt for line 0.
 		 * we have to start capture.
 		 */
-		ar_outl(0x8000, M32R_DMAEN_PORTL);		// disable DMA0
-		//ar_outl(ar->line_buff, M32R_DMA0CDA_PORTL);	// needless?
+		disable_dma();
+#if 0
+		ar_outl(ar->line_buff, M32R_DMA0CDA_PORTL);	/* needless? */
+#endif
 		memcpy(ar->frame[0], ar->line_buff, ar->line_bytes);
-		//ar_outl(0xa1861300, M32R_DMA0CR0_PORTL);
-		ar_outl(0x8080, M32R_DMAEN_PORTL);		// enable DMA0
-		ar->start_capture = 1;				// during capture
+#if 0
+		ar_outl(0xa1861300, M32R_DMA0CR0_PORTL);
+#endif
+		enable_dma();
+		ar->start_capture = 1;			/* during capture */
 		return;
 	}
 
 	if (ar->start_capture == 1 && line_number <= (ar->height - 1)) {
-		ar_outl(0x8000, M32R_DMAEN_PORTL);		// disable DMA0
+		disable_dma();
 		memcpy(ar->frame[line_number], ar->line_buff, ar->line_bytes);
 
 		/*
@@ -570,13 +602,15 @@ static void ar_interrupt(int irq, void *
 
 			/* disable AR interrupt request */
 			arvcr1 = ar_inl(ARVCR1);
-			arvcr1 &= ~ARVCR1_HIEN;		// clear int. flag
-			ar_outl(arvcr1, ARVCR1);	// disable
+			arvcr1 &= ~ARVCR1_HIEN;		/* clear int. flag */
+			ar_outl(arvcr1, ARVCR1);	/* disable */
 			wake_up_interruptible(&ar->wait);
 		} else {
-			//ar_outl(ar->line_buff, M32R_DMA0CDA_PORTL);
-			//ar_outl(0xa1861300, M32R_DMA0CR0_PORTL);
-			ar_outl(0x8080, M32R_DMAEN_PORTL);		// enable DMA
+#if 0
+			ar_outl(ar->line_buff, M32R_DMA0CDA_PORTL);
+			ar_outl(0xa1861300, M32R_DMA0CR0_PORTL);
+#endif
+			enable_dma();
 		}
 	}
 }
@@ -602,16 +636,20 @@ static int ar_initialize(struct video_de
 	/*
 	 * initialize AR LSI
 	 */
-	ar_outl(0, ARVCR0);		// assert reset of AR LSI
-	for( i=0; i<0x18; i++);		// wait for over 10 cycles @ 27MHz
-	ar_outl(ARVCR0_RST, ARVCR0);	// negate reset of AR LSI (enable)
-	for( i=0; i<0x40d; i++);	// wait for over 420 cycles @ 27MHz
+	ar_outl(0, ARVCR0);		/* assert reset of AR LSI */
+	for (i = 0; i < 0x18; i++)	/* wait for over 10 cycles @ 27MHz */
+		cpu_relax();
+	ar_outl(ARVCR0_RST, ARVCR0);	/* negate reset of AR LSI (enable) */
+	for (i = 0; i < 0x40d; i++)	/* wait for over 420 cycles @ 27MHz */
+		cpu_relax();
 
 	/* AR uses INT3 of CPU as interrupt pin. */
 	ar_outl(ARINTSEL_INT3, ARINTSEL);
 
-	if (ar->size == AR_SIZE_QVGA) cr |= ARVCR1_QVGA;
-	if (ar->mode == AR_MODE_NORMAL) cr |= ARVCR1_NORMAL;
+	if (ar->size == AR_SIZE_QVGA)
+		cr |= ARVCR1_QVGA;
+	if (ar->mode == AR_MODE_NORMAL)
+		cr |= ARVCR1_NORMAL;
 	ar_outl(cr, ARVCR1);
 
 	/*
@@ -620,18 +658,19 @@ static int ar_initialize(struct video_de
 	 */
 	init_iic();
 
-	for( i=0; i<0x100000; i++) // > 0xa1d10,  56ms
-		if((ar_inl(ARVCR0) & ARVCR0_VDS)){ // VSYNC
+	for (i = 0; i < 0x100000; i++) {	/* > 0xa1d10,  56ms */
+		if ((ar_inl(ARVCR0) & ARVCR0_VDS)) {	/* VSYNC */
 			found = 1;
 			break;
 		}
+	}
 
-	if(found == 0)
+	if (found == 0)
 		return -ENODEV;
 
 	printk("arv: Initializing ");
 
-	iic(2,0x78,0x11,0x01,0x00);	// start
+	iic(2,0x78,0x11,0x01,0x00);	/* start */
 	iic(3,0x78,0x12,0x00,0x06);
 	iic(3,0x78,0x12,0x12,0x30);
 	iic(3,0x78,0x12,0x15,0x58);
@@ -651,7 +690,9 @@ static int ar_initialize(struct video_de
 	printk(".");
 	iic(2,0x78,0x8e,0x0c,0x00);
 	iic(2,0x78,0x8f,0x00,0x00);
-//	iic(2,0x78,0x90,0x00,0x00);	// AWB on=1 off=0
+#if 0
+	iic(2,0x78,0x90,0x00,0x00);	/* AWB on=1 off=0 */
+#endif
 	iic(2,0x78,0x93,0x01,0x00);
 	iic(2,0x78,0x94,0xcd,0x00);
 	iic(2,0x78,0x95,0x00,0x00);
@@ -668,34 +709,24 @@ static int ar_initialize(struct video_de
 	iic(2,0x78,0x9e,0x2e,0x00);
 	iic(2,0x78,0xb8,0x78,0x00);
 	iic(2,0x78,0xba,0x05,0x00);
-//	iic(2,0x78,0x83,0x8c,0x00);	// brightness
-	printk(".");
-
-	// color correction
 #if 0
-	iic(3,0x78,0x49,0x00,0x89);	// a
-	iic(3,0x78,0x49,0x01,0x96);	// b
-	iic(3,0x78,0x49,0x03,0x85);	// c
-	iic(3,0x78,0x49,0x04,0x87);	// d
-	iic(3,0x78,0x49,0x02,0x66);	// e(Lo)
-	iic(3,0x78,0x49,0x05,0x84);	// f(Lo)
-	iic(3,0x78,0x49,0x06,0x04);	// e(Hi)
-	iic(3,0x78,0x49,0x07,0x04);	// e(Hi)
-	iic(2,0x78,0x48,0x01,0x00);	// on=1 off=0
-#else
-	iic(3,0x78,0x49,0x00,0x95);	// a
-	iic(3,0x78,0x49,0x01,0x96);	// b
-	iic(3,0x78,0x49,0x03,0x85);	// c
-	iic(3,0x78,0x49,0x04,0x97);	// d
-	iic(3,0x78,0x49,0x02,0x7e);	// e(Lo)
-	iic(3,0x78,0x49,0x05,0xa4);	// f(Lo)
-	iic(3,0x78,0x49,0x06,0x04);	// e(Hi)
-	iic(3,0x78,0x49,0x07,0x04);	// e(Hi)
-	iic(2,0x78,0x48,0x01,0x00);	// on=1 off=0
+	iic(2,0x78,0x83,0x8c,0x00);	/* brightness */
 #endif
+	printk(".");
+
+	/* color correction */
+	iic(3,0x78,0x49,0x00,0x95);	/* a		*/
+	iic(3,0x78,0x49,0x01,0x96);	/* b		*/
+	iic(3,0x78,0x49,0x03,0x85);	/* c		*/
+	iic(3,0x78,0x49,0x04,0x97);	/* d		*/
+	iic(3,0x78,0x49,0x02,0x7e);	/* e(Lo)	*/
+	iic(3,0x78,0x49,0x05,0xa4);	/* f(Lo)	*/
+	iic(3,0x78,0x49,0x06,0x04);	/* e(Hi)	*/
+	iic(3,0x78,0x49,0x07,0x04);	/* e(Hi)	*/
+	iic(2,0x78,0x48,0x01,0x00);	/* on=1 off=0	*/
 
 	printk(".");
-	iic(2,0x78,0x11,0x00,0x00);	// end
+	iic(2,0x78,0x11,0x00,0x00);	/* end */
 	printk(" done\n");
 	return 0;
 }
@@ -768,12 +799,12 @@ static int __init ar_init(void)
 	}
 
 	ar->vdev = video_device_alloc();
-	if(!ar->vdev){
+	if (!ar->vdev) {
 		printk(KERN_ERR "arv: video_device_alloc() failed\n");
 		return -ENOMEM;
 	}
 	memcpy(ar->vdev, &ar_template, sizeof(ar_template));
-	ar->vdev->priv 	= ar;
+	ar->vdev->priv = ar;
 
 	if (vga) {
 		ar->width 	= AR_WIDTH_VGA;
@@ -797,14 +828,14 @@ static int __init ar_init(void)
 	init_waitqueue_head(&ar->wait);
 
 #if USE_INT
-	if (request_irq(M32R_IRQ_INT3, ar_interrupt, 0, "arv", ar)){
+	if (request_irq(M32R_IRQ_INT3, ar_interrupt, 0, "arv", ar)) {
 		printk("arv: request_irq(%d) failed.\n", M32R_IRQ_INT3);
 		ret = -EIO;
 		goto out_irq;
 	}
 #endif
 
-	if (ar_initialize(ar->vdev) != 0 ){
+	if (ar_initialize(ar->vdev) != 0) {
 		printk("arv: M64278 not found.\n");
 		ret = -ENODEV;
 		goto out_dev;
@@ -816,7 +847,7 @@ static int __init ar_init(void)
 	 * device is named "video[0-64]".
 	 * video_register_device() initializes h/w using ar_initialize().
 	 */
-	if (video_register_device(ar->vdev, VFL_TYPE_GRABBER, video_nr)!=0) {
+	if (video_register_device(ar->vdev, VFL_TYPE_GRABBER, video_nr) != 0) {
 		/* return -1, -ENFILE(full) or others */
 		printk("arv: register video (Colour AR) failed.\n");
 		ret = -ENODEV;
@@ -831,13 +862,18 @@ static int __init ar_init(void)
 out_dev:
 #if USE_INT
 	free_irq(M32R_IRQ_INT3, ar);
+
 out_irq:
 #endif
-	for (i = 0; i < MAX_AR_HEIGHT; i++)
-		if (ar->frame[i]) kfree(ar->frame[i]);
+	for (i = 0; i < MAX_AR_HEIGHT; i++) {
+		if (ar->frame[i])
+			kfree(ar->frame[i]);
+	}
+
 out_line_buff:
 #if USE_INT
 	kfree(ar->line_buff);
+
 out_end:
 #endif
 	return ret;
@@ -863,8 +899,10 @@ static void __exit ar_cleanup_module(voi
 #if USE_INT
 	free_irq(M32R_IRQ_INT3, ar);
 #endif
-	for (i = 0; i < MAX_AR_HEIGHT; i++)
-		if (ar->frame[i]) kfree(ar->frame[i]);
+	for (i = 0; i < MAX_AR_HEIGHT; i++) {
+		if (ar->frame[i])
+			kfree(ar->frame[i]);
+	}
 #if USE_INT
 	kfree(ar->line_buff);
 #endif

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
