Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVAVRmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVAVRmM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 12:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVAVRmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 12:42:12 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:18386 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262612AbVAVRdR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 12:33:17 -0500
Cc: linux-kernel@vger.kernel.org, js@linuxtv.org
In-Reply-To: <1106415266247@linuxtv.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 22 Jan 2005 18:34:33 +0100
Message-Id: <11064152733063@linuxtv.org>
Mime-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
From: Johannes Stezenbach <js@linuxtv.org>
X-SA-Exim-Connect-IP: 217.231.47.99
Subject: [PATCH 8/9] dvb-ttpci: fix SMP race, budget: fixe init race, misc fixes
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] dvb-ttpci: re-added support for Fujitsu-Siemens DVB-S rev 1.6 0x13c2:0x0006
- [DVB] dvb-ttpci: finally clean up debi irq/tasklet handling to make it work on SMP
- [DVB] dvb-ttpci: misc. changes to av7110_send_fw_cmd() error handling done along the way
- [DVB] dvb-ttpci: budgetpatch integrated into dvb-ttpci: enables full ts option running
        in parallel with all previous functions of dvb-ttpci
- [DVB] dvb-ttpci: fix Oops provoked by insmod/rmmod test loop, patch by Emard
- [DVB] budget: Fixed start_ts_capture(): saa7146 will not issue a VPE interrupt
        if VPE bit is set in PSR and VPE interrupts are enabled afterwards.
- [DVB] budget: enable satelco support. code was commented out, but actually it works, patch by Emard
- [DVB] budget: Budget patch improved driver, fixed slight packet loss by using different trigger mode

Signed-off-by: Michael Hunold <hunold@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/ttpci/av7110.c linux-2.6.11-rc2-dvb/drivers/media/dvb/ttpci/av7110.c
--- linux-2.6.11-rc2/drivers/media/dvb/ttpci/av7110.c	2005-01-20 19:54:05.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/ttpci/av7110.c	2005-01-20 19:56:38.000000000 +0100
@@ -67,6 +67,12 @@
 #include "av7110_ca.h"
 #include "av7110_ipack.h"
 
+#define TS_WIDTH  376
+#define TS_HEIGHT 512
+#define TS_BUFLEN (TS_WIDTH*TS_HEIGHT)
+#define TS_MAX_PACKETS (TS_BUFLEN/TS_SIZE)
+
+
 int av7110_debug;
 
 static int vidmode=CVBS_RGB_OUT;
@@ -75,6 +81,7 @@
 static int hw_sections;
 static int rgb_on;
 static int volume = 255;
+static int budgetpatch = 0;
 
 module_param_named(debug, av7110_debug, int, 0644);
 MODULE_PARM_DESC(debug, "debug level (bitmask, default 0)");
@@ -91,6 +98,8 @@
 		" signal on SCART pin 16 to switch SCART video mode from CVBS to RGB");
 module_param(volume, int, 0444);
 MODULE_PARM_DESC(volume, "initial volume: default 255 (range 0-255)");
+module_param(budgetpatch, int, 0444);
+MODULE_PARM_DESC(budgetpatch, "use budget-patch hardware modification: default 0 (0 no, 1 autodetect, 2 always)");
 
 static void restart_feeds(struct av7110 *av7110);
 
@@ -349,27 +358,42 @@
 #endif
 }
 
+#define DEBI_READ 0
+#define DEBI_WRITE 1
+static inline void start_debi_dma(struct av7110 *av7110, int dir,
+				  unsigned long addr, unsigned int len)
+{
+	dprintk(8, "%c %08lx %u\n", dir == DEBI_READ ? 'R' : 'W', addr, len);
+	if (saa7146_wait_for_debi_done(av7110->dev, 0)) {
+		printk(KERN_ERR "%s: saa7146_wait_for_debi_done timed out\n", __FUNCTION__);
+		return;
+	}
+
+	SAA7146_ISR_CLEAR(av7110->dev, MASK_19); /* for good measure */
+	SAA7146_IER_ENABLE(av7110->dev, MASK_19);
+	if (len < 5)
+		len = 5; /* we want a real DEBI DMA */
+	if (dir == DEBI_WRITE)
+		iwdebi(av7110, DEBISWAB, addr, 0, (len + 3) & ~3);
+	else
+		irdebi(av7110, DEBISWAB, addr, 0, len);
+}
+
 static void debiirq (unsigned long data)
 {
 	struct av7110 *av7110 = (struct av7110*) data;
         int type=av7110->debitype;
         int handle=(type>>8)&0x1f;
-	
-//	dprintk(4, "%p\n",av7110);
+	unsigned int xfer = 0;
 
         print_time("debi");
-	SAA7146_IER_DISABLE(av7110->dev, MASK_19);
-	SAA7146_ISR_CLEAR(av7110->dev, MASK_19);
+	dprintk(4, "type 0x%04x\n", type);
 
         if (type==-1) {
 		printk("DEBI irq oops @ %ld, psr:0x%08x, ssr:0x%08x\n",
 		       jiffies, saa7146_read(av7110->dev, PSR),
 		       saa7146_read(av7110->dev, SSR));
-		spin_lock(&av7110->debilock);
-                ARM_ClearMailBox(av7110);
-                ARM_ClearIrq(av7110);
-		spin_unlock(&av7110->debilock);
-                return;
+		goto debi_done;
         }
         av7110->debitype=-1;
 
@@ -379,22 +403,16 @@
                 dvb_dmx_swfilter_packets(&av7110->demux, 
                                       (const u8 *)av7110->debi_virt, 
                                       av7110->debilen/188);
-                spin_lock(&av7110->debilock);
-                iwdebi(av7110, DEBINOSWAP, RX_BUFF, 0, 2);
-                ARM_ClearMailBox(av7110);
-                spin_unlock(&av7110->debilock);
-                return;
+		xfer = RX_BUFF;
+		break;
 
         case DATA_PES_RECORD:
                 if (av7110->demux.recording) 
 			av7110_record_cb(&av7110->p2t[handle],
                                   (u8 *)av7110->debi_virt,
                                   av7110->debilen);
-                spin_lock(&av7110->debilock);
-                iwdebi(av7110, DEBINOSWAP, RX_BUFF, 0, 2);
-                ARM_ClearMailBox(av7110);
-                spin_unlock(&av7110->debilock);
-                return;
+		xfer = RX_BUFF;
+		break;
 
         case DATA_IPMPE:
         case DATA_FSECTION:
@@ -404,11 +422,8 @@
                                              av7110->debilen, NULL, 0, 
                                              av7110->handle2filter[handle], 
                                              DMX_OK, av7110); 
-                spin_lock(&av7110->debilock);
-                iwdebi(av7110, DEBINOSWAP, RX_BUFF, 0, 2);
-                ARM_ClearMailBox(av7110);
-                spin_unlock(&av7110->debilock);
-                return;
+		xfer = RX_BUFF;
+		break;
 
         case DATA_CI_GET:
         {
@@ -425,11 +440,8 @@
                         ci_get_data(&av7110->ci_rbuffer, 
                                     av7110->debi_virt, 
                                     av7110->debilen);
-                spin_lock(&av7110->debilock);
-                iwdebi(av7110, DEBINOSWAP, RX_BUFF, 0, 2);
-                ARM_ClearMailBox(av7110);
-                spin_unlock(&av7110->debilock);
-                return;
+		xfer = RX_BUFF;
+		break;
         }
 
         case DATA_COMMON_INTERFACE:
@@ -449,37 +461,35 @@
                 printk("\n");
         }
 #endif
-                spin_lock(&av7110->debilock);
-                iwdebi(av7110, DEBINOSWAP, RX_BUFF, 0, 2);
-                ARM_ClearMailBox(av7110);
-                spin_unlock(&av7110->debilock);
-                return;
+		xfer = RX_BUFF;
+		break;
 
         case DATA_DEBUG_MESSAGE:
                 ((s8*)av7110->debi_virt)[Reserved_SIZE-1]=0;
                 printk("%s\n", (s8 *)av7110->debi_virt);
-                spin_lock(&av7110->debilock);
-                iwdebi(av7110, DEBINOSWAP, RX_BUFF, 0, 2);
-                ARM_ClearMailBox(av7110);
-                spin_unlock(&av7110->debilock);
-                return;
+		xfer = RX_BUFF;
+		break;
 
         case DATA_CI_PUT:
+		dprintk(4, "debi DATA_CI_PUT\n");
         case DATA_MPEG_PLAY:
+		dprintk(4, "debi DATA_MPEG_PLAY\n");
         case DATA_BMP_LOAD:
-                spin_lock(&av7110->debilock);
-                iwdebi(av7110, DEBINOSWAP, TX_BUFF, 0, 2);
-                ARM_ClearMailBox(av7110);
-                spin_unlock(&av7110->debilock);
-                return;
+		dprintk(4, "debi DATA_BMP_LOAD\n");
+		xfer = TX_BUFF;
+		break;
         default:
                 break;
         }
+debi_done:
         spin_lock(&av7110->debilock);
+	if (xfer)
+		iwdebi(av7110, DEBINOSWAP, xfer, 0, 2);
         ARM_ClearMailBox(av7110);
         spin_unlock(&av7110->debilock);
 }
 
