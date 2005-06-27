Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVF0NH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVF0NH7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVF0NEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:04:47 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:9701 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262053AbVF0MQ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:27 -0400
Message-Id: <20050627121413.123601000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:18 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-flexcop-irq-stop-workaround.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 18/51] flexcop: woraround irq stop problem
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

The flexcop chip often stops generating interrupts after some hours
of operation. Apparently this can be fixed by resetting register
block 0x300 at each channel change (this is
not detailed in the flexcop data books).
This patch also restructures DMA handling and adds a bit of debug
code for the irq problem in case it still happens for someone.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/b2c2/flexcop-common.h       |    6 
 drivers/media/dvb/b2c2/flexcop-dma.c          |  165 +++++++++++++++++---------
 drivers/media/dvb/b2c2/flexcop-hw-filter.c    |   12 +
 drivers/media/dvb/b2c2/flexcop-misc.c         |   12 +
 drivers/media/dvb/b2c2/flexcop-pci.c          |  122 +++++++++++++------
 drivers/media/dvb/b2c2/flexcop.c              |   34 +++++
 drivers/media/dvb/b2c2/flexcop.h              |    1 
 drivers/media/dvb/b2c2/flexcop_ibi_value_be.h |    9 +
 drivers/media/dvb/b2c2/flexcop_ibi_value_le.h |    9 +
 9 files changed, 274 insertions(+), 96 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop-common.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/b2c2/flexcop-common.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop-common.h	2005-06-27 13:24:10.000000000 +0200
