Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265999AbUHWQT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUHWQT7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 12:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUHWQTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 12:19:20 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:26867 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S265521AbUHWQLd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 12:11:33 -0400
Message-ID: <412A1701.8000302@ttnet.net.tr>
Date: Mon, 23 Aug 2004 19:10:41 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] gcc-3.4 more fixes
References: <4129F41A.3070805@ttnet.net.tr> <20040823123430.GD4569@logos.cnet> <4129FB86.40508@ttnet.net.tr>
In-Reply-To: <4129FB86.40508@ttnet.net.tr>
Content-Type: multipart/mixed;
	boundary="------------000704050704040705060508"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000704050704040705060508
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

Fixed the dev->dev_data / dev->phy_data error in
drivers/atm/idt77105.c that Marcelo caught. Attached.


--------------000704050704040705060508
Content-Type: text/plain;
	name="27-gcc340-lvalue-2c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="27-gcc340-lvalue-2c.diff"


 drivers/atm/atmtcp.c                |    4 +-
 drivers/atm/fore200e.c              |    8 ++--
 drivers/atm/he.c                    |    4 +-
 drivers/atm/idt77105.c              |    4 +-
 drivers/atm/iphase.c                |   10 ++---
 drivers/atm/uPD98402.c              |    2 -
 drivers/atm/zatm.c                  |    9 ++---
 drivers/hotplug/ibmphp_hpc.c        |   61 +++++++++++++++++-------------------
 drivers/hotplug/ibmphp_res.c        |    4 +-
 drivers/i2c/i2c-core.c              |    2 -
 drivers/i2c/i2c-proc.c              |   22 ++++++------
 drivers/ieee1394/highlevel.c        |    4 +-
 drivers/isdn/hisax/avm_pci.c        |    6 ++-
 drivers/isdn/hisax/hfc_pci.c        |    4 +-
 drivers/isdn/hysdn/hysdn_proclog.c  |    6 +--
 drivers/mtd/chips/cfi_cmdset_0001.c |   20 +++++++++--
 drivers/mtd/chips/cfi_cmdset_0020.c |   15 +++++++-
 drivers/mtd/maps/elan-104nc.c       |    2 -
 drivers/mtd/maps/sbc_gxx.c          |    2 -
 drivers/net/bonding/bond_alb.c      |    5 ++
 drivers/net/e100/e100.h             |   30 ++++++++---------
 drivers/net/ne2k-pci.c              |   16 +++++++--
 drivers/net/wan/sdla_fr.c           |    4 +-
 drivers/net/wan/sdladrv.c           |    6 +--
 drivers/net/wan/sdlamain.c          |    2 -
 drivers/scsi/advansys.c             |   26 +++++++--------
 drivers/scsi/dpt_i2o.c              |    4 +-
 drivers/scsi/seagate.c              |    2 -
 drivers/usb/audio.c                 |    8 ++--
 drivers/usb/hpusbscsi.c             |    2 -
 drivers/usb/microtek.c              |    2 -
 drivers/usb/uss720.c                |    8 ++--
 include/pcmcia/mem_op.h             |   20 ++++++++---
 33 files changed, 184 insertions(+), 140 deletions(-)

--- 27~/drivers/atm/atmtcp.c
+++ 27/drivers/atm/atmtcp.c
@@ -246,7 +246,7 @@
 	dev_data = PRIV(atmtcp_dev);
 	dev_data->vcc = NULL;
 	if (dev_data->persist) return;
-	PRIV(atmtcp_dev) = NULL;
+	atmtcp_dev->dev_data = NULL;
 	kfree(dev_data);
 	shutdown_atm_dev(atmtcp_dev);
 	vcc->dev_data = NULL;
@@ -362,7 +362,7 @@
 	}
 	dev->ci_range.vpi_bits = MAX_VPI_BITS;
 	dev->ci_range.vci_bits = MAX_VCI_BITS;
-	PRIV(dev) = dev_data;
+	dev->dev_data = dev_data;
 	PRIV(dev)->vcc = NULL;
 	PRIV(dev)->persist = persist;
 	if (result) *result = dev;
--- 27~/drivers/atm/fore200e.c
+++ 27/drivers/atm/fore200e.c
@@ -1620,7 +1620,7 @@
     set_bit(ATM_VF_PARTIAL,&vcc->flags);
     set_bit(ATM_VF_ADDR, &vcc->flags);
 
-    FORE200E_VCC(vcc) = fore200e_vcc;
+    vcc->dev_data = fore200e_vcc;
 
     if (fore200e_activate_vcin(fore200e, 1, vcc, vcc->qos.rxtp.max_sdu) < 0) {
 
@@ -1629,7 +1629,7 @@
 	clear_bit(ATM_VF_ADDR, &vcc->flags);
 	clear_bit(ATM_VF_PARTIAL,&vcc->flags);
 
-	FORE200E_VCC(vcc) = NULL;
+	vcc->dev_data = NULL;
 
 	fore200e->available_cell_rate += vcc->qos.txtp.max_pcr;
 
@@ -1691,7 +1691,7 @@
     vcc->itf = vcc->vci = vcc->vpi = 0;
 
     fore200e_vcc = FORE200E_VCC(vcc);
-    FORE200E_VCC(vcc) = NULL;
+    vcc->dev_data = NULL;
 
     spin_unlock_irqrestore(&fore200e->q_lock, flags);
 
@@ -2738,7 +2738,7 @@
 	return -ENODEV;
     }
 
-    FORE200E_DEV(atm_dev) = fore200e;
+    atm_dev->dev_data = fore200e;
     fore200e->atm_dev = atm_dev;
 
     atm_dev->ci_range.vpi_bits = FORE200E_VPI_BITS;
--- 27~/drivers/atm/he.c
+++ 27/drivers/atm/he.c
@@ -378,7 +378,7 @@
 	he_dev->pci_dev = pci_dev;
 	he_dev->atm_dev = atm_dev;
 	he_dev->atm_dev->dev_data = he_dev;