+/* irq from av7110 firmware writing the mailbox register in the DPRAM */
 static void gpioirq (unsigned long data)
 {
 	struct av7110 *av7110 = (struct av7110*) data;
@@ -487,27 +497,29 @@
         int len;
         
         if (av7110->debitype !=-1)
+		/* we shouldn't get any irq while a debi xfer is running */
 		printk("dvb-ttpci: GPIO0 irq oops @ %ld, psr:0x%08x, ssr:0x%08x\n",
 		       jiffies, saa7146_read(av7110->dev, PSR),
 		       saa7146_read(av7110->dev, SSR));
        
-        spin_lock(&av7110->debilock);
+	if (saa7146_wait_for_debi_done(av7110->dev, 0)) {
+		printk(KERN_ERR "%s: saa7146_wait_for_debi_done timed out\n", __FUNCTION__);
+		BUG(); /* maybe we should try resetting the debi? */
+	}
 
+	spin_lock(&av7110->debilock);
 	ARM_ClearIrq(av7110);
 
-	SAA7146_IER_DISABLE(av7110->dev, MASK_19);
-	SAA7146_ISR_CLEAR(av7110->dev, MASK_19);
-
+	/* see what the av7110 wants */
         av7110->debitype = irdebi(av7110, DEBINOSWAP, IRQ_STATE, 0, 2);
         av7110->debilen  = irdebi(av7110, DEBINOSWAP, IRQ_STATE_EXT, 0, 2);
         rxbuf=irdebi(av7110, DEBINOSWAP, RX_BUFF, 0, 2);
         txbuf=irdebi(av7110, DEBINOSWAP, TX_BUFF, 0, 2);
 	len = (av7110->debilen + 3) & ~3;
 
-//	dprintk(8, "GPIO0 irq %d %d\n", av7110->debitype, av7110->debilen);
         print_time("gpio");
+	dprintk(8, "GPIO0 irq 0x%04x %d\n", av7110->debitype, av7110->debilen);
 
-//	dprintk(8, "GPIO0 irq %02x\n", av7110->debitype&0xff);
         switch (av7110->debitype&0xff) {
 
         case DATA_TS_PLAY:
@@ -579,16 +591,12 @@
 
                 dvb_ringbuffer_read(cibuf,av7110->debi_virt,len,0);
 
-                wake_up(&cibuf->queue);
                 iwdebi(av7110, DEBINOSWAP, TX_LEN, len, 2);
                 iwdebi(av7110, DEBINOSWAP, IRQ_STATE_EXT, len, 2);
-		saa7146_wait_for_debi_done(av7110->dev, 0);
-                saa7146_write(av7110->dev, IER, 
-                              saa7146_read(av7110->dev, IER) | MASK_19 );
-		if (len < 5)
-			len = 5; /* we want a real DEBI DMA */
-                iwdebi(av7110, DEBISWAB, DPRAM_BASE+txbuf, 0, (len+3)&~3);
+		dprintk(8, "DMA: CI\n");
+		start_debi_dma(av7110, DEBI_WRITE, DPRAM_BASE + txbuf, len);
                 spin_unlock(&av7110->debilock);
+		wake_up(&cibuf->queue);
                 return;
         }
 
@@ -620,22 +628,21 @@
 		dprintk(8, "GPIO0 PES_PLAY len=%04x\n", len);
                 iwdebi(av7110, DEBINOSWAP, TX_LEN, len, 2);
                 iwdebi(av7110, DEBINOSWAP, IRQ_STATE_EXT, len, 2);
-		saa7146_wait_for_debi_done(av7110->dev, 0);
-                saa7146_write(av7110->dev, IER, 
-                              saa7146_read(av7110->dev, IER) | MASK_19 );
-
-                iwdebi(av7110, DEBISWAB, DPRAM_BASE+txbuf, 0, (len+3)&~3);
+		dprintk(8, "DMA: MPEG_PLAY\n");
+		start_debi_dma(av7110, DEBI_WRITE, DPRAM_BASE + txbuf, len);
                 spin_unlock(&av7110->debilock);
                 return;
 
         case DATA_BMP_LOAD:
                 len=av7110->debilen;
+		dprintk(8, "gpio DATA_BMP_LOAD len %d\n", len);
                 if (!len) {
                         av7110->bmp_state=BMP_LOADED;
                         iwdebi(av7110, DEBINOSWAP, IRQ_STATE_EXT, 0, 2);
                         iwdebi(av7110, DEBINOSWAP, TX_LEN, 0, 2);
                         iwdebi(av7110, DEBINOSWAP, TX_BUFF, 0, 2);
                         wake_up(&av7110->bmpq);
+			dprintk(8, "gpio DATA_BMP_LOAD done\n");
                         break;
                 }
                 if (len>av7110->bmplen)
@@ -647,12 +654,8 @@
                 memcpy(av7110->debi_virt, av7110->bmpbuf+av7110->bmpp, len);
                 av7110->bmpp+=len;
                 av7110->bmplen-=len;
-		saa7146_wait_for_debi_done(av7110->dev, 0);
-                saa7146_write(av7110->dev, IER, 
-                              saa7146_read(av7110->dev, IER) | MASK_19 );
-		if (len < 5)
-			len = 5; /* we want a real DEBI DMA */
-                iwdebi(av7110, DEBISWAB, DPRAM_BASE+txbuf, 0, (len+3)&~3);
+		dprintk(8, "gpio DATA_BMP_LOAD DMA len %d\n", len);
+		start_debi_dma(av7110, DEBI_WRITE, DPRAM_BASE+txbuf, len);
                 spin_unlock(&av7110->debilock);
                 return;
 
@@ -669,22 +672,17 @@
 
         case DATA_TS_RECORD:
         case DATA_PES_RECORD:
-		saa7146_wait_for_debi_done(av7110->dev, 0);
-                saa7146_write(av7110->dev, IER, 
-                              saa7146_read(av7110->dev, IER) | MASK_19);
-                irdebi(av7110, DEBISWAB, DPRAM_BASE+rxbuf, 0, len);
+		dprintk(8, "DMA: TS_REC etc.\n");
+		start_debi_dma(av7110, DEBI_READ, DPRAM_BASE+rxbuf, len);
                 spin_unlock(&av7110->debilock);
                 return;
 
         case DATA_DEBUG_MESSAGE:
-		saa7146_wait_for_debi_done(av7110->dev, 0);
                 if (!len || len>0xff) {
                         iwdebi(av7110, DEBINOSWAP, RX_BUFF, 0, 2);
                         break;
                 }
-                saa7146_write(av7110->dev, IER, 
-                              saa7146_read(av7110->dev, IER) | MASK_19);
-                irdebi(av7110, DEBISWAB, Reserved, 0, len);
+		start_debi_dma(av7110, DEBI_READ, Reserved, len);
                 spin_unlock(&av7110->debilock);
                 return;
 
@@ -699,8 +697,8 @@
                        av7110->debitype, av7110->debilen);
                 break;
         }      
-        ARM_ClearMailBox(av7110);
         av7110->debitype=-1;
+	ARM_ClearMailBox(av7110);
         spin_unlock(&av7110->debilock);
 }
 
@@ -1145,11 +1144,107 @@
 	return 0;
 }
 
+/* simplified code from budget-core.c */
+static int stop_ts_capture(struct av7110 *budget)
+{
+	dprintk(2, "budget: %p\n", budget);
+
+	if (--budget->feeding1)
+		return budget->feeding1;
+	saa7146_write(budget->dev, MC1, MASK_20);	/* DMA3 off */
+	SAA7146_IER_DISABLE(budget->dev, MASK_10);
+	SAA7146_ISR_CLEAR(budget->dev, MASK_10);
+	return 0;
+}
+
+static int start_ts_capture(struct av7110 *budget)
+{
+	dprintk(2, "budget: %p\n", budget);
+
+	if (budget->feeding1)
+		return ++budget->feeding1;
+	memset(budget->grabbing, 0x00, TS_HEIGHT * TS_WIDTH);
+	budget->tsf = 0xff;
+	budget->ttbp = 0;
+	SAA7146_IER_ENABLE(budget->dev, MASK_10); /* VPE */
+	saa7146_write(budget->dev, MC1, (MASK_04 | MASK_20)); /* DMA3 on */
+	return ++budget->feeding1;
+}
+
+static int budget_start_feed(struct dvb_demux_feed *feed)
+{
+	struct dvb_demux *demux = feed->demux;
+	struct av7110 *budget = (struct av7110 *) demux->priv;
+	int status;
+
+	dprintk(2, "av7110: %p\n", budget);
+
+	spin_lock(&budget->feedlock1);
+	feed->pusi_seen = 0; /* have a clean section start */
+	status = start_ts_capture(budget);
+	spin_unlock(&budget->feedlock1);
+	return status;
+}
+
+static int budget_stop_feed(struct dvb_demux_feed *feed)
+{
+	struct dvb_demux *demux = feed->demux;
+	struct av7110 *budget = (struct av7110 *) demux->priv;
+	int status;
+
+	dprintk(2, "budget: %p\n", budget);
+
+	spin_lock(&budget->feedlock1);
+	status = stop_ts_capture(budget);
+	spin_unlock(&budget->feedlock1);
+	return status;
+}
+
+static void vpeirq(unsigned long data)
+{
+	struct av7110 *budget = (struct av7110 *) data;
+	u8 *mem = (u8 *) (budget->grabbing);
+	u32 olddma = budget->ttbp;
+	u32 newdma = saa7146_read(budget->dev, PCI_VDP3);
+
+	if (!budgetpatch) {
+		printk("av7110.c: vpeirq() called while budgetpatch disabled!"
+		       " check saa7146 IER register\n");
+		BUG();
+	}
+	/* nearest lower position divisible by 188 */
+	newdma -= newdma % 188;
+
+	if (newdma >= TS_BUFLEN)
+		return;
+
+	budget->ttbp = newdma;
+
+	if (!budget->feeding1 || (newdma == olddma))
+		return;
+
+#if 0
+	/* track rps1 activity */
+	printk("vpeirq: %02x Event Counter 1 0x%04x\n",
+	       mem[olddma],
+	       saa7146_read(budget->dev, EC1R) & 0x3fff);
+#endif
+
+	if (newdma > olddma)
+		/* no wraparound, dump olddma..newdma */
+		dvb_dmx_swfilter_packets(&budget->demux1, mem + olddma, (newdma - olddma) / 188);
+	else {
+		/* wraparound, dump olddma..buflen and 0..newdma */
+		dvb_dmx_swfilter_packets(&budget->demux1, mem + olddma, (TS_BUFLEN - olddma) / 188);
+		dvb_dmx_swfilter_packets(&budget->demux1, mem, newdma / 188);
+	}
+}
 
 static int av7110_register(struct av7110 *av7110)
 {
         int ret, i;
         struct dvb_demux *dvbdemux=&av7110->demux;
+	struct dvb_demux *dvbdemux1 = &av7110->demux1;
 
 	dprintk(4, "%p\n", av7110);
 
@@ -1209,6 +1304,32 @@
         
         dvb_net_init(av7110->dvb_adapter, &av7110->dvb_net, &dvbdemux->dmx);
 
+	if (budgetpatch) {
+		/* initialize software demux1 without its own frontend
+		 * demux1 hardware is connected to frontend0 of demux0
+		 */
+		dvbdemux1->priv = (void *) av7110;
+
+		dvbdemux1->filternum = 256;
+		dvbdemux1->feednum = 256;
+		dvbdemux1->start_feed = budget_start_feed;
+		dvbdemux1->stop_feed = budget_stop_feed;
+		dvbdemux1->write_to_decoder = NULL;
+
+		dvbdemux1->dmx.capabilities = (DMX_TS_FILTERING | DMX_SECTION_FILTERING |
+					       DMX_MEMORY_BASED_FILTERING);
+
+		dvb_dmx_init(&av7110->demux1);
+
+		av7110->dmxdev1.filternum = 256;
+		av7110->dmxdev1.demux = &dvbdemux1->dmx;
+		av7110->dmxdev1.capabilities = 0;
+
+		dvb_dmxdev_init(&av7110->dmxdev1, av7110->dvb_adapter);
+
+		dvb_net_init(av7110->dvb_adapter, &av7110->dvb_net1, &dvbdemux1->dmx);
+		printk("dvb-ttpci: additional demux1 for budget-patch registered\n");
+	}
 	return 0;
 }
 
