Return-Path: <linux-kernel-owner+w=401wt.eu-S1752578AbWLSLgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbWLSLgX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 06:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754805AbWLSLgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 06:36:23 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:51197 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbWLSLgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 06:36:21 -0500
X-Originating-Ip: 24.148.236.183
Date: Tue, 19 Dec 2006 06:31:44 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Get rid of most of the remaining k*alloc() casts.
Message-ID: <Pine.LNX.4.64.0612190627020.22485@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.09, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	SARE_SUB_GETRID 0.56, TW_CF 0.08, TW_RR 0.08)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Get rid of the remaining obvious pointer casts of all k[cmz]alloc
calls, and do a little whitespace cleanup on the result, based on the
CodingStyle file.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  since this patch hits a range of files, i'm just throwing it out
there.  some folks might want to tweak it further.


 arch/cris/arch-v32/mm/intmem.c     |   12 +++++-------
 drivers/acpi/asus_acpi.c           |    3 +--
 drivers/acpi/hotkey.c              |    2 +-
 drivers/acpi/pci_bind.c            |    4 ++--
 drivers/acpi/pci_irq.c             |    2 +-
 drivers/block/DAC960.c             |   14 ++++++--------
 drivers/char/agp/sgi-agp.c         |    3 +--
 drivers/char/tty_io.c              |   12 ++++--------
 drivers/hid/hid-core.c             |    2 +-
 drivers/media/video/zoran_driver.c |    4 +---
 drivers/message/i2o/i2o_config.c   |    4 +---
 drivers/mtd/chips/amd_flash.c      |    2 +-
 drivers/mtd/maps/tqm834x.c         |    6 ++----
 drivers/mtd/maps/tqm8xxl.c         |    4 ++--
 drivers/net/gianfar.c              |   12 ++++++------
 drivers/net/ucc_geth.c             |   18 ++++++++----------
 drivers/net/wireless/ipw2100.c     |   17 ++++++-----------
 drivers/parisc/iosapic.c           |    4 ++--
 drivers/s390/net/ctcmain.c         |    3 +--
 drivers/scsi/advansys.c            |    9 +++------
 drivers/scsi/osst.c                |    3 +--
 drivers/serial/jsm/jsm_tty.c       |    6 +++---
 drivers/usb/host/ohci-pnx4008.c    |    2 +-
 drivers/usb/misc/auerswald.c       |    4 ++--
 fs/cifs/misc.c                     |    8 ++------
 fs/jfs/jfs_dtree.c                 |    6 ++----
 include/asm-um/thread_info.h       |    3 +--
 include/net/sctp/sctp.h            |    2 +-
 28 files changed, 68 insertions(+), 103 deletions(-)

