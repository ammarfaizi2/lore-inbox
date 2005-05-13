Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVEMWWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVEMWWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbVEMWNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:13:15 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:63392 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262572AbVEMWKR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:10:17 -0400
Message-Id: <20050513220225.791887000@abc>
References: <20050513220019.907667000@abc>
Date: Sat, 14 May 2005 00:00:26 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-flexcop-pidfilter.patch
X-SA-Exim-Connect-IP: 217.231.56.126
Subject: [DVB patch 07/11] flexcop: use hw pid filter
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- enabled the HW PID by default for the PCI cards
- correct the TS demux parsing when PID filter is enabled (and thus the timer IRQ)
- rewrote the PID-filter and FULLTS control part in flexcop-hw-filter
  (thanks to Krzysztof Matula for pointing that out)

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/b2c2/flexcop-common.h    |    2 
 drivers/media/dvb/b2c2/flexcop-hw-filter.c |   73 +++++++++++++++--------------
 drivers/media/dvb/b2c2/flexcop-pci.c       |   28 ++++++-----
 3 files changed, 56 insertions(+), 47 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-hw-filter.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop-hw-filter.c	2005-05-12 01:30:16.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-hw-filter.c	2005-05-12 01:30:45.000000000 +0200
@@ -104,6 +104,9 @@ static void flexcop_pid_ECM_PID_ctrl(str
 
 static void flexcop_pid_control(struct flexcop_device *fc, int index, u16 pid,int onoff)
 {
+	if (pid == 0x2000)
+		return;
+
 	deb_ts("setting pid: %5d %04x at index %d '%s'\n",pid,pid,index,onoff ? "on" : "off");
 
 	/* We could use bit magic here to reduce source code size.
@@ -133,50 +136,50 @@ static void flexcop_pid_control(struct f
 	}
 }
 
+static int flexcop_toggle_fullts_streaming(struct flexcop_device *fc,int onoff)
+{
+	if (fc->fullts_streaming_state != onoff) {
+		deb_ts("%s full TS transfer\n",onoff ? "enabling" : "disabling");
+		flexcop_pid_group_filter(fc, 0, 0x1fe0 * (!onoff));
+		flexcop_pid_group_filter_ctrl(fc,onoff);
+		fc->fullts_streaming_state = onoff;
+	}
+	return 0;
+}
+
 int flexcop_pid_feed_control(struct flexcop_device *fc, struct dvb_demux_feed *dvbdmxfeed, int onoff)
 {
 	int max_pid_filter = 6 + fc->has_32_hw_pid_filter*32;
 
-	fc->feedcount += (onoff ? 1 : -1);
+	fc->feedcount += onoff ? 1 : -1;
+	if (dvbdmxfeed->index >= max_pid_filter)
+		fc->extra_feedcount += onoff ? 1 : -1;
+
+	/* toggle complete-TS-streaming when:
+	 * - pid_filtering is not enabled and it is the first or last feed requested
+	 * - pid_filtering is enabled,
+	 *   - but the number of requested feeds is exceeded
+	 *   - or the requested pid is 0x2000 */
 
-	/* when doing hw pid filtering, set the pid */
-	if (fc->pid_filtering)
-		flexcop_pid_control(fc,dvbdmxfeed->index,dvbdmxfeed->pid,onoff);
+	if (!fc->pid_filtering && fc->feedcount == onoff)
+		flexcop_toggle_fullts_streaming(fc,onoff);
 
-	/* if it was the first feed request */
-	if (fc->feedcount == onoff && onoff) {
-		if (!fc->pid_filtering) {
-			deb_ts("enabling full TS transfer\n");
-			flexcop_pid_group_filter(fc, 0,0);
-			flexcop_pid_group_filter_ctrl(fc,1);
-		}
-
-		if (fc->stream_control)
-			fc->stream_control(fc,1);
-		flexcop_rcv_data_ctrl(fc,1);
-
-	/* if there is no more feed left to feed */
-	} else if (fc->feedcount == onoff && !onoff) {
-		if (!fc->pid_filtering) {
-			deb_ts("disabling full TS transfer\n");
-			flexcop_pid_group_filter(fc, 0, 0x1fe0);
-			flexcop_pid_group_filter_ctrl(fc,0);
-		}
+	if (fc->pid_filtering) {
+		flexcop_pid_control(fc,dvbdmxfeed->index,dvbdmxfeed->pid,onoff);
 
-		flexcop_rcv_data_ctrl(fc,0);
-		if (fc->stream_control)
-			fc->stream_control(fc,0);
+		if (fc->extra_feedcount > 0)
+			flexcop_toggle_fullts_streaming(fc,1);
+		else if (dvbdmxfeed->pid == 0x2000)
+			flexcop_toggle_fullts_streaming(fc,onoff);
+		else
+			flexcop_toggle_fullts_streaming(fc,0);
 	}
 
-	/* if pid_filtering is on and more pids than the hw-filter can provide are
-	 * requested enable the whole bandwidth.
-	 */
-	if (fc->pid_filtering && fc->feedcount > max_pid_filter) {
-		flexcop_pid_group_filter(fc, 0,0);
-		flexcop_pid_group_filter_ctrl(fc,1);
-	} else if (fc->pid_filtering && fc->feedcount <= max_pid_filter) {
-		flexcop_pid_group_filter(fc, 0,0x1fe0);
-		flexcop_pid_group_filter_ctrl(fc,0);
+	/* if it was the first or last feed request change the stream-status */
+	if (fc->feedcount == onoff) {
+		flexcop_rcv_data_ctrl(fc,onoff);
+		if (fc->stream_control)
+			fc->stream_control(fc,onoff);
 	}
 
 	return 0;
Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-pci.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop-pci.c	2005-05-12 01:30:40.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-pci.c	2005-05-12 01:30:45.000000000 +0200
@@ -9,7 +9,7 @@
 #define FC_LOG_PREFIX "flexcop-pci"
 #include "flexcop-common.h"
 
-static int enable_pid_filtering = 0;
+static int enable_pid_filtering = 1;
 module_param(enable_pid_filtering, int, 0444);
 MODULE_PARM_DESC(enable_pid_filtering, "enable hardware pid filtering: supported values: 0 (fullts), 1");
 
@@ -45,13 +45,14 @@ struct flexcop_pci {
 	void __iomem *io_mem;
 	u32 irq;
 /* buffersize (at least for DMA1, need to be % 188 == 0,
- * this is logic is required */
+ * this logic is required */
 #define FC_DEFAULT_DMA1_BUFSIZE (1280 * 188)
 #define FC_DEFAULT_DMA2_BUFSIZE (10 * 188)
 	struct flexcop_dma dma[2];
 
 	int active_dma1_addr; /* 0 = addr0 of dma1; 1 = addr1 of dma1 */
 	u32 last_dma1_cur_pos; /* position of the pointer last time the timer/packet irq occured */
+	int count;
 
 	spinlock_t irq_lock;
 
@@ -99,15 +100,6 @@ static irqreturn_t flexcop_pci_irq(int i
 
 	spin_lock_irq(&fc_pci->irq_lock);
 
-	deb_irq("irq: %08x cur_addr: %08x (%d), our addrs. 1: %08x 2: %08x; 0x000: "
-			"%08x, 0x00c: %08x\n",v.raw,
-			fc->read_ibi_reg(fc,dma1_008).dma_0x8.dma_cur_addr << 2,
-			fc_pci->active_dma1_addr,
-			fc_pci->dma[0].dma_addr0,fc_pci->dma[0].dma_addr1,
-			fc->read_ibi_reg(fc,dma1_000).raw,
-			fc->read_ibi_reg(fc,dma1_00c).raw);
-
-
 	if (v.irq_20c.DMA1_IRQ_Status == 1) {
 		if (fc_pci->active_dma1_addr == 0)
 			flexcop_pass_dmx_packets(fc_pci->fc_dev,fc_pci->dma[0].cpu_addr0,fc_pci->dma[0].size / 188);
@@ -123,21 +115,28 @@ static irqreturn_t flexcop_pci_irq(int i
 			fc->read_ibi_reg(fc,dma1_008).dma_0x8.dma_cur_addr << 2;
 		u32 cur_pos = cur_addr - fc_pci->dma[0].dma_addr0;
 
+		deb_irq("irq: %08x cur_addr: %08x: cur_pos: %08x, last_cur_pos: %08x ",
+				v.raw,cur_addr,cur_pos,fc_pci->last_dma1_cur_pos);
+
 		/* buffer end was reached, restarted from the beginning
 		 * pass the data from last_cur_pos to the buffer end to the demux
 		 */
 		if (cur_pos < fc_pci->last_dma1_cur_pos) {
+			deb_irq(" end was reached: passing %d bytes ",(fc_pci->dma[0].size*2 - 1) - fc_pci->last_dma1_cur_pos);
 			flexcop_pass_dmx_data(fc_pci->fc_dev,
 					fc_pci->dma[0].cpu_addr0 + fc_pci->last_dma1_cur_pos,
-					(fc_pci->dma[0].size*2 - 1) - fc_pci->last_dma1_cur_pos);
+					(fc_pci->dma[0].size*2) - fc_pci->last_dma1_cur_pos);
 			fc_pci->last_dma1_cur_pos = 0;
+			fc_pci->count = 0;
 		}
 
 		if (cur_pos > fc_pci->last_dma1_cur_pos) {
+			deb_irq(" passing %d bytes ",cur_pos - fc_pci->last_dma1_cur_pos);
 			flexcop_pass_dmx_data(fc_pci->fc_dev,
 					fc_pci->dma[0].cpu_addr0 + fc_pci->last_dma1_cur_pos,
 					cur_pos - fc_pci->last_dma1_cur_pos);
 		}
+		deb_irq("\n");
 
 		fc_pci->last_dma1_cur_pos = cur_pos;
 	} else
@@ -301,6 +300,11 @@ static int flexcop_pci_probe(struct pci_
 
 	fc->stream_control = flexcop_pci_stream_control;
 
+	if (enable_pid_filtering)
+		info("will use the HW PID filter.");
+	else
+		info("will pass the complete TS to the demuxer.");
+
 	fc->pid_filtering = enable_pid_filtering;
 	fc->bus_type = FC_PCI;
 
Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-common.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop-common.h	2005-05-12 01:30:26.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-common.h	2005-05-12 01:30:45.000000000 +0200
@@ -76,8 +76,10 @@ struct flexcop_device {
 	struct semaphore i2c_sem;
 
 	/* options and status */
+	int extra_feedcount;
 	int feedcount;
 	int pid_filtering;
+	int fullts_streaming_state;
 
 	/* bus specific callbacks */
 	flexcop_ibi_value (*read_ibi_reg)  (struct flexcop_device *, flexcop_ibi_register);

--