@@ -1216,12 +1337,20 @@
 static void dvb_unregister(struct av7110 *av7110)
 {
         struct dvb_demux *dvbdemux=&av7110->demux;
+	struct dvb_demux *dvbdemux1 = &av7110->demux1;
 
 	dprintk(4, "%p\n", av7110);
 
         if (!av7110->registered)
                 return;
 
+	if (budgetpatch) {
+		dvb_net_release(&av7110->dvb_net1);
+		dvbdemux->dmx.close(&dvbdemux1->dmx);
+		dvb_dmxdev_release(&av7110->dmxdev1);
+		dvb_dmx_release(&av7110->demux1);
+	}
+
 	dvb_net_release(&av7110->dvb_net);
 
 	dvbdemux->dmx.close(&dvbdemux->dmx);
@@ -1700,6 +1829,7 @@
 static struct stv0297_config nexusca_stv0297_config = {
 
 	.demod_address = 0x1C,
+	.invert = 1,
 	.pll_set = nexusca_stv0297_pll_set,
 };
 
@@ -1899,12 +2029,22 @@
                         av7110->fe = ves1820_attach(&alps_tdbe2_config, &av7110->i2c_adap, read_pwm(av7110));
 			break;
 
+		case 0x0006: /* Fujitsu-Siemens DVB-S rev 1.6 */
+			/* Grundig 29504-451 */
+			av7110->fe = tda8083_attach(&grundig_29504_451_config, &av7110->i2c_adap);
+			if (av7110->fe) {
+				av7110->fe->ops->diseqc_send_master_cmd = av7110_diseqc_send_master_cmd;
+				av7110->fe->ops->diseqc_send_burst = av7110_diseqc_send_burst;
+				av7110->fe->ops->set_tone = av7110_set_tone;
+			}
+			break;
+
 		case 0x000A: // Hauppauge/TT Nexus-CA rev1.X
 
 			av7110->fe = stv0297_attach(&nexusca_stv0297_config, &av7110->i2c_adap, 0x7b);
 			if (av7110->fe) {
 				/* set TDA9819 into DVB mode */
-				saa7146_setgpio(av7110->dev, 1, SAA7146_GPIO_OUTHI); // TDA9198 pin9(STD)
+				saa7146_setgpio(av7110->dev, 1, SAA7146_GPIO_OUTLO); // TDA9198 pin9(STD)
 				saa7146_setgpio(av7110->dev, 3, SAA7146_GPIO_OUTLO); // TDA9198 pin30(VIF)
 
 				/* tuner on this needs a slower i2c bus speed */
@@ -1940,13 +2080,169 @@
 	}
 }
 