-	HE_DEV(atm_dev) = he_dev;
+	atm_dev->dev_data = he_dev;
 	he_dev->number = atm_dev->number;
 	if (he_start(atm_dev)) {
 		he_stop(he_dev);
@@ -2347,7 +2347,7 @@
 	init_waitqueue_head(&he_vcc->rx_waitq);
 	init_waitqueue_head(&he_vcc->tx_waitq);
 
-	HE_VCC(vcc) = he_vcc;
+	vcc->dev_data = he_vcc;
 
 	if (vcc->qos.txtp.traffic_class != ATM_NONE) {
 		int pcr_goal;
--- 27~/drivers/atm/idt77105.c
+++ 27/drivers/atm/idt77105.c
@@ -267,7 +267,7 @@
 {
 	unsigned long flags;
 
-	if (!(PRIV(dev) = kmalloc(sizeof(struct idt77105_priv),GFP_KERNEL)))
+	if (!(dev->phy_data = kmalloc(sizeof(struct idt77105_priv),GFP_KERNEL)))
 		return -ENOMEM;
 	PRIV(dev)->dev = dev;
 	spin_lock_irqsave(&idt77105_priv_lock, flags);
@@ -345,7 +345,7 @@
                 else
                     idt77105_all = walk->next;
 	        dev->phy = NULL;
-                PRIV(dev) = NULL;
+                dev->phy_data = NULL;
                 kfree(walk);
                 break;
             }
--- 27~/drivers/atm/iphase.c
+++ 27/drivers/atm/iphase.c
@@ -1782,7 +1782,7 @@
                          (iadev->tx_buf_sz - sizeof(struct cpcs_trailer))){
            printk("IA:  SDU size over (%d) the configured SDU size %d\n",
 		  vcc->qos.txtp.max_sdu,iadev->tx_buf_sz);
-	   INPH_IA_VCC(vcc) = NULL;  
+	   vcc->dev_data = NULL;
            kfree(ia_vcc);
            return -EINVAL; 
         }
@@ -2707,7 +2707,7 @@
         }
 	kfree(INPH_IA_VCC(vcc));  
         ia_vcc = NULL;
-        INPH_IA_VCC(vcc) = NULL;  
+        vcc->dev_data = NULL;
         clear_bit(ATM_VF_ADDR,&vcc->flags);
         return;        
 }  
@@ -2720,7 +2720,7 @@
 	if (!test_bit(ATM_VF_PARTIAL,&vcc->flags))  
 	{  
 		IF_EVENT(printk("ia: not partially allocated resources\n");)  
-		INPH_IA_VCC(vcc) = NULL;  
+		vcc->dev_data = NULL;
 	}  
 	iadev = INPH_IA_DEV(vcc->dev);  
 	error = atm_find_ci(vcc, &vpi, &vci);  
@@ -2744,7 +2744,7 @@
 	/* Device dependent initialization */  
 	ia_vcc = kmalloc(sizeof(*ia_vcc), GFP_KERNEL);  
 	if (!ia_vcc) return -ENOMEM;  
-	INPH_IA_VCC(vcc) = ia_vcc;  
+	vcc->dev_data = ia_vcc;
   
 	if ((error = open_rx(vcc)))  
 	{  
@@ -3256,7 +3256,7 @@
 		ret = -ENOMEM;
 		goto err_out_disable_dev;
 	}
-	INPH_IA_DEV(dev) = iadev; 
+	dev->dev_data = iadev;
 	IF_INIT(printk(DEV_LABEL "registered at (itf :%d)\n", dev->number);)
 	IF_INIT(printk("dev_id = 0x%x iadev->LineRate = %d \n", (u32)dev,
 		iadev->LineRate);)
--- 27~/drivers/atm/uPD98402.c
+++ 27/drivers/atm/uPD98402.c
@@ -212,7 +212,7 @@
 static int uPD98402_start(struct atm_dev *dev)
 {
 	DPRINTK("phy_start\n");
-	if (!(PRIV(dev) = kmalloc(sizeof(struct uPD98402_priv),GFP_KERNEL)))
+	if (!(dev->dev_data = kmalloc(sizeof(struct uPD98402_priv),GFP_KERNEL)))
 		return -ENOMEM;
 	memset(&PRIV(dev)->sonet_stats,0,sizeof(struct k_sonet_stats));
 	(void) GET(PCR); /* clear performance events */
--- 27~/drivers/atm/zatm.c
+++ 27/drivers/atm/zatm.c
@@ -1565,7 +1565,7 @@
         DPRINTK("zatm_close: done waiting\n");
         /* deallocate memory */
         kfree(ZATM_VCC(vcc));
-        ZATM_VCC(vcc) = NULL;
+	vcc->dev_data = NULL;
 	clear_bit(ATM_VF_ADDR,&vcc->flags);
 }
 
@@ -1578,7 +1578,8 @@
 
 	DPRINTK(">zatm_open\n");
 	zatm_dev = ZATM_DEV(vcc->dev);
-	if (!test_bit(ATM_VF_PARTIAL,&vcc->flags)) ZATM_VCC(vcc) = NULL;
+	if (!test_bit(ATM_VF_PARTIAL,&vcc->flags))
+		vcc->dev_data = NULL;
 	error = atm_find_ci(vcc,&vpi,&vci);
 	if (error) return error;
 	vcc->vpi = vpi;
@@ -1594,7 +1595,7 @@
 			clear_bit(ATM_VF_ADDR,&vcc->flags);
 			return -ENOMEM;
 		}
