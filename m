Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268714AbUH0ViS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268714AbUH0ViS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268648AbUH0Vgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:36:45 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:41683 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S267867AbUH0VMu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:12:50 -0400
Message-ID: <412FA33A.7040107@ttnet.net.tr>
Date: Sat, 28 Aug 2004 00:10:18 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.28-pre2 gcc-3.4 misc lvalue fixes
Content-Type: multipart/mixed;
	boundary="------------090301090902070804070506"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090301090902070804070506
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

Marcelo:

This patch fixes the gcc-3.4 cast as l-value warnings
in the following files:

drivers/atm/atmtcp.c
drivers/atm/fore200e.c
drivers/atm/he.c
drivers/atm/idt77105.c
drivers/atm/iphase.c
drivers/atm/uPD98402.c
drivers/atm/zatm.c
drivers/hotplug/ibmphp_hpc.c
drivers/i2c/i2c-core.c
drivers/i2c/i2c-proc.c
drivers/ieee1394/highlevel.c
drivers/isdn/hisax/avm_pci.c
drivers/isdn/hisax/hfc_pci.c
drivers/isdn/hysdn/hysdn_proclog.c
drivers/mtd/chips/cfi_cmdset_0001.c
drivers/mtd/chips/cfi_cmdset_0020.c
drivers/mtd/maps/elan-104nc.c
drivers/mtd/maps/sbc_gxx.c
drivers/net/bonding/bond_alb.c
drivers/net/wan/sdla_fr.c
drivers/net/wan/sdladrv.c
drivers/net/wan/sdlamain.c
drivers/usb/audio.c
drivers/usb/hpusbscsi.c
drivers/usb/microtek.c
drivers/usb/uss720.c
include/pcmcia/mem_op.h (for drivers/net/pcmcia)

They are from the 2.6 tree. The i2c-proc.c is non-existant in
2.6 and is fixed the same way i2c-core.c, plus its first hunk
being borrowed from i2c-2.8.x. In addition, the idt77105.c fix
is re-fixed according to your warning. Please consider for
applying.

Ozkan


--------------090301090902070804070506
Content-Type: text/plain;
	name="28p2-gcc340-lvalue.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="28p2-gcc340-lvalue.diff"

diff -urN 28p2/drivers/atm/atmtcp.c 28p2_gcc340/drivers/atm/atmtcp.c
--- 28p2/drivers/atm/atmtcp.c	2003-11-28 20:26:19.000000000 +0200
+++ 28p2_gcc340/drivers/atm/atmtcp.c	2004-08-27 23:41:06.000000000 +0300
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
diff -urN 28p2/drivers/atm/fore200e.c 28p2_gcc340/drivers/atm/fore200e.c
--- 28p2/drivers/atm/fore200e.c	2004-08-27 23:39:41.000000000 +0300
+++ 28p2_gcc340/drivers/atm/fore200e.c	2004-08-27 23:41:06.000000000 +0300
@@ -1621,7 +1621,7 @@
     set_bit(ATM_VF_PARTIAL,&vcc->flags);
     set_bit(ATM_VF_ADDR, &vcc->flags);
 
-    FORE200E_VCC(vcc) = fore200e_vcc;
+    vcc->dev_data = fore200e_vcc;
 
     if (fore200e_activate_vcin(fore200e, 1, vcc, vcc->qos.rxtp.max_sdu) < 0) {
 
@@ -1630,7 +1630,7 @@
 	clear_bit(ATM_VF_ADDR, &vcc->flags);
 	clear_bit(ATM_VF_PARTIAL,&vcc->flags);
 
-	FORE200E_VCC(vcc) = NULL;
+	vcc->dev_data = NULL;
 
 	fore200e->available_cell_rate += vcc->qos.txtp.max_pcr;
 
@@ -1692,7 +1692,7 @@
     vcc->itf = vcc->vci = vcc->vpi = 0;
 
     fore200e_vcc = FORE200E_VCC(vcc);
-    FORE200E_VCC(vcc) = NULL;
+    vcc->dev_data = NULL;
 
     spin_unlock_irqrestore(&fore200e->q_lock, flags);
 
@@ -2739,7 +2739,7 @@
 	return -ENODEV;
     }
 
-    FORE200E_DEV(atm_dev) = fore200e;
+    atm_dev->dev_data = fore200e;
     fore200e->atm_dev = atm_dev;
 
     atm_dev->ci_range.vpi_bits = FORE200E_VPI_BITS;