+/* Budgetpatch note:
+ * Original hardware design by Roberto Deza:
+ * There is a DVB_Wiki at
+ * http://212.227.36.83/linuxtv/wiki/index.php/Main_Page
+ * where is described this 'DVB TT Budget Patch', on Card Modding:
+ * http://212.227.36.83/linuxtv/wiki/index.php/DVB_TT_Budget_Patch
+ * On the short description there is also a link to a external file,
+ * with more details:
+ * http://perso.wanadoo.es/jesussolano/Ttf_tsc1.zip
+ *
+ * New software triggering design by Emard that works on
+ * original Roberto Deza's hardware:
+ *
+ * rps1 code for budgetpatch will copy internal HS event to GPIO3 pin.
+ * GPIO3 is in budget-patch hardware connectd to port B VSYNC
+ * HS is an internal event of 7146, accessible with RPS
+ * and temporarily raised high every n lines
+ * (n in defined in the RPS_THRESH1 counter threshold)
+ * I think HS is raised high on the beginning of the n-th line
+ * and remains high until this n-th line that triggered
+ * it is completely received. When the receiption of n-th line
+ * ends, HS is lowered.
+ *
+ * To transmit data over DMA, 7146 needs changing state at
+ * port B VSYNC pin. Any changing of port B VSYNC will
+ * cause some DMA data transfer, with more or less packets loss.
+ * It depends on the phase and frequency of VSYNC and
+ * the way of 7146 is instructed to trigger on port B (defined
+ * in DD1_INIT register, 3rd nibble from the right valid
+ * numbers are 0-7, see datasheet)
+ *
+ * The correct triggering can minimize packet loss,
+ * dvbtraffic should give this stable bandwidths:
+ *   22k transponder = 33814 kbit/s
+ * 27.5k transponder = 38045 kbit/s
+ * by experiment it is found that the best results
+ * (stable bandwidths and almost no packet loss)
+ * are obtained using DD1_INIT triggering number 2
+ * (Va at rising edge of VS Fa = HS x VS-failing forced toggle)
+ * and a VSYNC phase that occurs in the middle of DMA transfer
+ * (about byte 188*512=96256 in the DMA window).
+ *
+ * Phase of HS is still not clear to me how to control,
+ * It just happens to be so. It can be seen if one enables
+ * RPS_IRQ and print Event Counter 1 in vpeirq(). Every
+ * time RPS_INTERRUPT is called, the Event Counter 1 will
+ * increment. That's how the 7146 is programmed to do event
+ * counting in this budget-patch.c
+ * I *think* HPS setting has something to do with the phase
+ * of HS but I cant be 100% sure in that.
+ *
+ * hardware debug note: a working budget card (including budget patch)
+ * with vpeirq() interrupt setup in mode "0x90" (every 64K) will
+ * generate 3 interrupts per 25-Hz DMA frame of 2*188*512 bytes
+ * and that means 3*25=75 Hz of interrupt freqency, as seen by
+ * watch cat /proc/interrupts
+ *
+ * If this frequency is 3x lower (and data received in the DMA
+ * buffer don't start with 0x47, but in the middle of packets,
+ * whose lengths appear to be like 188 292 188 104 etc.
+ * this means VSYNC line is not connected in the hardware.
+ * (check soldering pcb and pins)
+ * The same behaviour of missing VSYNC can be duplicated on budget
+ * cards, by seting DD1_INIT trigger mode 7 in 3rd nibble.
+ */
 static int av7110_attach(struct saa7146_dev* dev, struct saa7146_pci_extension_data *pci_ext)
 {
 	struct av7110 *av7110 = NULL;
+	int length = TS_WIDTH * TS_HEIGHT;
 	int ret = 0;
+	int count = 0;
 
 	dprintk(4, "dev: %p\n", dev);
 
+        /* Set RPS_IRQ to 1 to track rps1 activity.
+         * Enabling this won't send any interrupt to PC CPU.
+         */
+#define RPS_IRQ 0
+
+	if (budgetpatch == 1) {
+		budgetpatch = 0;
+		/* autodetect the presence of budget patch
+		 * this only works if saa7146 has been recently
+		 * reset with with MASK_31 to MC1
+		 *
+		 * will wait for VBI_B event (vertical blank at port B)
+		 * and will reset GPIO3 after VBI_B is detected.
+		 * (GPIO3 should be raised high by CPU to
+		 * test if GPIO3 will generate vertical blank signal
+		 * in budget patch GPIO3 is connected to VSYNC_B
+		 */
+
+		/* RESET SAA7146 */
+		saa7146_write(dev, MC1, MASK_31);
+		/* autodetection success seems to be time-dependend after reset */
+
+		/* Fix VSYNC level */
+		saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO);
+		/* set vsync_b triggering */
+		saa7146_write(dev, DD1_STREAM_B, 0);
+		/* port B VSYNC at rising edge */
+		saa7146_write(dev, DD1_INIT, 0x00000200);
+		saa7146_write(dev, BRS_CTRL, 0x00000000);  // VBI
+		saa7146_write(dev, MC2,
+			      1 * (MASK_08 | MASK_24)  |   // BRS control
+			      0 * (MASK_09 | MASK_25)  |   // a
+			      1 * (MASK_10 | MASK_26)  |   // b
+			      0 * (MASK_06 | MASK_22)  |   // HPS_CTRL1
+			      0 * (MASK_05 | MASK_21)  |   // HPS_CTRL2
+			      0 * (MASK_01 | MASK_15)      // DEBI
+		);
+
+		/* start writing RPS1 code from beginning */
+		count = 0;
+		/* Disable RPS1 */
+		saa7146_write(dev, MC1, MASK_29);
+		/* RPS1 timeout disable */
+		saa7146_write(dev, RPS_TOV1, 0);
+		WRITE_RPS1(cpu_to_le32(CMD_PAUSE | EVT_VBI_B));
+		WRITE_RPS1(cpu_to_le32(CMD_WR_REG_MASK | (GPIO_CTRL>>2)));
+		WRITE_RPS1(cpu_to_le32(GPIO3_MSK));
+		WRITE_RPS1(cpu_to_le32(SAA7146_GPIO_OUTLO<<24));
+#if RPS_IRQ
+		/* issue RPS1 interrupt to increment counter */
+		WRITE_RPS1(cpu_to_le32(CMD_INTERRUPT));
+#endif
+		WRITE_RPS1(cpu_to_le32(CMD_STOP));
+		/* Jump to begin of RPS program as safety measure               (p37) */
+		WRITE_RPS1(cpu_to_le32(CMD_JUMP));
+		WRITE_RPS1(cpu_to_le32(dev->d_rps1.dma_handle));
+
+#if RPS_IRQ
+		/* set event counter 1 source as RPS1 interrupt (0x03)          (rE4 p53)
+		 * use 0x03 to track RPS1 interrupts - increase by 1 every gpio3 is toggled
+		 * use 0x15 to track VPE  interrupts - increase by 1 every vpeirq() is called
+		 */
+		saa7146_write(dev, EC1SSR, (0x03<<2) | 3 );
+		/* set event counter 1 treshold to maximum allowed value        (rEC p55) */
+		saa7146_write(dev, ECT1R,  0x3fff );
+#endif
+		/* Set RPS1 Address register to point to RPS code               (r108 p42) */
+		saa7146_write(dev, RPS_ADDR1, dev->d_rps1.dma_handle);
+		/* Enable RPS1,                                                 (rFC p33) */
+		saa7146_write(dev, MC1, (MASK_13 | MASK_29 ));
+
+		mdelay(10);
+		/* now send VSYNC_B to rps1 by rising GPIO3 */
+		saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTHI);
+		mdelay(10);
+		/* if rps1 responded by lowering the GPIO3,
+		 * then we have budgetpatch hardware
+		 */
+		if ((saa7146_read(dev, GPIO_CTRL) & 0x10000000) == 0) {
+			budgetpatch = 1;
+			printk("dvb-ttpci: BUDGET-PATCH DETECTED.\n");
+		}
+		/* Disable RPS1 */
+		saa7146_write(dev, MC1, ( MASK_29 ));
+#if RPS_IRQ
+		printk("dvb-ttpci: Event Counter 1 0x%04x\n", saa7146_read(dev, EC1R) & 0x3fff );
+#endif
+	}
+
 	/* prepare the av7110 device struct */
 	if (!(av7110 = kmalloc (sizeof (struct av7110), GFP_KERNEL))) {
 		dprintk(1, "out of memory\n");
@@ -1980,6 +2276,7 @@
 	saa7146_i2c_adapter_prepare(dev, &av7110->i2c_adap, SAA7146_I2C_BUS_BIT_RATE_120); /* 275 kHz */
 
 	if (i2c_add_adapter(&av7110->i2c_adap) < 0) {
+err_no_mem:
 		dvb_unregister_adapter (av7110->dvb_adapter);
 		kfree(av7110);
 		return -ENOMEM;
@@ -1987,6 +2284,86 @@
 
 	ttpci_eeprom_parse_mac(&av7110->i2c_adap, av7110->dvb_adapter->proposed_mac);
 
+	if (budgetpatch) {
+		spin_lock_init(&av7110->feedlock1);
+		av7110->grabbing = saa7146_vmalloc_build_pgtable(
+					 dev->pci, length, &av7110->pt);
+		if (!av7110->grabbing)
+			goto err_no_mem;
+		saa7146_write(dev, PCI_BT_V1, 0x1c1f101f);
+		saa7146_write(dev, BCS_CTRL, 0x80400040);
+		/* set dd1 stream a & b */
+		saa7146_write(dev, DD1_STREAM_B, 0x00000000);
+		saa7146_write(dev, DD1_INIT, 0x03000200);
+		saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
+		saa7146_write(dev, BRS_CTRL, 0x60000000);
+		saa7146_write(dev, BASE_ODD3, 0);
+		saa7146_write(dev, BASE_EVEN3, 0);
+		saa7146_write(dev, PROT_ADDR3, TS_WIDTH * TS_HEIGHT);
+		saa7146_write(dev, BASE_PAGE3, av7110->pt.dma | ME1 | 0x90);
+
+		saa7146_write(dev, PITCH3, TS_WIDTH);
+		saa7146_write(dev, NUM_LINE_BYTE3, (TS_HEIGHT << 16) | TS_WIDTH);
+
+		/* upload all */
+		saa7146_write(dev, MC2, 0x077c077c);
+		saa7146_write(dev, GPIO_CTRL, 0x000000);
+#if RPS_IRQ
+		/* set event counter 1 source as RPS1 interrupt (0x03)          (rE4 p53)
+		 * use 0x03 to track RPS1 interrupts - increase by 1 every gpio3 is toggled
+		 * use 0x15 to track VPE  interrupts - increase by 1 every vpeirq() is called
+		 */
+		saa7146_write(dev, EC1SSR, (0x03<<2) | 3 );
+		/* set event counter 1 treshold to maximum allowed value        (rEC p55) */
+		saa7146_write(dev, ECT1R,  0x3fff );
+#endif
+		/* Setup BUDGETPATCH MAIN RPS1 "program" (p35) */
+		count = 0;
+
+		/* Wait Source Line Counter Threshold                           (p36) */
+		WRITE_RPS1(cpu_to_le32(CMD_PAUSE | EVT_HS));
+		/* Set GPIO3=1                                                  (p42) */
+		WRITE_RPS1(cpu_to_le32(CMD_WR_REG_MASK | (GPIO_CTRL>>2)));
+		WRITE_RPS1(cpu_to_le32(GPIO3_MSK));
+		WRITE_RPS1(cpu_to_le32(SAA7146_GPIO_OUTHI<<24));
+#if RPS_IRQ
+		/* issue RPS1 interrupt */
+		WRITE_RPS1(cpu_to_le32(CMD_INTERRUPT));
+#endif
+		/* Wait reset Source Line Counter Threshold                     (p36) */
+		WRITE_RPS1(cpu_to_le32(CMD_PAUSE | RPS_INV | EVT_HS));
+		/* Set GPIO3=0                                                  (p42) */
+		WRITE_RPS1(cpu_to_le32(CMD_WR_REG_MASK | (GPIO_CTRL>>2)));
+		WRITE_RPS1(cpu_to_le32(GPIO3_MSK));
+		WRITE_RPS1(cpu_to_le32(SAA7146_GPIO_OUTLO<<24));
+#if RPS_IRQ
+		/* issue RPS1 interrupt */
+		WRITE_RPS1(cpu_to_le32(CMD_INTERRUPT));
+#endif
+		/* Jump to begin of RPS program                                 (p37) */
+		WRITE_RPS1(cpu_to_le32(CMD_JUMP));
+		WRITE_RPS1(cpu_to_le32(dev->d_rps1.dma_handle));
+
+		/* Fix VSYNC level */
+		saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO);
+		/* Set RPS1 Address register to point to RPS code               (r108 p42) */
+		saa7146_write(dev, RPS_ADDR1, dev->d_rps1.dma_handle);
+		/* Set Source Line Counter Threshold, using BRS                 (rCC p43)
+		 * It generates HS event every TS_HEIGHT lines
+		 * this is related to TS_WIDTH set in register
+		 * NUM_LINE_BYTE3. If NUM_LINE_BYTE low 16 bits
+		 * are set to TS_WIDTH bytes (TS_WIDTH=2*188),
+		 * then RPS_THRESH1 should be set to trigger
+		 * every TS_HEIGHT (512) lines.
+		 */
+		saa7146_write(dev, RPS_THRESH1, (TS_HEIGHT*1) | MASK_12 );
+
+		/* Enable RPS1                                                  (rFC p33) */
+		saa7146_write(dev, MC1, (MASK_13 | MASK_29));
+
+		/* end of budgetpatch register initialization */
+		tasklet_init (&av7110->vpe_tasklet,  vpeirq,  (unsigned long) av7110);
+	} else {
 	saa7146_write(dev, PCI_BT_V1, 0x1c00101f);
 	saa7146_write(dev, BCS_CTRL, 0x80400040);
 
@@ -1998,6 +2375,7 @@
 	/* upload all */
 	saa7146_write(dev, MC2, 0x077c077c);
         saa7146_write(dev, GPIO_CTRL, 0x000000);
+	}
 
 	tasklet_init (&av7110->debi_tasklet, debiirq, (unsigned long) av7110);
 	tasklet_init (&av7110->gpio_tasklet, gpioirq, (unsigned long) av7110);
@@ -2109,10 +2487,21 @@
 	struct av7110 *av7110 = (struct av7110*)saa->ext_priv;
 	dprintk(4, "%p\n", av7110);
 	
-	if( 0 == av7110->device_initialized ) {
+	if (!av7110->device_initialized )
 		return 0;
-	}
 
+	if (budgetpatch) {
+		/* Disable RPS1 */
+		saa7146_write(saa, MC1, MASK_29);
+		/* VSYNC LOW (inactive) */
+		saa7146_setgpio(saa, 3, SAA7146_GPIO_OUTLO);
+		saa7146_write(saa, MC1, MASK_20);	/* DMA3 off */
+		SAA7146_IER_DISABLE(saa, MASK_10);
+		SAA7146_ISR_CLEAR(saa, MASK_10);
+		msleep(50);
+		tasklet_kill(&av7110->vpe_tasklet);
+		saa7146_pgtable_free(saa->pci, &av7110->pt);
+	}
 	av7110_exit_v4l(av7110);
 
 	av7110->arm_rmmod=1;
@@ -2121,6 +2510,9 @@
 	while (av7110->arm_thread)
 		msleep(1);
 
+	tasklet_kill(&av7110->debi_tasklet);
+	tasklet_kill(&av7110->gpio_tasklet);
+
 	dvb_unregister(av7110);
 	
 	SAA7146_IER_DISABLE(saa, MASK_19 | MASK_03);
@@ -2153,13 +2545,43 @@
 {
 	struct av7110 *av7110 = dev->ext_priv;
 
-	if (*isr & MASK_19)
+	//print_time("av7110_irq");
+
+	/* Note: Don't try to handle the DEBI error irq (MASK_18), in
+	 * intel mode the timeout is asserted all the time...
+	 */
+
+	if (*isr & MASK_19) {
+		//printk("av7110_irq: DEBI\n");
+		/* Note 1: The DEBI irq is level triggered: We must enable it
+		 * only after we started a DMA xfer, and disable it here
+		 * immediately, or it will be signalled all the time while
+		 * DEBI is idle.
+		 * Note 2: You would think that an irq which is masked is
+		 * not signalled by the hardware. Not so for the SAA7146:
+		 * An irq is signalled as long as the corresponding bit
+		 * in the ISR is set, and disabling irqs just prevents the
+		 * hardware from setting the ISR bit. This means a) that we
+		 * must clear the ISR *after* disabling the irq (which is why
+		 * we must do it here even though saa7146_core did it already),
+		 * and b) that if we were to disable an edge triggered irq
+		 * (like the gpio irqs sadly are) temporarily we would likely
+		 * loose some. This sucks :-(
+		 */
+		SAA7146_IER_DISABLE(av7110->dev, MASK_19);
+		SAA7146_ISR_CLEAR(av7110->dev, MASK_19);
 		tasklet_schedule (&av7110->debi_tasklet);
+	}
 	
-	if (*isr & MASK_03)
+	if (*isr & MASK_03) {
+		//printk("av7110_irq: GPIO\n");
 		tasklet_schedule (&av7110->gpio_tasklet);
 }
 
+	if ((*isr & MASK_10) && budgetpatch)
+		tasklet_schedule(&av7110->vpe_tasklet);
+}
+
 
 static struct saa7146_extension av7110_extension;
 
@@ -2173,8 +2595,9 @@
 MAKE_AV7110_INFO(ttc_1_X,    "Technotrend/Hauppauge WinTV Nexus-CA rev1.X");
 MAKE_AV7110_INFO(ttc_2_X,    "Technotrend/Hauppauge WinTV DVB-C rev2.X");
 MAKE_AV7110_INFO(tts_2_X,    "Technotrend/Hauppauge WinTV Nexus-S rev2.X");
-MAKE_AV7110_INFO(tts_1_3se,  "Technotrend/Hauppauge WinTV Nexus-S rev1.3");
+MAKE_AV7110_INFO(tts_1_3se,  "Technotrend/Hauppauge WinTV DVB-S rev1.3 SE");
 MAKE_AV7110_INFO(fsc,        "Fujitsu Siemens DVB-C");
+MAKE_AV7110_INFO(fss,        "Fujitsu Siemens DVB-S rev1.6");
 
 static struct pci_device_id pci_tbl[] = {
 	MAKE_EXTENSION_PCI(tts_1_X,   0x13c2, 0x0000),
@@ -2184,10 +2607,10 @@
 	MAKE_EXTENSION_PCI(tts_1_3se, 0x13c2, 0x1002),
 	MAKE_EXTENSION_PCI(fsc,       0x110a, 0x0000),
 	MAKE_EXTENSION_PCI(ttc_1_X,   0x13c2, 0x000a),
+	MAKE_EXTENSION_PCI(fss,       0x13c2, 0x0006),
 
 /*	MAKE_EXTENSION_PCI(???, 0x13c2, 0x0004), UNDEFINED CARD */ // Galaxis DVB PC-Sat-Carte
 /*	MAKE_EXTENSION_PCI(???, 0x13c2, 0x0005), UNDEFINED CARD */ // Technisat SkyStar1
-/*	MAKE_EXTENSION_PCI(???, 0x13c2, 0x0006), UNDEFINED CARD */ // TT/Hauppauge WinTV Nexus-S v????
 /*	MAKE_EXTENSION_PCI(???, 0x13c2, 0x0008), UNDEFINED CARD */ // TT/Hauppauge WinTV DVB-T v????
 /*	MAKE_EXTENSION_PCI(???, 0x13c2, 0x0009), UNDEFINED CARD */ // TT/Hauppauge WinTV Nexus-CA v????
 
@@ -2208,7 +2631,7 @@
 	.attach		= av7110_attach,
 	.detach		= av7110_detach,
 
-	.irq_mask	= MASK_19|MASK_03,
+	.irq_mask	= MASK_19 | MASK_03 | MASK_10,
 	.irq_func	= av7110_irq,
 };	
 
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/ttpci/av7110.h linux-2.6.11-rc2-dvb/drivers/media/dvb/ttpci/av7110.h
--- linux-2.6.11-rc2/drivers/media/dvb/ttpci/av7110.h	2005-01-20 19:54:05.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/ttpci/av7110.h	2005-01-20 19:56:38.000000000 +0100
@@ -115,7 +115,7 @@
 
         int                     bmpp;
         int                     bmplen;
-        int                     bmp_state;
+	volatile int		bmp_state;
 #define BMP_NONE     0
 #define BMP_LOADING  1
 #define BMP_LOADINGS 2
@@ -158,6 +158,18 @@
         struct dmx_frontend	hw_frontend;
         struct dmx_frontend	mem_frontend;
 
+	/* for budget mode demux1 */
+	struct dmxdev		dmxdev1;
+	struct dvb_demux	demux1;
+	struct dvb_net		dvb_net1;
+	spinlock_t		feedlock1;
+	int			feeding1;
+	u8			tsf;
+	u32			ttbp;
+	unsigned char           *grabbing;
+	struct saa7146_pgtable  pt;
+	struct tasklet_struct   vpe_tasklet;
+
         int                     fe_synced; 
         struct semaphore        pid_mutex;
 
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/ttpci/av7110_hw.c linux-2.6.11-rc2-dvb/drivers/media/dvb/ttpci/av7110_hw.c
--- linux-2.6.11-rc2/drivers/media/dvb/ttpci/av7110_hw.c	2005-01-20 19:55:47.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/ttpci/av7110_hw.c	2005-01-20 19:56:39.000000000 +0100
@@ -153,8 +153,10 @@
 	base = DRAM_START_CODE;
 
 	for (i = 0; i < blocks; i++) {
-		if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0)
+		if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0) {
+			printk(KERN_ERR "dvb-ttpci: load_dram(): timeout at block %d\n", i);
 			return -1;
+		}
 		dprintk(4, "writing DRAM block %d\n", i);
 		mwdebi(av7110, DEBISWAB, bootblock,
 		       ((char*)data) + i * BOOT_MAX_SIZE, BOOT_MAX_SIZE);