-		ZATM_VCC(vcc) = zatm_vcc;
+		vcc->dev_data = zatm_vcc;
 		ZATM_VCC(vcc)->tx_chan = 0; /* for zatm_close after open_rx */
 		if ((error = open_rx_first(vcc))) {
 	                zatm_close(vcc);
@@ -1828,7 +1829,7 @@
 			dev = atm_dev_register(DEV_LABEL,&ops,-1,NULL);
 			if (!dev) break;
 			zatm_dev->pci_dev = pci_dev;
-			ZATM_DEV(dev) = zatm_dev;
+			dev->dev_data = zatm_dev;
 			zatm_dev->copper = type;
 			if (zatm_init(dev) || zatm_start(dev)) {
 				atm_dev_deregister(dev);
--- 27~/drivers/hotplug/ibmphp_hpc.c
+++ 27/drivers/hotplug/ibmphp_hpc.c
@@ -152,11 +152,11 @@
 	u8 status;
 	int i;
 	void *wpg_addr;		// base addr + offset
-	ulong wpg_data,		// data to/from WPG LOHI format
-	ultemp, data;		// actual data HILO format
+	unsigned long wpg_data;	// data to/from WPG LOHI format
+	unsigned long ultemp;
+	unsigned long data;	// actual data HILO format
 
-
-	debug_polling ("%s - Entry WPGBbar[%lx] index[%x] \n", __FUNCTION__, (ulong) WPGBbar, index);
+	debug_polling ("%s - Entry WPGBbar[%p] index[%x] \n", __FUNCTION__, WPGBbar, index);
 
 	//--------------------------------------------------------------------
 	// READ - step 1
@@ -165,17 +165,17 @@
 	if (ctlr_ptr->ctlr_type == 0x02) {
 		data = WPG_READATADDR_MASK;
 		// fill in I2C address
-		ultemp = (ulong) ctlr_ptr->u.wpeg_ctlr.i2c_addr;
+		ultemp = (unsigned long)ctlr_ptr->u.wpeg_ctlr.i2c_addr;
 		ultemp = ultemp >> 1;
 		data |= (ultemp << 8);
 
 		// fill in index
-		data |= (ulong) index;
+		data |= (unsigned long)index;
 	} else if (ctlr_ptr->ctlr_type == 0x04) {
 		data = WPG_READDIRECT_MASK;
 
 		// fill in index
-		ultemp = (ulong) index;
+		ultemp = (unsigned long)index;
 		ultemp = ultemp << 8;
 		data |= ultemp;
 	} else {
@@ -184,14 +184,14 @@
 	}
 
 	wpg_data = swab32 (data);	// swap data before writing
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMOSUP_OFFSET;
+	wpg_addr = WPGBbar + WPG_I2CMOSUP_OFFSET;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
 	// READ - step 2 : clear the message buffer
 	data = 0x00000000;
 	wpg_data = swab32 (data);
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMBUFL_OFFSET;
+	wpg_addr = WPGBbar + WPG_I2CMBUFL_OFFSET;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
@@ -199,7 +199,7 @@
 	//                 2020 : [20] OR operation at [20] offset 0x20
 	data = WPG_I2CMCNTL_STARTOP_MASK;
 	wpg_data = swab32 (data);
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMCNTL_OFFSET + (ulong) WPG_I2C_OR;
+	wpg_addr = WPGBbar + WPG_I2CMCNTL_OFFSET + WPG_I2C_OR;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
@@ -207,7 +207,7 @@
 	i = CMD_COMPLETE_TOUT_SEC;
 	while (i) {
 		long_delay (1 * HZ / 100);
-		(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMCNTL_OFFSET;
+		wpg_addr = WPGBbar + WPG_I2CMCNTL_OFFSET;
 		wpg_data = readl (wpg_addr);
 		data = swab32 (wpg_data);
 		if (!(data & WPG_I2CMCNTL_STARTOP_MASK))
@@ -223,7 +223,7 @@
 	i = CMD_COMPLETE_TOUT_SEC;
 	while (i) {
 		long_delay (1 * HZ / 100);
-		(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CSTAT_OFFSET;
+		wpg_addr = WPGBbar + WPG_I2CSTAT_OFFSET;
 		wpg_data = readl (wpg_addr);
 		data = swab32 (wpg_data);
 		if (HPC_I2CSTATUS_CHECK (data))
@@ -237,7 +237,7 @@
 
 	//--------------------------------------------------------------------
 	// READ - step 6 : get DATA
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMBUFL_OFFSET;
+	wpg_addr = WPGBbar + WPG_I2CMBUFL_OFFSET;
 	wpg_data = readl (wpg_addr);
 	data = swab32 (wpg_data);
 
@@ -259,12 +259,12 @@
 {
 	u8 rc;
 	void *wpg_addr;		// base addr + offset
-	ulong wpg_data,		// data to/from WPG LOHI format 
-	ultemp, data;		// actual data HILO format
+	unsigned long wpg_data;	// data to/from WPG LOHI format 
+	unsigned long ultemp;
+	unsigned long data;	// actual data HILO format
 	int i;
 
-
-	debug_polling ("%s - Entry WPGBbar[%lx] index[%x] cmd[%x]\n", __FUNCTION__, (ulong) WPGBbar, index, cmd);
+	debug_polling ("%s - Entry WPGBbar[%p] index[%x] cmd[%x]\n", __FUNCTION__, WPGBbar, index, cmd);
 
 	rc = 0;
 	//--------------------------------------------------------------------
@@ -276,17 +276,17 @@
 	if (ctlr_ptr->ctlr_type == 0x02) {
 		data = WPG_WRITEATADDR_MASK;
 		// fill in I2C address
-		ultemp = (ulong) ctlr_ptr->u.wpeg_ctlr.i2c_addr;
+		ultemp = (unsigned long)ctlr_ptr->u.wpeg_ctlr.i2c_addr;
 		ultemp = ultemp >> 1;
 		data |= (ultemp << 8);
 
 		// fill in index
-		data |= (ulong) index;
+		data |= (unsigned long)index;
 	} else if (ctlr_ptr->ctlr_type == 0x04) {
 		data = WPG_WRITEDIRECT_MASK;
 
 		// fill in index
-		ultemp = (ulong) index;
+		ultemp = (unsigned long)index;
 		ultemp = ultemp << 8;
 		data |= ultemp;
 	} else {
@@ -295,14 +295,14 @@
 	}
 
 	wpg_data = swab32 (data);	// swap data before writing
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMOSUP_OFFSET;
+	wpg_addr = WPGBbar + WPG_I2CMOSUP_OFFSET;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
 	// WRITE - step 2 : clear the message buffer
-	data = 0x00000000 | (ulong) cmd;
+	data = 0x00000000 | (unsigned long)cmd;
 	wpg_data = swab32 (data);
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMBUFL_OFFSET;
+	wpg_addr = WPGBbar + WPG_I2CMBUFL_OFFSET;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
@@ -310,7 +310,7 @@
 	//                 2020 : [20] OR operation at [20] offset 0x20
 	data = WPG_I2CMCNTL_STARTOP_MASK;
 	wpg_data = swab32 (data);
-	(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMCNTL_OFFSET + (ulong) WPG_I2C_OR;
+	wpg_addr = WPGBbar + WPG_I2CMCNTL_OFFSET + WPG_I2C_OR;
 	writel (wpg_data, wpg_addr);
 
 	//--------------------------------------------------------------------
@@ -318,7 +318,7 @@
 	i = CMD_COMPLETE_TOUT_SEC;
 	while (i) {
 		long_delay (1 * HZ / 100);
-		(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CMCNTL_OFFSET;
+		wpg_addr = WPGBbar + WPG_I2CMCNTL_OFFSET;
 		wpg_data = readl (wpg_addr);
 		data = swab32 (wpg_data);
 		if (!(data & WPG_I2CMCNTL_STARTOP_MASK))
@@ -335,7 +335,7 @@
 	i = CMD_COMPLETE_TOUT_SEC;
 	while (i) {
 		long_delay (1 * HZ / 100);
-		(ulong) wpg_addr = (ulong) WPGBbar + (ulong) WPG_I2CSTAT_OFFSET;
+		wpg_addr = WPGBbar + WPG_I2CSTAT_OFFSET;
 		wpg_data = readl (wpg_addr);
 		data = swab32 (wpg_data);
 		if (HPC_I2CSTATUS_CHECK (data))
@@ -543,7 +543,7 @@
 	int rc = 0;
 	int busindex;
 
-	debug_polling ("%s - Entry pslot[%lx] cmd[%x] pstatus[%lx]\n", __FUNCTION__, (ulong) pslot, cmd, (ulong) pstatus);
+	debug_polling ("%s - Entry pslot[%p] cmd[%x] pstatus[%p]\n", __FUNCTION__, pslot, cmd, pstatus);
 
 	if ((pslot == NULL)
 	    || ((pstatus == NULL) && (cmd != READ_ALLSTAT) && (cmd != READ_BUSSTATUS))) {
@@ -683,7 +683,7 @@
 	int rc = 0;
 	int timeout;
 
-	debug_polling ("%s - Entry pslot[%lx] cmd[%x]\n", __FUNCTION__, (ulong) pslot, cmd);
+	debug_polling ("%s - Entry pslot[%p] cmd[%x]\n", __FUNCTION__, pslot, cmd);
 	if (pslot == NULL) {
 		rc = -EINVAL;
 		err ("%s - Error Exit rc[%d]\n", __FUNCTION__, rc);
@@ -976,7 +976,7 @@
 {
 	int rc = 0;
 
-	debug ("%s - Entry pslot[%lx]\n", __FUNCTION__, (ulong) pslot);
+	debug ("%s - Entry pslot[%p]\n", __FUNCTION__, pslot);
 	rc = ibmphp_hpc_readslot (pslot, READ_ALLSTAT, NULL);
 	debug ("%s - Exit rc[%d]\n", __FUNCTION__, rc);
 	return rc;
@@ -1004,8 +1004,7 @@
 	u8 disable = FALSE;
 	u8 update = FALSE;
 
-	debug ("process_changeinstatus - Entry pslot[%lx], poldslot[%lx]\n", (ulong) pslot,
-	       (ulong) poldslot);
+	debug ("process_changeinstatus - Entry pslot[%p], poldslot[%p]\n", pslot, poldslot);
 
 	// bit 0 - HPC_SLOT_POWER
 	if ((pslot->status & 0x01) != (poldslot->status & 0x01))
--- 27~/drivers/hotplug/ibmphp_res.c
+++ 27/drivers/hotplug/ibmphp_res.c
@@ -42,7 +42,7 @@
 static int update_bridge_ranges (struct bus_node **);
 static int add_range (int type, struct range_node *, struct bus_node *);
 static void fix_resources (struct bus_node *);
-static inline struct bus_node *find_bus_wprev (u8, struct bus_node **, u8);
+static struct bus_node *find_bus_wprev (u8, struct bus_node **, u8);
 
 static LIST_HEAD(gbuses);
 LIST_HEAD(ibmphp_res_head);
@@ -1757,7 +1757,7 @@
 	return find_bus_wprev (bus_number, NULL, 0);
 }
 
-static inline struct bus_node *find_bus_wprev (u8 bus_number, struct bus_node **prev, u8 flag)
+static struct bus_node *find_bus_wprev (u8 bus_number, struct bus_node **prev, u8 flag)
 {
 	struct bus_node *bus_cur;
 	struct list_head *tmp;
--- 27~/drivers/i2c/i2c-core.c
+++ 27/drivers/i2c/i2c-core.c
@@ -750,7 +750,7 @@
 		msg.addr   = client->addr;
 		msg.flags = client->flags & I2C_M_TEN;
 		msg.len = count;
-		(const char *)msg.buf = buf;
+		msg.buf = (char *)buf;
 	
 		DEB2(printk(KERN_DEBUG "i2c-core.o: master_send: writing %d bytes on %s.\n",
 			count,client->adapter->name));
--- 27~/drivers/i2c/i2c-proc.c
+++ 27/drivers/i2c/i2c-proc.c
@@ -287,7 +287,7 @@
 			if(copy_to_user(buffer, BUF, buflen))
 				return -EFAULT;
 			curbufsize += buflen;
-			(char *) buffer += buflen;
+			buffer = (void *)buffer + buflen;
 		}
 	*lenp = curbufsize;
 	filp->f_pos += curbufsize;
@@ -318,8 +318,8 @@
 					     sizeof(struct
 						    i2c_chips_data)))
 					return -EFAULT;
-				(char *) oldval +=
-				    sizeof(struct i2c_chips_data);
+				oldval =
+				    (void *) oldval + sizeof(struct i2c_chips_data);
 				nrels++;
 			}
 		oldlen = nrels * sizeof(struct i2c_chips_data);
@@ -473,7 +473,7 @@
 		       !((ret=get_user(nextchar, (char *) buffer))) &&
 		       isspace((int) nextchar)) {
 			bufsize--;
-			((char *) buffer)++;
+			buffer++;
 		}
 
 		if (ret)
@@ -492,7 +492,7 @@
 		    && (nextchar == '-')) {
 			min = 1;
 			bufsize--;
-			((char *) buffer)++;
+			buffer++;
 		}
 		if (ret)
 			return -EFAULT;
@@ -503,7 +503,7 @@
 		       isdigit((int) nextchar)) {
 			res = res * 10 + nextchar - '0';
 			bufsize--;
-			((char *) buffer)++;
+			buffer++;
 		}
 		if (ret)
 			return -EFAULT;
@@ -517,7 +517,7 @@
 		if (bufsize && (nextchar == '.')) {
 			/* Skip the dot */
 			bufsize--;
-			((char *) buffer)++;
+			buffer++;
 
 			/* Read digits while they are significant */
 			while (bufsize && (mag > 0) &&
@@ -526,7 +526,7 @@
 				res = res * 10 + nextchar - '0';
 				mag--;
 				bufsize--;
-				((char *) buffer)++;
+				buffer++;
 			}
 			if (ret)
 				return -EFAULT;
@@ -542,7 +542,7 @@
 		       !((ret=get_user(nextchar, (char *) buffer))) &&
 		       isspace((int) nextchar)) {
 			bufsize--;
-			((char *) buffer)++;
+			buffer++;
 		}
 		if (ret)
 			return -EFAULT;
@@ -574,7 +574,7 @@
 			if(put_user(' ', (char *) buffer))
 				return -EFAULT;
 			curbufsize++;
-			((char *) buffer)++;
+			buffer++;
 		}
 
 		/* Fill BUF with the representation of the next string */
@@ -615,7 +615,7 @@
 		if(copy_to_user(buffer, BUF, buflen))
 			return -EFAULT;
 		curbufsize += buflen;
-		(char *) buffer += buflen;
+		buffer = (void *)buffer + buflen;
 
 		nr++;
 	}
--- 27~/drivers/ieee1394/highlevel.c
+++ 27/drivers/ieee1394/highlevel.c
@@ -500,7 +500,7 @@
                                 rcode = RCODE_TYPE_ERROR;
                         }
 
-			(u8 *)data += partlength;
+			data += partlength;
                         length -= partlength;
                         addr += partlength;
 
@@ -546,7 +546,7 @@
                                 rcode = RCODE_TYPE_ERROR;
                         }
 
-			(u8 *)data += partlength;
+			data += partlength;
                         length -= partlength;
                         addr += partlength;
 
--- 27~/drivers/isdn/hisax/avm_pci.c
+++ 27/drivers/isdn/hisax/avm_pci.c
@@ -291,7 +291,8 @@
 			debugl1(cs, "hdlc_empty_fifo: incoming packet too large");
 		return;
 	}
-	ptr = (u_int *) p = bcs->hw.hdlc.rcvbuf + bcs->hw.hdlc.rcvidx;
+	p = bcs->hw.hdlc.rcvbuf + bcs->hw.hdlc.rcvidx;
+	ptr = (u_int *) p;
 	bcs->hw.hdlc.rcvidx += count;
 	if (cs->subtyp == AVM_FRITZ_PCI) {
 		outl(idx, cs->hw.avm.cfg_reg + 4);
@@ -352,7 +353,8 @@
 	}
 	if ((cs->debug & L1_DEB_HSCX) && !(cs->debug & L1_DEB_HSCX_FIFO))
 		debugl1(cs, "hdlc_fill_fifo %d/%ld", count, bcs->tx_skb->len);
-	ptr = (u_int *) p = bcs->tx_skb->data;
+	p = bcs->tx_skb->data;
+	ptr = (u_int *) p;
 	skb_pull(bcs->tx_skb, count);
 	bcs->tx_cnt -= count;
 	bcs->hw.hdlc.count += count;
--- 27~/drivers/isdn/hisax/hfc_pci.c
+++ 27/drivers/isdn/hisax/hfc_pci.c
@@ -1742,11 +1742,11 @@
 		/* Allocate memory for FIFOS */
 		/* Because the HFC-PCI needs a 32K physical alignment, we */
 		/* need to allocate the double mem and align the address */
-		if (!((void *) cs->hw.hfcpci.share_start = kmalloc(65536, GFP_KERNEL))) {
+		if (!(cs->hw.hfcpci.share_start = kmalloc(65536, GFP_KERNEL))) {
 			printk(KERN_WARNING "HFC-PCI: Error allocating memory for FIFO!\n");
 			return 0;
 		}
-		(ulong) cs->hw.hfcpci.fifos =
+		cs->hw.hfcpci.fifos = (void *)
 		    (((ulong) cs->hw.hfcpci.share_start) & ~0x7FFF) + 0x8000;
 		pcibios_write_config_dword(cs->hw.hfcpci.pci_bus,
 				       cs->hw.hfcpci.pci_device_fn, 0x80,
--- 27~/drivers/isdn/hysdn/hysdn_proclog.c
+++ 27/drivers/isdn/hysdn/hysdn_proclog.c
@@ -235,7 +235,7 @@
 		return (0);
 
 	inf->usage_cnt--;	/* new usage count */
-	(struct log_data **) file->private_data = &inf->next;	/* next structure */
+	file->private_data = &inf->next;	/* next structure */
 	if ((len = strlen(inf->log_start)) <= count) {
 		if (copy_to_user(buf, inf->log_start, len))
 			return -EFAULT;
@@ -278,9 +278,9 @@
 		cli();
 		pd->if_used++;
 		if (pd->log_head)
-			(struct log_data **) filep->private_data = &(pd->log_tail->next);
+			filep->private_data = &pd->log_tail->next;
 		else
-			(struct log_data **) filep->private_data = &(pd->log_head);
+			filep->private_data = &pd->log_head;
 		restore_flags(flags);
 	} else {		/* simultaneous read/write access forbidden ! */
 		unlock_kernel();
--- 27~/drivers/mtd/chips/cfi_cmdset_0001.c
+++ 27/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -1201,13 +1201,25 @@
 	/* Write data */
 	for (z = 0; z < len; z += CFIDEV_BUSWIDTH) {
 		if (cfi_buswidth_is_1()) {
-			map->write8 (map, *((__u8*)buf)++, adr+z);
+			u8 *b = (u8 *)buf;
+
+			map->write8 (map, *b++, adr+z);
+			buf = (const u_char *)b;
 		} else if (cfi_buswidth_is_2()) {
-			map->write16 (map, *((__u16*)buf)++, adr+z);
+			u16 *b = (u16 *)buf;
+
+			map->write16 (map, *b++, adr+z);
+			buf = (const u_char *)b;
 		} else if (cfi_buswidth_is_4()) {
-			map->write32 (map, *((__u32*)buf)++, adr+z);
+			u32 *b = (u32 *)buf;
+
+			map->write32 (map, *b++, adr+z);
+			buf = (const u_char *)b;
 		} else if (cfi_buswidth_is_8()) {
-			map->write64 (map, *((__u64*)buf)++, adr+z);
+			u64 *b = (u64 *)buf;
+
+			map->write64 (map, *b++, adr+z);
+			buf = (const u_char *)b;
 		} else {
 			DISABLE_VPP(map);
 			ret = -EINVAL;
--- 27~/drivers/mtd/chips/cfi_cmdset_0020.c
+++ 27/drivers/mtd/chips/cfi_cmdset_0020.c
@@ -540,11 +540,20 @@
 	/* Write data */
 	for (z = 0; z < len; z += CFIDEV_BUSWIDTH) {
 		if (cfi_buswidth_is_1()) {
-			map->write8 (map, *((__u8*)buf)++, adr+z);
+			u8 *b = (u8 *)buf;
+
+			map->write8 (map, *b++, adr+z);
+			buf = (const u_char *)b;
 		} else if (cfi_buswidth_is_2()) {
-			map->write16 (map, *((__u16*)buf)++, adr+z);
+			u16 *b = (u16 *)buf;
+
+			map->write16 (map, *b++, adr+z);
+			buf = (const u_char *)b;
 		} else if (cfi_buswidth_is_4()) {
-			map->write32 (map, *((__u32*)buf)++, adr+z);
+			u32 *b = (u32 *)buf;
+
+			map->write32 (map, *b++, adr+z);
+			buf = (const u_char *)b;
 		} else {
 			DISABLE_VPP(map);
 			return -EINVAL;
--- 27~/drivers/mtd/maps/elan-104nc.c
+++ 27/drivers/mtd/maps/elan-104nc.c
@@ -147,7 +147,7 @@
 		elan_104nc_page(map, from);
 		memcpy_fromio(to, iomapadr + (from & WINDOW_MASK), thislen);
 		spin_unlock(&elan_104nc_spin);
-		(__u8*)to += thislen;
+		to += thislen;
 		from += thislen;
 		len -= thislen;
 	}
--- 27~/drivers/mtd/maps/sbc_gxx.c
+++ 27/drivers/mtd/maps/sbc_gxx.c
@@ -155,7 +155,7 @@
 		sbc_gxx_page(map, from);
 		memcpy_fromio(to, iomapadr + (from & WINDOW_MASK), thislen);
 		spin_unlock(&sbc_gxx_spin);
-		(__u8*)to += thislen;
+		to += thislen;
 		from += thislen;
 		len -= thislen;
 	}
--- 27~/drivers/net/bonding/bond_alb.c
+++ 27/drivers/net/bonding/bond_alb.c
@@ -1275,7 +1275,7 @@
 int bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
 {
 	struct bonding *bond = bond_dev->priv;
-	struct ethhdr *eth_data = (struct ethhdr *)skb->mac.raw = skb->data;
+	struct ethhdr *eth_data;
 	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
 	struct slave *tx_slave = NULL;
 	static u32 ip_bcast = 0xffffffff;
@@ -1285,6 +1285,9 @@
 	u8 *hash_start = NULL;
 	int res = 1;
 
+	skb->mac.raw = (unsigned char *)skb->data;
+	eth_data = (struct ethhdr *)skb->data;
+
 	/* make sure that the curr_active_slave and the slaves list do
 	 * not change during tx
 	 */
--- 27~/drivers/net/e100/e100.h
+++ 27/drivers/net/e100/e100.h
@@ -501,7 +501,7 @@
 	u8 scb_fc_thld;	/* Flow Control threshold */
 	u8 scb_fc_xon_xoff;	/* Flow Control XON/XOFF values */
 	u8 scb_pmdr;	/* Power Mgmt. Driver Reg */
-} d101_scb_ext __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) d101_scb_ext;
 
 /* Changed for 82559 enhancement */
 typedef struct _d101m_scb_ext_t {
@@ -517,7 +517,7 @@
 	u32 scb_function_event_mask;	/* Cardbus Function Mask */
 	u32 scb_function_present_state;	/* Cardbus Function state */
 	u32 scb_force_event;	/* Cardbus Force Event */
-} d101m_scb_ext __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) d101m_scb_ext;
 
 /* Changed for 82550 enhancement */
 typedef struct _d102_scb_ext_t {
@@ -536,7 +536,7 @@
 	u32 scb_function_event_mask;	/* Cardbus Function Mask */
 	u32 scb_function_present_state;	/* Cardbus Function state */
 	u32 scb_force_event;	/* Cardbus Force Event */
-} d102_scb_ext __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) d102_scb_ext;
 
 /*
  * 82557 status control block. this will be memory mapped & will hang of the
@@ -558,7 +558,7 @@
 		d101m_scb_ext d101m_scb;	/* 82559 specific fields */
 		d102_scb_ext d102_scb;
 	} scb_ext;
-} scb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) scb_t;
 
 /* Self test
  * This is used to dump results of the self test 
@@ -566,7 +566,7 @@
 typedef struct _self_test_t {
 	u32 st_sign;	/* Self Test Signature */
 	u32 st_result;	/* Self Test Results */
-} self_test_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) self_test_t;
 
 /* 
  *  Statistical Counters 
@@ -649,39 +649,39 @@
 	u16 cb_status;	/* Command Block Status */
 	u16 cb_cmd;	/* Command Block Command */
 	u32 cb_lnk_ptr;	/* Link To Next CB */