diff -urN 28p2/drivers/atm/he.c 28p2_gcc340/drivers/atm/he.c
--- 28p2/drivers/atm/he.c	2004-02-18 15:36:31.000000000 +0200
+++ 28p2_gcc340/drivers/atm/he.c	2004-08-27 23:41:06.000000000 +0300
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
diff -urN 28p2/drivers/atm/idt77105.c 28p2_gcc340/drivers/atm/idt77105.c
--- 28p2/drivers/atm/idt77105.c	2003-06-13 17:51:32.000000000 +0300
+++ 28p2_gcc340/drivers/atm/idt77105.c	2004-08-27 23:41:06.000000000 +0300
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
diff -urN 28p2/drivers/atm/iphase.c 28p2_gcc340/drivers/atm/iphase.c
--- 28p2/drivers/atm/iphase.c	2003-08-25 14:44:41.000000000 +0300
+++ 28p2_gcc340/drivers/atm/iphase.c	2004-08-27 23:41:06.000000000 +0300
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
diff -urN 28p2/drivers/atm/uPD98402.c 28p2_gcc340/drivers/atm/uPD98402.c
--- 28p2/drivers/atm/uPD98402.c	2001-09-14 01:21:32.000000000 +0300
+++ 28p2_gcc340/drivers/atm/uPD98402.c	2004-08-27 23:41:06.000000000 +0300
@@ -212,7 +212,7 @@
 static int uPD98402_start(struct atm_dev *dev)
 {
 	DPRINTK("phy_start\n");
-	if (!(PRIV(dev) = kmalloc(sizeof(struct uPD98402_priv),GFP_KERNEL)))
+	if (!(dev->dev_data = kmalloc(sizeof(struct uPD98402_priv),GFP_KERNEL)))
 		return -ENOMEM;
 	memset(&PRIV(dev)->sonet_stats,0,sizeof(struct k_sonet_stats));
 	(void) GET(PCR); /* clear performance events */
diff -urN 28p2/drivers/atm/zatm.c 28p2_gcc340/drivers/atm/zatm.c
--- 28p2/drivers/atm/zatm.c	2003-08-25 14:44:41.000000000 +0300
+++ 28p2_gcc340/drivers/atm/zatm.c	2004-08-27 23:41:06.000000000 +0300
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
diff -urN 28p2/drivers/hotplug/ibmphp_hpc.c 28p2_gcc340/drivers/hotplug/ibmphp_hpc.c
--- 28p2/drivers/hotplug/ibmphp_hpc.c	2003-11-28 20:26:20.000000000 +0200
+++ 28p2_gcc340/drivers/hotplug/ibmphp_hpc.c	2004-08-27 23:41:06.000000000 +0300
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
diff -urN 28p2/drivers/i2c/i2c-core.c 28p2_gcc340/drivers/i2c/i2c-core.c
--- 28p2/drivers/i2c/i2c-core.c	2004-02-18 15:36:31.000000000 +0200
+++ 28p2_gcc340/drivers/i2c/i2c-core.c	2004-08-27 23:41:07.000000000 +0300
@@ -750,7 +750,7 @@
 		msg.addr   = client->addr;
 		msg.flags = client->flags & I2C_M_TEN;
 		msg.len = count;
-		(const char *)msg.buf = buf;
+		msg.buf = (char *)buf;
 	
 		DEB2(printk(KERN_DEBUG "i2c-core.o: master_send: writing %d bytes on %s.\n",
 			count,client->adapter->name));
diff -urN 28p2/drivers/i2c/i2c-proc.c 28p2_gcc340/drivers/i2c/i2c-proc.c
--- 28p2/drivers/i2c/i2c-proc.c	2004-02-18 15:36:31.000000000 +0200
+++ 28p2_gcc340/drivers/i2c/i2c-proc.c	2004-08-27 23:41:07.000000000 +0300
@@ -198,19 +198,19 @@
 
 void i2c_deregister_entry(int id)
 {
-	ctl_table *table;
-	char *temp;
 	id -= 256;
+
 	if (i2c_entries[id]) {
-		table = i2c_entries[id]->ctl_table;
-		unregister_sysctl_table(i2c_entries[id]);
-		/* 2-step kfree needed to keep gcc happy about const points */
-		(const char *) temp = table[4].procname;
-		kfree(temp);
-		kfree(table);
-		i2c_entries[id] = NULL;
-		i2c_clients[id] = NULL;
+		struct ctl_table_header *hdr = i2c_entries[id];
+		struct ctl_table *tbl = hdr->ctl_table;
+
+		unregister_sysctl_table(hdr);
+		kfree(tbl->child->child->procname);
+		kfree(tbl); /* actually the whole anonymous struct */
 	}
+
+	i2c_entries[id] = NULL;
+	i2c_clients[id] = NULL;
 }
 
 /* Monitor access for /proc/sys/dev/sensors; make unloading i2c-proc.o 
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
diff -urN 28p2/drivers/ieee1394/highlevel.c 28p2_gcc340/drivers/ieee1394/highlevel.c
--- 28p2/drivers/ieee1394/highlevel.c	2003-11-28 20:26:20.000000000 +0200
+++ 28p2_gcc340/drivers/ieee1394/highlevel.c	2004-08-27 23:41:07.000000000 +0300
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
 
diff -urN 28p2/drivers/isdn/hisax/avm_pci.c 28p2_gcc340/drivers/isdn/hisax/avm_pci.c
--- 28p2/drivers/isdn/hisax/avm_pci.c	2002-11-29 01:53:13.000000000 +0200
+++ 28p2_gcc340/drivers/isdn/hisax/avm_pci.c	2004-08-27 23:41:07.000000000 +0300
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
diff -urN 28p2/drivers/isdn/hisax/hfc_pci.c 28p2_gcc340/drivers/isdn/hisax/hfc_pci.c
--- 28p2/drivers/isdn/hisax/hfc_pci.c	2003-06-13 17:51:34.000000000 +0300
+++ 28p2_gcc340/drivers/isdn/hisax/hfc_pci.c	2004-08-27 23:41:07.000000000 +0300
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
diff -urN 28p2/drivers/isdn/hysdn/hysdn_proclog.c 28p2_gcc340/drivers/isdn/hysdn/hysdn_proclog.c
--- 28p2/drivers/isdn/hysdn/hysdn_proclog.c	2004-08-08 02:26:04.000000000 +0300
+++ 28p2_gcc340/drivers/isdn/hysdn/hysdn_proclog.c	2004-08-27 23:41:07.000000000 +0300
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
diff -urN 28p2/drivers/mtd/chips/cfi_cmdset_0001.c 28p2_gcc340/drivers/mtd/chips/cfi_cmdset_0001.c
--- 28p2/drivers/mtd/chips/cfi_cmdset_0001.c	2003-06-13 17:51:34.000000000 +0300
+++ 28p2_gcc340/drivers/mtd/chips/cfi_cmdset_0001.c	2004-08-27 23:41:07.000000000 +0300
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
diff -urN 28p2/drivers/mtd/chips/cfi_cmdset_0020.c 28p2_gcc340/drivers/mtd/chips/cfi_cmdset_0020.c
--- 28p2/drivers/mtd/chips/cfi_cmdset_0020.c	2003-06-13 17:51:34.000000000 +0300
+++ 28p2_gcc340/drivers/mtd/chips/cfi_cmdset_0020.c	2004-08-27 23:41:07.000000000 +0300
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
diff -urN 28p2/drivers/mtd/maps/elan-104nc.c 28p2_gcc340/drivers/mtd/maps/elan-104nc.c
--- 28p2/drivers/mtd/maps/elan-104nc.c	2002-08-03 03:39:44.000000000 +0300
+++ 28p2_gcc340/drivers/mtd/maps/elan-104nc.c	2004-08-27 23:41:07.000000000 +0300
@@ -147,7 +147,7 @@
 		elan_104nc_page(map, from);
 		memcpy_fromio(to, iomapadr + (from & WINDOW_MASK), thislen);
 		spin_unlock(&elan_104nc_spin);
-		(__u8*)to += thislen;
+		to += thislen;
 		from += thislen;
 		len -= thislen;
 	}
diff -urN 28p2/drivers/mtd/maps/sbc_gxx.c 28p2_gcc340/drivers/mtd/maps/sbc_gxx.c
--- 28p2/drivers/mtd/maps/sbc_gxx.c	2003-06-13 17:51:34.000000000 +0300
+++ 28p2_gcc340/drivers/mtd/maps/sbc_gxx.c	2004-08-27 23:41:07.000000000 +0300
@@ -155,7 +155,7 @@
 		sbc_gxx_page(map, from);
 		memcpy_fromio(to, iomapadr + (from & WINDOW_MASK), thislen);
 		spin_unlock(&sbc_gxx_spin);
-		(__u8*)to += thislen;
+		to += thislen;
 		from += thislen;
 		len -= thislen;
 	}
diff -urN 28p2/drivers/net/bonding/bond_alb.c 28p2_gcc340/drivers/net/bonding/bond_alb.c
--- 28p2/drivers/net/bonding/bond_alb.c	2004-04-14 16:05:30.000000000 +0300
+++ 28p2_gcc340/drivers/net/bonding/bond_alb.c	2004-08-27 23:41:07.000000000 +0300
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
diff -urN 28p2/drivers/net/wan/sdladrv.c 28p2_gcc340/drivers/net/wan/sdladrv.c
--- 28p2/drivers/net/wan/sdladrv.c	2001-09-14 02:04:43.000000000 +0300
+++ 28p2_gcc340/drivers/net/wan/sdladrv.c	2004-08-27 23:41:07.000000000 +0300
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
      
diff -urN 28p2/drivers/net/wan/sdla_fr.c 28p2_gcc340/drivers/net/wan/sdla_fr.c
--- 28p2/drivers/net/wan/sdla_fr.c	2003-11-28 20:26:20.000000000 +0200
+++ 28p2_gcc340/drivers/net/wan/sdla_fr.c	2004-08-27 23:41:07.000000000 +0300
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
diff -urN 28p2/drivers/net/wan/sdlamain.c 28p2_gcc340/drivers/net/wan/sdlamain.c
--- 28p2/drivers/net/wan/sdlamain.c	2003-11-28 20:26:20.000000000 +0200
+++ 28p2_gcc340/drivers/net/wan/sdlamain.c	2004-08-27 23:41:07.000000000 +0300
@@ -1027,7 +1027,7 @@
                       #endif
                         dump.length     -= len;
                         dump.offset     += len;
-                        (char*)dump.ptr += len;
+                        dump.ptr         = (void*)dump.ptr + len;
                 }
 		
                 sdla_mapmem(&card->hw, oldvec);/* restore DPM window position */
diff -urN 28p2/drivers/usb/audio.c 28p2_gcc340/drivers/usb/audio.c
--- 28p2/drivers/usb/audio.c	2004-08-08 02:26:05.000000000 +0300
+++ 28p2_gcc340/drivers/usb/audio.c	2004-08-27 23:41:07.000000000 +0300
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
diff -urN 28p2/drivers/usb/hpusbscsi.c 28p2_gcc340/drivers/usb/hpusbscsi.c
--- 28p2/drivers/usb/hpusbscsi.c	2003-06-13 17:51:36.000000000 +0300
+++ 28p2_gcc340/drivers/usb/hpusbscsi.c	2004-08-27 23:41:07.000000000 +0300
@@ -182,7 +182,7 @@
 
 	memcpy (&(new->ctempl), &hpusbscsi_scsi_host_template,
 		sizeof (hpusbscsi_scsi_host_template));
-	(struct hpusbscsi *) new->ctempl.proc_dir = new;
+	new->ctempl.proc_dir = (void *)new;
 	new->ctempl.module = THIS_MODULE;
 
 	if (scsi_register_module (MODULE_SCSI_HA, &(new->ctempl)))
diff -urN 28p2/drivers/usb/microtek.c 28p2_gcc340/drivers/usb/microtek.c
--- 28p2/drivers/usb/microtek.c	2002-11-29 01:53:14.000000000 +0200
+++ 28p2_gcc340/drivers/usb/microtek.c	2004-08-27 23:41:07.000000000 +0300
@@ -987,7 +987,7 @@
 	/* Initialize the host template based on the default one */
 	memcpy(&(new_desc->ctempl), &mts_scsi_host_template, sizeof(mts_scsi_host_template));
 	/* HACK from usb-storage - this is needed for scsi detection */
-	(struct mts_desc *)new_desc->ctempl.proc_dir = new_desc; /* FIXME */
+	new_desc->ctempl.proc_dir = (void *)new_desc; /* FIXME */
 
 	MTS_DEBUG("registering SCSI module\n");
 
diff -urN 28p2/drivers/usb/uss720.c 28p2_gcc340/drivers/usb/uss720.c
--- 28p2/drivers/usb/uss720.c	2001-10-21 05:13:11.000000000 +0300
+++ 28p2_gcc340/drivers/usb/uss720.c	2004-08-27 23:41:07.000000000 +0300
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
diff -urN 28p2/include/pcmcia/mem_op.h 28p2_gcc340/include/pcmcia/mem_op.h
--- 28p2/include/pcmcia/mem_op.h	2001-02-17 02:02:37.000000000 +0200
+++ 28p2_gcc340/include/pcmcia/mem_op.h	2004-08-27 23:41:07.000000000 +0300
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

--------------090301090902070804070506--