@@ -166,8 +168,10 @@
 	}
 
 	if (rest > 0) {
-		if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0)
+		if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0) {
+			printk(KERN_ERR "dvb-ttpci: load_dram(): timeout at last block\n");
 			return -1;
+		}
 		if (rest > 4)
 			mwdebi(av7110, DEBISWAB, bootblock,
 			       ((char*)data) + i * BOOT_MAX_SIZE, rest);
@@ -179,12 +183,16 @@
 		iwdebi(av7110, DEBINOSWAP, BOOT_SIZE, rest, 2);
 		iwdebi(av7110, DEBINOSWAP, BOOT_STATE, BOOTSTATE_BUFFER_FULL, 2);
 	}
-	if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0)
+	if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0) {
+		printk(KERN_ERR "dvb-ttpci: load_dram(): timeout after last block\n");
 		return -1;
+	}
 	iwdebi(av7110, DEBINOSWAP, BOOT_SIZE, 0, 2);
 	iwdebi(av7110, DEBINOSWAP, BOOT_STATE, BOOTSTATE_BUFFER_FULL, 2);
-	if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BOOT_COMPLETE) < 0)
+	if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BOOT_COMPLETE) < 0) {
+		printk(KERN_ERR "dvb-ttpci: load_dram(): final handshake timeout\n");
 		return -1;
+	}
 	return 0;
 }
 
@@ -261,8 +269,11 @@
 	mdelay(1);
 
 	dprintk(1, "load dram code\n");
-	if (load_dram(av7110, (u32 *)av7110->bin_root, av7110->size_root) < 0)
+	if (load_dram(av7110, (u32 *)av7110->bin_root, av7110->size_root) < 0) {
+		printk(KERN_ERR "dvb-ttpci: av7110_bootarm(): "
+		       "load_dram() failed\n");
 		return -1;
+	}
 
 	saa7146_setgpio(dev, RESET_LINE, SAA7146_GPIO_OUTLO);
 	mdelay(1);
@@ -336,7 +347,7 @@
 
 	if (!av7110->arm_ready) {
 		dprintk(1, "arm not ready.\n");
-		return -1;
+		return -ENXIO;
 	}
 
 	start = jiffies;
@@ -344,7 +355,7 @@
 		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
 			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for COMMAND idle\n", __FUNCTION__);
-			return -1;
+			return -ETIMEDOUT;
 		}
 	}
 
@@ -356,7 +367,7 @@
 		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_SHAKE)) {
 			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for HANDSHAKE_REG\n", __FUNCTION__);
-			return -1;
+			return -ETIMEDOUT;
 		}
 	}
 #endif
@@ -375,6 +386,13 @@
 		flags[0] = OSDQOver;
 		flags[1] = OSDQFull;
 		break;
+	case COMTYPE_MISC:
+		if (FW_VERSION(av7110->arm_app) >= 0x261d) {
+			type = "MSG";
+			flags[0] = GPMQOver;
+			flags[1] = GPMQBusy;
+		}
+		break;
 	default:
 		break;
 	}
@@ -419,18 +437,18 @@
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
 			printk(KERN_ERR "dvb-ttpci: %s(): timeout waiting for COMMAND to complete\n",
 			       __FUNCTION__);
-			return -1;
+			return -ETIMEDOUT;
 		}
 	}
 
 	stat = rdebi(av7110, DEBINOSWAP, MSGSTATE, 0, 2);
 	if (stat & GPMQOver) {
 		printk(KERN_ERR "dvb-ttpci: %s(): GPMQOver\n", __FUNCTION__);
-		return -1;
+		return -ENOSPC;
 	}
 	else if (stat & OSDQOver) {
 		printk(KERN_ERR "dvb-ttpci: %s(): OSDQOver\n", __FUNCTION__);
-		return -1;
+		return -ENOSPC;
 	}
 #endif
 
@@ -453,7 +471,8 @@
 	ret = __av7110_send_fw_cmd(av7110, buf, length);
 	up(&av7110->dcomlock);
 	if (ret)
-		printk("dvb-ttpci: %s(): av7110_send_fw_cmd error\n", __FUNCTION__);
+		printk(KERN_ERR "dvb-ttpci: %s(): av7110_send_fw_cmd error %d\n",
+		       __FUNCTION__, ret);
 	return ret;
 }
 
@@ -477,7 +496,7 @@
 
 	ret = av7110_send_fw_cmd(av7110, buf, num + 2);
 	if (ret)
-		printk("dvb-ttpci: av7110_fw_cmd error\n");
+		printk(KERN_ERR "dvb-ttpci: av7110_fw_cmd error %d\n", ret);
 	return ret;
 }
 
@@ -499,7 +518,7 @@
 
 	ret = av7110_send_fw_cmd(av7110, cmd, 18);
 	if (ret)
-		printk("dvb-ttpci: av7110_send_ci_cmd error\n");
+		printk(KERN_ERR "dvb-ttpci: av7110_send_ci_cmd error %d\n", ret);
 	return ret;
 }
 
@@ -525,7 +544,7 @@
 
 	if ((err = __av7110_send_fw_cmd(av7110, request_buf, request_buf_len)) < 0) {
 		up(&av7110->dcomlock);
-		printk("dvb-ttpci: av7110_fw_request error\n");
+		printk(KERN_ERR "dvb-ttpci: av7110_fw_request error %d\n", err);
 		return err;
 	}
 
@@ -579,7 +598,7 @@
 	int ret;
 	ret = av7110_fw_request(av7110, &tag, 0, buf, length);
 	if (ret)
-		printk("dvb-ttpci: av7110_fw_query error\n");
+		printk(KERN_ERR "dvb-ttpci: av7110_fw_query error %d\n", ret);
 	return ret;
 }
 
@@ -626,7 +645,7 @@
 
 int av7110_diseqc_send(struct av7110 *av7110, int len, u8 *msg, unsigned long burst)
 {
-	int i;
+	int i, ret;
 	u16 buf[18] = { ((COMTYPE_AUDIODAC << 8) + SendDiSEqC),
 			16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 
@@ -646,8 +665,8 @@
 	for (i = 0; i < len; i++)
 		buf[i + 4] = msg[i];
 
-	if (av7110_send_fw_cmd(av7110, buf, 18))
-		printk("dvb-ttpci: av7110_diseqc_send error\n");
+	if ((ret = av7110_send_fw_cmd(av7110, buf, 18)))
+		printk(KERN_ERR "dvb-ttpci: av7110_diseqc_send error %d\n", ret);
 
 	return 0;
 }
@@ -741,7 +775,7 @@
 	ret = __av7110_send_fw_cmd(av7110, cbuf, 5);
 	up(&av7110->dcomlock);
 	if (ret)
-		printk("dvb-ttpci: WriteText error\n");
+		printk(KERN_ERR "dvb-ttpci: WriteText error %d\n", ret);
 	return ret;
 }
 