-} cb_header_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) cb_header_t;
 
 //* Individual Address Command Block (IA_CB)*/
 typedef struct _ia_cb_t {
 	cb_header_t ia_cb_hdr;
 	u8 ia_addr[ETH_ALEN];
-} ia_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) ia_cb_t;
 
 /* Configure Command Block (CONFIG_CB)*/
 typedef struct _config_cb_t {
 	cb_header_t cfg_cbhdr;
 	u8 cfg_byte[CB_CFIG_BYTE_COUNT + CB_CFIG_D102_BYTE_COUNT];
-} config_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) config_cb_t;
 
 /* MultiCast Command Block (MULTICAST_CB)*/
 typedef struct _multicast_cb_t {
 	cb_header_t mc_cbhdr;
 	u16 mc_count;	/* Number of multicast addresses */
 	u8 mc_addr[(ETH_ALEN * MAX_MULTICAST_ADDRS)];
-} mltcst_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) mltcst_cb_t;
 
 #define UCODE_MAX_DWORDS	134
 /* Load Microcode Command Block (LOAD_UCODE_CB)*/
 typedef struct _load_ucode_cb_t {
 	cb_header_t load_ucode_cbhdr;
 	u32 ucode_dword[UCODE_MAX_DWORDS];
-} load_ucode_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) load_ucode_cb_t;
 
 /* Load Programmable Filter Data*/
 typedef struct _filter_cb_t {
 	cb_header_t filter_cb_hdr;
 	u32 filter_data[MAX_FILTER];
-} filter_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) filter_cb_t;
 
 /* NON_TRANSMIT_CB -- Generic Non-Transmit Command Block 
  */
