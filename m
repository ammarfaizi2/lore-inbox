Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269382AbUJWEs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269382AbUJWEs6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269727AbUJWEsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:48:38 -0400
Received: from [211.58.254.17] ([211.58.254.17]:45201 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S269320AbUJWEcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:32:43 -0400
Date: Sat, 23 Oct 2004 13:32:37 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Per-device parameter support (16/16)
Message-ID: <20041023043237.GQ3456@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_16_DEVPARAM_via-velocity.diff

 This is the 16th patch of 16 patches for devparam.

 This patch converts via-velocity driver to use devparam.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-devparam-export/drivers/net/via-velocity.c
===================================================================
--- linux-devparam-export.orig/drivers/net/via-velocity.c	2004-10-22 17:13:05.000000000 +0900
+++ linux-devparam-export/drivers/net/via-velocity.c	2004-10-23 11:09:33.000000000 +0900
@@ -84,7 +84,6 @@
 #include "via-velocity.h"
 
 
-static int velocity_nics = 0;
 static int msglevel = MSG_LEVEL_INFO;
 
 
@@ -99,134 +98,106 @@ MODULE_AUTHOR("VIA Networking Technologi
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("VIA Networking Velocity Family Gigabit Ethernet Adapter Driver");
 
-#define VELOCITY_PARAM(N,D) \
-        static const int N[MAX_UNITS]=OPTION_DEFAULT;\
-        MODULE_PARM(N, "1-" __MODULE_STRING(MAX_UNITS) "i");\
-        MODULE_PARM_DESC(N, D);
-
 #define RX_DESC_MIN     64
 #define RX_DESC_MAX     255
 #define RX_DESC_DEF     64
-VELOCITY_PARAM(RxDescriptors, "Number of receive descriptors");
-
-#define TX_DESC_MIN     16
-#define TX_DESC_MAX     256
-#define TX_DESC_DEF     64
-VELOCITY_PARAM(TxDescriptors, "Number of transmit descriptors");
-
-#define VLAN_ID_MIN     0
-#define VLAN_ID_MAX     4095
-#define VLAN_ID_DEF     0
-/* VID_setting[] is used for setting the VID of NIC.
-   0: default VID.
-   1-4094: other VIDs.
-*/
-VELOCITY_PARAM(VID_setting, "802.1Q VLAN ID");
-
-#define RX_THRESH_MIN   0
-#define RX_THRESH_MAX   3
-#define RX_THRESH_DEF   0
-/* rx_thresh[] is used for controlling the receive fifo threshold.
-   0: indicate the rxfifo threshold is 128 bytes.
-   1: indicate the rxfifo threshold is 512 bytes.
-   2: indicate the rxfifo threshold is 1024 bytes.
-   3: indicate the rxfifo threshold is store & forward.
-*/
-VELOCITY_PARAM(rx_thresh, "Receive fifo threshold");
-
-#define DMA_LENGTH_MIN  0
-#define DMA_LENGTH_MAX  7
-#define DMA_LENGTH_DEF  0
-
-/* DMA_length[] is used for controlling the DMA length
-   0: 8 DWORDs
-   1: 16 DWORDs
-   2: 32 DWORDs
-   3: 64 DWORDs
-   4: 128 DWORDs
-   5: 256 DWORDs
-   6: SF(flush till emply)
-   7: SF(flush till emply)
-*/
-VELOCITY_PARAM(DMA_length, "DMA length");
 
-#define TAGGING_DEF     0
-/* enable_tagging[] is used for enabling 802.1Q VID tagging.
-   0: disable VID seeting(default).
-   1: enable VID setting.
-*/
-VELOCITY_PARAM(enable_tagging, "Enable 802.1Q tagging");
-
-#define IP_ALIG_DEF     0
-/* IP_byte_align[] is used for IP header DWORD byte aligned
-   0: indicate the IP header won't be DWORD byte aligned.(Default) .
-   1: indicate the IP header will be DWORD byte aligned.
-      In some enviroment, the IP header should be DWORD byte aligned,
-      or the packet will be droped when we receive it. (eg: IPVS)
-*/
-VELOCITY_PARAM(IP_byte_align, "Enable IP header dword aligned");
-
-#define TX_CSUM_DEF     1
-/* txcsum_offload[] is used for setting the checksum offload ability of NIC.
-   (We only support RX checksum offload now)
-   0: disable csum_offload[checksum offload
-   1: enable checksum offload. (Default)
-*/
-VELOCITY_PARAM(txcsum_offload, "Enable transmit packet checksum offload");
-
-#define FLOW_CNTL_DEF   1
-#define FLOW_CNTL_MIN   1
-#define FLOW_CNTL_MAX   5
-
-/* flow_control[] is used for setting the flow control ability of NIC.
-   1: hardware deafult - AUTO (default). Use Hardware default value in ANAR.
-   2: enable TX flow control.
-   3: enable RX flow control.
-   4: enable RX/TX flow control.
-   5: disable
-*/
-VELOCITY_PARAM(flow_control, "Enable flow control ability");
-
-#define MED_LNK_DEF 0
-#define MED_LNK_MIN 0
-#define MED_LNK_MAX 4
-/* speed_duplex[] is used for setting the speed and duplex mode of NIC.
-   0: indicate autonegotiation for both speed and duplex mode
-   1: indicate 100Mbps half duplex mode
-   2: indicate 100Mbps full duplex mode
-   3: indicate 10Mbps half duplex mode
-   4: indicate 10Mbps full duplex mode
-
-   Note:
-        if EEPROM have been set to the force mode, this option is ignored
-            by driver.
-*/
-VELOCITY_PARAM(speed_duplex, "Setting the speed and duplex mode");
-
-#define VAL_PKT_LEN_DEF     0
-/* ValPktLen[] is used for setting the checksum offload ability of NIC.
-   0: Receive frame with invalid layer 2 length (Default)
-   1: Drop frame with invalid layer 2 length
-*/
-VELOCITY_PARAM(ValPktLen, "Receiving or Drop invalid 802.3 frame");
-
-#define WOL_OPT_DEF     0
-#define WOL_OPT_MIN     0
-#define WOL_OPT_MAX     7
-/* wol_opts[] is used for controlling wake on lan behavior.
-   0: Wake up if recevied a magic packet. (Default)
-   1: Wake up if link status is on/off.
-   2: Wake up if recevied an arp packet.
-   4: Wake up if recevied any unicast packet.
-   Those value can be sumed up to support more than one option.
-*/
-VELOCITY_PARAM(wol_opts, "Wake On Lan options");
-
-#define INT_WORKS_DEF   20
-#define INT_WORKS_MIN   10
-#define INT_WORKS_MAX   64
-
-VELOCITY_PARAM(int_works, "Number of packets per interrupt services");
+#define VELOCITY_INT_PARAM(name, field, min, max, dfl, desc) \
+	DEVICE_PARAM_NAMED_RANGED(name, field, int, min, max, #dfl, 0444, desc)
+#define VELOCITY_FLAG_PARAM(name, flag, dfl, desc) \
+	DEVICE_PARAM_FLAG(name, flags, flag, #dfl, 0444, desc)
+
+static DEFINE_DEVICE_PARAMSET(velocity_paramset_def, struct velocity_opt,
+	VELOCITY_INT_PARAM(RxDescriptors, numrx, 64, 255, 64,
+			   "Number of receive descriptors")
+
+	VELOCITY_INT_PARAM(TxDescriptors, numtx, 16, 256, 64,
+			   "Number of transmit descriptors")
+
+	/* VID_setting is used for setting the VID of NIC.
+	   0: default VID.
+	   1-4094: other VIDs. */
+	VELOCITY_INT_PARAM(VID_setting, vid, 0, 4095, 0, "802.1Q VLAN ID")
+
+	/* rx_thresh is used for controlling the receive fifo threshold.
+	   0: indicate the rxfifo threshold is 128 bytes.
+	   1: indicate the rxfifo threshold is 512 bytes.
+	   2: indicate the rxfifo threshold is 1024 bytes.
+	   3: indicate the rxfifo threshold is store & forward. */
+	VELOCITY_INT_PARAM(rx_thresh, rx_thresh, 0, 3, 0,
+			   "Receive fifo threshold")
+
+	/* DMA_length is used for controlling the DMA length
+	   0: 8 DWORDs
+	   1: 16 DWORDs
+	   2: 32 DWORDs
+	   3: 64 DWORDs
+	   4: 128 DWORDs
+	   5: 256 DWORDs
+	   6: SF(flush till emply)
+	   7: SF(flush till emply) */
+	VELOCITY_INT_PARAM(DMA_length, DMA_length, 0, 7, 0, "DMA length")
+
+	/* enable_tagging is used for enabling 802.1Q VID tagging.
+	   0: disable VID seeting(default).
+	   1: enable VID setting. */
+	VELOCITY_FLAG_PARAM(enable_tagging, VELOCITY_FLAGS_TAGGING, 0,
+			   "Enable 802.1Q tagging")
+
+	/* IP_byte_align is used for IP header DWORD byte aligned
+	   0: indicate the IP header won't be DWORD byte aligned.(Default) .
+	   1: indicate the IP header will be DWORD byte aligned.
+	   In some enviroment, the IP header should be DWORD byte aligned,
+	   or the packet will be droped when we receive it. (eg: IPVS) */
+	VELOCITY_FLAG_PARAM(IP_byte_align, VELOCITY_FLAGS_IP_ALIGN, 0,
+			   "Enable IP header dword aligned")
+
+	/* txcsum_offload is used for setting the checksum offload ability of NIC.
+	   (We only support RX checksum offload now)
+	   0: disable csum_offload[checksum offload
+	   1: enable checksum offload. (Default) */
+	VELOCITY_FLAG_PARAM(txcsum_offload, VELOCITY_FLAGS_TX_CSUM, 1,
+			    "Enable transmit packet checksum offload")
+
+	/* flow_control is used for setting the flow control ability of NIC.
+	   1: hardware deafult - AUTO (default). Use Hardware default value in ANAR.
+	   2: enable TX flow control.
+	   3: enable RX flow control.
+	   4: enable RX/TX flow control.
+	   5: disable */
+	VELOCITY_INT_PARAM(flow_control, flow_cntl, 1, 5, 1,
+			   "Enable flow control ability")
+
+	/* speed_duplex is used for setting the speed and duplex mode of NIC.
+	   0: indicate autonegotiation for both speed and duplex mode
+	   1: indicate 100Mbps half duplex mode
+	   2: indicate 100Mbps full duplex mode
+	   3: indicate 10Mbps half duplex mode
+	   4: indicate 10Mbps full duplex mode
+	   
+	   Note:
+	   if EEPROM have been set to the force mode, this option is ignored
+	   by driver. */
+	VELOCITY_INT_PARAM(speed_duplex, spd_dpx, 0, 4, 0,
+			   "Setting the speed and duplex mode")
+
+	/* ValPktLen is used for setting the checksum offload ability of NIC.
+	   0: Receive frame with invalid layer 2 length (Default)
+	   1: Drop frame with invalid layer 2 length */
+	VELOCITY_FLAG_PARAM(ValPktLen, VELOCITY_FLAGS_VAL_PKT_LEN, 0,
+			    "Receiving or Drop invalid 802.3 frame")
+
+	/* wol_opts is used for controlling wake on lan behavior.
+	   0: Wake up if recevied a magic packet. (Default)
+	   1: Wake up if link status is on/off.
+	   2: Wake up if recevied an arp packet.
+	   4: Wake up if recevied any unicast packet.
+	   Those value can be sumed up to support more than one option. */
+	VELOCITY_INT_PARAM(wol_opts, wol_opts, 0, 7, 0, "Wake On Lan options")
+
+	VELOCITY_INT_PARAM(int_works, int_works, 10, 64, 20,
+			   "Number of packets per interrupt services")
+);
 
 static int rx_copybreak = 200;
 MODULE_PARM(rx_copybreak, "i");
@@ -359,97 +330,6 @@ static void __devexit velocity_remove1(s
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 	free_netdev(dev);
-
-	velocity_nics--;
-}
-
-/**
- *	velocity_set_int_opt	-	parser for integer options
- *	@opt: pointer to option value
- *	@val: value the user requested (or -1 for default)
- *	@min: lowest value allowed
- *	@max: highest value allowed
- *	@def: default value
- *	@name: property name
- *	@dev: device name
- *
- *	Set an integer property in the module options. This function does
- *	all the verification and checking as well as reporting so that
- *	we don't duplicate code for each option.
- */
-
-static void __devinit velocity_set_int_opt(int *opt, int val, int min, int max, int def, char *name, char *devname)
-{
-	if (val == -1)
-		*opt = def;
-	else if (val < min || val > max) {
-		VELOCITY_PRT(MSG_LEVEL_INFO, KERN_NOTICE "%s: the value of parameter %s is invalid, the valid range is (%d-%d)\n",
-					devname, name, min, max);
-		*opt = def;
-	} else {
-		VELOCITY_PRT(MSG_LEVEL_INFO, KERN_INFO "%s: set value of parameter %s to %d\n",
-					devname, name, val);
-		*opt = val;
-	}
-}
-
-/**
- *	velocity_set_bool_opt	-	parser for boolean options
- *	@opt: pointer to option value
- *	@val: value the user requested (or -1 for default)
- *	@def: default value (yes/no)
- *	@flag: numeric value to set for true.
- *	@name: property name
- *	@dev: device name
- *
- *	Set a boolean property in the module options. This function does
- *	all the verification and checking as well as reporting so that
- *	we don't duplicate code for each option.
- */
-
-static void __devinit velocity_set_bool_opt(u32 * opt, int val, int def, u32 flag, char *name, char *devname)
-{
-	(*opt) &= (~flag);
-	if (val == -1)
-		*opt |= (def ? flag : 0);
-	else if (val < 0 || val > 1) {
-		printk(KERN_NOTICE "%s: the value of parameter %s is invalid, the valid range is (0-1)\n", 
-			devname, name);
-		*opt |= (def ? flag : 0);
-	} else {
-		printk(KERN_INFO "%s: set parameter %s to %s\n", 
-			devname, name, val ? "TRUE" : "FALSE");
-		*opt |= (val ? flag : 0);
-	}
-}
-
-/**
- *	velocity_get_options	-	set options on device
- *	@opts: option structure for the device
- *	@index: index of option to use in module options array
- *	@devname: device name
- *
- *	Turn the module and command options into a single structure
- *	for the current device
- */
-
-static void __devinit velocity_get_options(struct velocity_opt *opts, int index, char *devname)
-{
-
-	velocity_set_int_opt(&opts->rx_thresh, rx_thresh[index], RX_THRESH_MIN, RX_THRESH_MAX, RX_THRESH_DEF, "rx_thresh", devname);
-	velocity_set_int_opt(&opts->DMA_length, DMA_length[index], DMA_LENGTH_MIN, DMA_LENGTH_MAX, DMA_LENGTH_DEF, "DMA_length", devname);
-	velocity_set_int_opt(&opts->numrx, RxDescriptors[index], RX_DESC_MIN, RX_DESC_MAX, RX_DESC_DEF, "RxDescriptors", devname);
-	velocity_set_int_opt(&opts->numtx, TxDescriptors[index], TX_DESC_MIN, TX_DESC_MAX, TX_DESC_DEF, "TxDescriptors", devname);
-	velocity_set_int_opt(&opts->vid, VID_setting[index], VLAN_ID_MIN, VLAN_ID_MAX, VLAN_ID_DEF, "VID_setting", devname);
-	velocity_set_bool_opt(&opts->flags, enable_tagging[index], TAGGING_DEF, VELOCITY_FLAGS_TAGGING, "enable_tagging", devname);
-	velocity_set_bool_opt(&opts->flags, txcsum_offload[index], TX_CSUM_DEF, VELOCITY_FLAGS_TX_CSUM, "txcsum_offload", devname);
-	velocity_set_int_opt(&opts->flow_cntl, flow_control[index], FLOW_CNTL_MIN, FLOW_CNTL_MAX, FLOW_CNTL_DEF, "flow_control", devname);
-	velocity_set_bool_opt(&opts->flags, IP_byte_align[index], IP_ALIG_DEF, VELOCITY_FLAGS_IP_ALIGN, "IP_byte_align", devname);
-	velocity_set_bool_opt(&opts->flags, ValPktLen[index], VAL_PKT_LEN_DEF, VELOCITY_FLAGS_VAL_PKT_LEN, "ValPktLen", devname);
-	velocity_set_int_opt((int *) &opts->spd_dpx, speed_duplex[index], MED_LNK_MIN, MED_LNK_MAX, MED_LNK_DEF, "Media link mode", devname);
-	velocity_set_int_opt((int *) &opts->wol_opts, wol_opts[index], WOL_OPT_MIN, WOL_OPT_MAX, WOL_OPT_DEF, "Wake On Lan options", devname);
-	velocity_set_int_opt((int *) &opts->int_works, int_works[index], INT_WORKS_MIN, INT_WORKS_MAX, INT_WORKS_DEF, "Interrupt service works", devname);
-	opts->numrx = (opts->numrx & ~3);
 }
 
 /**
@@ -478,10 +358,10 @@ static void velocity_init_cam_filter(str
 	if (vptr->flags & VELOCITY_FLAGS_TAGGING) {
 		/* If Tagging option is enabled and VLAN ID is not zero, then
 		   turn on MCFG_RTGOPT also */
-		if (vptr->options.vid != 0)
+		if (vptr->options->vid != 0)
 			WORD_REG_BITS_ON(MCFG_RTGOPT, &regs->MCFG);
 
-		mac_set_cam(regs, 0, (u8 *) & (vptr->options.vid), VELOCITY_VLAN_ID_CAM);
+		mac_set_cam(regs, 0, (u8 *) & (vptr->options->vid), VELOCITY_VLAN_ID_CAM);
 		vptr->vCAMmask[0] |= 1;
 		mac_set_cam_mask(regs, vptr->vCAMmask, VELOCITY_VLAN_ID_CAM);
 	} else {
@@ -511,13 +391,13 @@ static void velocity_rx_reset(struct vel
 	/*
 	 *	Init state, all RD entries belong to the NIC
 	 */
-	for (i = 0; i < vptr->options.numrx; ++i)
+	for (i = 0; i < vptr->options->numrx; ++i)
 		vptr->rd_ring[i].rdesc0.owner = OWNED_BY_NIC;
 
-	writew(vptr->options.numrx, &regs->RBRDU);
+	writew(vptr->options->numrx, &regs->RBRDU);
 	writel(vptr->rd_pool_dma, &regs->RDBaseLo);
 	writew(0, &regs->RDIdx);
-	writew(vptr->options.numrx - 1, &regs->RDCSize);
+	writew(vptr->options->numrx - 1, &regs->RDCSize);
 }
 
 /**
@@ -582,8 +462,8 @@ static void velocity_init_registers(stru
 		 *	clear Pre_ACPI bit.
 		 */
 		BYTE_REG_BITS_OFF(CFGA_PACPI, &(regs->CFGA));
-		mac_set_rx_thresh(regs, vptr->options.rx_thresh);
-		mac_set_dma_length(regs, vptr->options.DMA_length);
+		mac_set_rx_thresh(regs, vptr->options->rx_thresh);
+		mac_set_dma_length(regs, vptr->options->DMA_length);
 
 		writeb(WOLCFG_SAM | WOLCFG_SAB, &regs->WOLCFGSet);
 		/*
@@ -609,11 +489,11 @@ static void velocity_init_registers(stru
 		vptr->int_mask = INT_MASK_DEF;
 
 		writel(cpu_to_le32(vptr->rd_pool_dma), &regs->RDBaseLo);
-		writew(vptr->options.numrx - 1, &regs->RDCSize);
+		writew(vptr->options->numrx - 1, &regs->RDCSize);
 		mac_rx_queue_run(regs);
 		mac_rx_queue_wake(regs);
 
-		writew(vptr->options.numtx - 1, &regs->TDCSize);
+		writew(vptr->options->numtx - 1, &regs->TDCSize);
 
 		for (i = 0; i < vptr->num_txq; i++) {
 			writel(cpu_to_le32(vptr->td_pool_dma[i]), &(regs->TDBaseLo[i]));
@@ -693,12 +573,6 @@ static int __devinit velocity_found1(str
 	struct mac_regs __iomem * regs;
 	int ret = -ENOMEM;
 
-	if (velocity_nics >= MAX_UNITS) {
-		printk(KERN_NOTICE VELOCITY_NAME ": already found %d NICs.\n", 
-				velocity_nics);
-		return -ENODEV;
-	}
-
 	dev = alloc_etherdev(sizeof(struct velocity_info));
 
 	if (dev == NULL) {
@@ -711,7 +585,8 @@ static int __devinit velocity_found1(str
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	vptr = dev->priv;
-
+	vptr->options = pdev->dev.params.dev;
+	vptr->options->numrx &= ~3;
 
 	if (first) {
 		printk(KERN_INFO "%s Ver. %s\n", 
@@ -758,22 +633,19 @@ static int __devinit velocity_found1(str
 	for (i = 0; i < 6; i++)
 		dev->dev_addr[i] = readb(&regs->PAR[i]);
 
-
-	velocity_get_options(&vptr->options, velocity_nics, dev->name);
-
 	/* 
 	 *	Mask out the options cannot be set to the chip
 	 */
 	 
-	vptr->options.flags &= info->flags;
+	vptr->options->flags &= info->flags;
 
 	/*
 	 *	Enable the chip specified capbilities
 	 */
 	 
-	vptr->flags = vptr->options.flags | (info->flags & 0xFF000000UL);
+	vptr->flags = vptr->options->flags | (info->flags & 0xFF000000UL);
 
-	vptr->wol_opts = vptr->options.wol_opts;
+	vptr->wol_opts = vptr->options->wol_opts;
 	vptr->flags |= VELOCITY_FLAGS_WOL_ENABLED;
 
 	vptr->phy_id = MII_GET_PHY_ID(vptr->mac_regs);
@@ -814,7 +686,6 @@ static int __devinit velocity_found1(str
 		spin_unlock_irqrestore(&velocity_dev_list_lock, flags);
 	}
 #endif
-	velocity_nics++;
 out:
 	return ret;
 
@@ -936,8 +807,8 @@ static int velocity_init_rings(struct ve
 	 *	Allocate all RD/TD rings a single pool 
 	 */
 	 
-	psize = vptr->options.numrx * sizeof(struct rx_desc) + 
-		vptr->options.numtx * sizeof(struct tx_desc) * vptr->num_txq;
+	psize = vptr->options->numrx * sizeof(struct rx_desc) + 
+		vptr->options->numtx * sizeof(struct tx_desc) * vptr->num_txq;
 
 	/*
 	 * pci_alloc_consistent() fulfills the requirement for 64 bytes
@@ -957,7 +828,7 @@ static int velocity_init_rings(struct ve
 
 	vptr->rd_pool_dma = pool_dma;
 
-	tsize = vptr->options.numtx * PKT_BUF_SZ * vptr->num_txq;
+	tsize = vptr->options->numtx * PKT_BUF_SZ * vptr->num_txq;
 	vptr->tx_bufs = pci_alloc_consistent(vptr->pdev, tsize, 
 						&vptr->tx_bufs_dma);
 
@@ -968,13 +839,13 @@ static int velocity_init_rings(struct ve
 		return -ENOMEM;
 	}
 
-	memset(vptr->tx_bufs, 0, vptr->options.numtx * PKT_BUF_SZ * vptr->num_txq);
+	memset(vptr->tx_bufs, 0, vptr->options->numtx * PKT_BUF_SZ * vptr->num_txq);
 
-	i = vptr->options.numrx * sizeof(struct rx_desc);
+	i = vptr->options->numrx * sizeof(struct rx_desc);
 	pool += i;
 	pool_dma += i;
 	for (i = 0; i < vptr->num_txq; i++) {
-		int offset = vptr->options.numtx * sizeof(struct tx_desc);
+		int offset = vptr->options->numtx * sizeof(struct tx_desc);
 
 		vptr->td_pool_dma[i] = pool_dma;
 		vptr->td_rings[i] = (struct tx_desc *) pool;
@@ -995,12 +866,12 @@ static void velocity_free_rings(struct v
 {
 	int size;
 
-	size = vptr->options.numrx * sizeof(struct rx_desc) + 
-	       vptr->options.numtx * sizeof(struct tx_desc) * vptr->num_txq;
+	size = vptr->options->numrx * sizeof(struct rx_desc) + 
+	       vptr->options->numtx * sizeof(struct tx_desc) * vptr->num_txq;
 
 	pci_free_consistent(vptr->pdev, size, vptr->rd_ring, vptr->rd_pool_dma);
 
-	size = vptr->options.numtx * PKT_BUF_SZ * vptr->num_txq;
+	size = vptr->options->numtx * PKT_BUF_SZ * vptr->num_txq;
 
 	pci_free_consistent(vptr->pdev, size, vptr->tx_bufs, vptr->tx_bufs_dma);
 }
@@ -1022,7 +893,7 @@ static inline void velocity_give_many_rx
 	unusable = vptr->rd_filled & 0x0003;
 	dirty = vptr->rd_dirty - unusable;
 	for (avail = vptr->rd_filled & 0xfffc; avail; avail--) {
-		dirty = (dirty > 0) ? dirty - 1 : vptr->options.numrx - 1;
+		dirty = (dirty > 0) ? dirty - 1 : vptr->options->numrx - 1;
 		vptr->rd_ring[dirty].rdesc0.owner = OWNED_BY_NIC;
 	}
 
@@ -1047,7 +918,7 @@ static int velocity_rx_refill(struct vel
 				break;
 		}
 		done++;
-		dirty = (dirty < vptr->options.numrx - 1) ? dirty + 1 : 0;	
+		dirty = (dirty < vptr->options->numrx - 1) ? dirty + 1 : 0;	
 	} while (dirty != vptr->rd_curr);
 
 	if (done) {
@@ -1071,7 +942,7 @@ static int velocity_init_rd_ring(struct 
 {
 	int ret = -ENOMEM;
 	unsigned int rsize = sizeof(struct velocity_rd_info) * 
-					vptr->options.numrx;
+					vptr->options->numrx;
 
 	vptr->rd_info = kmalloc(rsize, GFP_KERNEL);
 	if(vptr->rd_info == NULL)
@@ -1105,7 +976,7 @@ static void velocity_free_rd_ring(struct
 	if (vptr->rd_info == NULL)
 		return;
 
-	for (i = 0; i < vptr->options.numrx; i++) {
+	for (i = 0; i < vptr->options->numrx; i++) {
 		struct velocity_rd_info *rd_info = &(vptr->rd_info[i]);
 
 		if (!rd_info->skb)
@@ -1138,7 +1009,7 @@ static int velocity_init_td_ring(struct 
 	struct tx_desc *td;
 	struct velocity_td_info *td_info;
 	unsigned int tsize = sizeof(struct velocity_td_info) * 
-					vptr->options.numtx;
+					vptr->options->numtx;
 
 	/* Init the TD ring entries */
 	for (j = 0; j < vptr->num_txq; j++) {
@@ -1153,13 +1024,13 @@ static int velocity_init_td_ring(struct 
 		}
 		memset(vptr->td_infos[j], 0, tsize);
 
-		for (i = 0; i < vptr->options.numtx; i++, curr += sizeof(struct tx_desc)) {
+		for (i = 0; i < vptr->options->numtx; i++, curr += sizeof(struct tx_desc)) {
 			td = &(vptr->td_rings[j][i]);
 			td_info = &(vptr->td_infos[j][i]);
 			td_info->buf = vptr->tx_bufs +
-				(j * vptr->options.numtx + i) * PKT_BUF_SZ;
+				(j * vptr->options->numtx + i) * PKT_BUF_SZ;
 			td_info->buf_dma = vptr->tx_bufs_dma +
-				(j * vptr->options.numtx + i) * PKT_BUF_SZ;
+				(j * vptr->options->numtx + i) * PKT_BUF_SZ;
 		}
 		vptr->td_tail[j] = vptr->td_curr[j] = vptr->td_used[j] = 0;
 	}
@@ -1208,7 +1079,7 @@ static void velocity_free_td_ring(struct
 	for (j = 0; j < vptr->num_txq; j++) {
 		if (vptr->td_infos[j] == NULL)
 			continue;
-		for (i = 0; i < vptr->options.numtx; i++) {
+		for (i = 0; i < vptr->options->numtx; i++) {
 			velocity_free_td_ring_entry(vptr, j, i);
 
 		}
@@ -1266,7 +1137,7 @@ static int velocity_rx_srv(struct veloci
 		vptr->dev->last_rx = jiffies;
 
 		rd_curr++;
-		if (rd_curr >= vptr->options.numrx)
+		if (rd_curr >= vptr->options->numrx)
 			rd_curr = 0;
 	} while (++works <= 15);
 
@@ -1494,7 +1365,7 @@ static int velocity_tx_srv(struct veloci
 
 	for (qnum = 0; qnum < vptr->num_txq; qnum++) {
 		for (idx = vptr->td_tail[qnum]; vptr->td_used[qnum] > 0; 
-			idx = (idx + 1) % vptr->options.numtx) {
+			idx = (idx + 1) % vptr->options->numtx) {
 
 			/*
 			 *	Get Tx Descriptor
@@ -1557,7 +1428,7 @@ static void velocity_print_link_status(s
 
 	if (vptr->mii_status & VELOCITY_LINK_FAIL) {
 		VELOCITY_PRT(MSG_LEVEL_INFO, KERN_NOTICE "%s: failed to detect cable link\n", vptr->dev->name);
-	} else if (vptr->options.spd_dpx == SPD_DPX_AUTO) {
+	} else if (vptr->options->spd_dpx == SPD_DPX_AUTO) {
 		VELOCITY_PRT(MSG_LEVEL_INFO, KERN_NOTICE "%s: Link autonegation", vptr->dev->name);
 
 		if (vptr->mii_status & VELOCITY_SPEED_1000)
@@ -1573,7 +1444,7 @@ static void velocity_print_link_status(s
 			VELOCITY_PRT(MSG_LEVEL_INFO, " half duplex\n");
 	} else {
 		VELOCITY_PRT(MSG_LEVEL_INFO, KERN_NOTICE "%s: Link forced", vptr->dev->name);
-		switch (vptr->options.spd_dpx) {
+		switch (vptr->options->spd_dpx) {
 		case SPD_DPX_100_HALF:
 			VELOCITY_PRT(MSG_LEVEL_INFO, " speed 100M bps half duplex\n");
 			break;
@@ -1623,7 +1494,7 @@ static void velocity_error(struct veloci
 		struct mac_regs __iomem * regs = vptr->mac_regs;
 		int linked;
 
-		if (vptr->options.spd_dpx == SPD_DPX_AUTO) {
+		if (vptr->options->spd_dpx == SPD_DPX_AUTO) {
 			vptr->mii_status = check_connection_type(regs);
 
 			/*
@@ -1986,7 +1857,7 @@ static int velocity_xmit(struct sk_buff 
 	}
 
 	if (vptr->flags & VELOCITY_FLAGS_TAGGING) {
-		td_ptr->tdesc1.pqinf.VID = (vptr->options.vid & 0xfff);
+		td_ptr->tdesc1.pqinf.VID = (vptr->options->vid & 0xfff);
 		td_ptr->tdesc1.pqinf.priority = 0;
 		td_ptr->tdesc1.pqinf.CFI = 0;
 		td_ptr->tdesc1.TCR |= TCR0_VETAG;
@@ -2009,10 +1880,10 @@ static int velocity_xmit(struct sk_buff 
 		int prev = index - 1;
 
 		if (prev < 0)
-			prev = vptr->options.numtx - 1;
+			prev = vptr->options->numtx - 1;
 		td_ptr->tdesc0.owner = OWNED_BY_NIC;
 		vptr->td_used[qnum]++;
-		vptr->td_curr[qnum] = (index + 1) % vptr->options.numtx;
+		vptr->td_curr[qnum] = (index + 1) % vptr->options->numtx;
 
 		if (AVAIL_TD(vptr, qnum) < 1)
 			netif_stop_queue(dev);
@@ -2071,7 +1942,7 @@ static int velocity_intr(int irq, void *
 		if (isr_status & (ISR_PTXI | ISR_PPTXI))
 			max_count += velocity_tx_srv(vptr, isr_status);
 		isr_status = mac_read_isr(vptr->mac_regs);
-		if (max_count > vptr->options.int_works)
+		if (max_count > vptr->options->int_works)
 		{
 			printk(KERN_WARNING "%s: excessive work at interrupt.\n", 
 				dev->name);
@@ -2220,13 +2091,14 @@ static int velocity_ioctl(struct net_dev
  */
  
 static struct pci_driver velocity_driver = {
-      .name	= VELOCITY_NAME,
-      .id_table	= velocity_id_table,
-      .probe	= velocity_found1,
-      .remove	= __devexit_p(velocity_remove1),
+      .name			= VELOCITY_NAME,
+      .id_table			= velocity_id_table,
+      .driver.dev_paramset_def	= &velocity_paramset_def,
+      .probe			= velocity_found1,
+      .remove			= __devexit_p(velocity_remove1),
 #ifdef CONFIG_PM
-      .suspend	= velocity_suspend,
-      .resume	= velocity_resume,
+      .suspend			= velocity_suspend,
+      .resume			= velocity_resume,
 #endif
 };
 
@@ -2484,7 +2356,7 @@ static u32 velocity_get_opt_media_mode(s
 {
 	u32 status = 0;
 
-	switch (vptr->options.spd_dpx) {
+	switch (vptr->options->spd_dpx) {
 	case SPD_DPX_AUTO:
 		status = VELOCITY_AUTONEG_ENABLE;
 		break;
@@ -2539,7 +2411,7 @@ static void mii_set_auto_off(struct velo
 static void set_mii_flow_control(struct velocity_info *vptr)
 {
 	/*Enable or Disable PAUSE in ANAR */
-	switch (vptr->options.flow_cntl) {
+	switch (vptr->options->flow_cntl) {
 	case FLOW_CNTL_TX:
 		MII_REG_BITS_OFF(ANAR_PAUSE, MII_REG_ANAR, vptr->mac_regs);
 		MII_REG_BITS_ON(ANAR_ASMDIR, MII_REG_ANAR, vptr->mac_regs);
@@ -2766,7 +2638,7 @@ static void enable_flow_control_ability(
 
 	struct mac_regs __iomem * regs = vptr->mac_regs;
 
-	switch (vptr->options.flow_cntl) {
+	switch (vptr->options->flow_cntl) {
 
 	case FLOW_CNTL_DEFAULT:
 		if (BYTE_REG_BITS_IS_ON(PHYSR0_RXFLC, &regs->PHYSR0))
Index: linux-devparam-export/drivers/net/via-velocity.h
===================================================================
--- linux-devparam-export.orig/drivers/net/via-velocity.h	2004-10-22 17:13:05.000000000 +0900
+++ linux-devparam-export/drivers/net/via-velocity.h	2004-10-23 11:09:33.000000000 +0900
@@ -33,9 +33,6 @@
 
 #define PKT_BUF_SZ          1540
 
-#define MAX_UNITS           8
-#define OPTION_DEFAULT      { [0 ... MAX_UNITS-1] = -1}
-
 #define REV_ID_VT6110       (0)
 
 #define BYTE_REG_BITS_ON(x,p)       do { writeb(readb((p))|(x),(p));} while (0)
@@ -1193,7 +1190,7 @@ struct velocity_info_tbl {
 	char *name;
 	int io_size;
 	int txqueue;
-	u32 flags;
+	unsigned flags;
 };
 
 #define mac_hw_mibs_init(regs) {\
@@ -1718,7 +1715,7 @@ enum velocity_flow_cntl_type {
 struct velocity_opt {
 	int numrx;			/* Number of RX descriptors */
 	int numtx;			/* Number of TX descriptors */
-	enum speed_opt spd_dpx;		/* Media link mode */
+	int spd_dpx;			/* Media link mode */
 	int vid;			/* vlan id */
 	int DMA_length;			/* DMA length */
 	int rx_thresh;			/* RX_THRESH */
@@ -1729,7 +1726,7 @@ struct velocity_opt {
 	int rx_bandwidth_hi;
 	int rx_bandwidth_lo;
 	int rx_bandwidth_en;
-	u32 flags;
+	unsigned flags;
 };
 
 struct velocity_info {
@@ -1755,7 +1752,7 @@ struct velocity_info {
 
 	u8 rev_id;
 
-#define AVAIL_TD(p,q)   ((p)->options.numtx-((p)->td_used[(q)]))
+#define AVAIL_TD(p,q)   ((p)->options->numtx-((p)->td_used[(q)]))
 
 	int num_txq;
 
@@ -1773,11 +1770,11 @@ struct velocity_info {
 
 #define GET_RD_BY_IDX(vptr, idx)   (vptr->rd_ring[idx])
 	u32 mib_counter[MAX_HW_MIB_COUNTER];
-	struct velocity_opt options;
+	struct velocity_opt *options;
 
 	u32 int_mask;
 
-	u32 flags;
+	unsigned flags;
 
 	int rx_buf_sz;
 	u32 mii_status;
@@ -1872,7 +1869,7 @@ static inline void init_flow_control_reg
 	writew(0xFFFF, &regs->tx_pause_timer);
 
 	/* Initialize RBRDU to Rx buffer count. */
-	writew(vptr->options.numrx, &regs->RBRDU);
+	writew(vptr->options->numrx, &regs->RBRDU);
 }
 
 