@@ -808,7 +842,8 @@
 
 	ret = wait_event_interruptible_timeout(av7110->bmpq, av7110->bmp_state != BMP_LOADING, HZ);
 	if (ret == -ERESTARTSYS || ret == 0) {
-		printk("dvb-ttpci: warning: timeout waiting in %s()\n", __FUNCTION__);
+		printk("dvb-ttpci: warning: timeout waiting in LoadBitmap: %d, %d\n",
+		       ret, av7110->bmp_state);
 		av7110->bmp_state = BMP_NONE;
 		return -1;
 	}
@@ -850,6 +885,7 @@
 		}
 	}
 	av7110->bmplen += 1024;
+	dprintk(4, "av7110_fw_cmd: LoadBmp size %d\n", av7110->bmplen);
 	return av7110_fw_cmd(av7110, COMTYPE_OSD, LoadBmp, 3, format, dx, dy);
 }
 
@@ -861,11 +897,13 @@
 
 	BUG_ON (av7110->bmp_state == BMP_NONE);
 
-	ret = wait_event_interruptible_timeout(av7110->bmpq, av7110->bmp_state != BMP_LOADING, HZ);
+	ret = wait_event_interruptible_timeout(av7110->bmpq,
+				av7110->bmp_state != BMP_LOADING, 10*HZ);
 	if (ret == -ERESTARTSYS || ret == 0) {
-		printk("dvb-ttpci: warning: timeout waiting in %s()\n", __FUNCTION__);
+		printk("dvb-ttpci: warning: timeout waiting in BlitBitmap: %d, %d\n",
+		       ret, av7110->bmp_state);
 		av7110->bmp_state = BMP_NONE;
-		return -1;
+		return (ret == 0) ? -ETIMEDOUT : ret;
 		}
 
 	BUG_ON (av7110->bmp_state != BMP_LOADED);