@@ -693,7 +693,7 @@
 		mltcst_cb_t multicast;
 		filter_cb_t filter;
 	} ntcb;
-} nxmit_cb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) nxmit_cb_t;
 
 /*Block for queuing for postponed execution of the non-transmit commands*/
 typedef struct _nxmit_cb_entry_t {
@@ -724,7 +724,7 @@
 	u32 tbd_buf_addr;	/* Physical Transmit Buffer Address */
 	u16 tbd_buf_cnt;	/* Actual Count Of Bytes */
 	u16 padd;
-} tbd_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) tbd_t;
 
 /* d102 specific fields */
 typedef struct _tcb_ipcb_t {
@@ -743,7 +743,7 @@
 		u16 tbd_zero_size;
 	} tbd_sec_size;
 	u16 total_tcp_payload;
-} tcb_ipcb_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) tcb_ipcb_t;
 
 #define E100_TBD_ARRAY_SIZE (2+MAX_SKB_FRAGS)
 
@@ -806,7 +806,7 @@
 	u32 rbd_rcb_addr;	/* Receive Buffer Address */
 	u16 rbd_sz;	/* Receive Buffer Size */
 	u16 rbd_filler1;
-} rbd_t __attribute__ ((__packed__));
+} __attribute__ ((__packed__)) rbd_t;
 
 /*
  * This structure is used to maintain a FIFO access to a resource that is 
--- 27~/drivers/net/ne2k-pci.c
+++ 27/drivers/net/ne2k-pci.c
@@ -505,8 +505,12 @@
 		insl(NE_BASE + NE_DATAPORT, buf, count>>2);
 		if (count & 3) {
 			buf += count & ~3;
-			if (count & 2)
-				*((u16*)buf)++ = le16_to_cpu(inw(NE_BASE + NE_DATAPORT));
+			if (count & 2) {
+				u16 *b = (u16 *)buf;
+
+				*b++ = le16_to_cpu(inw(NE_BASE + NE_DATAPORT));
+				buf = (char *)b;
+			}
 			if (count & 1)
 				*buf = inb(NE_BASE + NE_DATAPORT);
 		}
@@ -566,8 +570,12 @@
 		outsl(NE_BASE + NE_DATAPORT, buf, count>>2);
 		if (count & 3) {
 			buf += count & ~3;
-			if (count & 2)
-				outw(cpu_to_le16(*((u16*)buf)++), NE_BASE + NE_DATAPORT);
+			if (count & 2) {
+				u16 *b = (u16 *)buf;
+
+				outw(cpu_to_le16(*b++), NE_BASE + NE_DATAPORT);
+				buf = (char *)b;
+			}
 		}
 	}
 
--- 27~/drivers/net/wan/sdladrv.c
+++ 27/drivers/net/wan/sdladrv.c
@@ -1002,7 +1002,7 @@
                         peek_by_4 ((unsigned long)hw->dpmbase + curpos, buf,
 				curlen);
                         addr       += curlen;
-                        (char*)buf += curlen;
+                        buf         = (void*)buf + curlen;
                         len        -= curlen;
                 }
 
@@ -1086,7 +1086,7 @@
                         poke_by_4 ((unsigned long)hw->dpmbase + curpos, buf,
 				curlen);
 	                addr       += curlen;
-                        (char*)buf += curlen;
+                        buf         = (void*)buf + curlen;
                         len        -= curlen;
                 }
 
@@ -2130,7 +2130,7 @@
 	(void *)hw->dpmbase = ioremap((unsigned long)S514_mem_base_addr,
 		(unsigned long)MAX_SIZEOF_S514_MEMORY);
     	/* map the physical control register memory to virtual memory */