@@ -108,6 +108,8 @@ void flexcop_device_kfree(struct flexcop
 int  flexcop_device_initialize(struct flexcop_device*);
 void flexcop_device_exit(struct flexcop_device *fc);
 
+void flexcop_reset_block_300(struct flexcop_device *fc);
+
 /* from flexcop-dma.c */
 int flexcop_dma_allocate(struct pci_dev *pdev, struct flexcop_dma *dma, u32 size);
 void flexcop_dma_free(struct flexcop_dma *dma);
@@ -115,7 +117,8 @@ void flexcop_dma_free(struct flexcop_dma
 int flexcop_dma_control_timer_irq(struct flexcop_device *fc, flexcop_dma_index_t no, int onoff);
 int flexcop_dma_control_size_irq(struct flexcop_device *fc, flexcop_dma_index_t no, int onoff);
 int flexcop_dma_control_packet_irq(struct flexcop_device *fc, flexcop_dma_index_t no, int onoff);
-int flexcop_dma_config(struct flexcop_device *fc, struct flexcop_dma *dma, flexcop_dma_index_t dma_idx,flexcop_dma_addr_index_t index);
+int flexcop_dma_config(struct flexcop_device *fc, struct flexcop_dma *dma, flexcop_dma_index_t dma_idx);
+int flexcop_dma_xfer_control(struct flexcop_device *fc, flexcop_dma_index_t dma_idx, flexcop_dma_addr_index_t index, int onoff);
 int flexcop_dma_config_timer(struct flexcop_device *fc, flexcop_dma_index_t dma_idx, u8 cycles);
 int flexcop_dma_config_packet_count(struct flexcop_device *fc, flexcop_dma_index_t dma_idx, u8 packets);
 
@@ -151,6 +154,7 @@ int flexcop_sram_init(struct flexcop_dev
 /* from flexcop-misc.c */
 void flexcop_determine_revision(struct flexcop_device *fc);
 void flexcop_device_name(struct flexcop_device *fc,const char *prefix,const char *suffix);
+void flexcop_dump_reg(struct flexcop_device *fc, flexcop_ibi_register reg, int num);
 
 /* from flexcop-hw-filter.c */
 int flexcop_pid_feed_control(struct flexcop_device *fc, struct dvb_demux_feed *dvbdmxfeed, int onoff);
Index: linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop-dma.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/b2c2/flexcop-dma.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop-dma.c	2005-06-27 13:24:10.000000000 +0200
@@ -37,22 +37,90 @@ void flexcop_dma_free(struct flexcop_dma
 }
 EXPORT_SYMBOL(flexcop_dma_free);
 
-int flexcop_dma_control_timer_irq(struct flexcop_device *fc, flexcop_dma_index_t no, int onoff)
+int flexcop_dma_config(struct flexcop_device *fc,
+		struct flexcop_dma *dma,
+		flexcop_dma_index_t dma_idx)
 {
-	flexcop_ibi_value v = fc->read_ibi_reg(fc,ctrl_208);
+	flexcop_ibi_value v0x0,v0x4,v0xc;
+	v0x0.raw = v0x4.raw = v0xc.raw = 0;
 
-	if (no & FC_DMA_1)
-		v.ctrl_208.DMA1_Timer_Enable_sig = onoff;
+	v0x0.dma_0x0.dma_address0        = dma->dma_addr0 >> 2;
+	v0xc.dma_0xc.dma_address1        = dma->dma_addr1 >> 2;
+	v0x4.dma_0x4_write.dma_addr_size = dma->size / 4;
 
-	if (no & FC_DMA_2)
-		v.ctrl_208.DMA2_Timer_Enable_sig = onoff;
+	if ((dma_idx & FC_DMA_1) == dma_idx) {
+		fc->write_ibi_reg(fc,dma1_000,v0x0);
+		fc->write_ibi_reg(fc,dma1_004,v0x4);
+		fc->write_ibi_reg(fc,dma1_00c,v0xc);
+	} else if ((dma_idx & FC_DMA_2) == dma_idx) {
+		fc->write_ibi_reg(fc,dma2_010,v0x0);
+		fc->write_ibi_reg(fc,dma2_014,v0x4);
+		fc->write_ibi_reg(fc,dma2_01c,v0xc);
+	} else {
+		err("either DMA1 or DMA2 can be configured at the within one flexcop_dma_config call.");
+		return -EINVAL;
+	}
 
-	fc->write_ibi_reg(fc,ctrl_208,v);
 	return 0;
 }
-EXPORT_SYMBOL(flexcop_dma_control_timer_irq);
+EXPORT_SYMBOL(flexcop_dma_config);
+
+/* start the DMA transfers, but not the DMA IRQs */
+int flexcop_dma_xfer_control(struct flexcop_device *fc,
+		flexcop_dma_index_t dma_idx,
+		flexcop_dma_addr_index_t index,
+		int onoff)
+{
+	flexcop_ibi_value v0x0,v0xc;
+	flexcop_ibi_register r0x0,r0xc;
+
+	if ((dma_idx & FC_DMA_1) == dma_idx) {
+		r0x0 = dma1_000;
+		r0xc = dma1_00c;
+	} else if ((dma_idx & FC_DMA_2) == dma_idx) {
+		r0x0 = dma2_010;
+		r0xc = dma2_01c;
+	} else {
+		err("either transfer DMA1 or DMA2 can be started within one flexcop_dma_xfer_control call.");
+		return -EINVAL;
+	}
+
+	v0x0 = fc->read_ibi_reg(fc,r0x0);
+	v0xc = fc->read_ibi_reg(fc,r0xc);
 
-int flexcop_dma_control_size_irq(struct flexcop_device *fc, flexcop_dma_index_t no, int onoff)
+	deb_rdump("reg: %03x: %x\n",r0x0,v0x0.raw);
+	deb_rdump("reg: %03x: %x\n",r0xc,v0xc.raw);
+
+	if (index & FC_DMA_SUBADDR_0)
+		v0x0.dma_0x0.dma_0start = onoff;
+
+	if (index & FC_DMA_SUBADDR_1)
+		v0xc.dma_0xc.dma_1start = onoff;
+
+	fc->write_ibi_reg(fc,r0x0,v0x0);
+	fc->write_ibi_reg(fc,r0xc,v0xc);
+
+	deb_rdump("reg: %03x: %x\n",r0x0,v0x0.raw);
+	deb_rdump("reg: %03x: %x\n",r0xc,v0xc.raw);
+	return 0;
+}
+EXPORT_SYMBOL(flexcop_dma_xfer_control);
+
+static int flexcop_dma_remap(struct flexcop_device *fc,
+		flexcop_dma_index_t dma_idx,
+		int onoff)
+{
+	flexcop_ibi_register r = (dma_idx & FC_DMA_1) ? dma1_00c : dma2_01c;
+	flexcop_ibi_value v = fc->read_ibi_reg(fc,r);
+	deb_info("%s\n",__FUNCTION__);
+	v.dma_0xc.remap_enable = onoff;
+	fc->write_ibi_reg(fc,r,v);
+	return 0;
+}
+
+int flexcop_dma_control_size_irq(struct flexcop_device *fc,
+		flexcop_dma_index_t no,
+		int onoff)
 {
 	flexcop_ibi_value v = fc->read_ibi_reg(fc,ctrl_208);
 
@@ -67,75 +135,64 @@ int flexcop_dma_control_size_irq(struct 
 }
 EXPORT_SYMBOL(flexcop_dma_control_size_irq);
 
-int flexcop_dma_control_packet_irq(struct flexcop_device *fc, flexcop_dma_index_t no, int onoff)
+int flexcop_dma_control_timer_irq(struct flexcop_device *fc,
+		flexcop_dma_index_t no,
+		int onoff)
 {
 	flexcop_ibi_value v = fc->read_ibi_reg(fc,ctrl_208);
 
 	if (no & FC_DMA_1)
-		v.ctrl_208.DMA1_Size_IRQ_Enable_sig = onoff;
+		v.ctrl_208.DMA1_Timer_Enable_sig = onoff;
 
 	if (no & FC_DMA_2)
-		v.ctrl_208.DMA2_Size_IRQ_Enable_sig = onoff;
+		v.ctrl_208.DMA2_Timer_Enable_sig = onoff;
 
 	fc->write_ibi_reg(fc,ctrl_208,v);
 	return 0;
 }
-EXPORT_SYMBOL(flexcop_dma_control_packet_irq);
+EXPORT_SYMBOL(flexcop_dma_control_timer_irq);
 
-int flexcop_dma_config(struct flexcop_device *fc, struct flexcop_dma *dma, flexcop_dma_index_t dma_idx,flexcop_dma_addr_index_t index)
+/* 1 cycles = 1.97 msec */
+int flexcop_dma_config_timer(struct flexcop_device *fc,
+		flexcop_dma_index_t dma_idx,
+		u8 cycles)
 {
+	flexcop_ibi_register r = (dma_idx & FC_DMA_1) ? dma1_004 : dma2_014;
+	flexcop_ibi_value v = fc->read_ibi_reg(fc,r);
 
-	flexcop_ibi_value v0x0,v0x4,v0xc;
-	v0x0.raw = v0x4.raw = v0xc.raw = 0;
-
-	v0x0.dma_0x0.dma_address0        = dma->dma_addr0 >> 2;
-	v0xc.dma_0xc.dma_address1        = dma->dma_addr1 >> 2;
-	v0x4.dma_0x4_write.dma_addr_size = dma->size / 4;
-
-	if (index & FC_DMA_SUBADDR_0)
-		v0x0.dma_0x0.dma_0start = 1;
-
-	if (index & FC_DMA_SUBADDR_1)
-		v0xc.dma_0xc.dma_1start = 1;
-
-	if (dma_idx & FC_DMA_1) {
-		fc->write_ibi_reg(fc,dma1_000,v0x0);
-		fc->write_ibi_reg(fc,dma1_004,v0x4);
-		fc->write_ibi_reg(fc,dma1_00c,v0xc);
-	} else { /* (dma_idx & FC_DMA_2) */
-		fc->write_ibi_reg(fc,dma2_010,v0x0);
-		fc->write_ibi_reg(fc,dma2_014,v0x4);
-		fc->write_ibi_reg(fc,dma2_01c,v0xc);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(flexcop_dma_config);
+	flexcop_dma_remap(fc,dma_idx,0);
 
-static int flexcop_dma_remap(struct flexcop_device *fc, flexcop_dma_index_t dma_idx, int onoff)
-{
-	flexcop_ibi_register r = (dma_idx & FC_DMA_1) ? dma1_00c : dma2_01c;
-	flexcop_ibi_value v = fc->read_ibi_reg(fc,r);
-	v.dma_0xc.remap_enable = onoff;
+	deb_info("%s\n",__FUNCTION__);
+	v.dma_0x4_write.dmatimer = cycles;
 	fc->write_ibi_reg(fc,r,v);
 	return 0;
 }
+EXPORT_SYMBOL(flexcop_dma_config_timer);
 
-/* 1 cycles = 1.97 msec */
-int flexcop_dma_config_timer(struct flexcop_device *fc, flexcop_dma_index_t dma_idx, u8 cycles)
+/* packet IRQ does not exist in FCII or FCIIb - according to data book and tests */
+int flexcop_dma_control_packet_irq(struct flexcop_device *fc,
+		flexcop_dma_index_t no,
+		int onoff)
 {
-	flexcop_ibi_register r = (dma_idx & FC_DMA_1) ? dma1_004 : dma2_014;
-	flexcop_ibi_value v = fc->read_ibi_reg(fc,r);
+	flexcop_ibi_value v = fc->read_ibi_reg(fc,ctrl_208);
 
-	flexcop_dma_remap(fc,dma_idx,0);
+	deb_rdump("reg: %03x: %x\n",ctrl_208,v.raw);
+	if (no & FC_DMA_1)
+		v.ctrl_208.DMA1_Size_IRQ_Enable_sig = onoff;
+
+	if (no & FC_DMA_2)
+		v.ctrl_208.DMA2_Size_IRQ_Enable_sig = onoff;
+
+	fc->write_ibi_reg(fc,ctrl_208,v);
+	deb_rdump("reg: %03x: %x\n",ctrl_208,v.raw);
 
-	v.dma_0x4_write.dmatimer = cycles >> 1;
-	fc->write_ibi_reg(fc,r,v);
 	return 0;
 }
-EXPORT_SYMBOL(flexcop_dma_config_timer);
+EXPORT_SYMBOL(flexcop_dma_control_packet_irq);
 
-int flexcop_dma_config_packet_count(struct flexcop_device *fc, flexcop_dma_index_t dma_idx, u8 packets)
+int flexcop_dma_config_packet_count(struct flexcop_device *fc,
+		flexcop_dma_index_t dma_idx,
+		u8 packets)
 {
 	flexcop_ibi_register r = (dma_idx & FC_DMA_1) ? dma1_004 : dma2_014;
 	flexcop_ibi_value v = fc->read_ibi_reg(fc,r);
Index: linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop-hw-filter.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/b2c2/flexcop-hw-filter.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop-hw-filter.c	2005-06-27 13:24:10.000000000 +0200
@@ -10,6 +10,8 @@
 static void flexcop_rcv_data_ctrl(struct flexcop_device *fc, int onoff)
 {
 	flexcop_set_ibi_value(ctrl_208,Rcv_Data_sig,onoff);
+
+	deb_ts("rcv_data is now: '%s'\n",onoff ? "on" : "off");
 }
 
 void flexcop_smc_ctrl(struct flexcop_device *fc, int onoff)
@@ -151,7 +153,7 @@ int flexcop_pid_feed_control(struct flex
 {
 	int max_pid_filter = 6 + fc->has_32_hw_pid_filter*32;
 
-	fc->feedcount += onoff ? 1 : -1;
+	fc->feedcount += onoff ? 1 : -1; /* the number of PIDs/Feed currently requested */
 	if (dvbdmxfeed->index >= max_pid_filter)
 		fc->extra_feedcount += onoff ? 1 : -1;
 
@@ -178,8 +180,14 @@ int flexcop_pid_feed_control(struct flex
 	/* if it was the first or last feed request change the stream-status */
 	if (fc->feedcount == onoff) {
 		flexcop_rcv_data_ctrl(fc,onoff);
-		if (fc->stream_control)
+		if (fc->stream_control) /* device specific stream control */
 			fc->stream_control(fc,onoff);
+
+		/* feeding stopped -> reset the flexcop filter*/
+		if (onoff == 0) {
+			flexcop_reset_block_300(fc);
+			flexcop_hw_filter_init(fc);
+		}
 	}
 
 	return 0;
Index: linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop-misc.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/b2c2/flexcop-misc.c	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop-misc.c	2005-06-27 13:24:10.000000000 +0200
@@ -65,3 +65,15 @@ void flexcop_device_name(struct flexcop_
 			flexcop_device_names[fc->dev_type],flexcop_bus_names[fc->bus_type],
 			flexcop_revision_names[fc->rev],suffix);
 }
+
+void flexcop_dump_reg(struct flexcop_device *fc, flexcop_ibi_register reg, int num)
+{
+	flexcop_ibi_value v;
+	int i;
+	for (i = 0; i < num; i++) {
+		v = fc->read_ibi_reg(fc,reg+4*i);
+		deb_rdump("0x%03x: %08x, ",reg+4*i, v.raw);
+	}
+	deb_rdump("\n");
+}
+EXPORT_SYMBOL(flexcop_dump_reg);
Index: linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop-pci.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/b2c2/flexcop-pci.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop-pci.c	2005-06-27 13:24:10.000000000 +0200
@@ -13,6 +13,10 @@ static int enable_pid_filtering = 1;
 module_param(enable_pid_filtering, int, 0444);
 MODULE_PARM_DESC(enable_pid_filtering, "enable hardware pid filtering: supported values: 0 (fullts), 1");
 
+static int irq_chk_intv;
+module_param(irq_chk_intv, int, 0644);
+MODULE_PARM_DESC(irq_chk_intv, "set the interval for IRQ watchdog (currently just debugging).");
+
 #ifdef CONFIG_DVB_B2C2_FLEXCOP_DEBUG
 #define dprintk(level,args...) \
 	do { if ((debug & level)) printk(args); } while (0)
@@ -26,6 +30,7 @@ MODULE_PARM_DESC(enable_pid_filtering, "
 #define deb_reg(args...)   dprintk(0x02,args)
 #define deb_ts(args...)    dprintk(0x04,args)
 #define deb_irq(args...)   dprintk(0x08,args)
+#define deb_chk(args...)   dprintk(0x10,args)
 
 static int debug = 0;
 module_param(debug, int, 0644);
@@ -56,6 +61,10 @@ struct flexcop_pci {
 
 	spinlock_t irq_lock;
 
+	unsigned long last_irq;
+
+	struct work_struct irq_check_work;
+
 	struct flexcop_device *fc_dev;
 };
 
@@ -88,18 +97,55 @@ static int flexcop_pci_write_ibi_reg(str
 	return 0;
 }
 
+static void flexcop_pci_irq_check_work(void *data)
+{
+	struct flexcop_pci *fc_pci = data;
+	struct flexcop_device *fc = fc_pci->fc_dev;
+
+	flexcop_ibi_value v = fc->read_ibi_reg(fc,sram_dest_reg_714);
+
+	flexcop_dump_reg(fc_pci->fc_dev,dma1_000,4);
+
+	if (v.sram_dest_reg_714.net_ovflow_error)
+		deb_chk("sram net_ovflow_error\n");
+	if (v.sram_dest_reg_714.media_ovflow_error)
+		deb_chk("sram media_ovflow_error\n");
+	if (v.sram_dest_reg_714.cai_ovflow_error)
+		deb_chk("sram cai_ovflow_error\n");
+	if (v.sram_dest_reg_714.cai_ovflow_error)
+		deb_chk("sram cai_ovflow_error\n");
+
+	schedule_delayed_work(&fc_pci->irq_check_work,
+			msecs_to_jiffies(irq_chk_intv < 100 ? 100 : irq_chk_intv));
+}
+
 /* When PID filtering is turned on, we use the timer IRQ, because small amounts
  * of data need to be passed to the user space instantly as well. When PID
  * filtering is turned off, we use the page-change-IRQ */
-static irqreturn_t flexcop_pci_irq(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t flexcop_pci_isr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct flexcop_pci *fc_pci = dev_id;
 	struct flexcop_device *fc = fc_pci->fc_dev;
-	flexcop_ibi_value v = fc->read_ibi_reg(fc,irq_20c);
+	flexcop_ibi_value v;
 	irqreturn_t ret = IRQ_HANDLED;
 
 	spin_lock_irq(&fc_pci->irq_lock);
 
+	v = fc->read_ibi_reg(fc,irq_20c);
+
+   /* errors */
+	if (v.irq_20c.Data_receiver_error)
+		deb_chk("data receiver error\n");
+	if (v.irq_20c.Continuity_error_flag)
+		deb_chk("Contunuity error flag is set\n");
+	if (v.irq_20c.LLC_SNAP_FLAG_set)
+		deb_chk("LLC_SNAP_FLAG_set is set\n");
+	if (v.irq_20c.Transport_Error)
+		deb_chk("Transport error\n");
+
+	if ((fc_pci->count % 1000) == 0)
+		deb_chk("%d valid irq took place so far\n",fc_pci->count);
+
 	if (v.irq_20c.DMA1_IRQ_Status == 1) {
 		if (fc_pci->active_dma1_addr == 0)
 			flexcop_pass_dmx_packets(fc_pci->fc_dev,fc_pci->dma[0].cpu_addr0,fc_pci->dma[0].size / 188);
@@ -115,8 +161,9 @@ static irqreturn_t flexcop_pci_irq(int i
 			fc->read_ibi_reg(fc,dma1_008).dma_0x8.dma_cur_addr << 2;
 		u32 cur_pos = cur_addr - fc_pci->dma[0].dma_addr0;
 
-		deb_irq("irq: %08x cur_addr: %08x: cur_pos: %08x, last_cur_pos: %08x ",
-				v.raw,cur_addr,cur_pos,fc_pci->last_dma1_cur_pos);
+		deb_irq("%u irq: %08x cur_addr: %08x: cur_pos: %08x, last_cur_pos: %08x ",
+				jiffies_to_usecs(jiffies - fc_pci->last_irq),v.raw,cur_addr,cur_pos,fc_pci->last_dma1_cur_pos);
+		fc_pci->last_irq = jiffies;
 
 		/* buffer end was reached, restarted from the beginning
 		 * pass the data from last_cur_pos to the buffer end to the demux
@@ -127,7 +174,6 @@ static irqreturn_t flexcop_pci_irq(int i
 					fc_pci->dma[0].cpu_addr0 + fc_pci->last_dma1_cur_pos,
 					(fc_pci->dma[0].size*2) - fc_pci->last_dma1_cur_pos);
 			fc_pci->last_dma1_cur_pos = 0;
-			fc_pci->count = 0;
 		}
 
 		if (cur_pos > fc_pci->last_dma1_cur_pos) {
@@ -139,16 +185,14 @@ static irqreturn_t flexcop_pci_irq(int i
 		deb_irq("\n");
 
 		fc_pci->last_dma1_cur_pos = cur_pos;
-	} else
+		fc_pci->count++;
+	} else {
+		deb_irq("isr for flexcop called, apparently without reason (%08x)\n",v.raw);
 		ret = IRQ_NONE;
+	}
 
 	spin_unlock_irq(&fc_pci->irq_lock);
 
-/* packet count would be ideal for hw filtering, but it isn't working. Either
- * the data book is wrong, or I'm unable to read it correctly */
-
-/*	if (v.irq_20c.DMA1_Size_IRQ_Status == 1) { packet counter */
-
 	return ret;
 }
 
@@ -156,30 +200,35 @@ static int flexcop_pci_stream_control(st
 {
 	struct flexcop_pci *fc_pci = fc->bus_specific;
 	if (onoff) {
-		flexcop_dma_config(fc,&fc_pci->dma[0],FC_DMA_1,FC_DMA_SUBADDR_0 | FC_DMA_SUBADDR_1);
-		flexcop_dma_config(fc,&fc_pci->dma[1],FC_DMA_2,FC_DMA_SUBADDR_0 | FC_DMA_SUBADDR_1);
-		flexcop_dma_config_timer(fc,FC_DMA_1,1);
+		flexcop_dma_config(fc,&fc_pci->dma[0],FC_DMA_1);
+		flexcop_dma_config(fc,&fc_pci->dma[1],FC_DMA_2);
 
-		if (fc_pci->fc_dev->pid_filtering) {
-			fc_pci->last_dma1_cur_pos = 0;
-			flexcop_dma_control_timer_irq(fc,FC_DMA_1,1);
-		} else {
-			fc_pci->active_dma1_addr = 0;
-			flexcop_dma_control_size_irq(fc,FC_DMA_1,1);
-		}
+		flexcop_dma_config_timer(fc,FC_DMA_1,0);
 
-/*		flexcop_dma_config_packet_count(fc,FC_DMA_1,0xc0);
-		flexcop_dma_control_packet_irq(fc,FC_DMA_1,1); */
+		flexcop_dma_xfer_control(fc,FC_DMA_1,FC_DMA_SUBADDR_0 | FC_DMA_SUBADDR_1,1);
+		deb_irq("DMA xfer enabled\n");
 
-		deb_irq("irqs enabled\n");
+		fc_pci->last_dma1_cur_pos = 0;
+		flexcop_dma_control_timer_irq(fc,FC_DMA_1,1);
+		deb_irq("IRQ enabled\n");
+
+//		fc_pci->active_dma1_addr = 0;
+//		flexcop_dma_control_size_irq(fc,FC_DMA_1,1);
+
+		if (irq_chk_intv > 0)
+			schedule_delayed_work(&fc_pci->irq_check_work,
+					msecs_to_jiffies(irq_chk_intv < 100 ? 100 : irq_chk_intv));
 	} else {
-		if (fc_pci->fc_dev->pid_filtering)
-			flexcop_dma_control_timer_irq(fc,FC_DMA_1,0);
-		else
-			flexcop_dma_control_size_irq(fc,FC_DMA_1,0);
+		if (irq_chk_intv > 0)
+			cancel_delayed_work(&fc_pci->irq_check_work);
+
+		flexcop_dma_control_timer_irq(fc,FC_DMA_1,0);
+		deb_irq("IRQ disabled\n");
 
-//		flexcop_dma_control_packet_irq(fc,FC_DMA_1,0);
-		deb_irq("irqs disabled\n");
+//		flexcop_dma_control_size_irq(fc,FC_DMA_1,0);
+
+		flexcop_dma_xfer_control(fc,FC_DMA_1,FC_DMA_SUBADDR_0 | FC_DMA_SUBADDR_1,0);
+		deb_irq("DMA xfer disabled\n");
 	}
 
 	return 0;
@@ -198,6 +247,7 @@ static int flexcop_pci_dma_init(struct f
 	flexcop_sram_set_dest(fc_pci->fc_dev,FC_SRAM_DEST_CAO   | FC_SRAM_DEST_CAI, FC_SRAM_DEST_TARGET_DMA2);
 
 	fc_pci->init_state |= FC_PCI_DMA_INIT;
+
 	goto success;
 dma1_free:
 	flexcop_dma_free(&fc_pci->dma[0]);
@@ -244,7 +294,7 @@ static int flexcop_pci_init(struct flexc
 
 	pci_set_drvdata(fc_pci->pdev, fc_pci);
 
-	if ((ret = request_irq(fc_pci->pdev->irq, flexcop_pci_irq,
+	if ((ret = request_irq(fc_pci->pdev->irq, flexcop_pci_isr,
 					SA_SHIRQ, DRIVER_NAME, fc_pci)) != 0)
 		goto err_pci_iounmap;
 
@@ -324,6 +374,8 @@ static int flexcop_pci_probe(struct pci_
 	if ((ret = flexcop_pci_dma_init(fc_pci)) != 0)
 		goto err_fc_exit;
 
+	INIT_WORK(&fc_pci->irq_check_work, flexcop_pci_irq_check_work, fc_pci);
+
 	goto success;
 err_fc_exit:
 	flexcop_device_exit(fc);
@@ -350,17 +402,17 @@ static void flexcop_pci_remove(struct pc
 
 static struct pci_device_id flexcop_pci_tbl[] = {
 	{ PCI_DEVICE(0x13d0, 0x2103) },
-/*	{ PCI_DEVICE(0x13d0, 0x2200) }, PCI FlexCopIII ? */
+/*	{ PCI_DEVICE(0x13d0, 0x2200) }, ? */
 	{ },
 };
 
 MODULE_DEVICE_TABLE(pci, flexcop_pci_tbl);
 
 static struct pci_driver flexcop_pci_driver = {
-	.name = "Technisat/B2C2 FlexCop II/IIb/III PCI",
+	.name     = "Technisat/B2C2 FlexCop II/IIb PCI",
 	.id_table = flexcop_pci_tbl,
-	.probe = flexcop_pci_probe,
-	.remove = flexcop_pci_remove,
+	.probe    = flexcop_pci_probe,
+	.remove   = flexcop_pci_remove,
 };
 
 static int __init flexcop_pci_module_init(void)
Index: linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/b2c2/flexcop.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop.c	2005-06-27 13:24:10.000000000 +0200
@@ -46,7 +46,7 @@
 
 int b2c2_flexcop_debug;
 module_param_named(debug, b2c2_flexcop_debug,  int, 0644);
-MODULE_PARM_DESC(debug, "set debug level (1=info,2=tuner,4=i2c,8=ts,16=sram (|-able))." DEBSTATUS);
+MODULE_PARM_DESC(debug, "set debug level (1=info,2=tuner,4=i2c,8=ts,16=sram,32=reg (|-able))." DEBSTATUS);
 #undef DEBSTATUS
 
 /* global zero for ibi values */
@@ -173,9 +173,20 @@ static void flexcop_reset(struct flexcop
 	fc->write_ibi_reg(fc,ctrl_208,ibi_zero);
 
 	v210.raw = 0;
-	v210.sw_reset_210.reset_blocks = 0xff;
+	v210.sw_reset_210.reset_block_000 = 1;
+	v210.sw_reset_210.reset_block_100 = 1;
+	v210.sw_reset_210.reset_block_200 = 1;
+	v210.sw_reset_210.reset_block_300 = 1;
+	v210.sw_reset_210.reset_block_400 = 1;
+	v210.sw_reset_210.reset_block_500 = 1;
+	v210.sw_reset_210.reset_block_600 = 1;
+	v210.sw_reset_210.reset_block_700 = 1;
 	v210.sw_reset_210.Block_reset_enable = 0xb2;
+
+	v210.sw_reset_210.Special_controls = 0xc259;
+
 	fc->write_ibi_reg(fc,sw_reset_210,v210);
+	msleep(1);
 
 /* reset the periphical devices */
 
@@ -186,6 +197,25 @@ static void flexcop_reset(struct flexcop
 	fc->write_ibi_reg(fc,misc_204,v204);
 }
 
+void flexcop_reset_block_300(struct flexcop_device *fc)
+{
+	flexcop_ibi_value v208_save = fc->read_ibi_reg(fc,ctrl_208),
+					  v210 = fc->read_ibi_reg(fc,sw_reset_210);
+
+	deb_rdump("208: %08x, 210: %08x\n",v208_save.raw,v210.raw);
+
+	fc->write_ibi_reg(fc,ctrl_208,ibi_zero);
+
+	v210.sw_reset_210.reset_block_300 = 1;
+	v210.sw_reset_210.Block_reset_enable = 0xb2;
+
+	fc->write_ibi_reg(fc,sw_reset_210,v210);
+	msleep(1);
+
+	fc->write_ibi_reg(fc,ctrl_208,v208_save);
+}
+EXPORT_SYMBOL(flexcop_reset_block_300);
+
 struct flexcop_device *flexcop_device_kmalloc(size_t bus_specific_len)
 {
 	void *bus;
Index: linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/b2c2/flexcop.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop.h	2005-06-27 13:24:10.000000000 +0200
@@ -26,5 +26,6 @@ extern int b2c2_flexcop_debug;
 #define deb_i2c(args...)   dprintk(0x04,args)
 #define deb_ts(args...)    dprintk(0x08,args)
 #define deb_sram(args...)  dprintk(0x10,args)
+#define deb_rdump(args...)  dprintk(0x20,args)
 
 #endif
Index: linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop_ibi_value_be.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/b2c2/flexcop_ibi_value_be.h	2005-06-27 13:24:09.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop_ibi_value_be.h	2005-06-27 13:24:10.000000000 +0200
@@ -152,7 +152,14 @@ typedef union {
 	struct {
 		u32 Special_controls               :16;
 		u32 Block_reset_enable             : 8;
-		u32 reset_blocks                   : 8;
+		u32 reset_block_700                : 1;
+		u32 reset_block_600                : 1;
+		u32 reset_block_500                : 1;
+		u32 reset_block_400                : 1;
+		u32 reset_block_300                : 1;
+		u32 reset_block_200                : 1;
+		u32 reset_block_100                : 1;
+		u32 reset_block_000                : 1;
 	} sw_reset_210;
 
 	struct {
Index: linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop_ibi_value_le.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/b2c2/flexcop_ibi_value_le.h	2005-06-27 13:24:09.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/b2c2/flexcop_ibi_value_le.h	2005-06-27 13:24:10.000000000 +0200
@@ -150,7 +150,14 @@ typedef union {
 	} irq_20c;
 
 	struct {
-		u32 reset_blocks                   : 8;
+		u32 reset_block_000                : 1;
+		u32 reset_block_100                : 1;
+		u32 reset_block_200                : 1;
+		u32 reset_block_300                : 1;
+		u32 reset_block_400                : 1;
+		u32 reset_block_500                : 1;
+		u32 reset_block_600                : 1;
+		u32 reset_block_700                : 1;
 		u32 Block_reset_enable             : 8;
 		u32 Special_controls               :16;
 	} sw_reset_210;

--