@@ -943,6 +981,7 @@
 {
 	uint w, h, bpp, bpl, size, lpb, bnum, brest;
 	int i;
+	int rc;
 
 	w = x1 - x0 + 1;
 	h = y1 - y0 + 1;
@@ -958,15 +997,23 @@
 	brest = size - bnum * lpb * bpl;
 
 	for (i = 0; i < bnum; i++) {
-		LoadBitmap(av7110, bpp2bit[av7110->osdbpp[av7110->osdwin]],
+		rc = LoadBitmap(av7110, bpp2bit[av7110->osdbpp[av7110->osdwin]],
 			   w, lpb, inc, data);
-		BlitBitmap(av7110, av7110->osdwin, x0, y0 + i * lpb, 0);
+		if (rc)
+			return rc;
+		rc = BlitBitmap(av7110, av7110->osdwin, x0, y0 + i * lpb, 0);
+		if (rc)
+			return rc;
 		data += lpb * inc;
 	}
 	if (brest) {
-		LoadBitmap(av7110, bpp2bit[av7110->osdbpp[av7110->osdwin]],
+		rc = LoadBitmap(av7110, bpp2bit[av7110->osdbpp[av7110->osdwin]],
 			   w, brest / bpl, inc, data);
-		BlitBitmap(av7110, av7110->osdwin, x0, y0 + bnum * lpb, 0);
+		if (rc)
+			return rc;
+		rc = BlitBitmap(av7110, av7110->osdwin, x0, y0 + bnum * lpb, 0);
+		if (rc)
+			return rc;
 	}
 	ReleaseBitmap(av7110);
 	return 0;
@@ -1019,7 +1066,7 @@
 			goto out;
 		} else {
 			int i, len = dc->x0-dc->color+1;
-			u8 __user *colors = (u8 __user *)dc->data;
+			u8 __user *colors = (u8 *)dc->data;
 			u8 r, g, b, blend;
 
 			for (i = 0; i<len; i++) {
@@ -1048,7 +1095,7 @@
 		dc->y1 = dc->y0;
 		/* fall through */
 	case OSD_SetBlock:
-		OSDSetBlock(av7110, dc->x0, dc->y0, dc->x1, dc->y1, dc->color, dc->data);
+		ret = OSDSetBlock(av7110, dc->x0, dc->y0, dc->x1, dc->y1, dc->color, dc->data);
 		goto out;
 	case OSD_FillRow:
 		DrawBlock(av7110, av7110->osdwin, dc->x0, dc->y0,
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/ttpci/av7110_v4l.c linux-2.6.11-rc2-dvb/drivers/media/dvb/ttpci/av7110_v4l.c
--- linux-2.6.11-rc2/drivers/media/dvb/ttpci/av7110_v4l.c	2005-01-20 19:54:05.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/ttpci/av7110_v4l.c	2005-01-20 19:56:39.000000000 +0100
@@ -250,7 +248,7 @@
 			if (ves1820_writereg(dev, 0x09, 0x0f, 0x20))
 				dprintk(1, "setting band in demodulator failed.\n");
 		} else if (av7110->analog_tuner_flags & ANALOG_TUNER_STV0297) {
-			saa7146_setgpio(dev, 1, SAA7146_GPIO_OUTHI); // TDA9198 pin9(STD)
+			saa7146_setgpio(dev, 1, SAA7146_GPIO_OUTLO); // TDA9198 pin9(STD)
 			saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO); // TDA9198 pin30(VIF)
 		}
 	}
@@ -591,7 +589,7 @@
 			if (ves1820_writereg(av7110->dev, 0x09, 0x0f, 0x20))
 				dprintk(1, "setting band in demodulator failed.\n");
 		} else if (av7110->analog_tuner_flags & ANALOG_TUNER_STV0297) {
-			saa7146_setgpio(av7110->dev, 1, SAA7146_GPIO_OUTHI); // TDA9198 pin9(STD)
+			saa7146_setgpio(av7110->dev, 1, SAA7146_GPIO_OUTLO); // TDA9198 pin9(STD)
 			saa7146_setgpio(av7110->dev, 3, SAA7146_GPIO_OUTLO); // TDA9198 pin30(VIF)
 		}
 
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/ttpci/budget.c linux-2.6.11-rc2-dvb/drivers/media/dvb/ttpci/budget.c
--- linux-2.6.11-rc2/drivers/media/dvb/ttpci/budget.c	2005-01-20 19:54:05.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/ttpci/budget.c	2005-01-20 19:56:39.000000000 +0100
@@ -414,7 +412,7 @@
 {
 	switch(budget->dev->pci->subsystem_device) {
 	case 0x1003: // Hauppauge/TT Nova budget (stv0299/ALPS BSRU6(tsa5059) OR ves1893/ALPS BSRV2(sp5659))
-
+	case 0x1013:
 		// try the ALPS BSRV2 first of all
 		budget->dvb_frontend = ves1x93_attach(&alps_bsrv2_config, &budget->i2c_adap);
 		if (budget->dvb_frontend) {
@@ -522,14 +517,14 @@
 MAKE_BUDGET_INFO(ttbs,	"TT-Budget/WinTV-NOVA-S  PCI",	BUDGET_TT);
 MAKE_BUDGET_INFO(ttbc,	"TT-Budget/WinTV-NOVA-C  PCI",	BUDGET_TT);
 MAKE_BUDGET_INFO(ttbt,	"TT-Budget/WinTV-NOVA-T  PCI",	BUDGET_TT);
-/* MAKE_BUDGET_INFO(satel,	"SATELCO Multimedia PCI",	BUDGET_TT_HW_DISEQC); UNDEFINED HARDWARE - mail linuxtv.org list */
+MAKE_BUDGET_INFO(satel,	"SATELCO Multimedia PCI",	BUDGET_TT_HW_DISEQC);
 MAKE_BUDGET_INFO(fsacs, "Fujitsu Siemens Activy Budget-S PCI", BUDGET_FS_ACTIVY);
 
 static struct pci_device_id pci_tbl[] = {
 	MAKE_EXTENSION_PCI(ttbs,  0x13c2, 0x1003),
 	MAKE_EXTENSION_PCI(ttbc,  0x13c2, 0x1004),
 	MAKE_EXTENSION_PCI(ttbt,  0x13c2, 0x1005),
-/*	MAKE_EXTENSION_PCI(satel, 0x13c2, 0x1013), UNDEFINED HARDWARE */
+	MAKE_EXTENSION_PCI(satel, 0x13c2, 0x1013),
 	MAKE_EXTENSION_PCI(fsacs, 0x1131, 0x4f61),
 	{
 		.vendor    = 0,
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/ttpci/budget-core.c linux-2.6.11-rc2-dvb/drivers/media/dvb/ttpci/budget-core.c
--- linux-2.6.11-rc2/drivers/media/dvb/ttpci/budget-core.c	2005-01-20 19:54:05.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/ttpci/budget-core.c	2005-01-20 19:56:39.000000000 +0100
@@ -89,11 +87,18 @@
 	 *	Pitch: 188, NumBytes3: 188, NumLines3: 1024
 	 */
 
-	if (budget->card->type == BUDGET_FS_ACTIVY) {
+        switch(budget->card->type) {
+	case BUDGET_FS_ACTIVY:
 		saa7146_write(dev, DD1_INIT, 0x04000000);
 		saa7146_write(dev, MC2, (MASK_09 | MASK_25));
 		saa7146_write(dev, BRS_CTRL, 0x00000000);
-	} else {
+		break;
+	case BUDGET_PATCH:
+		saa7146_write(dev, DD1_INIT, 0x00000200);
+		saa7146_write(dev, MC2, (MASK_10 | MASK_26));
+		saa7146_write(dev, BRS_CTRL, 0x60000000);
+		break;
+	default:
 		if (budget->video_port == BUDGET_VIDEO_PORTA) {
 			saa7146_write(dev, DD1_INIT, 0x06000200);
 			saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
@@ -122,9 +127,10 @@
 	}
 
       	saa7146_write(dev, MC2, (MASK_04 | MASK_20));
-     	saa7146_write(dev, MC1, (MASK_04 | MASK_20)); // DMA3 on
 
-	SAA7146_IER_ENABLE(budget->dev, MASK_10);	// VPE
+	SAA7146_ISR_CLEAR(budget->dev, MASK_10);	/* VPE */
+	SAA7146_IER_ENABLE(budget->dev, MASK_10);	/* VPE */
+	saa7146_write(dev, MC1, (MASK_04 | MASK_20));	/* DMA3 on */
 
         return ++budget->feeding;
 }
@@ -249,6 +254,7 @@
                 return -EINVAL;
 
    	spin_lock(&budget->feedlock);   
+	feed->pusi_seen = 0; /* have a clean section start */
 	status = start_ts_capture (budget);
    	spin_unlock(&budget->feedlock);
 	return status;
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/ttpci/budget-patch.c linux-2.6.11-rc2-dvb/drivers/media/dvb/ttpci/budget-patch.c
--- linux-2.6.11-rc2/drivers/media/dvb/ttpci/budget-patch.c	2005-01-20 19:54:05.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/ttpci/budget-patch.c	2005-01-20 19:56:39.000000000 +0100
@@ -41,34 +41,127 @@
 
 static struct saa7146_extension budget_extension;
 
-MAKE_BUDGET_INFO(fs_1_3,"Siemens/Technotrend/Hauppauge PCI rev1.3+Budget_Patch", BUDGET_PATCH);
+MAKE_BUDGET_INFO(ttbp, "TT-Budget/Patch DVB-S 1.x PCI", BUDGET_PATCH);
+//MAKE_BUDGET_INFO(satel,"TT-Budget/Patch SATELCO PCI", BUDGET_TT_HW_DISEQC);
 
 static struct pci_device_id pci_tbl[] = {
-        MAKE_EXTENSION_PCI(fs_1_3,0x13c2, 0x0000),
+        MAKE_EXTENSION_PCI(ttbp,0x13c2, 0x0000),
+//        MAKE_EXTENSION_PCI(satel, 0x13c2, 0x1013),
         {
                 .vendor    = 0,
         }
 };
 
-static int budget_wdebi(struct budget_patch *budget, u32 config, int addr, u32 val, int count)
+/* those lines are for budget-patch to be tried
+** on a true budget card and observe the
+** behaviour of VSYNC generated by rps1.
+** this code was shamelessly copy/pasted from budget.c 
+*/
+static void gpio_Set22K (struct budget *budget, int state)
+{
+	struct saa7146_dev *dev=budget->dev;
+	dprintk(2, "budget: %p\n", budget);
+	saa7146_setgpio(dev, 3, (state ? SAA7146_GPIO_OUTHI : SAA7146_GPIO_OUTLO));
+}
+
+/* Diseqc functions only for TT Budget card */
+/* taken from the Skyvision DVB driver by
+   Ralph Metzler <rjkm@metzlerbros.de> */
+
+static void DiseqcSendBit (struct budget *budget, int data)
+{
+	struct saa7146_dev *dev=budget->dev;
+	dprintk(2, "budget: %p\n", budget);
+
+	saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTHI);
+	udelay(data ? 500 : 1000);
+	saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO);
+	udelay(data ? 1000 : 500);
+}
+
+static void DiseqcSendByte (struct budget *budget, int data)
+{
+	int i, par=1, d;
+
+	dprintk(2, "budget: %p\n", budget);
+
+	for (i=7; i>=0; i--) {
+		d = (data>>i)&1;
+		par ^= d;
+		DiseqcSendBit(budget, d);
+	}
+
+	DiseqcSendBit(budget, par);
+}
+
+static int SendDiSEqCMsg (struct budget *budget, int len, u8 *msg, unsigned long burst)
 {
         struct saa7146_dev *dev=budget->dev;
+	int i;
 
         dprintk(2, "budget: %p\n", budget);
 
-        if (count <= 0 || count > 4)
-                return -1;
+	saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO);
+	mdelay(16);
+
+	for (i=0; i<len; i++)
+		DiseqcSendByte(budget, msg[i]);
+
+	mdelay(16);
+
+	if (burst!=-1) {
+		if (burst)
+			DiseqcSendByte(budget, 0xff);
+		else {
+			saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTHI);
+			udelay(12500);
+			saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO);
+		}
+		msleep(20);
+	}
+
+	return 0;
+}
+
+/* shamelessly copy/pasted from budget.c 
+*/
+static int budget_set_tone(struct dvb_frontend* fe, fe_sec_tone_mode_t tone)
+{
+	struct budget* budget = (struct budget*) fe->dvb->priv;
+
+	switch (tone) {
+	case SEC_TONE_ON:
+		gpio_Set22K (budget, 1);
+		break;
+
+	case SEC_TONE_OFF:
+		gpio_Set22K (budget, 0);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
 
-        saa7146_write(dev, DEBI_CONFIG, config);
+static int budget_diseqc_send_master_cmd(struct dvb_frontend* fe, struct dvb_diseqc_master_cmd* cmd)
+{
+	struct budget* budget = (struct budget*) fe->dvb->priv;
 
-        saa7146_write(dev, DEBI_AD, val );
-        saa7146_write(dev, DEBI_COMMAND, (count << 17) | (addr & 0xffff));
-        saa7146_write(dev, MC2, (2 << 16) | 2);
-        mdelay(5);
+	SendDiSEqCMsg (budget, cmd->msg_len, cmd->msg, 0);
 
         return 0;
 }
 
+static int budget_diseqc_send_burst(struct dvb_frontend* fe, fe_sec_mini_cmd_t minicmd)
+{
+	struct budget* budget = (struct budget*) fe->dvb->priv;
+
+	SendDiSEqCMsg (budget, 0, NULL, minicmd);
+
+	return 0;
+}
 
 static int budget_av7110_send_fw_cmd(struct budget_patch *budget, u16* buf, int length)
 {
@@ -77,14 +170,17 @@
         dprintk(2, "budget: %p\n", budget);
 
         for (i = 2; i < length; i++)
-                budget_wdebi(budget, DEBINOSWAP, COMMAND + 2*i, (u32) buf[i], 2);
-
+        {
+                  ttpci_budget_debiwrite(budget, DEBINOSWAP, COMMAND + 2*i, 2, (u32) buf[i], 0,0);
+                  msleep(5);
+        }                  
         if (length)
-                budget_wdebi(budget, DEBINOSWAP, COMMAND + 2, (u32) buf[1], 2);
+                  ttpci_budget_debiwrite(budget, DEBINOSWAP, COMMAND + 2, 2, (u32) buf[1], 0,0);
         else
-                budget_wdebi(budget, DEBINOSWAP, COMMAND + 2, 0, 2);
-
-        budget_wdebi(budget, DEBINOSWAP, COMMAND, (u32) buf[0], 2);
+                  ttpci_budget_debiwrite(budget, DEBINOSWAP, COMMAND + 2, 2, 0, 0,0);
+        msleep(5);     
+        ttpci_budget_debiwrite(budget, DEBINOSWAP, COMMAND, 2, (u32) buf[0], 0,0);
+        msleep(5);
         return 0;
 }
 
@@ -319,6 +415,7 @@
 {
 	switch(budget->dev->pci->subsystem_device) {
 	case 0x0000: // Hauppauge/TT WinTV DVB-S rev1.X
+        case 0x1013: // SATELCO Multimedia PCI
 
 		// try the ALPS BSRV2 first of all
 		budget->dvb_frontend = ves1x93_attach(&alps_bsrv2_config, &budget->i2c_adap);
@@ -332,18 +429,18 @@
 		// try the ALPS BSRU6 now
 		budget->dvb_frontend = stv0299_attach(&alps_bsru6_config, &budget->i2c_adap);
 		if (budget->dvb_frontend) {
-			budget->dvb_frontend->ops->diseqc_send_master_cmd = budget_patch_diseqc_send_master_cmd;
-			budget->dvb_frontend->ops->diseqc_send_burst = budget_patch_diseqc_send_burst;
-			budget->dvb_frontend->ops->set_tone = budget_patch_set_tone;
+			budget->dvb_frontend->ops->diseqc_send_master_cmd = budget_diseqc_send_master_cmd;
+			budget->dvb_frontend->ops->diseqc_send_burst = budget_diseqc_send_burst;
+			budget->dvb_frontend->ops->set_tone = budget_set_tone;
 			break;
 		}
 
 		// Try the grundig 29504-451
 		budget->dvb_frontend = tda8083_attach(&grundig_29504_451_config, &budget->i2c_adap);
 		if (budget->dvb_frontend) {
-			budget->dvb_frontend->ops->diseqc_send_master_cmd = budget_patch_diseqc_send_master_cmd;
-			budget->dvb_frontend->ops->diseqc_send_burst = budget_patch_diseqc_send_burst;
-			budget->dvb_frontend->ops->set_tone = budget_patch_set_tone;
+			budget->dvb_frontend->ops->diseqc_send_master_cmd = budget_diseqc_send_master_cmd;
+			budget->dvb_frontend->ops->diseqc_send_burst = budget_diseqc_send_burst;
+			budget->dvb_frontend->ops->set_tone = budget_set_tone;
 			break;
 		}
 		break;
@@ -365,23 +462,120 @@
 	}
 }
 
+/* written by Emard */
 static int budget_patch_attach (struct saa7146_dev* dev, struct saa7146_pci_extension_data *info)
 {
         struct budget_patch *budget;
         int err;
 	int count = 0;
+	int detected = 0;
 
-        if (!(budget = kmalloc (sizeof(struct budget_patch), GFP_KERNEL)))
-                return -ENOMEM;
+#define PATCH_RESET 0
+#define RPS_IRQ 0
+#define HPS_SETUP 0
+#if PATCH_RESET
+        saa7146_write(dev, MC1, MASK_31);
+        msleep(40);
+#endif
+#if HPS_SETUP
+        // initialize registers. Better to have it like this
+        // than leaving something unconfigured
+	saa7146_write(dev, DD1_STREAM_B, 0);
+	// port B VSYNC at rising edge
+	saa7146_write(dev, DD1_INIT, 0x00000200);  // have this in budget-core too!
+	saa7146_write(dev, BRS_CTRL, 0x00000000);  // VBI
+
+	// debi config
+	// saa7146_write(dev, DEBI_CONFIG, MASK_30|MASK_28|MASK_18);
+
+        // zero all HPS registers
+        saa7146_write(dev, HPS_H_PRESCALE, 0);                  // r68
+        saa7146_write(dev, HPS_H_SCALE, 0);                     // r6c
+        saa7146_write(dev, BCS_CTRL, 0);                        // r70
+        saa7146_write(dev, HPS_V_SCALE, 0);                     // r60
+        saa7146_write(dev, HPS_V_GAIN, 0);                      // r64
+        saa7146_write(dev, CHROMA_KEY_RANGE, 0);                // r74
+        saa7146_write(dev, CLIP_FORMAT_CTRL, 0);                // r78
+        // Set HPS prescaler for port B input
+        saa7146_write(dev, HPS_CTRL, (1<<30) | (0<<29) | (1<<28) | (0<<12) );
+        saa7146_write(dev, MC2, 
+          0 * (MASK_08 | MASK_24)  |   // BRS control
+          0 * (MASK_09 | MASK_25)  |   // a
+          0 * (MASK_10 | MASK_26)  |   // b
+          1 * (MASK_06 | MASK_22)  |   // HPS_CTRL1
+          1 * (MASK_05 | MASK_21)  |   // HPS_CTRL2
+          0 * (MASK_01 | MASK_15)      // DEBI
+           );
+#endif
+	// Disable RPS1 and RPS0
+        saa7146_write(dev, MC1, ( MASK_29 | MASK_28));
+        // RPS1 timeout disable
+        saa7146_write(dev, RPS_TOV1, 0);
+
+	// code for autodetection 
+	// will wait for VBI_B event (vertical blank at port B)
+	// and will reset GPIO3 after VBI_B is detected.
+	// (GPIO3 should be raised high by CPU to
+	// test if GPIO3 will generate vertical blank signal 
+	// in budget patch GPIO3 is connected to VSYNC_B
+	count = 0;
+#if 0
+	WRITE_RPS1(cpu_to_le32(CMD_UPLOAD | 
+	  MASK_10 | MASK_09 | MASK_08 | MASK_06 | MASK_05 | MASK_04 | MASK_03 | MASK_02 ));
+#endif
+        WRITE_RPS1(cpu_to_le32(CMD_PAUSE | EVT_VBI_B));
+        WRITE_RPS1(cpu_to_le32(CMD_WR_REG_MASK | (GPIO_CTRL>>2)));
+        WRITE_RPS1(cpu_to_le32(GPIO3_MSK));
+        WRITE_RPS1(cpu_to_le32(SAA7146_GPIO_OUTLO<<24));
+#if RPS_IRQ
+        // issue RPS1 interrupt to increment counter
+        WRITE_RPS1(cpu_to_le32(CMD_INTERRUPT));
+        // at least a NOP is neede between two interrupts
+        WRITE_RPS1(cpu_to_le32(CMD_NOP));
+        // interrupt again
+        WRITE_RPS1(cpu_to_le32(CMD_INTERRUPT));
+#endif
+        WRITE_RPS1(cpu_to_le32(CMD_STOP));
+
+#if RPS_IRQ
+        // set event counter 1 source as RPS1 interrupt (0x03)          (rE4 p53)
+        // use 0x03 to track RPS1 interrupts - increase by 1 every gpio3 is toggled
+        // use 0x15 to track VPE  interrupts - increase by 1 every vpeirq() is called
+        saa7146_write(dev, EC1SSR, (0x03<<2) | 3 );
+        // set event counter 1 treshold to maximum allowed value        (rEC p55)
+        saa7146_write(dev, ECT1R,  0x3fff );
+#endif
+        // Fix VSYNC level
+        saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO);
+        // Set RPS1 Address register to point to RPS code               (r108 p42)
+        saa7146_write(dev, RPS_ADDR1, dev->d_rps1.dma_handle);
+        // Enable RPS1,                                                 (rFC p33)
+        saa7146_write(dev, MC1, (MASK_13 | MASK_29 ));
 
-        dprintk(2, "budget: %p\n", budget);
 
-        if ((err = ttpci_budget_init (budget, dev, info, THIS_MODULE))) {
-                kfree (budget);
-                return err;
-        }
+        mdelay(50);
+        saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTHI);
+	mdelay(150);
+
+	
+	if( (saa7146_read(dev, GPIO_CTRL) & 0x10000000) == 0)
+		detected = 1;
+
+#if RPS_IRQ
+        printk("Event Counter 1 0x%04x\n", saa7146_read(dev, EC1R) & 0x3fff );
+#endif
+	// Disable RPS1
+        saa7146_write(dev, MC1, ( MASK_29 ));
+
+	if(detected == 0)
+                printk("budget-patch not detected or saa7146 in non-default state.\n"
+                       "try enabling ressetting of 7146 with MASK_31 in MC1 register\n");
+                
+	else
+                printk("BUDGET-PATCH DETECTED.\n");
 
-/*
+
+/*      OLD (Original design by Roberto Deza):
 **      This code will setup the SAA7146_RPS1 to generate a square 
 **      wave on GPIO3, changing when a field (TS_HEIGHT/2 "lines" of 
 **      TS_WIDTH packets) has been acquired on SAA7146_D1B video port; 
@@ -393,24 +587,85 @@
 **      which seems that can be done perfectly without this :-)).
 */                                                      
 
+/*      New design (By Emard)
+**      this rps1 code will copy internal HS event to GPIO3 pin.
+**      GPIO3 is in budget-patch hardware connectd to port B VSYNC
+
+**      HS is an internal event of 7146, accessible with RPS
+**      and temporarily raised high every n lines 
+**      (n in defined in the RPS_THRESH1 counter threshold)
+**      I think HS is raised high on the beginning of the n-th line
+**      and remains high until this n-th line that triggered
+**      it is completely received. When the receiption of n-th line
+**      ends, HS is lowered.
+
+**      To transmit data over DMA, 7146 needs changing state at 
+**      port B VSYNC pin. Any changing of port B VSYNC will 
+**      cause some DMA data transfer, with more or less packets loss.
+**      It depends on the phase and frequency of VSYNC and 
+**      the way of 7146 is instructed to trigger on port B (defined
+**      in DD1_INIT register, 3rd nibble from the right valid
+**      numbers are 0-7, see datasheet)
+**
+**      The correct triggering can minimize packet loss, 
+**      dvbtraffic should give this stable bandwidths:
+**        22k transponder = 33814 kbit/s
+**      27.5k transponder = 38045 kbit/s
+**      by experiment it is found that the best results 
+**      (stable bandwidths and almost no packet loss) 
+**      are obtained using DD1_INIT triggering number 2 
+**      (Va at rising edge of VS Fa = HS x VS-failing forced toggle) 
+**      and a VSYNC phase that occurs in the middle of DMA transfer
+**      (about byte 188*512=96256 in the DMA window).
+**
+**      Phase of HS is still not clear to me how to control,
+**      It just happens to be so. It can be seen if one enables
+**      RPS_IRQ and print Event Counter 1 in vpeirq(). Every
+**      time RPS_INTERRUPT is called, the Event Counter 1 will
+**      increment. That's how the 7146 is programmed to do event
+**      counting in this budget-patch.c
+**      I *think* HPS setting has something to do with the phase
+**      of HS but I cant be 100% sure in that. 
+
+**      hardware debug note: a working budget card (including budget patch)
+**      with vpeirq() interrupt setup in mode "0x90" (every 64K) will
+**      generate 3 interrupts per 25-Hz DMA frame of 2*188*512 bytes
+**      and that means 3*25=75 Hz of interrupt freqency, as seen by
+**      watch cat /proc/interrupts 
+**
+**      If this frequency is 3x lower (and data received in the DMA
+**      buffer don't start with 0x47, but in the middle of packets,
+**      whose lengths appear to be like 188 292 188 104 etc.
+**      this means VSYNC line is not connected in the hardware. 
+**      (check soldering pcb and pins)
+**      The same behaviour of missing VSYNC can be duplicated on budget 
+**      cards, by seting DD1_INIT trigger mode 7 in 3rd nibble.
+*/
+
 	// Setup RPS1 "program" (p35)
+        count = 0;
+
 
-        // Wait reset Source Line Counter Threshold                     (p36)
-        WRITE_RPS1(cpu_to_le32(CMD_PAUSE | RPS_INV | EVT_HS));
         // Wait Source Line Counter Threshold                           (p36)
         WRITE_RPS1(cpu_to_le32(CMD_PAUSE | EVT_HS));
         // Set GPIO3=1                                                  (p42)
         WRITE_RPS1(cpu_to_le32(CMD_WR_REG_MASK | (GPIO_CTRL>>2)));
         WRITE_RPS1(cpu_to_le32(GPIO3_MSK));
         WRITE_RPS1(cpu_to_le32(SAA7146_GPIO_OUTHI<<24));
+#if RPS_IRQ
+        // issue RPS1 interrupt
+        WRITE_RPS1(cpu_to_le32(CMD_INTERRUPT));
+#endif
         // Wait reset Source Line Counter Threshold                     (p36)
         WRITE_RPS1(cpu_to_le32(CMD_PAUSE | RPS_INV | EVT_HS));
-        // Wait Source Line Counter Threshold
-        WRITE_RPS1(cpu_to_le32(CMD_PAUSE | EVT_HS));
         // Set GPIO3=0                                                  (p42)
         WRITE_RPS1(cpu_to_le32(CMD_WR_REG_MASK | (GPIO_CTRL>>2)));
         WRITE_RPS1(cpu_to_le32(GPIO3_MSK));
         WRITE_RPS1(cpu_to_le32(SAA7146_GPIO_OUTLO<<24));
+#if RPS_IRQ
+        // issue RPS1 interrupt
+        WRITE_RPS1(cpu_to_le32(CMD_INTERRUPT));
+#endif
         // Jump to begin of RPS program                                 (p37)
         WRITE_RPS1(cpu_to_le32(CMD_JUMP));
         WRITE_RPS1(cpu_to_le32(dev->d_rps1.dma_handle));
@@ -420,10 +675,31 @@
         // Set RPS1 Address register to point to RPS code               (r108 p42)
         saa7146_write(dev, RPS_ADDR1, dev->d_rps1.dma_handle);
         // Set Source Line Counter Threshold, using BRS                 (rCC p43)
-        saa7146_write(dev, RPS_THRESH1, ((TS_HEIGHT/2) | MASK_12));
+        // It generates HS event every TS_HEIGHT lines
+        // this is related to TS_WIDTH set in register
+        // NUM_LINE_BYTE3 in budget-core.c. If NUM_LINE_BYTE
+        // low 16 bits are set to TS_WIDTH bytes (TS_WIDTH=2*188
+        //,then RPS_THRESH1
+        // should be set to trigger every TS_HEIGHT (512) lines.
+        // 
+        saa7146_write(dev, RPS_THRESH1, (TS_HEIGHT*1) | MASK_12 );
+        
+        // saa7146_write(dev, RPS_THRESH0, ((TS_HEIGHT/2)<<16) |MASK_28| (TS_HEIGHT/2) |MASK_12 );
         // Enable RPS1                                                  (rFC p33)
         saa7146_write(dev, MC1, (MASK_13 | MASK_29));
 
+	
+        if (!(budget = kmalloc (sizeof(struct budget_patch), GFP_KERNEL)))
+                return -ENOMEM;
+
+        dprintk(2, "budget: %p\n", budget);
+
+        if ((err = ttpci_budget_init (budget, dev, info, THIS_MODULE))) {
+                kfree (budget);
+                return err;
+        }
+
+
         dev->ext_priv = budget;
 
 	budget->dvb_adapter->priv = budget;