-	(void *)hw->vector = ioremap(
+	hw->vector = (unsigned long)ioremap(
 		(unsigned long)(S514_mem_base_addr + S514_CTRL_REG_BYTE),
 		(unsigned long)16);
      
--- 27~/drivers/net/wan/sdla_fr.c
+++ 27/drivers/net/wan/sdla_fr.c
@@ -3929,7 +3929,7 @@
                                 break;
                         }
 
-			(void *)ptr_trc_el = card->u.f.curr_trc_el;
+			ptr_trc_el = card->u.f.curr_trc_el;
 
                         buffer_length = 0;
 			fr_udp_pkt->data[0x00] = 0x00;
@@ -3980,7 +3980,7 @@
                                
 				ptr_trc_el ++;
 				if((void *)ptr_trc_el > card->u.f.trc_el_last)
-					(void*)ptr_trc_el = card->u.f.trc_el_base;
+					ptr_trc_el = card->u.f.trc_el_base;
 
 				buffer_length += sizeof(fpipemon_trc_hdr_t);
                                	if(fpipemon_trc->fpipemon_trc_hdr.data_passed) {
--- 27~/drivers/net/wan/sdlamain.c
+++ 27/drivers/net/wan/sdlamain.c
@@ -1027,7 +1027,7 @@
                       #endif
                         dump.length     -= len;
                         dump.offset     += len;
-                        (char*)dump.ptr += len;
+                        dump.ptr         = (void*)dump.ptr + len;
                 }
 		
                 sdla_mapmem(&card->hw, oldvec);/* restore DPM window position */