diff --git a/arch/cris/arch-v32/mm/intmem.c b/arch/cris/arch-v32/mm/intmem.c
index 41ee7f7..3ed98a4 100644
--- a/arch/cris/arch-v32/mm/intmem.c
+++ b/arch/cris/arch-v32/mm/intmem.c
@@ -27,8 +27,8 @@ static void crisv32_intmem_init(void)
 {
 	static int initiated = 0;
 	if (!initiated) {
-		struct intmem_allocation* alloc =
-		  (struct intmem_allocation*)kmalloc(sizeof *alloc, GFP_KERNEL);
+		struct intmem_allocation* alloc =
+			kmalloc(sizeof(*alloc), GFP_KERNEL);
 		INIT_LIST_HEAD(&intmem_allocations);
 		intmem_virtual = ioremap(MEM_INTMEM_START, MEM_INTMEM_SIZE);
 		initiated = 1;
@@ -56,17 +56,15 @@ void* crisv32_intmem_alloc(unsigned size, unsigned align)
 		    allocation->size >= size + alignment) {
 			if (allocation->size > size + alignment) {
 				struct intmem_allocation* alloc =
-					(struct intmem_allocation*)
-					kmalloc(sizeof *alloc, GFP_ATOMIC);
+					kmalloc(sizeof(*alloc), GFP_ATOMIC);
 				alloc->status = STATUS_FREE;
 				alloc->size = allocation->size - size - alignment;
 				alloc->offset = allocation->offset + size;
 				list_add(&alloc->entry, &allocation->entry);

 				if (alignment) {
-					struct intmem_allocation* tmp;
-					tmp = (struct intmem_allocation*)
-						kmalloc(sizeof *tmp, GFP_ATOMIC);
+					struct intmem_allocation* tmp =
+						kmalloc(sizeof(*tmp), GFP_ATOMIC);
 					tmp->offset = allocation->offset;
 					tmp->size = alignment;
 					tmp->status = STATUS_FREE;
diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index c7ac929..b5b2158 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -1252,8 +1252,7 @@ static int asus_hotk_add(struct acpi_device *device)
 	printk(KERN_NOTICE "Asus Laptop ACPI Extras version %s\n",
 	       ASUS_ACPI_VERSION);

-	hotk =
-	    (struct asus_hotk *)kmalloc(sizeof(struct asus_hotk), GFP_KERNEL);
+	hotk = kmalloc(sizeof(struct asus_hotk), GFP_KERNEL);
 	if (!hotk)
 		return -ENOMEM;
 	memset(hotk, 0, sizeof(struct asus_hotk));
diff --git a/drivers/acpi/hotkey.c b/drivers/acpi/hotkey.c
index 1ba2db6..3d984d2 100644
--- a/drivers/acpi/hotkey.c
+++ b/drivers/acpi/hotkey.c
@@ -577,7 +577,7 @@ init_poll_hotkey_device(union acpi_hotkey *key, char **config_entry,
 	if (ACPI_FAILURE(status))
 		goto do_fail_zero;
 	key->poll_hotkey.poll_result =
-	    (union acpi_object *)kmalloc(sizeof(union acpi_object), GFP_KERNEL);
+	    kmalloc(sizeof(union acpi_object), GFP_KERNEL);
 	if (!key->poll_hotkey.poll_result)
 		goto do_fail_zero;
 	return AE_OK;
diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index 1e2ae6e..70b440f 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -281,7 +281,7 @@ int acpi_pci_unbind(struct acpi_device *device)
 	if (!device || !device->parent)
 		return -EINVAL;

-	pathname = (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
+	pathname = kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
 		return -ENOMEM;
 	memset(pathname, 0, ACPI_PATHNAME_MAX);
@@ -332,7 +332,7 @@ acpi_pci_bind_root(struct acpi_device *device,
 	struct acpi_buffer buffer = { 0, NULL };


-	pathname = (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
+	pathname = kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
 		return -ENOMEM;
 	memset(pathname, 0, ACPI_PATHNAME_MAX);
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index feda034..226892e 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -161,7 +161,7 @@ int acpi_pci_irq_add_prt(acpi_handle handle, int segment, int bus)
 	static int first_time = 1;


-	pathname = (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
+	pathname = kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
 		return -ENOMEM;
 	memset(pathname, 0, ACPI_PATHNAME_MAX);
diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index 8d81a3a..b3937e3 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -1879,8 +1879,7 @@ static boolean DAC960_V2_ReadControllerConfiguration(DAC960_Controller_T
       if (NewLogicalDeviceInfo->LogicalDeviceState !=
 	  DAC960_V2_LogicalDevice_Offline)
 	Controller->LogicalDriveInitiallyAccessible[LogicalDeviceNumber] = true;
-      LogicalDeviceInfo = (DAC960_V2_LogicalDeviceInfo_T *)
-	kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
+      LogicalDeviceInfo = kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
       if (LogicalDeviceInfo == NULL)
 	return DAC960_Failure(Controller, "LOGICAL DEVICE ALLOCATION");
       Controller->V2.LogicalDeviceInformation[LogicalDeviceNumber] =
@@ -2113,8 +2112,7 @@ static boolean DAC960_V2_ReadDeviceConfiguration(DAC960_Controller_T
       if (!DAC960_V2_NewPhysicalDeviceInfo(Controller, Channel, TargetID, LogicalUnit))
 	  break;

-      PhysicalDeviceInfo = (DAC960_V2_PhysicalDeviceInfo_T *)
-		kmalloc(sizeof(DAC960_V2_PhysicalDeviceInfo_T), GFP_ATOMIC);
+      PhysicalDeviceInfo = kmalloc(sizeof(DAC960_V2_PhysicalDeviceInfo_T), GFP_ATOMIC);
       if (PhysicalDeviceInfo == NULL)
 		return DAC960_Failure(Controller, "PHYSICAL DEVICE ALLOCATION");
       Controller->V2.PhysicalDeviceInformation[PhysicalDeviceIndex] =
@@ -2122,7 +2120,7 @@ static boolean DAC960_V2_ReadDeviceConfiguration(DAC960_Controller_T
       memcpy(PhysicalDeviceInfo, NewPhysicalDeviceInfo,
 		sizeof(DAC960_V2_PhysicalDeviceInfo_T));

-      InquiryUnitSerialNumber = (DAC960_SCSI_Inquiry_UnitSerialNumber_T *)
+      InquiryUnitSerialNumber =
 	kmalloc(sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T), GFP_ATOMIC);
       if (InquiryUnitSerialNumber == NULL) {
 	kfree(PhysicalDeviceInfo);
@@ -4949,7 +4947,7 @@ static void DAC960_V2_ProcessCompletedCommand(DAC960_Command_T *Command)
 	      PhysicalDevice.LogicalUnit = NewLogicalDeviceInfo->LogicalUnit;
 	      Controller->V2.LogicalDriveToVirtualDevice[LogicalDeviceNumber] =
 		PhysicalDevice;
-	      LogicalDeviceInfo = (DAC960_V2_LogicalDeviceInfo_T *)
+	      LogicalDeviceInfo =
 		kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
 	      Controller->V2.LogicalDeviceInformation[LogicalDeviceNumber] =
 		LogicalDeviceInfo;
@@ -5710,12 +5708,12 @@ static boolean DAC960_CheckStatusBuffer(DAC960_Controller_T *Controller,
       while (NewStatusBufferLength < ByteCount)
 	NewStatusBufferLength *= 2;
       Controller->CombinedStatusBuffer =
-	(unsigned char *) kmalloc(NewStatusBufferLength, GFP_ATOMIC);
+	kmalloc(NewStatusBufferLength, GFP_ATOMIC);
       if (Controller->CombinedStatusBuffer == NULL) return false;
       Controller->CombinedStatusBufferLength = NewStatusBufferLength;
       return true;
     }
-  NewStatusBuffer = (unsigned char *)
+  NewStatusBuffer =
     kmalloc(2 * Controller->CombinedStatusBufferLength, GFP_ATOMIC);
   if (NewStatusBuffer == NULL)
     {
diff --git a/drivers/char/agp/sgi-agp.c b/drivers/char/agp/sgi-agp.c
index d73be4c..7d47d6a 100644
--- a/drivers/char/agp/sgi-agp.c
+++ b/drivers/char/agp/sgi-agp.c
@@ -281,8 +281,7 @@ static int __devinit agp_sgi_init(void)
 	else
 		return 0;

-	sgi_tioca_agp_bridges =
-	    (struct agp_bridge_data **)kmalloc(tioca_gart_found *
+	sgi_tioca_agp_bridges = kmalloc(tioca_gart_found *
 					       sizeof(struct agp_bridge_data *),
 					       GFP_KERNEL);

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index 47a6eac..d1f2776 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -1932,16 +1932,14 @@ static int init_dev(struct tty_driver *driver, int idx,
 	}

 	if (!*tp_loc) {
-		tp = (struct ktermios *) kmalloc(sizeof(struct ktermios),
-						GFP_KERNEL);
+		tp = kmalloc(sizeof(*tp), GFP_KERNEL);
 		if (!tp)
 			goto free_mem_out;
 		*tp = driver->init_termios;
 	}

 	if (!*ltp_loc) {
-		ltp = (struct ktermios *) kmalloc(sizeof(struct ktermios),
-						 GFP_KERNEL);
+		ltp = kmalloc(sizeof(*ltp), GFP_KERNEL);
 		if (!ltp)
 			goto free_mem_out;
 		memset(ltp, 0, sizeof(struct ktermios));
@@ -1965,16 +1963,14 @@ static int init_dev(struct tty_driver *driver, int idx,
 		}

 		if (!*o_tp_loc) {
-			o_tp = (struct ktermios *)
-				kmalloc(sizeof(struct ktermios), GFP_KERNEL);
+			o_tp = kmalloc(sizeof(*o_tp), GFP_KERNEL);
 			if (!o_tp)
 				goto free_mem_out;
 			*o_tp = driver->other->init_termios;
 		}

 		if (!*o_ltp_loc) {
-			o_ltp = (struct ktermios *)
-				kmalloc(sizeof(struct ktermios), GFP_KERNEL);
+			o_ltp = kmalloc(sizeof(*o_ltp), GFP_KERNEL);
 			if (!o_ltp)
 				goto free_mem_out;
 			memset(o_ltp, 0, sizeof(struct ktermios));
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 18c2b3c..2fcfdbb 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -656,7 +656,7 @@ struct hid_device *hid_parse_report(__u8 *start, unsigned size)
 	for (i = 0; i < HID_REPORT_TYPES; i++)
 		INIT_LIST_HEAD(&device->report_enum[i].report_list);

-	if (!(device->rdesc = (__u8 *)kmalloc(size, GFP_KERNEL))) {
+	if (!(device->rdesc = kmalloc(size, GFP_KERNEL))) {
 		kfree(device->collection);
 		kfree(device);
 		return NULL;
diff --git a/drivers/media/video/zoran_driver.c b/drivers/media/video/zoran_driver.c
index 862a984..bc2956b 100644
--- a/drivers/media/video/zoran_driver.c
+++ b/drivers/media/video/zoran_driver.c
@@ -343,9 +343,7 @@ v4l_fbuffer_alloc (struct file *file)
 		if (fh->v4l_buffers.buffer_size <= MAX_KMALLOC_MEM) {
 			/* Use kmalloc */

-			mem =
-			    (unsigned char *) kmalloc(fh->v4l_buffers.
-						      buffer_size,
+			mem = kmalloc(fh->v4l_buffers.buffer_size,
 						      GFP_KERNEL);
 			if (mem == 0) {
 				dprintk(1,
diff --git a/drivers/message/i2o/i2o_config.c b/drivers/message/i2o/i2o_config.c
index e33d446..c37b504 100644
--- a/drivers/message/i2o/i2o_config.c
+++ b/drivers/message/i2o/i2o_config.c
@@ -1039,9 +1039,7 @@ static int i2o_cfg_ioctl(struct inode *inode, struct file *fp, unsigned int cmd,

 static int cfg_open(struct inode *inode, struct file *file)
 {
-	struct i2o_cfg_info *tmp =
-	    (struct i2o_cfg_info *)kmalloc(sizeof(struct i2o_cfg_info),
-					   GFP_KERNEL);
+	struct i2o_cfg_info *tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
 	unsigned long flags;

 	if (!tmp)
diff --git a/drivers/mtd/chips/amd_flash.c b/drivers/mtd/chips/amd_flash.c
index 16eaca6..7689155 100644
--- a/drivers/mtd/chips/amd_flash.c
+++ b/drivers/mtd/chips/amd_flash.c
@@ -643,7 +643,7 @@ static struct mtd_info *amd_flash_probe(struct map_info *map)
 	int reg_idx;
 	int offset;

-	mtd = (struct mtd_info*)kmalloc(sizeof(*mtd), GFP_KERNEL);
+	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);
 	if (!mtd) {
 		printk(KERN_WARNING
 		       "%s: kmalloc failed for info structure\n", map->name);
diff --git a/drivers/mtd/maps/tqm834x.c b/drivers/mtd/maps/tqm834x.c
index 58e5912..a5e331f 100644
--- a/drivers/mtd/maps/tqm834x.c
+++ b/drivers/mtd/maps/tqm834x.c
@@ -132,15 +132,13 @@ static int __init init_tqm834x_mtd(void)

 		pr_debug("%s: chip probing count %d\n", __FUNCTION__, idx);

-		map_banks[idx] =
-			(struct map_info *)kmalloc(sizeof(struct map_info),
-						   GFP_KERNEL);
+		map_banks[idx] = kmalloc(sizeof(struct map_info), GFP_KERNEL);
 		if (map_banks[idx] == NULL) {
 			ret = -ENOMEM;
 			goto error_mem;
 		}
 		memset((void *)map_banks[idx], 0, sizeof(struct map_info));
-		map_banks[idx]->name = (char *)kmalloc(16, GFP_KERNEL);
+		map_banks[idx]->name = kmalloc(16, GFP_KERNEL);
 		if (map_banks[idx]->name == NULL) {
 			ret = -ENOMEM;
 			goto error_mem;
diff --git a/drivers/mtd/maps/tqm8xxl.c b/drivers/mtd/maps/tqm8xxl.c
index 19578ba..73f2245 100644
--- a/drivers/mtd/maps/tqm8xxl.c
+++ b/drivers/mtd/maps/tqm8xxl.c
@@ -134,7 +134,7 @@ int __init init_tqm_mtd(void)

 		printk(KERN_INFO "%s: chip probing count %d\n", __FUNCTION__, idx);

-		map_banks[idx] = (struct map_info *)kmalloc(sizeof(struct map_info), GFP_KERNEL);
+		map_banks[idx] = kmalloc(sizeof(struct map_info), GFP_KERNEL);
 		if(map_banks[idx] == NULL) {
 			ret = -ENOMEM;
 			/* FIXME: What if some MTD devices were probed already? */
@@ -142,7 +142,7 @@ int __init init_tqm_mtd(void)
 		}

 		memset((void *)map_banks[idx], 0, sizeof(struct map_info));
-		map_banks[idx]->name = (char *)kmalloc(16, GFP_KERNEL);
+		map_banks[idx]->name = kmalloc(16, GFP_KERNEL);

 		if (!map_banks[idx]->name) {
 			ret = -ENOMEM;
diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index baa3514..c3052c2 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -702,9 +702,9 @@ int startup_gfar(struct net_device *dev)
 	gfar_write(&regs->rbase0, addr);

 	/* Setup the skbuff rings */
-	priv->tx_skbuff =
-	    (struct sk_buff **) kmalloc(sizeof (struct sk_buff *) *
-					priv->tx_ring_size, GFP_KERNEL);
+	priv->tx_skbuff = kmalloc(sizeof (struct sk_buff *) *
+					priv->tx_ring_size,
+					GFP_KERNEL);

 	if (NULL == priv->tx_skbuff) {
 		if (netif_msg_ifup(priv))
@@ -717,9 +717,9 @@ int startup_gfar(struct net_device *dev)
 	for (i = 0; i < priv->tx_ring_size; i++)
 		priv->tx_skbuff[i] = NULL;

-	priv->rx_skbuff =
-	    (struct sk_buff **) kmalloc(sizeof (struct sk_buff *) *
-					priv->rx_ring_size, GFP_KERNEL);
+	priv->rx_skbuff = kmalloc(sizeof (struct sk_buff *) *
+					priv->rx_ring_size,
+					GFP_KERNEL);

 	if (NULL == priv->rx_skbuff) {
 		if (netif_msg_ifup(priv))
diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 8243150..72f4438 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -2926,10 +2926,9 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	/* Init Tx bds */
 	for (j = 0; j < ug_info->numQueuesTx; j++) {
 		/* Setup the skbuff rings */
-		ugeth->tx_skbuff[j] =
-		    (struct sk_buff **)kmalloc(sizeof(struct sk_buff *) *
-					       ugeth->ug_info->bdRingLenTx[j],
-					       GFP_KERNEL);
+		ugeth->tx_skbuff[j] = kmalloc(sizeof(struct sk_buff *) *
+						ugeth->ug_info->bdRingLenTx[j],
+						GFP_KERNEL);

 		if (ugeth->tx_skbuff[j] == NULL) {
 			ugeth_err("%s: Could not allocate tx_skbuff",
@@ -2958,10 +2957,9 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	/* Init Rx bds */
 	for (j = 0; j < ug_info->numQueuesRx; j++) {
 		/* Setup the skbuff rings */
-		ugeth->rx_skbuff[j] =
-		    (struct sk_buff **)kmalloc(sizeof(struct sk_buff *) *
-					       ugeth->ug_info->bdRingLenRx[j],
-					       GFP_KERNEL);
+		ugeth->rx_skbuff[j] = kmalloc(sizeof(struct sk_buff *) *
+						ugeth->ug_info->bdRingLenRx[j],
+						GFP_KERNEL);

 		if (ugeth->rx_skbuff[j] == NULL) {
 			ugeth_err("%s: Could not allocate rx_skbuff",
@@ -3452,8 +3450,8 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	 * allocated resources can be released when the channel is freed.
 	 */
 	if (!(ugeth->p_init_enet_param_shadow =
-	     (struct ucc_geth_init_pram *) kmalloc(sizeof(struct ucc_geth_init_pram),
-					      GFP_KERNEL))) {
+	     kmalloc(sizeof(struct ucc_geth_init_pram),
+				GFP_KERNEL))) {
 		ugeth_err
 		    ("%s: Can not allocate memory for"
 			" p_UccInitEnetParamShadows.", __FUNCTION__);
diff --git a/drivers/net/wireless/ipw2100.c b/drivers/net/wireless/ipw2100.c
index 0e94fbb..146ff04 100644
--- a/drivers/net/wireless/ipw2100.c
+++ b/drivers/net/wireless/ipw2100.c
@@ -3362,10 +3362,8 @@ static int ipw2100_msg_allocate(struct ipw2100_priv *priv)
 	dma_addr_t p;

 	priv->msg_buffers =
-	    (struct ipw2100_tx_packet *)kmalloc(IPW_COMMAND_POOL_SIZE *
-						sizeof(struct
-						       ipw2100_tx_packet),
-						GFP_KERNEL);
+	    kmalloc(IPW_COMMAND_POOL_SIZE * sizeof(struct ipw2100_tx_packet),
+				GFP_KERNEL);
 	if (!priv->msg_buffers) {
 		printk(KERN_ERR DRV_NAME ": %s: PCI alloc failed for msg "
 		       "buffers.\n", priv->net_dev->name);
@@ -4396,10 +4394,8 @@ static int ipw2100_tx_allocate(struct ipw2100_priv *priv)
 	}

 	priv->tx_buffers =
-	    (struct ipw2100_tx_packet *)kmalloc(TX_PENDED_QUEUE_LENGTH *
-						sizeof(struct
-						       ipw2100_tx_packet),
-						GFP_ATOMIC);
+	    kmalloc(TX_PENDED_QUEUE_LENGTH * sizeof(struct ipw2100_tx_packet),
+				GFP_ATOMIC);
 	if (!priv->tx_buffers) {
 		printk(KERN_ERR DRV_NAME
 		       ": %s: alloc failed form tx buffers.\n",
@@ -4548,9 +4544,8 @@ static int ipw2100_rx_allocate(struct ipw2100_priv *priv)
 	/*
 	 * allocate packets
 	 */
-	priv->rx_buffers = (struct ipw2100_rx_packet *)
-	    kmalloc(RX_QUEUE_LENGTH * sizeof(struct ipw2100_rx_packet),
-		    GFP_KERNEL);
+	priv->rx_buffers = kmalloc(RX_QUEUE_LENGTH * sizeof(struct ipw2100_rx_packet),
+		    		GFP_KERNEL);
 	if (!priv->rx_buffers) {
 		IPW_DEBUG_INFO("can't allocate rx packet buffer table\n");

diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index 6fb3f79..bcbb7a8 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -885,8 +885,8 @@ void *iosapic_register(unsigned long hpa)
 	isi->isi_version = iosapic_rd_version(isi);
 	isi->isi_num_vectors = IOSAPIC_IRDT_MAX_ENTRY(isi->isi_version) + 1;

-	vip = isi->isi_vector = (struct vector_info *)
-		kzalloc(sizeof(struct vector_info) * isi->isi_num_vectors, GFP_KERNEL);
+	vip = isi->isi_vector =
+		kzalloc(sizeof(*vip) * isi->isi_num_vectors, GFP_KERNEL);
 	if (vip == NULL) {
 		kfree(isi);
 		return NULL;
diff --git a/drivers/s390/net/ctcmain.c b/drivers/s390/net/ctcmain.c
index 03cc263..9a7ffcc 100644
--- a/drivers/s390/net/ctcmain.c
+++ b/drivers/s390/net/ctcmain.c
@@ -1639,8 +1639,7 @@ add_channel(struct ccw_device *cdev, enum channel_types type)
 	struct channel *ch;

 	DBF_TEXT(trace, 2, __FUNCTION__);
-	if ((ch =
-	     (struct channel *) kmalloc(sizeof (struct channel),
+	if ((ch = kmalloc(sizeof (struct channel),
 					GFP_KERNEL)) == NULL) {
 		ctc_pr_warn("ctc: Out of memory in add_channel\n");
 		return -1;
diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 2b34435..df76b7c 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -5256,8 +5256,7 @@ advansys_detect(struct scsi_host_template *tpnt)
                  * Allocate buffer carrier structures. The total size
                  * is about 4 KB, so allocate all at once.
                  */
-                carrp =
-                    (ADV_CARR_T *) kmalloc(ADV_CARRIER_BUFSIZE, GFP_ATOMIC);
+                carrp = kmalloc(ADV_CARRIER_BUFSIZE, GFP_ATOMIC);
                 ASC_DBG1(1, "advansys_detect: carrp 0x%lx\n", (ulong) carrp);

                 if (carrp == NULL) {
@@ -5273,8 +5272,7 @@ advansys_detect(struct scsi_host_template *tpnt)
                 for (req_cnt = adv_dvc_varp->max_host_qng;
                     req_cnt > 0; req_cnt--) {

-                    reqp = (adv_req_t *)
-                        kmalloc(sizeof(adv_req_t) * req_cnt, GFP_ATOMIC);
+                    reqp = kmalloc(sizeof(adv_req_t) * req_cnt, GFP_ATOMIC);

                     ASC_DBG3(1,
                         "advansys_detect: reqp 0x%lx, req_cnt %d, bytes %lu\n",
@@ -5297,8 +5295,7 @@ advansys_detect(struct scsi_host_template *tpnt)
                 boardp->adv_sgblkp = NULL;
                 for (sg_cnt = 0; sg_cnt < ADV_TOT_SG_BLOCK; sg_cnt++) {

-                    sgp = (adv_sgblk_t *)
-                        kmalloc(sizeof(adv_sgblk_t), GFP_ATOMIC);
+                    sgp = kmalloc(sizeof(adv_sgblk_t), GFP_ATOMIC);

                     if (sgp == NULL) {
                         break;
diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
index 7d23110..f5f679e 100644
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -5754,8 +5754,7 @@ static int osst_probe(struct device *dev)
 	/* if this is the first attach, build the infrastructure */
 	write_lock(&os_scsi_tapes_lock);
 	if (os_scsi_tapes == NULL) {
-		os_scsi_tapes =
-			(struct osst_tape **)kmalloc(osst_max_dev * sizeof(struct osst_tape *),
+		os_scsi_tapes = kmalloc(osst_max_dev * sizeof(struct osst_tape *),
 				   GFP_ATOMIC);
 		if (os_scsi_tapes == NULL) {
 			write_unlock(&os_scsi_tapes_lock);
diff --git a/drivers/serial/jsm/jsm_tty.c b/drivers/serial/jsm/jsm_tty.c
index 7cf1c60..610290a 100644
--- a/drivers/serial/jsm/jsm_tty.c
+++ b/drivers/serial/jsm/jsm_tty.c
@@ -194,7 +194,7 @@ static int jsm_tty_open(struct uart_port *port)
 	/* Drop locks, as malloc with GFP_KERNEL can sleep */

 	if (!channel->ch_rqueue) {
-		channel->ch_rqueue = (u8 *) kmalloc(RQUEUESIZE, GFP_KERNEL);
+		channel->ch_rqueue = kmalloc(RQUEUESIZE, GFP_KERNEL);
 		if (!channel->ch_rqueue) {
 			jsm_printk(INIT, ERR, &channel->ch_bd->pci_dev,
 				"unable to allocate read queue buf");
@@ -203,7 +203,7 @@ static int jsm_tty_open(struct uart_port *port)
 		memset(channel->ch_rqueue, 0, RQUEUESIZE);
 	}
 	if (!channel->ch_equeue) {
-		channel->ch_equeue = (u8 *) kmalloc(EQUEUESIZE, GFP_KERNEL);
+		channel->ch_equeue = kmalloc(EQUEUESIZE, GFP_KERNEL);
 		if (!channel->ch_equeue) {
 			jsm_printk(INIT, ERR, &channel->ch_bd->pci_dev,
 				"unable to allocate error queue buf");
@@ -212,7 +212,7 @@ static int jsm_tty_open(struct uart_port *port)
 		memset(channel->ch_equeue, 0, EQUEUESIZE);
 	}
 	if (!channel->ch_wqueue) {
-		channel->ch_wqueue = (u8 *) kmalloc(WQUEUESIZE, GFP_KERNEL);
+		channel->ch_wqueue = kmalloc(WQUEUESIZE, GFP_KERNEL);
 		if (!channel->ch_wqueue) {
 			jsm_printk(INIT, ERR, &channel->ch_bd->pci_dev,
 				"unable to allocate write queue buf");
diff --git a/drivers/usb/host/ohci-pnx4008.c b/drivers/usb/host/ohci-pnx4008.c
index 7f26f9b..07279b0 100644
--- a/drivers/usb/host/ohci-pnx4008.c
+++ b/drivers/usb/host/ohci-pnx4008.c
@@ -134,7 +134,7 @@ static int isp1301_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	struct i2c_client *c;

-	c = (struct i2c_client *)kzalloc(sizeof(*c), GFP_KERNEL);
+	c = kzalloc(sizeof(*c), GFP_KERNEL);

 	if (!c)
 		return -ENOMEM;
diff --git a/drivers/usb/misc/auerswald.c b/drivers/usb/misc/auerswald.c
index 6c7f3ef..f5fc4b3 100644
--- a/drivers/usb/misc/auerswald.c
+++ b/drivers/usb/misc/auerswald.c
@@ -1376,7 +1376,7 @@ static int auerchar_open (struct inode *inode, struct file *file)
 	}

 	/* we have access to the device. Now lets allocate memory */
-	ccp = (pauerchar_t) kmalloc(sizeof(auerchar_t), GFP_KERNEL);
+	ccp = kmalloc(sizeof(*ccp), GFP_KERNEL);
 	if (ccp == NULL) {
 		err ("out of memory");
 		ret = -ENOMEM;
@@ -1912,7 +1912,7 @@ static int auerswald_probe (struct usb_interface *intf,
 		return -ENODEV;

 	/* allocate memory for our device and initialize it */
-	cp = kmalloc (sizeof(auerswald_t), GFP_KERNEL);
+	cp = kmalloc(sizeof(*cp), GFP_KERNEL);
 	if (cp == NULL) {
 		err ("out of memory");
 		goto pfail;
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index aedf683..84f4032 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -71,9 +71,7 @@ sesInfoAlloc(void)
 {
 	struct cifsSesInfo *ret_buf;

-	ret_buf =
-	    (struct cifsSesInfo *) kzalloc(sizeof (struct cifsSesInfo),
-					   GFP_KERNEL);
+	ret_buf = kzalloc(sizeof(*ret_buf), GFP_KERNEL);
 	if (ret_buf) {
 		write_lock(&GlobalSMBSeslock);
 		atomic_inc(&sesInfoAllocCount);
@@ -109,9 +107,7 @@ struct cifsTconInfo *
 tconInfoAlloc(void)
 {
 	struct cifsTconInfo *ret_buf;
-	ret_buf =
-	    (struct cifsTconInfo *) kzalloc(sizeof (struct cifsTconInfo),
-					    GFP_KERNEL);
+	ret_buf = kzalloc(sizeof(*ret_buf), GFP_KERNEL);
 	if (ret_buf) {
 		write_lock(&GlobalSMBSeslock);
 		atomic_inc(&tconInfoAllocCount);
diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 6d62f32..d235881 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -592,8 +592,7 @@ int dtSearch(struct inode *ip, struct component_name * key, ino_t * data,
 	struct component_name ciKey;
 	struct super_block *sb = ip->i_sb;

-	ciKey.name =
-	    (wchar_t *) kmalloc((JFS_NAME_MAX + 1) * sizeof(wchar_t),
+	ciKey.name = kmalloc((JFS_NAME_MAX + 1) * sizeof(wchar_t),
 				GFP_NOFS);
 	if (ciKey.name == 0) {
 		rc = -ENOMEM;
@@ -957,8 +956,7 @@ static int dtSplitUp(tid_t tid,
 	smp = split->mp;
 	sp = DT_PAGE(ip, smp);

-	key.name =
-	    (wchar_t *) kmalloc((JFS_NAME_MAX + 2) * sizeof(wchar_t),
+	key.name = kmalloc((JFS_NAME_MAX + 2) * sizeof(wchar_t),
 				GFP_NOFS);
 	if (key.name == 0) {
 		DT_PUTPAGE(smp);
diff --git a/include/asm-um/thread_info.h b/include/asm-um/thread_info.h
index 261e2f4..e43c2dd 100644
--- a/include/asm-um/thread_info.h
+++ b/include/asm-um/thread_info.h
@@ -51,8 +51,7 @@ static inline struct thread_info *current_thread_info(void)
 }

 /* thread information allocation */
-#define alloc_thread_info(tsk) \
-	((struct thread_info *) kmalloc(THREAD_SIZE, GFP_KERNEL))
+#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL))
 #define free_thread_info(ti) kfree(ti)

 #endif
diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index c818f87..b20567f 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -539,7 +539,7 @@ for (pos = chunk->subh.fwdtsn_hdr->skip;\
 #define WORD_ROUND(s) (((s)+3)&~3)

 /* Make a new instance of type.  */
-#define t_new(type, flags)	(type *)kmalloc(sizeof(type), flags)
+#define t_new(type, flags)	kmalloc(sizeof(type), flags)

 /* Compare two timevals.  */
 #define tv_lt(s, t) \