--- 27~/drivers/scsi/advansys.c
+++ 27/drivers/scsi/advansys.c
@@ -6118,8 +6118,8 @@
     } else {
         /* Append to 'done_scp' at the end with 'last_scp'. */
         ASC_ASSERT(last_scp != NULL);
-        REQPNEXT(last_scp) = asc_dequeue_list(&boardp->active,
-            &new_last_scp, ASC_TID_ALL);
+        last_scp->host_scribble = (unsigned char *)asc_dequeue_list(
+			&boardp->active, &new_last_scp, ASC_TID_ALL);
         if (new_last_scp != NULL) {
             ASC_ASSERT(REQPNEXT(last_scp) != NULL);
             for (tscp = REQPNEXT(last_scp); tscp; tscp = REQPNEXT(tscp)) {
@@ -6141,8 +6141,8 @@
     } else {
         /* Append to 'done_scp' at the end with 'last_scp'. */
         ASC_ASSERT(last_scp != NULL);
-        REQPNEXT(last_scp) = asc_dequeue_list(&boardp->waiting,
-            &new_last_scp, ASC_TID_ALL);
+        last_scp->host_scribble = (unsigned char *)asc_dequeue_list(
+			&boardp->waiting, &new_last_scp, ASC_TID_ALL);
         if (new_last_scp != NULL) {
             ASC_ASSERT(REQPNEXT(last_scp) != NULL);
             for (tscp = REQPNEXT(last_scp); tscp; tscp = REQPNEXT(tscp)) {
@@ -6394,8 +6394,8 @@
                     ASC_TID_ALL);
             } else {
                 ASC_ASSERT(last_scp != NULL);
-                REQPNEXT(last_scp) = asc_dequeue_list(&boardp->done,
-                    &new_last_scp, ASC_TID_ALL);
+                last_scp->host_scribble = (unsigned char *)asc_dequeue_list(
+			&boardp->done, &new_last_scp, ASC_TID_ALL);
                 if (new_last_scp != NULL) {
                     ASC_ASSERT(REQPNEXT(last_scp) != NULL);
                     last_scp = new_last_scp;
@@ -6466,7 +6466,7 @@
     while (scp != NULL) {
         ASC_DBG1(3, "asc_scsi_done_list: scp 0x%lx\n", (ulong) scp);
         tscp = REQPNEXT(scp);
-        REQPNEXT(scp) = NULL;
+        scp->host_scribble = NULL;
         ASC_STATS(scp->host, done);
         ASC_ASSERT(scp->scsi_done != NULL);
         scp->scsi_done(scp);
@@ -7511,7 +7511,7 @@
     tid = REQPTID(reqp);
     ASC_ASSERT(tid >= 0 && tid <= ADV_MAX_TID);
     if (flag == ASC_FRONT) {
-        REQPNEXT(reqp) = ascq->q_first[tid];
+        reqp->host_scribble = (unsigned char *)ascq->q_first[tid];
         ascq->q_first[tid] = reqp;
         /* If the queue was empty, set the last pointer. */
         if (ascq->q_last[tid] == NULL) {
@@ -7519,10 +7519,10 @@
         }
     } else { /* ASC_BACK */
         if (ascq->q_last[tid] != NULL) {
-            REQPNEXT(ascq->q_last[tid]) = reqp;
+            ascq->q_last[tid]->host_scribble = (unsigned char *)reqp;
         }
         ascq->q_last[tid] = reqp;
-        REQPNEXT(reqp) = NULL;
+        reqp->host_scribble = NULL;
         /* If the queue was empty, set the first pointer. */
         if (ascq->q_first[tid] == NULL) {
             ascq->q_first[tid] = reqp;
@@ -7643,7 +7643,7 @@
                     lastp = ascq->q_last[i];
                 } else {
                     ASC_ASSERT(lastp != NULL);
-                    REQPNEXT(lastp) = ascq->q_first[i];
+                    lastp->host_scribble = (unsigned char *)ascq->q_first[i];
                     lastp = ascq->q_last[i];
                 }
                 ascq->q_first[i] = ascq->q_last[i] = NULL;
@@ -7721,8 +7721,8 @@
              currp; prevp = currp, currp = REQPNEXT(currp)) {
             if (currp == reqp) {
                 ret = ASC_TRUE;
-                REQPNEXT(prevp) = REQPNEXT(currp);
-                REQPNEXT(reqp) = NULL;
+                prevp->host_scribble = (unsigned char *)REQPNEXT(currp);
+                reqp->host_scribble = NULL;
                 if (ascq->q_last[tid] == reqp) {
                     ascq->q_last[tid] = prevp;
                 }
--- 27~/drivers/scsi/dpt_i2o.c
+++ 27/drivers/scsi/dpt_i2o.c
@@ -434,7 +434,7 @@
 			cmd->scsi_done(cmd);
 			return 0;
 		}
-		(struct adpt_device*)(cmd->device->hostdata) = pDev;
+		cmd->device->hostdata = pDev;
 	}
 	pDev->pScsi_dev = cmd->device;
 
@@ -2194,7 +2194,7 @@
 		printk ("%s: scsi_register returned NULL\n",pHba->name);
 		return -1;
 	}
-	(adpt_hba*)(host->hostdata[0]) = pHba;
+	host->hostdata[0] = (unsigned long)pHba;
 	pHba->host = host;
 
 	host->irq = pHba->pDev->irq;;
--- 27~/drivers/scsi/seagate.c
+++ 27/drivers/scsi/seagate.c
@@ -698,7 +698,7 @@
 	done_fn = done;
 	current_target = SCpnt->target;
 	current_lun = SCpnt->lun;
-	(const void *) current_cmnd = SCpnt->cmnd;
+	current_cmnd = SCpnt->cmnd;
 	current_data = (unsigned char *) SCpnt->request_buffer;
 	current_bufflen = SCpnt->request_bufflen;
 	SCint = SCpnt;
--- 27~/drivers/usb/audio.c
+++ 27/drivers/usb/audio.c
@@ -609,7 +609,7 @@
 			pgrem = rem;
 		memcpy((db->sgbuf[db->wrptr >> PAGE_SHIFT]) + (db->wrptr & (PAGE_SIZE-1)), buffer, pgrem);
 		size -= pgrem;
-		(char *)buffer += pgrem;
+		buffer += pgrem;
 		db->wrptr += pgrem;
 		if (db->wrptr >= db->dmasize)
 			db->wrptr = 0;
@@ -632,7 +632,7 @@
 			pgrem = rem;
 		memcpy(buffer, (db->sgbuf[db->rdptr >> PAGE_SHIFT]) + (db->rdptr & (PAGE_SIZE-1)), pgrem);
 		size -= pgrem;
-		(char *)buffer += pgrem;
+		buffer += pgrem;
 		db->rdptr += pgrem;
 		if (db->rdptr >= db->dmasize)
 			db->rdptr = 0;
@@ -657,7 +657,7 @@
 		if (copy_from_user((db->sgbuf[ptr >> PAGE_SHIFT]) + (ptr & (PAGE_SIZE-1)), buffer, pgrem))
 			return -EFAULT;
 		size -= pgrem;
-		(char *)buffer += pgrem;
+		buffer += pgrem;
 		ptr += pgrem;
 		if (ptr >= db->dmasize)
 			ptr = 0;
@@ -682,7 +682,7 @@
 		if (copy_to_user(buffer, (db->sgbuf[ptr >> PAGE_SHIFT]) + (ptr & (PAGE_SIZE-1)), pgrem))
 			return -EFAULT;
 		size -= pgrem;
-		(char *)buffer += pgrem;
+		buffer += pgrem;
 		ptr += pgrem;
 		if (ptr >= db->dmasize)
 			ptr = 0;
--- 27~/drivers/usb/hpusbscsi.c
+++ 27/drivers/usb/hpusbscsi.c
@@ -182,7 +182,7 @@
 
 	memcpy (&(new->ctempl), &hpusbscsi_scsi_host_template,
 		sizeof (hpusbscsi_scsi_host_template));
-	(struct hpusbscsi *) new->ctempl.proc_dir = new;
+	new->ctempl.proc_dir = (void *)new;
 	new->ctempl.module = THIS_MODULE;
 
 	if (scsi_register_module (MODULE_SCSI_HA, &(new->ctempl)))
--- 27~/drivers/usb/microtek.c
+++ 27/drivers/usb/microtek.c
@@ -987,7 +987,7 @@
 	/* Initialize the host template based on the default one */
 	memcpy(&(new_desc->ctempl), &mts_scsi_host_template, sizeof(mts_scsi_host_template));
 	/* HACK from usb-storage - this is needed for scsi detection */
-	(struct mts_desc *)new_desc->ctempl.proc_dir = new_desc; /* FIXME */
+	new_desc->ctempl.proc_dir = (void *)new_desc; /* FIXME */
 
 	MTS_DEBUG("registering SCSI module\n");
 
--- 27~/drivers/usb/uss720.c
+++ 27/drivers/usb/uss720.c
@@ -333,7 +333,7 @@
 	for (; got < length; got++) {
 		if (get_1284_register(pp, 4, (char *)buf))
 			break;
-		((char*)buf)++;
+		buf++;
 		if (priv->reg[0] & 0x01) {
 			clear_epp_timeout(pp);
 			break;
@@ -392,7 +392,7 @@
 	for (; got < length; got++) {
 		if (get_1284_register(pp, 3, (char *)buf))
 			break;
-		((char*)buf)++;
+		buf++;
 		if (priv->reg[0] & 0x01) {
 			clear_epp_timeout(pp);
 			break;
@@ -412,7 +412,7 @@
 	for (; written < length; written++) {
 		if (set_1284_register(pp, 3, *(char *)buf))
 			break;
-		((char*)buf)++;
+		buf++;
 		if (get_1284_register(pp, 1, NULL))
 			break;
 		if (priv->reg[0] & 0x01) {
@@ -469,7 +469,7 @@
 	for (; written < len; written++) {
 		if (set_1284_register(pp, 5, *(char *)buffer))
 			break;
-		((char*)buffer)++;
+		buffer++;
 	}
 	change_mode(pp, ECR_PS2);
 	return written;
--- 27~/include/pcmcia/mem_op.h
+++ 27/include/pcmcia/mem_op.h
@@ -80,8 +80,12 @@
     size_t odd = (n & 1);
     n -= odd;
     while (n) {
-	*(u_short *)to = __raw_readw(from);
-	(char *)to += 2; (char *)from += 2; n -= 2;
+	u_short *t = to;
+
+	*t = __raw_readw(from);
+	to = (void *)((long)to + 2);
+	from = (const void *)((long)from + 2);
+	n -= 2;
     }
     if (odd)
 	*(u_char *)to = readb(from);
@@ -93,7 +97,9 @@
     n -= odd;
     while (n) {
 	__raw_writew(*(u_short *)from, to);
-	(char *)to += 2; (char *)from += 2; n -= 2;
+	to = (void *)((long)to + 2);
+	from = (const void *)((long)from + 2);
+	n -= 2;
     }
     if (odd)
 	writeb(*(u_char *)from, to);
@@ -105,7 +111,9 @@
     n -= odd;
     while (n) {
 	put_user(__raw_readw(from), (short *)to);
-	(char *)to += 2; (char *)from += 2; n -= 2;
+	to = (void *)((long)to + 2);
+	from = (const void *)((long)from + 2);
+	n -= 2;
     }
     if (odd)
 	put_user(readb(from), (char *)to);
@@ -120,7 +128,9 @@
     while (n) {
 	get_user(s, (short *)from);
 	__raw_writew(s, to);
-	(char *)to += 2; (char *)from += 2; n -= 2;
+	to = (void *)((long)to + 2);
+	from = (const void *)((long)from + 2);
+	n -= 2;
     }
     if (odd) {
 	get_user(c, (char *)from);


--------------000704050704040705060508--
