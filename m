Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVLLSuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVLLSuh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 13:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVLLSug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 13:50:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43612 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932127AbVLLSuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 13:50:35 -0500
Date: Mon, 12 Dec 2005 19:51:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Nathan Lynch <ntl@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Brian King <brking@us.ibm.com>
Subject: Re: Memory corruption & SCSI in 2.6.15
Message-ID: <20051212185135.GB12024@suse.de>
References: <1134371606.6989.95.camel@gaston> <Pine.LNX.4.64.0512120909460.15597@g5.osdl.org> <20051212183201.GA19599@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212183201.GA19599@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12 2005, Nathan Lynch wrote:
> Linus Torvalds wrote:
> > 
> > On Mon, 12 Dec 2005, Benjamin Herrenschmidt wrote:
> > > 
> > > Current -git as of today (that is 2.6.15-rc5 + the batch of fixes Linus
> > > pulled after his return) was dying in weird ways for me on POWER5. I had
> > > the good idea to activate slab debugging, and I now see it detecting
> > > slab corruption as soon as the IPR driver initializes.
> > > 
> > > Since I remember seeing a discussion somewhere on a list between Brian
> > > King and Jens Axboe about use-after-free problems in SCSI and possible
> > > other niceties of that sort, I though it might be related...
> > > 
> > > Anything I can do to help track this down ?
> > 
> > If it's easily repeatable, doing a "git bisect" to see when it starts 
> > happening is the obvious big sledge-hammer thing to try. Even if you don't 
> > bisect all the way, just narrowing it down a bit more might help.
> 
> I manually narrowed this down to between 2.6.14-git14 (good) and
> 2.6.15-rc1 (bad).  Will try git bisection later today.
> 
> > There's a raid1 use-after-free bugfix that I just merged and pushed out, 
> > but I doubt that one is relevant. But you might try to update.
> 
> FWIW, I'm hitting this in a non-raid setup.

There's a pretty big ipr update between those two revisions, at least
benh seemed to be using ipr dunno about you. So you may want to try with
this backed out.

diff -urp linux-2.6.14-git14/drivers/scsi/ipr.c linux-2.6.15-rc1/drivers/scsi/ipr.c
--- linux-2.6.14-git14/drivers/scsi/ipr.c	2005-12-12 19:42:03.000000000 +0100
+++ linux-2.6.15-rc1/drivers/scsi/ipr.c	2005-11-12 02:43:36.000000000 +0100
@@ -91,11 +91,14 @@ static unsigned int ipr_max_speed = 1;
 static int ipr_testmode = 0;
 static unsigned int ipr_fastfail = 0;
 static unsigned int ipr_transop_timeout = IPR_OPERATIONAL_TIMEOUT;
+static unsigned int ipr_enable_cache = 1;
+static unsigned int ipr_debug = 0;
+static int ipr_auto_create = 1;
 static DEFINE_SPINLOCK(ipr_driver_lock);
 
 /* This table describes the differences between DMA controller chips */
 static const struct ipr_chip_cfg_t ipr_chip_cfg[] = {
-	{ /* Gemstone and Citrine */
+	{ /* Gemstone, Citrine, and Obsidian */
 		.mailbox = 0x0042C,
 		.cache_line_size = 0x20,
 		{
@@ -130,6 +133,8 @@ static const struct ipr_chip_cfg_t ipr_c
 static const struct ipr_chip_t ipr_chip[] = {
 	{ PCI_VENDOR_ID_MYLEX, PCI_DEVICE_ID_IBM_GEMSTONE, &ipr_chip_cfg[0] },
 	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_CITRINE, &ipr_chip_cfg[0] },
+	{ PCI_VENDOR_ID_ADAPTEC2, PCI_DEVICE_ID_ADAPTEC2_OBSIDIAN, &ipr_chip_cfg[0] },
+	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_OBSIDIAN, &ipr_chip_cfg[0] },
 	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_SNIPE, &ipr_chip_cfg[1] },
 	{ PCI_VENDOR_ID_ADAPTEC2, PCI_DEVICE_ID_ADAPTEC2_SCAMP, &ipr_chip_cfg[1] }
 };
@@ -150,6 +155,12 @@ module_param_named(fastfail, ipr_fastfai
 MODULE_PARM_DESC(fastfail, "Reduce timeouts and retries");
 module_param_named(transop_timeout, ipr_transop_timeout, int, 0);
 MODULE_PARM_DESC(transop_timeout, "Time in seconds to wait for adapter to come operational (default: 300)");
+module_param_named(enable_cache, ipr_enable_cache, int, 0);
+MODULE_PARM_DESC(enable_cache, "Enable adapter's non-volatile write cache (default: 1)");
+module_param_named(debug, ipr_debug, int, 0);
+MODULE_PARM_DESC(debug, "Enable device driver debugging logging. Set to 1 to enable. (default: 0)");
+module_param_named(auto_create, ipr_auto_create, int, 0);
+MODULE_PARM_DESC(auto_create, "Auto-create single device RAID 0 arrays when initialized (default: 1)");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(IPR_DRIVER_VERSION);
 
@@ -285,12 +296,18 @@ struct ipr_error_table_t ipr_error_table
 	"3110: Device bus error, message or command phase"},
 	{0x04670400, 0, 1,
 	"9091: Incorrect hardware configuration change has been detected"},
+	{0x04678000, 0, 1,
+	"9073: Invalid multi-adapter configuration"},
 	{0x046E0000, 0, 1,
 	"FFF4: Command to logical unit failed"},
 	{0x05240000, 1, 0,
 	"Illegal request, invalid request type or request packet"},
 	{0x05250000, 0, 0,
 	"Illegal request, invalid resource handle"},
+	{0x05258000, 0, 0,
+	"Illegal request, commands not allowed to this device"},
+	{0x05258100, 0, 0,
+	"Illegal request, command not allowed to a secondary adapter"},
 	{0x05260000, 0, 0,
 	"Illegal request, invalid field in parameter list"},
 	{0x05260100, 0, 0,
@@ -299,6 +316,8 @@ struct ipr_error_table_t ipr_error_table
 	"Illegal request, parameter value invalid"},
 	{0x052C0000, 0, 0,
 	"Illegal request, command sequence error"},
+	{0x052C8000, 1, 0,
+	"Illegal request, dual adapter support not enabled"},
 	{0x06040500, 0, 1,
 	"9031: Array protection temporarily suspended, protection resuming"},
 	{0x06040600, 0, 1,
@@ -315,18 +334,26 @@ struct ipr_error_table_t ipr_error_table
 	"3029: A device replacement has occurred"},
 	{0x064C8000, 0, 1,
 	"9051: IOA cache data exists for a missing or failed device"},
+	{0x064C8100, 0, 1,
+	"9055: Auxiliary cache IOA contains cache data needed by the primary IOA"},
 	{0x06670100, 0, 1,
 	"9025: Disk unit is not supported at its physical location"},
 	{0x06670600, 0, 1,
 	"3020: IOA detected a SCSI bus configuration error"},
 	{0x06678000, 0, 1,
 	"3150: SCSI bus configuration error"},
+	{0x06678100, 0, 1,
+	"9074: Asymmetric advanced function disk configuration"},
 	{0x06690200, 0, 1,
 	"9041: Array protection temporarily suspended"},
 	{0x06698200, 0, 1,
 	"9042: Corrupt array parity detected on specified device"},
 	{0x066B0200, 0, 1,
 	"9030: Array no longer protected due to missing or failed disk unit"},
+	{0x066B8000, 0, 1,
+	"9071: Link operational transition"},
+	{0x066B8100, 0, 1,
+	"9072: Link not operational transition"},
 	{0x066B8200, 0, 1,
 	"9032: Array exposed but still protected"},
 	{0x07270000, 0, 0,
@@ -789,7 +816,7 @@ static void ipr_send_hcam(struct ipr_ioa
  **/
 static void ipr_init_res_entry(struct ipr_resource_entry *res)
 {
-	res->needs_sync_complete = 1;
+	res->needs_sync_complete = 0;
 	res->in_erp = 0;
 	res->add_to_ml = 0;
 	res->del_from_ml = 0;
@@ -889,29 +916,74 @@ static void ipr_process_ccn(struct ipr_c
 
 /**
  * ipr_log_vpd - Log the passed VPD to the error log.
- * @vpids:			vendor/product id struct
- * @serial_num:		serial number string
+ * @vpd:		vendor/product id/sn struct
  *
  * Return value:
  * 	none
  **/
-static void ipr_log_vpd(struct ipr_std_inq_vpids *vpids, u8 *serial_num)
+static void ipr_log_vpd(struct ipr_vpd *vpd)
 {
 	char buffer[IPR_VENDOR_ID_LEN + IPR_PROD_ID_LEN
 		    + IPR_SERIAL_NUM_LEN];
 
-	memcpy(buffer, vpids->vendor_id, IPR_VENDOR_ID_LEN);
-	memcpy(buffer + IPR_VENDOR_ID_LEN, vpids->product_id,
+	memcpy(buffer, vpd->vpids.vendor_id, IPR_VENDOR_ID_LEN);
+	memcpy(buffer + IPR_VENDOR_ID_LEN, vpd->vpids.product_id,
 	       IPR_PROD_ID_LEN);
 	buffer[IPR_VENDOR_ID_LEN + IPR_PROD_ID_LEN] = '\0';
 	ipr_err("Vendor/Product ID: %s\n", buffer);
 
-	memcpy(buffer, serial_num, IPR_SERIAL_NUM_LEN);
+	memcpy(buffer, vpd->sn, IPR_SERIAL_NUM_LEN);
 	buffer[IPR_SERIAL_NUM_LEN] = '\0';
 	ipr_err("    Serial Number: %s\n", buffer);
 }
 
 /**
+ * ipr_log_ext_vpd - Log the passed extended VPD to the error log.
+ * @vpd:		vendor/product id/sn/wwn struct
+ *
+ * Return value:
+ * 	none
+ **/
+static void ipr_log_ext_vpd(struct ipr_ext_vpd *vpd)
+{
+	ipr_log_vpd(&vpd->vpd);
+	ipr_err("    WWN: %08X%08X\n", be32_to_cpu(vpd->wwid[0]),
+		be32_to_cpu(vpd->wwid[1]));
+}
+
+/**
+ * ipr_log_enhanced_cache_error - Log a cache error.
+ * @ioa_cfg:	ioa config struct
+ * @hostrcb:	hostrcb struct
+ *
+ * Return value:
+ * 	none
+ **/
+static void ipr_log_enhanced_cache_error(struct ipr_ioa_cfg *ioa_cfg,
+					 struct ipr_hostrcb *hostrcb)
+{
+	struct ipr_hostrcb_type_12_error *error =
+		&hostrcb->hcam.u.error.u.type_12_error;
+
+	ipr_err("-----Current Configuration-----\n");
+	ipr_err("Cache Directory Card Information:\n");
+	ipr_log_ext_vpd(&error->ioa_vpd);
+	ipr_err("Adapter Card Information:\n");
+	ipr_log_ext_vpd(&error->cfc_vpd);
+
+	ipr_err("-----Expected Configuration-----\n");
+	ipr_err("Cache Directory Card Information:\n");
+	ipr_log_ext_vpd(&error->ioa_last_attached_to_cfc_vpd);
+	ipr_err("Adapter Card Information:\n");
+	ipr_log_ext_vpd(&error->cfc_last_attached_to_ioa_vpd);
+
+	ipr_err("Additional IOA Data: %08X %08X %08X\n",
+		     be32_to_cpu(error->ioa_data[0]),
+		     be32_to_cpu(error->ioa_data[1]),
+		     be32_to_cpu(error->ioa_data[2]));
+}
+
+/**
  * ipr_log_cache_error - Log a cache error.
  * @ioa_cfg:	ioa config struct
  * @hostrcb:	hostrcb struct
@@ -927,17 +999,15 @@ static void ipr_log_cache_error(struct i
 
 	ipr_err("-----Current Configuration-----\n");
 	ipr_err("Cache Directory Card Information:\n");
-	ipr_log_vpd(&error->ioa_vpids, error->ioa_sn);
+	ipr_log_vpd(&error->ioa_vpd);
 	ipr_err("Adapter Card Information:\n");
-	ipr_log_vpd(&error->cfc_vpids, error->cfc_sn);
+	ipr_log_vpd(&error->cfc_vpd);
 
 	ipr_err("-----Expected Configuration-----\n");
 	ipr_err("Cache Directory Card Information:\n");
-	ipr_log_vpd(&error->ioa_last_attached_to_cfc_vpids,
-		    error->ioa_last_attached_to_cfc_sn);
+	ipr_log_vpd(&error->ioa_last_attached_to_cfc_vpd);
 	ipr_err("Adapter Card Information:\n");
-	ipr_log_vpd(&error->cfc_last_attached_to_ioa_vpids,
-		    error->cfc_last_attached_to_ioa_sn);
+	ipr_log_vpd(&error->cfc_last_attached_to_ioa_vpd);
 
 	ipr_err("Additional IOA Data: %08X %08X %08X\n",
 		     be32_to_cpu(error->ioa_data[0]),
@@ -946,6 +1016,46 @@ static void ipr_log_cache_error(struct i
 }
 
 /**
+ * ipr_log_enhanced_config_error - Log a configuration error.
+ * @ioa_cfg:	ioa config struct
+ * @hostrcb:	hostrcb struct
+ *
+ * Return value:
+ * 	none
+ **/
+static void ipr_log_enhanced_config_error(struct ipr_ioa_cfg *ioa_cfg,
+					  struct ipr_hostrcb *hostrcb)
+{
+	int errors_logged, i;
+	struct ipr_hostrcb_device_data_entry_enhanced *dev_entry;
+	struct ipr_hostrcb_type_13_error *error;
+
+	error = &hostrcb->hcam.u.error.u.type_13_error;
+	errors_logged = be32_to_cpu(error->errors_logged);
+
+	ipr_err("Device Errors Detected/Logged: %d/%d\n",
+		be32_to_cpu(error->errors_detected), errors_logged);
+
+	dev_entry = error->dev;
+
+	for (i = 0; i < errors_logged; i++, dev_entry++) {
+		ipr_err_separator;
+
+		ipr_phys_res_err(ioa_cfg, dev_entry->dev_res_addr, "Device %d", i + 1);
+		ipr_log_ext_vpd(&dev_entry->vpd);
+
+		ipr_err("-----New Device Information-----\n");
+		ipr_log_ext_vpd(&dev_entry->new_vpd);
+
+		ipr_err("Cache Directory Card Information:\n");
+		ipr_log_ext_vpd(&dev_entry->ioa_last_with_dev_vpd);
+
+		ipr_err("Adapter Card Information:\n");
+		ipr_log_ext_vpd(&dev_entry->cfc_last_with_dev_vpd);
+	}
+}
+
+/**
  * ipr_log_config_error - Log a configuration error.
  * @ioa_cfg:	ioa config struct
  * @hostrcb:	hostrcb struct
@@ -966,30 +1076,22 @@ static void ipr_log_config_error(struct 
 	ipr_err("Device Errors Detected/Logged: %d/%d\n",
 		be32_to_cpu(error->errors_detected), errors_logged);
 
-	dev_entry = error->dev_entry;
+	dev_entry = error->dev;
 
 	for (i = 0; i < errors_logged; i++, dev_entry++) {
 		ipr_err_separator;
 
-		if (dev_entry->dev_res_addr.bus >= IPR_MAX_NUM_BUSES) {
-			ipr_err("Device %d: missing\n", i + 1);
-		} else {
-			ipr_err("Device %d: %d:%d:%d:%d\n", i + 1,
-				ioa_cfg->host->host_no, dev_entry->dev_res_addr.bus,
-				dev_entry->dev_res_addr.target, dev_entry->dev_res_addr.lun);
-		}
-		ipr_log_vpd(&dev_entry->dev_vpids, dev_entry->dev_sn);
+		ipr_phys_res_err(ioa_cfg, dev_entry->dev_res_addr, "Device %d", i + 1);
+		ipr_log_vpd(&dev_entry->vpd);
 
 		ipr_err("-----New Device Information-----\n");
-		ipr_log_vpd(&dev_entry->new_dev_vpids, dev_entry->new_dev_sn);
+		ipr_log_vpd(&dev_entry->new_vpd);
 
 		ipr_err("Cache Directory Card Information:\n");
-		ipr_log_vpd(&dev_entry->ioa_last_with_dev_vpids,
-			    dev_entry->ioa_last_with_dev_sn);
+		ipr_log_vpd(&dev_entry->ioa_last_with_dev_vpd);
 
 		ipr_err("Adapter Card Information:\n");
-		ipr_log_vpd(&dev_entry->cfc_last_with_dev_vpids,
-			    dev_entry->cfc_last_with_dev_sn);
+		ipr_log_vpd(&dev_entry->cfc_last_with_dev_vpd);
 
 		ipr_err("Additional IOA Data: %08X %08X %08X %08X %08X\n",
 			be32_to_cpu(dev_entry->ioa_data[0]),
@@ -1001,6 +1103,57 @@ static void ipr_log_config_error(struct 
 }
 
 /**
+ * ipr_log_enhanced_array_error - Log an array configuration error.
+ * @ioa_cfg:	ioa config struct
+ * @hostrcb:	hostrcb struct
+ *
+ * Return value:
+ * 	none
+ **/
+static void ipr_log_enhanced_array_error(struct ipr_ioa_cfg *ioa_cfg,
+					 struct ipr_hostrcb *hostrcb)
+{
+	int i, num_entries;
+	struct ipr_hostrcb_type_14_error *error;
+	struct ipr_hostrcb_array_data_entry_enhanced *array_entry;
+	const u8 zero_sn[IPR_SERIAL_NUM_LEN] = { [0 ... IPR_SERIAL_NUM_LEN-1] = '0' };
+
+	error = &hostrcb->hcam.u.error.u.type_14_error;
+
+	ipr_err_separator;
+
+	ipr_err("RAID %s Array Configuration: %d:%d:%d:%d\n",
+		error->protection_level,
+		ioa_cfg->host->host_no,
+		error->last_func_vset_res_addr.bus,
+		error->last_func_vset_res_addr.target,
+		error->last_func_vset_res_addr.lun);
+
+	ipr_err_separator;
+
+	array_entry = error->array_member;
+	num_entries = min_t(u32, be32_to_cpu(error->num_entries),
+			    sizeof(error->array_member));
+
+	for (i = 0; i < num_entries; i++, array_entry++) {
+		if (!memcmp(array_entry->vpd.vpd.sn, zero_sn, IPR_SERIAL_NUM_LEN))
+			continue;
+
+		if (be32_to_cpu(error->exposed_mode_adn) == i)
+			ipr_err("Exposed Array Member %d:\n", i);
+		else
+			ipr_err("Array Member %d:\n", i);
+
+		ipr_log_ext_vpd(&array_entry->vpd);
+		ipr_phys_res_err(ioa_cfg, array_entry->dev_res_addr, "Current Location");
+		ipr_phys_res_err(ioa_cfg, array_entry->expected_dev_res_addr,
+				 "Expected Location");
+
+		ipr_err_separator;
+	}
+}
+
+/**
  * ipr_log_array_error - Log an array configuration error.
  * @ioa_cfg:	ioa config struct
  * @hostrcb:	hostrcb struct
@@ -1032,36 +1185,19 @@ static void ipr_log_array_error(struct i
 	array_entry = error->array_member;
 
 	for (i = 0; i < 18; i++) {
-		if (!memcmp(array_entry->serial_num, zero_sn, IPR_SERIAL_NUM_LEN))
+		if (!memcmp(array_entry->vpd.sn, zero_sn, IPR_SERIAL_NUM_LEN))
 			continue;
 
-		if (be32_to_cpu(error->exposed_mode_adn) == i) {
+		if (be32_to_cpu(error->exposed_mode_adn) == i)
 			ipr_err("Exposed Array Member %d:\n", i);
-		} else {
+		else
 			ipr_err("Array Member %d:\n", i);
-		}
 
-		ipr_log_vpd(&array_entry->vpids, array_entry->serial_num);
-
-		if (array_entry->dev_res_addr.bus >= IPR_MAX_NUM_BUSES) {
-			ipr_err("Current Location: unknown\n");
-		} else {
-			ipr_err("Current Location: %d:%d:%d:%d\n",
-				ioa_cfg->host->host_no,
-				array_entry->dev_res_addr.bus,
-				array_entry->dev_res_addr.target,
-				array_entry->dev_res_addr.lun);
-		}
+		ipr_log_vpd(&array_entry->vpd);
 
-		if (array_entry->expected_dev_res_addr.bus >= IPR_MAX_NUM_BUSES) {
-			ipr_err("Expected Location: unknown\n");
-		} else {
-			ipr_err("Expected Location: %d:%d:%d:%d\n",
-				ioa_cfg->host->host_no,
-				array_entry->expected_dev_res_addr.bus,
-				array_entry->expected_dev_res_addr.target,
-				array_entry->expected_dev_res_addr.lun);
-		}
+		ipr_phys_res_err(ioa_cfg, array_entry->dev_res_addr, "Current Location");
+		ipr_phys_res_err(ioa_cfg, array_entry->expected_dev_res_addr,
+				 "Expected Location");
 
 		ipr_err_separator;
 
@@ -1073,35 +1209,95 @@ static void ipr_log_array_error(struct i
 }
 
 /**
- * ipr_log_generic_error - Log an adapter error.
- * @ioa_cfg:	ioa config struct
- * @hostrcb:	hostrcb struct
+ * ipr_log_hex_data - Log additional hex IOA error data.
+ * @data:		IOA error data
+ * @len:		data length
  *
  * Return value:
  * 	none
  **/
-static void ipr_log_generic_error(struct ipr_ioa_cfg *ioa_cfg,
-				  struct ipr_hostrcb *hostrcb)
+static void ipr_log_hex_data(u32 *data, int len)
 {
 	int i;
-	int ioa_data_len = be32_to_cpu(hostrcb->hcam.length);
 
-	if (ioa_data_len == 0)
+	if (len == 0)
 		return;
 
-	ipr_err("IOA Error Data:\n");
-	ipr_err("Offset    0 1 2 3  4 5 6 7  8 9 A B  C D E F\n");
-
-	for (i = 0; i < ioa_data_len / 4; i += 4) {
+	for (i = 0; i < len / 4; i += 4) {
 		ipr_err("%08X: %08X %08X %08X %08X\n", i*4,
-			be32_to_cpu(hostrcb->hcam.u.raw.data[i]),
-			be32_to_cpu(hostrcb->hcam.u.raw.data[i+1]),
-			be32_to_cpu(hostrcb->hcam.u.raw.data[i+2]),
-			be32_to_cpu(hostrcb->hcam.u.raw.data[i+3]));
+			be32_to_cpu(data[i]),
+			be32_to_cpu(data[i+1]),
+			be32_to_cpu(data[i+2]),
+			be32_to_cpu(data[i+3]));
 	}
 }
 
 /**
+ * ipr_log_enhanced_dual_ioa_error - Log an enhanced dual adapter error.
+ * @ioa_cfg:	ioa config struct
+ * @hostrcb:	hostrcb struct
+ *
+ * Return value:
+ * 	none
+ **/
+static void ipr_log_enhanced_dual_ioa_error(struct ipr_ioa_cfg *ioa_cfg,
+					    struct ipr_hostrcb *hostrcb)
+{
+	struct ipr_hostrcb_type_17_error *error;
+
+	error = &hostrcb->hcam.u.error.u.type_17_error;
+	error->failure_reason[sizeof(error->failure_reason) - 1] = '\0';
+
+	ipr_err("%s\n", error->failure_reason);
+	ipr_err("Remote Adapter VPD:\n");
+	ipr_log_ext_vpd(&error->vpd);
+	ipr_log_hex_data(error->data,
+			 be32_to_cpu(hostrcb->hcam.length) -
+			 (offsetof(struct ipr_hostrcb_error, u) +
+			  offsetof(struct ipr_hostrcb_type_17_error, data)));
+}
+
+/**
+ * ipr_log_dual_ioa_error - Log a dual adapter error.
+ * @ioa_cfg:	ioa config struct
+ * @hostrcb:	hostrcb struct
+ *
+ * Return value:
+ * 	none
+ **/
+static void ipr_log_dual_ioa_error(struct ipr_ioa_cfg *ioa_cfg,
+				   struct ipr_hostrcb *hostrcb)
+{
+	struct ipr_hostrcb_type_07_error *error;
+
+	error = &hostrcb->hcam.u.error.u.type_07_error;
+	error->failure_reason[sizeof(error->failure_reason) - 1] = '\0';
+
+	ipr_err("%s\n", error->failure_reason);
+	ipr_err("Remote Adapter VPD:\n");
+	ipr_log_vpd(&error->vpd);
+	ipr_log_hex_data(error->data,
+			 be32_to_cpu(hostrcb->hcam.length) -
+			 (offsetof(struct ipr_hostrcb_error, u) +
+			  offsetof(struct ipr_hostrcb_type_07_error, data)));
+}
+
+/**
+ * ipr_log_generic_error - Log an adapter error.
+ * @ioa_cfg:	ioa config struct
+ * @hostrcb:	hostrcb struct
+ *
+ * Return value:
+ * 	none
+ **/
+static void ipr_log_generic_error(struct ipr_ioa_cfg *ioa_cfg,
+				  struct ipr_hostrcb *hostrcb)
+{
+	ipr_log_hex_data(hostrcb->hcam.u.raw.data,
+			 be32_to_cpu(hostrcb->hcam.length));
+}
+
+/**
  * ipr_get_error - Find the specfied IOASC in the ipr_error_table.
  * @ioasc:	IOASC
  *
@@ -1172,11 +1368,10 @@ static void ipr_handle_log_data(struct i
 
 	if (ioa_cfg->log_level < IPR_DEFAULT_LOG_LEVEL)
 		return;
+	if (be32_to_cpu(hostrcb->hcam.length) > sizeof(hostrcb->hcam.u.raw))
+		hostrcb->hcam.length = cpu_to_be32(sizeof(hostrcb->hcam.u.raw));
 
 	switch (hostrcb->hcam.overlay_id) {
-	case IPR_HOST_RCB_OVERLAY_ID_1:
-		ipr_log_generic_error(ioa_cfg, hostrcb);
-		break;
 	case IPR_HOST_RCB_OVERLAY_ID_2:
 		ipr_log_cache_error(ioa_cfg, hostrcb);
 		break;
@@ -1187,13 +1382,26 @@ static void ipr_handle_log_data(struct i
 	case IPR_HOST_RCB_OVERLAY_ID_6:
 		ipr_log_array_error(ioa_cfg, hostrcb);
 		break;
-	case IPR_HOST_RCB_OVERLAY_ID_DEFAULT:
-		ipr_log_generic_error(ioa_cfg, hostrcb);
+	case IPR_HOST_RCB_OVERLAY_ID_7:
+		ipr_log_dual_ioa_error(ioa_cfg, hostrcb);
+		break;
+	case IPR_HOST_RCB_OVERLAY_ID_12:
+		ipr_log_enhanced_cache_error(ioa_cfg, hostrcb);
+		break;
+	case IPR_HOST_RCB_OVERLAY_ID_13:
+		ipr_log_enhanced_config_error(ioa_cfg, hostrcb);
+		break;
+	case IPR_HOST_RCB_OVERLAY_ID_14:
+	case IPR_HOST_RCB_OVERLAY_ID_16:
+		ipr_log_enhanced_array_error(ioa_cfg, hostrcb);
 		break;
+	case IPR_HOST_RCB_OVERLAY_ID_17:
+		ipr_log_enhanced_dual_ioa_error(ioa_cfg, hostrcb);
+		break;
+	case IPR_HOST_RCB_OVERLAY_ID_1:
+	case IPR_HOST_RCB_OVERLAY_ID_DEFAULT:
 	default:
-		dev_err(&ioa_cfg->pdev->dev,
-			"Unknown error received. Overlay ID: %d\n",
-			hostrcb->hcam.overlay_id);
+		ipr_log_generic_error(ioa_cfg, hostrcb);
 		break;
 	}
 }
@@ -1972,6 +2180,103 @@ static struct bin_attribute ipr_trace_at
 };
 #endif
 
+static const struct {
+	enum ipr_cache_state state;
+	char *name;
+} cache_state [] = {
+	{ CACHE_NONE, "none" },
+	{ CACHE_DISABLED, "disabled" },
+	{ CACHE_ENABLED, "enabled" }
+};
+
+/**
+ * ipr_show_write_caching - Show the write caching attribute
+ * @class_dev:	class device struct
+ * @buf:		buffer
+ *
+ * Return value:
+ *	number of bytes printed to buffer
+ **/
+static ssize_t ipr_show_write_caching(struct class_device *class_dev, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(class_dev);
+	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)shost->hostdata;
+	unsigned long lock_flags = 0;
+	int i, len = 0;
+
+	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
+	for (i = 0; i < ARRAY_SIZE(cache_state); i++) {
+		if (cache_state[i].state == ioa_cfg->cache_state) {
+			len = snprintf(buf, PAGE_SIZE, "%s\n", cache_state[i].name);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
+	return len;
+}
+
+
+/**
+ * ipr_store_write_caching - Enable/disable adapter write cache
+ * @class_dev:	class_device struct
+ * @buf:		buffer
+ * @count:		buffer size
+ *
+ * This function will enable/disable adapter write cache.
+ *
+ * Return value:
+ * 	count on success / other on failure
+ **/
+static ssize_t ipr_store_write_caching(struct class_device *class_dev,
+					const char *buf, size_t count)
+{
+	struct Scsi_Host *shost = class_to_shost(class_dev);
+	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)shost->hostdata;
+	unsigned long lock_flags = 0;
+	enum ipr_cache_state new_state = CACHE_INVALID;
+	int i;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (ioa_cfg->cache_state == CACHE_NONE)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(cache_state); i++) {
+		if (!strncmp(cache_state[i].name, buf, strlen(cache_state[i].name))) {
+			new_state = cache_state[i].state;
+			break;
+		}
+	}
+
+	if (new_state != CACHE_DISABLED && new_state != CACHE_ENABLED)
+		return -EINVAL;
+
+	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
+	if (ioa_cfg->cache_state == new_state) {
+		spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
+		return count;
+	}
+
+	ioa_cfg->cache_state = new_state;
+	dev_info(&ioa_cfg->pdev->dev, "%s adapter write cache.\n",
+		 new_state == CACHE_ENABLED ? "Enabling" : "Disabling");
+	if (!ioa_cfg->in_reset_reload)
+		ipr_initiate_ioa_reset(ioa_cfg, IPR_SHUTDOWN_NORMAL);
+	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
+	wait_event(ioa_cfg->reset_wait_q, !ioa_cfg->in_reset_reload);
+
+	return count;
+}
+
+static struct class_device_attribute ipr_ioa_cache_attr = {
+	.attr = {
+		.name =		"write_cache",
+		.mode =		S_IRUGO | S_IWUSR,
+	},
+	.show = ipr_show_write_caching,
+	.store = ipr_store_write_caching
+};
+
 /**
  * ipr_show_fw_version - Show the firmware version
  * @class_dev:	class device struct
@@ -2112,6 +2417,74 @@ static struct class_device_attribute ipr
 };
 
 /**
+ * ipr_show_adapter_state - Show the adapter's state
+ * @class_dev:	class device struct
+ * @buf:		buffer
+ *
+ * Return value:
+ * 	number of bytes printed to buffer
+ **/
+static ssize_t ipr_show_adapter_state(struct class_device *class_dev, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(class_dev);
+	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)shost->hostdata;
+	unsigned long lock_flags = 0;
+	int len;
+
+	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
+	if (ioa_cfg->ioa_is_dead)
+		len = snprintf(buf, PAGE_SIZE, "offline\n");
+	else
+		len = snprintf(buf, PAGE_SIZE, "online\n");
+	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
+	return len;
+}
+
+/**
+ * ipr_store_adapter_state - Change adapter state
+ * @class_dev:	class_device struct
+ * @buf:		buffer
+ * @count:		buffer size
+ *
+ * This function will change the adapter's state.
+ *
+ * Return value:
+ * 	count on success / other on failure
+ **/
+static ssize_t ipr_store_adapter_state(struct class_device *class_dev,
+				       const char *buf, size_t count)
+{
+	struct Scsi_Host *shost = class_to_shost(class_dev);
+	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)shost->hostdata;
+	unsigned long lock_flags;
+	int result = count;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
+	if (ioa_cfg->ioa_is_dead && !strncmp(buf, "online", 6)) {
+		ioa_cfg->ioa_is_dead = 0;
+		ioa_cfg->reset_retries = 0;
+		ioa_cfg->in_ioa_bringdown = 0;
+		ipr_initiate_ioa_reset(ioa_cfg, IPR_SHUTDOWN_NONE);
+	}
+	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
+	wait_event(ioa_cfg->reset_wait_q, !ioa_cfg->in_reset_reload);
+
+	return result;
+}
+
+static struct class_device_attribute ipr_ioa_state_attr = {
+	.attr = {
+		.name =		"state",
+		.mode =		S_IRUGO | S_IWUSR,
+	},
+	.show = ipr_show_adapter_state,
+	.store = ipr_store_adapter_state
+};
+
+/**
  * ipr_store_reset_adapter - Reset the adapter
  * @class_dev:	class_device struct
  * @buf:		buffer
@@ -2183,7 +2556,7 @@ static struct ipr_sglist *ipr_alloc_ucod
 		num_elem = buf_len / bsize_elem;
 
 	/* Allocate a scatter/gather list for the DMA */
-	sglist = kmalloc(sizeof(struct ipr_sglist) +
+	sglist = kzalloc(sizeof(struct ipr_sglist) +
 			 (sizeof(struct scatterlist) * (num_elem - 1)),
 			 GFP_KERNEL);
 
@@ -2192,9 +2565,6 @@ static struct ipr_sglist *ipr_alloc_ucod
 		return NULL;
 	}
 
-	memset(sglist, 0, sizeof(struct ipr_sglist) +
-	       (sizeof(struct scatterlist) * (num_elem - 1)));
-
 	scatterlist = sglist->scatterlist;
 
 	sglist->order = order;
@@ -2289,31 +2659,24 @@ static int ipr_copy_ucode_buffer(struct 
 }
 
 /**
- * ipr_map_ucode_buffer - Map a microcode download buffer
+ * ipr_build_ucode_ioadl - Build a microcode download IOADL
  * @ipr_cmd:	ipr command struct
  * @sglist:		scatter/gather list
- * @len:		total length of download buffer
  *
- * Maps a microcode download scatter/gather list for DMA and
- * builds the IOADL.
+ * Builds a microcode download IOA data list (IOADL).
  *
- * Return value:
- * 	0 on success / -EIO on failure
  **/
-static int ipr_map_ucode_buffer(struct ipr_cmnd *ipr_cmd,
-				struct ipr_sglist *sglist, int len)
+static void ipr_build_ucode_ioadl(struct ipr_cmnd *ipr_cmd,
+				  struct ipr_sglist *sglist)
 {
-	struct ipr_ioa_cfg *ioa_cfg = ipr_cmd->ioa_cfg;
 	struct ipr_ioarcb *ioarcb = &ipr_cmd->ioarcb;
 	struct ipr_ioadl_desc *ioadl = ipr_cmd->ioadl;
 	struct scatterlist *scatterlist = sglist->scatterlist;
 	int i;
 
-	ipr_cmd->dma_use_sg = pci_map_sg(ioa_cfg->pdev, scatterlist,
-					 sglist->num_sg, DMA_TO_DEVICE);
-
+	ipr_cmd->dma_use_sg = sglist->num_dma_sg;
 	ioarcb->cmd_pkt.flags_hi |= IPR_FLAGS_HI_WRITE_NOT_READ;
-	ioarcb->write_data_transfer_length = cpu_to_be32(len);
+	ioarcb->write_data_transfer_length = cpu_to_be32(sglist->buffer_len);
 	ioarcb->write_ioadl_len =
 		cpu_to_be32(sizeof(struct ipr_ioadl_desc) * ipr_cmd->dma_use_sg);
 
@@ -2324,15 +2687,52 @@ static int ipr_map_ucode_buffer(struct i
 			cpu_to_be32(sg_dma_address(&scatterlist[i]));
 	}
 
-	if (likely(ipr_cmd->dma_use_sg)) {
-		ioadl[i-1].flags_and_data_len |=
-			cpu_to_be32(IPR_IOADL_FLAGS_LAST);
+	ioadl[i-1].flags_and_data_len |=
+		cpu_to_be32(IPR_IOADL_FLAGS_LAST);
+}
+
+/**
+ * ipr_update_ioa_ucode - Update IOA's microcode
+ * @ioa_cfg:	ioa config struct
+ * @sglist:		scatter/gather list
+ *
+ * Initiate an adapter reset to update the IOA's microcode
+ *
+ * Return value:
+ * 	0 on success / -EIO on failure
+ **/
+static int ipr_update_ioa_ucode(struct ipr_ioa_cfg *ioa_cfg,
+				struct ipr_sglist *sglist)
+{
+	unsigned long lock_flags;
+
+	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
+
+	if (ioa_cfg->ucode_sglist) {
+		spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
+		dev_err(&ioa_cfg->pdev->dev,
+			"Microcode download already in progress\n");
+		return -EIO;
 	}
-	else {
-		dev_err(&ioa_cfg->pdev->dev, "pci_map_sg failed!\n");
+
+	sglist->num_dma_sg = pci_map_sg(ioa_cfg->pdev, sglist->scatterlist,
+					sglist->num_sg, DMA_TO_DEVICE);
+
+	if (!sglist->num_dma_sg) {
+		spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
+		dev_err(&ioa_cfg->pdev->dev,
+			"Failed to map microcode download buffer!\n");
 		return -EIO;
 	}
 
+	ioa_cfg->ucode_sglist = sglist;
+	ipr_initiate_ioa_reset(ioa_cfg, IPR_SHUTDOWN_NORMAL);
+	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
+	wait_event(ioa_cfg->reset_wait_q, !ioa_cfg->in_reset_reload);
+
+	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
+	ioa_cfg->ucode_sglist = NULL;
+	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
 	return 0;
 }
 
@@ -2355,7 +2755,6 @@ static ssize_t ipr_store_update_fw(struc
 	struct ipr_ucode_image_header *image_hdr;
 	const struct firmware *fw_entry;
 	struct ipr_sglist *sglist;
-	unsigned long lock_flags;
 	char fname[100];
 	char *src;
 	int len, result, dnld_size;
@@ -2396,35 +2795,17 @@ static ssize_t ipr_store_update_fw(struc
 	if (result) {
 		dev_err(&ioa_cfg->pdev->dev,
 			"Microcode buffer copy to DMA buffer failed\n");
-		ipr_free_ucode_buffer(sglist);
-		release_firmware(fw_entry);
-		return result;
-	}
-
-	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
-
-	if (ioa_cfg->ucode_sglist) {
-		spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
-		dev_err(&ioa_cfg->pdev->dev,
-			"Microcode download already in progress\n");
-		ipr_free_ucode_buffer(sglist);
-		release_firmware(fw_entry);
-		return -EIO;
+		goto out;
 	}
 
-	ioa_cfg->ucode_sglist = sglist;
-	ipr_initiate_ioa_reset(ioa_cfg, IPR_SHUTDOWN_NORMAL);
-	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
-	wait_event(ioa_cfg->reset_wait_q, !ioa_cfg->in_reset_reload);
-
-	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
-	ioa_cfg->ucode_sglist = NULL;
-	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
+	result = ipr_update_ioa_ucode(ioa_cfg, sglist);
 
+	if (!result)
+		result = count;
+out:
 	ipr_free_ucode_buffer(sglist);
 	release_firmware(fw_entry);
-
-	return count;
+	return result;
 }
 
 static struct class_device_attribute ipr_update_fw_attr = {
@@ -2439,8 +2820,10 @@ static struct class_device_attribute *ip
 	&ipr_fw_version_attr,
 	&ipr_log_level_attr,
 	&ipr_diagnostics_attr,
+	&ipr_ioa_state_attr,
 	&ipr_ioa_reset_attr,
 	&ipr_update_fw_attr,
+	&ipr_ioa_cache_attr,
 	NULL,
 };
 
@@ -2548,14 +2931,13 @@ static int ipr_alloc_dump(struct ipr_ioa
 	unsigned long lock_flags = 0;
 
 	ENTER;
-	dump = kmalloc(sizeof(struct ipr_dump), GFP_KERNEL);
+	dump = kzalloc(sizeof(struct ipr_dump), GFP_KERNEL);
 
 	if (!dump) {
 		ipr_err("Dump memory allocation failed\n");
 		return -ENOMEM;
 	}
 
-	memset(dump, 0, sizeof(struct ipr_dump));
 	kref_init(&dump->kref);
 	dump->ioa_cfg = ioa_cfg;
 
@@ -2824,8 +3206,10 @@ static int ipr_slave_configure(struct sc
 	if (res) {
 		if (ipr_is_af_dasd_device(res))
 			sdev->type = TYPE_RAID;
-		if (ipr_is_af_dasd_device(res) || ipr_is_ioa_resource(res))
+		if (ipr_is_af_dasd_device(res) || ipr_is_ioa_resource(res)) {
 			sdev->scsi_level = 4;
+			sdev->no_uld_attach = 1;
+		}
 		if (ipr_is_vset_device(res)) {
 			sdev->timeout = IPR_VSET_RW_TIMEOUT;
 			blk_queue_max_sectors(sdev->request_queue, IPR_VSET_MAX_SECTORS);
@@ -2848,13 +3232,14 @@ static int ipr_slave_configure(struct sc
  * handling new commands.
  *
  * Return value:
- * 	0 on success
+ * 	0 on success / -ENXIO if device does not exist
  **/
 static int ipr_slave_alloc(struct scsi_device *sdev)
 {
 	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *) sdev->host->hostdata;
 	struct ipr_resource_entry *res;
 	unsigned long lock_flags;
+	int rc = -ENXIO;
 
 	sdev->hostdata = NULL;
 
@@ -2868,14 +3253,16 @@ static int ipr_slave_alloc(struct scsi_d
 			res->add_to_ml = 0;
 			res->in_erp = 0;
 			sdev->hostdata = res;
-			res->needs_sync_complete = 1;
+			if (!ipr_is_naca_model(res))
+				res->needs_sync_complete = 1;
+			rc = 0;
 			break;
 		}
 	}
 
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
 
-	return 0;
+	return rc;
 }
 
 /**
@@ -2939,7 +3326,7 @@ static int __ipr_eh_dev_reset(struct scs
 	ioa_cfg = (struct ipr_ioa_cfg *) scsi_cmd->device->host->hostdata;
 	res = scsi_cmd->device->hostdata;
 
-	if (!res || (!ipr_is_gscsi(res) && !ipr_is_vset_device(res)))
+	if (!res)
 		return FAILED;
 
 	/*
@@ -3131,7 +3518,8 @@ static int ipr_cancel_op(struct scsi_cmn
 	}
 
 	list_add_tail(&ipr_cmd->queue, &ioa_cfg->free_q);
-	res->needs_sync_complete = 1;
+	if (!ipr_is_naca_model(res))
+		res->needs_sync_complete = 1;
 
 	LEAVE;
 	return (IPR_IOASC_SENSE_KEY(ioasc) ? FAILED : SUCCESS);
@@ -3435,7 +3823,8 @@ static void ipr_erp_done(struct ipr_cmnd
 	}
 
 	if (res) {
-		res->needs_sync_complete = 1;
+		if (!ipr_is_naca_model(res))
+			res->needs_sync_complete = 1;
 		res->in_erp = 0;
 	}
 	ipr_unmap_sglist(ioa_cfg, ipr_cmd);
@@ -3705,6 +4094,30 @@ static void ipr_gen_sense(struct ipr_cmn
 }
 
 /**
+ * ipr_get_autosense - Copy autosense data to sense buffer
+ * @ipr_cmd:	ipr command struct
+ *
+ * This function copies the autosense buffer to the buffer
+ * in the scsi_cmd, if there is autosense available.
+ *
+ * Return value:
+ *	1 if autosense was available / 0 if not
+ **/
+static int ipr_get_autosense(struct ipr_cmnd *ipr_cmd)
+{
+	struct ipr_ioasa *ioasa = &ipr_cmd->ioasa;
+
+	if ((be32_to_cpu(ioasa->ioasc_specific) &
+	     (IPR_ADDITIONAL_STATUS_FMT | IPR_AUTOSENSE_VALID)) == 0)
+		return 0;
+
+	memcpy(ipr_cmd->scsi_cmd->sense_buffer, ioasa->auto_sense.data,
+	       min_t(u16, be16_to_cpu(ioasa->auto_sense.auto_sense_len),
+		   SCSI_SENSE_BUFFERSIZE));
+	return 1;
+}
+
+/**
  * ipr_erp_start - Process an error response for a SCSI op
  * @ioa_cfg:	ioa config struct
  * @ipr_cmd:	ipr command struct
@@ -3734,14 +4147,19 @@ static void ipr_erp_start(struct ipr_ioa
 
 	switch (ioasc & IPR_IOASC_IOASC_MASK) {
 	case IPR_IOASC_ABORTED_CMD_TERM_BY_HOST:
-		scsi_cmd->result |= (DID_IMM_RETRY << 16);
+		if (ipr_is_naca_model(res))
+			scsi_cmd->result |= (DID_ABORT << 16);
+		else
+			scsi_cmd->result |= (DID_IMM_RETRY << 16);
 		break;
 	case IPR_IOASC_IR_RESOURCE_HANDLE:
+	case IPR_IOASC_IR_NO_CMDS_TO_2ND_IOA:
 		scsi_cmd->result |= (DID_NO_CONNECT << 16);
 		break;
 	case IPR_IOASC_HW_SEL_TIMEOUT:
 		scsi_cmd->result |= (DID_NO_CONNECT << 16);
-		res->needs_sync_complete = 1;
+		if (!ipr_is_naca_model(res))
+			res->needs_sync_complete = 1;
 		break;
 	case IPR_IOASC_SYNC_REQUIRED:
 		if (!res->in_erp)
@@ -3749,6 +4167,7 @@ static void ipr_erp_start(struct ipr_ioa
 		scsi_cmd->result |= (DID_IMM_RETRY << 16);
 		break;
 	case IPR_IOASC_MED_DO_NOT_REALLOC: /* prevent retries */
+	case IPR_IOASA_IR_DUAL_IOA_DISABLED:
 		scsi_cmd->result |= (DID_PASSTHROUGH << 16);
 		break;
 	case IPR_IOASC_BUS_WAS_RESET:
@@ -3760,21 +4179,27 @@ static void ipr_erp_start(struct ipr_ioa
 		if (!res->resetting_device)
 			scsi_report_bus_reset(ioa_cfg->host, scsi_cmd->device->channel);
 		scsi_cmd->result |= (DID_ERROR << 16);
-		res->needs_sync_complete = 1;
+		if (!ipr_is_naca_model(res))
+			res->needs_sync_complete = 1;
 		break;
 	case IPR_IOASC_HW_DEV_BUS_STATUS:
 		scsi_cmd->result |= IPR_IOASC_SENSE_STATUS(ioasc);
 		if (IPR_IOASC_SENSE_STATUS(ioasc) == SAM_STAT_CHECK_CONDITION) {
-			ipr_erp_cancel_all(ipr_cmd);
-			return;
+			if (!ipr_get_autosense(ipr_cmd)) {
+				if (!ipr_is_naca_model(res)) {
+					ipr_erp_cancel_all(ipr_cmd);
+					return;
+				}
+			}
 		}
-		res->needs_sync_complete = 1;
+		if (!ipr_is_naca_model(res))
+			res->needs_sync_complete = 1;
 		break;
 	case IPR_IOASC_NR_INIT_CMD_REQUIRED:
 		break;
 	default:
 		scsi_cmd->result |= (DID_ERROR << 16);
-		if (!ipr_is_vset_device(res))
+		if (!ipr_is_vset_device(res) && !ipr_is_naca_model(res))
 			res->needs_sync_complete = 1;
 		break;
 	}
@@ -4073,6 +4498,7 @@ static int ipr_ioa_reset_done(struct ipr
 	ioa_cfg->in_reset_reload = 0;
 	ioa_cfg->allow_cmds = 1;
 	ioa_cfg->reset_cmd = NULL;
+	ioa_cfg->doorbell |= IPR_RUNTIME_RESET;
 
 	list_for_each_entry(res, &ioa_cfg->used_res_q, queue) {
 		if (ioa_cfg->allow_ml_add_del && (res->add_to_ml || res->del_from_ml)) {
@@ -4146,7 +4572,7 @@ static int ipr_set_supported_devs(struct
 	ipr_cmd->job_step = ipr_ioa_reset_done;
 
 	list_for_each_entry_continue(res, &ioa_cfg->used_res_q, queue) {
-		if (!ipr_is_af_dasd_device(res))
+		if (!IPR_IS_DASD_DEVICE(res->cfgte.std_inq_data))
 			continue;
 
 		ipr_cmd->u.res = res;
@@ -4179,6 +4605,36 @@ static int ipr_set_supported_devs(struct
 }
 
 /**
+ * ipr_setup_write_cache - Disable write cache if needed
+ * @ipr_cmd:	ipr command struct
+ *
+ * This function sets up adapters write cache to desired setting
+ *
+ * Return value:
+ * 	IPR_RC_JOB_CONTINUE / IPR_RC_JOB_RETURN
+ **/
+static int ipr_setup_write_cache(struct ipr_cmnd *ipr_cmd)
+{
+	struct ipr_ioa_cfg *ioa_cfg = ipr_cmd->ioa_cfg;
+
+	ipr_cmd->job_step = ipr_set_supported_devs;
+	ipr_cmd->u.res = list_entry(ioa_cfg->used_res_q.next,
+				    struct ipr_resource_entry, queue);
+
+	if (ioa_cfg->cache_state != CACHE_DISABLED)
+		return IPR_RC_JOB_CONTINUE;
+
+	ipr_cmd->ioarcb.res_handle = cpu_to_be32(IPR_IOA_RES_HANDLE);
+	ipr_cmd->ioarcb.cmd_pkt.request_type = IPR_RQTYPE_IOACMD;
+	ipr_cmd->ioarcb.cmd_pkt.cdb[0] = IPR_IOA_SHUTDOWN;
+	ipr_cmd->ioarcb.cmd_pkt.cdb[1] = IPR_SHUTDOWN_PREPARE_FOR_NORMAL;
+
+	ipr_do_req(ipr_cmd, ipr_reset_ioa_job, ipr_timeout, IPR_INTERNAL_TIMEOUT);
+
+	return IPR_RC_JOB_RETURN;
+}
+
+/**
  * ipr_get_mode_page - Locate specified mode page
  * @mode_pages:	mode page buffer
  * @page_code:	page code to find
@@ -4389,10 +4845,7 @@ static int ipr_ioafp_mode_select_page28(
 			      ioa_cfg->vpd_cbs_dma + offsetof(struct ipr_misc_cbs, mode_pages),
 			      length);
 
-	ipr_cmd->job_step = ipr_set_supported_devs;
-	ipr_cmd->u.res = list_entry(ioa_cfg->used_res_q.next,
-				    struct ipr_resource_entry, queue);
-
+	ipr_cmd->job_step = ipr_setup_write_cache;
 	ipr_do_req(ipr_cmd, ipr_reset_ioa_job, ipr_timeout, IPR_INTERNAL_TIMEOUT);
 
 	LEAVE;
@@ -4431,6 +4884,51 @@ static void ipr_build_mode_sense(struct 
 }
 
 /**
+ * ipr_reset_cmd_failed - Handle failure of IOA reset command
+ * @ipr_cmd:	ipr command struct
+ *
+ * This function handles the failure of an IOA bringup command.
+ *
+ * Return value:
+ * 	IPR_RC_JOB_RETURN
+ **/
+static int ipr_reset_cmd_failed(struct ipr_cmnd *ipr_cmd)
+{
+	struct ipr_ioa_cfg *ioa_cfg = ipr_cmd->ioa_cfg;
+	u32 ioasc = be32_to_cpu(ipr_cmd->ioasa.ioasc);
+
+	dev_err(&ioa_cfg->pdev->dev,
+		"0x%02X failed with IOASC: 0x%08X\n",
+		ipr_cmd->ioarcb.cmd_pkt.cdb[0], ioasc);
+
+	ipr_initiate_ioa_reset(ioa_cfg, IPR_SHUTDOWN_NONE);
+	list_add_tail(&ipr_cmd->queue, &ioa_cfg->free_q);
+	return IPR_RC_JOB_RETURN;
+}
+
+/**
+ * ipr_reset_mode_sense_failed - Handle failure of IOAFP mode sense
+ * @ipr_cmd:	ipr command struct
+ *
+ * This function handles the failure of a Mode Sense to the IOAFP.
+ * Some adapters do not handle all mode pages.
+ *
+ * Return value:
+ * 	IPR_RC_JOB_CONTINUE / IPR_RC_JOB_RETURN
+ **/
+static int ipr_reset_mode_sense_failed(struct ipr_cmnd *ipr_cmd)
+{
+	u32 ioasc = be32_to_cpu(ipr_cmd->ioasa.ioasc);
+
+	if (ioasc == IPR_IOASC_IR_INVALID_REQ_TYPE_OR_PKT) {
+		ipr_cmd->job_step = ipr_setup_write_cache;
+		return IPR_RC_JOB_CONTINUE;
+	}
+
+	return ipr_reset_cmd_failed(ipr_cmd);
+}
+
+/**
  * ipr_ioafp_mode_sense_page28 - Issue Mode Sense Page 28 to IOA
  * @ipr_cmd:	ipr command struct
  *
@@ -4451,6 +4949,7 @@ static int ipr_ioafp_mode_sense_page28(s
 			     sizeof(struct ipr_mode_pages));
 
 	ipr_cmd->job_step = ipr_ioafp_mode_select_page28;
+	ipr_cmd->job_step_failed = ipr_reset_mode_sense_failed;
 
 	ipr_do_req(ipr_cmd, ipr_reset_ioa_job, ipr_timeout, IPR_INTERNAL_TIMEOUT);
 
@@ -4612,6 +5111,27 @@ static void ipr_ioafp_inquiry(struct ipr
 }
 
 /**
+ * ipr_inquiry_page_supported - Is the given inquiry page supported
+ * @page0:		inquiry page 0 buffer
+ * @page:		page code.
+ *
+ * This function determines if the specified inquiry page is supported.
+ *
+ * Return value:
+ *	1 if page is supported / 0 if not
+ **/
+static int ipr_inquiry_page_supported(struct ipr_inquiry_page0 *page0, u8 page)
+{
+	int i;
+
+	for (i = 0; i < min_t(u8, page0->len, IPR_INQUIRY_PAGE0_ENTRIES); i++)
+		if (page0->page[i] == page)
+			return 1;
+
+	return 0;
+}
+
+/**
  * ipr_ioafp_page3_inquiry - Send a Page 3 Inquiry to the adapter.
  * @ipr_cmd:	ipr command struct
  *
@@ -4624,6 +5144,36 @@ static void ipr_ioafp_inquiry(struct ipr
 static int ipr_ioafp_page3_inquiry(struct ipr_cmnd *ipr_cmd)
 {
 	struct ipr_ioa_cfg *ioa_cfg = ipr_cmd->ioa_cfg;
+	struct ipr_inquiry_page0 *page0 = &ioa_cfg->vpd_cbs->page0_data;
+
+	ENTER;
+
+	if (!ipr_inquiry_page_supported(page0, 1))
+		ioa_cfg->cache_state = CACHE_NONE;
+
+	ipr_cmd->job_step = ipr_ioafp_query_ioa_cfg;
+
+	ipr_ioafp_inquiry(ipr_cmd, 1, 3,
+			  ioa_cfg->vpd_cbs_dma + offsetof(struct ipr_misc_cbs, page3_data),
+			  sizeof(struct ipr_inquiry_page3));
+
+	LEAVE;
+	return IPR_RC_JOB_RETURN;
+}
+
+/**
+ * ipr_ioafp_page0_inquiry - Send a Page 0 Inquiry to the adapter.
+ * @ipr_cmd:	ipr command struct
+ *
+ * This function sends a Page 0 inquiry to the adapter
+ * to retrieve supported inquiry pages.
+ *
+ * Return value:
+ * 	IPR_RC_JOB_CONTINUE / IPR_RC_JOB_RETURN
+ **/
+static int ipr_ioafp_page0_inquiry(struct ipr_cmnd *ipr_cmd)
+{
+	struct ipr_ioa_cfg *ioa_cfg = ipr_cmd->ioa_cfg;
 	char type[5];
 
 	ENTER;
@@ -4633,11 +5183,11 @@ static int ipr_ioafp_page3_inquiry(struc
 	type[4] = '\0';
 	ioa_cfg->type = simple_strtoul((char *)type, NULL, 16);
 
-	ipr_cmd->job_step = ipr_ioafp_query_ioa_cfg;
+	ipr_cmd->job_step = ipr_ioafp_page3_inquiry;
 
-	ipr_ioafp_inquiry(ipr_cmd, 1, 3,
-			  ioa_cfg->vpd_cbs_dma + offsetof(struct ipr_misc_cbs, page3_data),
-			  sizeof(struct ipr_inquiry_page3));
+	ipr_ioafp_inquiry(ipr_cmd, 1, 0,
+			  ioa_cfg->vpd_cbs_dma + offsetof(struct ipr_misc_cbs, page0_data),
+			  sizeof(struct ipr_inquiry_page0));
 
 	LEAVE;
 	return IPR_RC_JOB_RETURN;
@@ -4657,7 +5207,7 @@ static int ipr_ioafp_std_inquiry(struct 
 	struct ipr_ioa_cfg *ioa_cfg = ipr_cmd->ioa_cfg;
 
 	ENTER;
-	ipr_cmd->job_step = ipr_ioafp_page3_inquiry;
+	ipr_cmd->job_step = ipr_ioafp_page0_inquiry;
 
 	ipr_ioafp_inquiry(ipr_cmd, 0, 0,
 			  ioa_cfg->vpd_cbs_dma + offsetof(struct ipr_misc_cbs, ioa_vpd),
@@ -4815,7 +5365,7 @@ static int ipr_reset_enable_ioa(struct i
 	}
 
 	/* Enable destructive diagnostics on IOA */
-	writel(IPR_DOORBELL, ioa_cfg->regs.set_uproc_interrupt_reg);
+	writel(ioa_cfg->doorbell, ioa_cfg->regs.set_uproc_interrupt_reg);
 
 	writel(IPR_PCII_OPER_INTERRUPTS, ioa_cfg->regs.clr_interrupt_mask_reg);
 	int_reg = readl(ioa_cfg->regs.sense_interrupt_mask_reg);
@@ -5147,12 +5697,7 @@ static int ipr_reset_ucode_download(stru
 	ipr_cmd->ioarcb.cmd_pkt.cdb[7] = (sglist->buffer_len & 0x00ff00) >> 8;
 	ipr_cmd->ioarcb.cmd_pkt.cdb[8] = sglist->buffer_len & 0x0000ff;
 
-	if (ipr_map_ucode_buffer(ipr_cmd, sglist, sglist->buffer_len)) {
-		dev_err(&ioa_cfg->pdev->dev,
-			"Failed to map microcode download buffer\n");
-		return IPR_RC_JOB_CONTINUE;
-	}
-
+	ipr_build_ucode_ioadl(ipr_cmd, sglist);
 	ipr_cmd->job_step = ipr_reset_ucode_download_done;
 
 	ipr_do_req(ipr_cmd, ipr_reset_ioa_job, ipr_timeout,
@@ -5217,7 +5762,6 @@ static int ipr_reset_shutdown_ioa(struct
 static void ipr_reset_ioa_job(struct ipr_cmnd *ipr_cmd)
 {
 	u32 rc, ioasc;
-	unsigned long scratch = ipr_cmd->u.scratch;
 	struct ipr_ioa_cfg *ioa_cfg = ipr_cmd->ioa_cfg;
 
 	do {
@@ -5233,17 +5777,13 @@ static void ipr_reset_ioa_job(struct ipr
 		}
 
 		if (IPR_IOASC_SENSE_KEY(ioasc)) {
-			dev_err(&ioa_cfg->pdev->dev,
-				"0x%02X failed with IOASC: 0x%08X\n",
-				ipr_cmd->ioarcb.cmd_pkt.cdb[0], ioasc);
-
-			ipr_initiate_ioa_reset(ioa_cfg, IPR_SHUTDOWN_NONE);
-			list_add_tail(&ipr_cmd->queue, &ioa_cfg->free_q);
-			return;
+			rc = ipr_cmd->job_step_failed(ipr_cmd);
+			if (rc == IPR_RC_JOB_RETURN)
+				return;
 		}
 
 		ipr_reinit_ipr_cmnd(ipr_cmd);
-		ipr_cmd->u.scratch = scratch;
+		ipr_cmd->job_step_failed = ipr_reset_cmd_failed;
 		rc = ipr_cmd->job_step(ipr_cmd);
 	} while(rc == IPR_RC_JOB_CONTINUE);
 }
@@ -5517,15 +6057,12 @@ static int __devinit ipr_alloc_mem(struc
 	int i, rc = -ENOMEM;
 
 	ENTER;
-	ioa_cfg->res_entries = kmalloc(sizeof(struct ipr_resource_entry) *
+	ioa_cfg->res_entries = kzalloc(sizeof(struct ipr_resource_entry) *
 				       IPR_MAX_PHYSICAL_DEVS, GFP_KERNEL);
 
 	if (!ioa_cfg->res_entries)
 		goto out;
 
-	memset(ioa_cfg->res_entries, 0,
-	       sizeof(struct ipr_resource_entry) * IPR_MAX_PHYSICAL_DEVS);
-
 	for (i = 0; i < IPR_MAX_PHYSICAL_DEVS; i++)
 		list_add_tail(&ioa_cfg->res_entries[i].queue, &ioa_cfg->free_res_q);
 
@@ -5566,15 +6103,12 @@ static int __devinit ipr_alloc_mem(struc
 		list_add_tail(&ioa_cfg->hostrcb[i]->queue, &ioa_cfg->hostrcb_free_q);
 	}
 
-	ioa_cfg->trace = kmalloc(sizeof(struct ipr_trace_entry) *
+	ioa_cfg->trace = kzalloc(sizeof(struct ipr_trace_entry) *
 				 IPR_NUM_TRACE_ENTRIES, GFP_KERNEL);
 
 	if (!ioa_cfg->trace)
 		goto out_free_hostrcb_dma;
 
-	memset(ioa_cfg->trace, 0,
-	       sizeof(struct ipr_trace_entry) * IPR_NUM_TRACE_ENTRIES);
-
 	rc = 0;
 out:
 	LEAVE;
@@ -5642,6 +6176,9 @@ static void __devinit ipr_init_ioa_cfg(s
 	ioa_cfg->host = host;
 	ioa_cfg->pdev = pdev;
 	ioa_cfg->log_level = ipr_log_level;
+	ioa_cfg->doorbell = IPR_DOORBELL;
+	if (!ipr_auto_create)
+		ioa_cfg->doorbell |= IPR_RUNTIME_RESET;
 	sprintf(ioa_cfg->eye_catcher, IPR_EYECATCHER);
 	sprintf(ioa_cfg->trace_start, IPR_TRACE_START_LABEL);
 	sprintf(ioa_cfg->ipr_free_label, IPR_FREEQ_LABEL);
@@ -5660,6 +6197,10 @@ static void __devinit ipr_init_ioa_cfg(s
 	INIT_WORK(&ioa_cfg->work_q, ipr_worker_thread, ioa_cfg);
 	init_waitqueue_head(&ioa_cfg->reset_wait_q);
 	ioa_cfg->sdt_state = INACTIVE;
+	if (ipr_enable_cache)
+		ioa_cfg->cache_state = CACHE_ENABLED;
+	else
+		ioa_cfg->cache_state = CACHE_DISABLED;
 
 	ipr_initialize_bus_attr(ioa_cfg);
 
@@ -6008,6 +6549,7 @@ static int __devinit ipr_probe(struct pc
 	ipr_scan_vsets(ioa_cfg);
 	scsi_add_device(ioa_cfg->host, IPR_IOA_BUS, IPR_IOA_TARGET, IPR_IOA_LUN);
 	ioa_cfg->allow_ml_add_del = 1;
+	ioa_cfg->host->max_channel = IPR_VSET_BUS;
 	schedule_work(&ioa_cfg->work_q);
 	return 0;
 }
@@ -6055,12 +6597,30 @@ static struct pci_device_id ipr_pci_tabl
 	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_CITRINE,
 		PCI_VENDOR_ID_IBM, IPR_SUBS_DEV_ID_571A,
 	      0, 0, (kernel_ulong_t)&ipr_chip_cfg[0] },
+	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_CITRINE,
+		PCI_VENDOR_ID_IBM, IPR_SUBS_DEV_ID_575B,
+		0, 0, (kernel_ulong_t)&ipr_chip_cfg[0] },
+	{ PCI_VENDOR_ID_ADAPTEC2, PCI_DEVICE_ID_ADAPTEC2_OBSIDIAN,
+	      PCI_VENDOR_ID_IBM, IPR_SUBS_DEV_ID_572A,
+	      0, 0, (kernel_ulong_t)&ipr_chip_cfg[0] },
+	{ PCI_VENDOR_ID_ADAPTEC2, PCI_DEVICE_ID_ADAPTEC2_OBSIDIAN,
+	      PCI_VENDOR_ID_IBM, IPR_SUBS_DEV_ID_572B,
+	      0, 0, (kernel_ulong_t)&ipr_chip_cfg[0] },
+	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_OBSIDIAN,
+	      PCI_VENDOR_ID_IBM, IPR_SUBS_DEV_ID_572A,
+	      0, 0, (kernel_ulong_t)&ipr_chip_cfg[0] },
+	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_OBSIDIAN,
+	      PCI_VENDOR_ID_IBM, IPR_SUBS_DEV_ID_572B,
+	      0, 0, (kernel_ulong_t)&ipr_chip_cfg[0] },
 	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_SNIPE,
 		PCI_VENDOR_ID_IBM, IPR_SUBS_DEV_ID_2780,
 		0, 0, (kernel_ulong_t)&ipr_chip_cfg[1] },
 	{ PCI_VENDOR_ID_ADAPTEC2, PCI_DEVICE_ID_ADAPTEC2_SCAMP,
 		PCI_VENDOR_ID_IBM, IPR_SUBS_DEV_ID_571E,
 		0, 0, (kernel_ulong_t)&ipr_chip_cfg[1] },
+	{ PCI_VENDOR_ID_ADAPTEC2, PCI_DEVICE_ID_ADAPTEC2_SCAMP,
+		PCI_VENDOR_ID_IBM, IPR_SUBS_DEV_ID_571F,
+		0, 0, (kernel_ulong_t)&ipr_chip_cfg[1] },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, ipr_pci_table);
diff -urp linux-2.6.14-git14/drivers/scsi/ipr.h linux-2.6.15-rc1/drivers/scsi/ipr.h
--- linux-2.6.14-git14/drivers/scsi/ipr.h	2005-12-12 19:42:03.000000000 +0100
+++ linux-2.6.15-rc1/drivers/scsi/ipr.h	2005-11-12 02:43:36.000000000 +0100
@@ -36,23 +36,8 @@
 /*
  * Literals
  */
-#define IPR_DRIVER_VERSION "2.0.14"
-#define IPR_DRIVER_DATE "(May 2, 2005)"
-
-/*
- * IPR_DBG_TRACE: Setting this to 1 will turn on some general function tracing
- *			resulting in a bunch of extra debugging printks to the console
- *
- * IPR_DEBUG:	Setting this to 1 will turn on some error path tracing.
- *			Enables the ipr_trace macro.
- */
-#ifdef IPR_DEBUG_ALL
-#define IPR_DEBUG				1
-#define IPR_DBG_TRACE			1
-#else
-#define IPR_DEBUG				0
-#define IPR_DBG_TRACE			0
-#endif
+#define IPR_DRIVER_VERSION "2.1.0"
+#define IPR_DRIVER_DATE "(October 31, 2005)"
 
 /*
  * IPR_MAX_CMD_PER_LUN: This defines the maximum number of outstanding
@@ -76,6 +61,10 @@
 #define IPR_SUBS_DEV_ID_571A	0x02C0
 #define IPR_SUBS_DEV_ID_571B	0x02BE
 #define IPR_SUBS_DEV_ID_571E  0x02BF
+#define IPR_SUBS_DEV_ID_571F	0x02D5
+#define IPR_SUBS_DEV_ID_572A	0x02C1
+#define IPR_SUBS_DEV_ID_572B	0x02C2
+#define IPR_SUBS_DEV_ID_575B	0x030D
 
 #define IPR_NAME				"ipr"
 
@@ -95,7 +84,10 @@
 #define IPR_IOASC_HW_DEV_BUS_STATUS			0x04448500
 #define	IPR_IOASC_IOASC_MASK			0xFFFFFF00
 #define	IPR_IOASC_SCSI_STATUS_MASK		0x000000FF
+#define IPR_IOASC_IR_INVALID_REQ_TYPE_OR_PKT	0x05240000
 #define IPR_IOASC_IR_RESOURCE_HANDLE		0x05250000
+#define IPR_IOASC_IR_NO_CMDS_TO_2ND_IOA		0x05258100
+#define IPR_IOASA_IR_DUAL_IOA_DISABLED		0x052C8000
 #define IPR_IOASC_BUS_WAS_RESET			0x06290000
 #define IPR_IOASC_BUS_WAS_RESET_BY_OTHER		0x06298000
 #define IPR_IOASC_ABORTED_CMD_TERM_BY_HOST	0x0B5A0000
@@ -107,14 +99,14 @@
 #define IPR_NUM_LOG_HCAMS				2
 #define IPR_NUM_CFG_CHG_HCAMS				2
 #define IPR_NUM_HCAMS	(IPR_NUM_LOG_HCAMS + IPR_NUM_CFG_CHG_HCAMS)
-#define IPR_MAX_NUM_TARGETS_PER_BUS			0x10
+#define IPR_MAX_NUM_TARGETS_PER_BUS			256
 #define IPR_MAX_NUM_LUNS_PER_TARGET			256
 #define IPR_MAX_NUM_VSET_LUNS_PER_TARGET	8
 #define IPR_VSET_BUS					0xff
 #define IPR_IOA_BUS						0xff
 #define IPR_IOA_TARGET					0xff
 #define IPR_IOA_LUN						0xff
-#define IPR_MAX_NUM_BUSES				4
+#define IPR_MAX_NUM_BUSES				8
 #define IPR_MAX_BUS_TO_SCAN				IPR_MAX_NUM_BUSES
 
 #define IPR_NUM_RESET_RELOAD_RETRIES		3
@@ -205,6 +197,7 @@
 #define IPR_SDT_FMT2_EXP_ROM_SEL			0x8
 #define IPR_FMT2_SDT_READY_TO_USE			0xC4D4E3F2
 #define IPR_DOORBELL					0x82800000
+#define IPR_RUNTIME_RESET				0x40000000
 
 #define IPR_PCII_IOA_TRANS_TO_OPER			(0x80000000 >> 0)
 #define IPR_PCII_IOARCB_XFER_FAILED			(0x80000000 >> 3)
@@ -261,6 +254,16 @@ struct ipr_std_inq_vpids {
 	u8 product_id[IPR_PROD_ID_LEN];
 }__attribute__((packed));
 
+struct ipr_vpd {
+	struct ipr_std_inq_vpids vpids;
+	u8 sn[IPR_SERIAL_NUM_LEN];
+}__attribute__((packed));
+
+struct ipr_ext_vpd {
+	struct ipr_vpd vpd;
+	__be32 wwid[2];
+}__attribute__((packed));
+
 struct ipr_std_inq_data {
 	u8 peri_qual_dev_type;
 #define IPR_STD_INQ_PERI_QUAL(peri) ((peri) >> 5)
@@ -304,6 +307,10 @@ struct ipr_config_table_entry {
 #define IPR_SUBTYPE_GENERIC_SCSI	1
 #define IPR_SUBTYPE_VOLUME_SET		2
 
+#define IPR_QUEUEING_MODEL(res)	((((res)->cfgte.flags) & 0x70) >> 4)
+#define IPR_QUEUE_FROZEN_MODEL	0
+#define IPR_QUEUE_NACA_MODEL		1
+
 	struct ipr_res_addr res_addr;
 	__be32 res_handle;
 	__be32 reserved4[2];
@@ -410,23 +417,26 @@ struct ipr_ioadl_desc {
 struct ipr_ioasa_vset {
 	__be32 failing_lba_hi;
 	__be32 failing_lba_lo;
-	__be32 ioa_data[22];
+	__be32 reserved;
 }__attribute__((packed, aligned (4)));
 
 struct ipr_ioasa_af_dasd {
 	__be32 failing_lba;
+	__be32 reserved[2];
 }__attribute__((packed, aligned (4)));
 
 struct ipr_ioasa_gpdd {
 	u8 end_state;
 	u8 bus_phase;
 	__be16 reserved;
-	__be32 ioa_data[23];
+	__be32 ioa_data[2];
 }__attribute__((packed, aligned (4)));
 
-struct ipr_ioasa_raw {
-	__be32 ioa_data[24];
-}__attribute__((packed, aligned (4)));
+struct ipr_auto_sense {
+	__be16 auto_sense_len;
+	__be16 ioa_data_len;
+	__be32 data[SCSI_SENSE_BUFFERSIZE/sizeof(__be32)];
+};
 
 struct ipr_ioasa {
 	__be32 ioasc;
@@ -453,6 +463,8 @@ struct ipr_ioasa {
 	__be32 fd_res_handle;
 
 	__be32 ioasc_specific;	/* status code specific field */
+#define IPR_ADDITIONAL_STATUS_FMT		0x80000000
+#define IPR_AUTOSENSE_VALID			0x40000000
 #define IPR_IOASC_SPECIFIC_MASK		0x00ffffff
 #define IPR_FIELD_POINTER_VALID		(0x80000000 >> 8)
 #define IPR_FIELD_POINTER_MASK		0x0000ffff
@@ -461,8 +473,9 @@ struct ipr_ioasa {
 		struct ipr_ioasa_vset vset;
 		struct ipr_ioasa_af_dasd dasd;
 		struct ipr_ioasa_gpdd gpdd;
-		struct ipr_ioasa_raw raw;
 	} u;
+
+	struct ipr_auto_sense auto_sense;
 }__attribute__((packed, aligned (4)));
 
 struct ipr_mode_parm_hdr {
@@ -536,28 +549,49 @@ struct ipr_inquiry_page3 {
 	u8 patch_number[4];
 }__attribute__((packed));
 
+#define IPR_INQUIRY_PAGE0_ENTRIES 20
+struct ipr_inquiry_page0 {
+	u8 peri_qual_dev_type;
+	u8 page_code;
+	u8 reserved1;
+	u8 len;
+	u8 page[IPR_INQUIRY_PAGE0_ENTRIES];
+}__attribute__((packed));
+
 struct ipr_hostrcb_device_data_entry {
-	struct ipr_std_inq_vpids dev_vpids;
-	u8 dev_sn[IPR_SERIAL_NUM_LEN];
+	struct ipr_vpd vpd;
 	struct ipr_res_addr dev_res_addr;
-	struct ipr_std_inq_vpids new_dev_vpids;
-	u8 new_dev_sn[IPR_SERIAL_NUM_LEN];
-	struct ipr_std_inq_vpids ioa_last_with_dev_vpids;
-	u8 ioa_last_with_dev_sn[IPR_SERIAL_NUM_LEN];
-	struct ipr_std_inq_vpids cfc_last_with_dev_vpids;
-	u8 cfc_last_with_dev_sn[IPR_SERIAL_NUM_LEN];
+	struct ipr_vpd new_vpd;
+	struct ipr_vpd ioa_last_with_dev_vpd;
+	struct ipr_vpd cfc_last_with_dev_vpd;
 	__be32 ioa_data[5];
 }__attribute__((packed, aligned (4)));
 
+struct ipr_hostrcb_device_data_entry_enhanced {
+	struct ipr_ext_vpd vpd;
+	u8 ccin[4];
+	struct ipr_res_addr dev_res_addr;
+	struct ipr_ext_vpd new_vpd;
+	u8 new_ccin[4];
+	struct ipr_ext_vpd ioa_last_with_dev_vpd;
+	struct ipr_ext_vpd cfc_last_with_dev_vpd;
+}__attribute__((packed, aligned (4)));
+
 struct ipr_hostrcb_array_data_entry {
-	struct ipr_std_inq_vpids vpids;
-	u8 serial_num[IPR_SERIAL_NUM_LEN];
+	struct ipr_vpd vpd;
+	struct ipr_res_addr expected_dev_res_addr;
+	struct ipr_res_addr dev_res_addr;
+}__attribute__((packed, aligned (4)));
+
+struct ipr_hostrcb_array_data_entry_enhanced {
+	struct ipr_ext_vpd vpd;
+	u8 ccin[4];
 	struct ipr_res_addr expected_dev_res_addr;
 	struct ipr_res_addr dev_res_addr;
 }__attribute__((packed, aligned (4)));
 
 struct ipr_hostrcb_type_ff_error {
-	__be32 ioa_data[246];
+	__be32 ioa_data[502];
 }__attribute__((packed, aligned (4)));
 
 struct ipr_hostrcb_type_01_error {
@@ -568,47 +602,75 @@ struct ipr_hostrcb_type_01_error {
 }__attribute__((packed, aligned (4)));
 
 struct ipr_hostrcb_type_02_error {
-	struct ipr_std_inq_vpids ioa_vpids;
-	u8 ioa_sn[IPR_SERIAL_NUM_LEN];
-	struct ipr_std_inq_vpids cfc_vpids;
-	u8 cfc_sn[IPR_SERIAL_NUM_LEN];
-	struct ipr_std_inq_vpids ioa_last_attached_to_cfc_vpids;
-	u8 ioa_last_attached_to_cfc_sn[IPR_SERIAL_NUM_LEN];
-	struct ipr_std_inq_vpids cfc_last_attached_to_ioa_vpids;
-	u8 cfc_last_attached_to_ioa_sn[IPR_SERIAL_NUM_LEN];
+	struct ipr_vpd ioa_vpd;
+	struct ipr_vpd cfc_vpd;
+	struct ipr_vpd ioa_last_attached_to_cfc_vpd;
+	struct ipr_vpd cfc_last_attached_to_ioa_vpd;
+	__be32 ioa_data[3];
+}__attribute__((packed, aligned (4)));
+
+struct ipr_hostrcb_type_12_error {
+	struct ipr_ext_vpd ioa_vpd;
+	struct ipr_ext_vpd cfc_vpd;
+	struct ipr_ext_vpd ioa_last_attached_to_cfc_vpd;
+	struct ipr_ext_vpd cfc_last_attached_to_ioa_vpd;
 	__be32 ioa_data[3];
-	u8 reserved[844];
 }__attribute__((packed, aligned (4)));
 
 struct ipr_hostrcb_type_03_error {
-	struct ipr_std_inq_vpids ioa_vpids;
-	u8 ioa_sn[IPR_SERIAL_NUM_LEN];
-	struct ipr_std_inq_vpids cfc_vpids;
-	u8 cfc_sn[IPR_SERIAL_NUM_LEN];
+	struct ipr_vpd ioa_vpd;
+	struct ipr_vpd cfc_vpd;
 	__be32 errors_detected;
 	__be32 errors_logged;
 	u8 ioa_data[12];
-	struct ipr_hostrcb_device_data_entry dev_entry[3];
-	u8 reserved[444];
+	struct ipr_hostrcb_device_data_entry dev[3];
+}__attribute__((packed, aligned (4)));
+
+struct ipr_hostrcb_type_13_error {
+	struct ipr_ext_vpd ioa_vpd;
+	struct ipr_ext_vpd cfc_vpd;
+	__be32 errors_detected;
+	__be32 errors_logged;
+	struct ipr_hostrcb_device_data_entry_enhanced dev[3];
 }__attribute__((packed, aligned (4)));
 
 struct ipr_hostrcb_type_04_error {
-	struct ipr_std_inq_vpids ioa_vpids;
-	u8 ioa_sn[IPR_SERIAL_NUM_LEN];
-	struct ipr_std_inq_vpids cfc_vpids;
-	u8 cfc_sn[IPR_SERIAL_NUM_LEN];
+	struct ipr_vpd ioa_vpd;
+	struct ipr_vpd cfc_vpd;
 	u8 ioa_data[12];
 	struct ipr_hostrcb_array_data_entry array_member[10];
 	__be32 exposed_mode_adn;
 	__be32 array_id;
-	struct ipr_std_inq_vpids incomp_dev_vpids;
-	u8 incomp_dev_sn[IPR_SERIAL_NUM_LEN];
+	struct ipr_vpd incomp_dev_vpd;
 	__be32 ioa_data2;
 	struct ipr_hostrcb_array_data_entry array_member2[8];
 	struct ipr_res_addr last_func_vset_res_addr;
 	u8 vset_serial_num[IPR_SERIAL_NUM_LEN];
 	u8 protection_level[8];
-	u8 reserved[124];
+}__attribute__((packed, aligned (4)));
+
+struct ipr_hostrcb_type_14_error {
+	struct ipr_ext_vpd ioa_vpd;
+	struct ipr_ext_vpd cfc_vpd;
+	__be32 exposed_mode_adn;
+	__be32 array_id;
+	struct ipr_res_addr last_func_vset_res_addr;
+	u8 vset_serial_num[IPR_SERIAL_NUM_LEN];
+	u8 protection_level[8];
+	__be32 num_entries;
+	struct ipr_hostrcb_array_data_entry_enhanced array_member[18];
+}__attribute__((packed, aligned (4)));
+
+struct ipr_hostrcb_type_07_error {
+	u8 failure_reason[64];
+	struct ipr_vpd vpd;
+	u32 data[222];
+}__attribute__((packed, aligned (4)));
+
+struct ipr_hostrcb_type_17_error {
+	u8 failure_reason[64];
+	struct ipr_ext_vpd vpd;
+	u32 data[476];
 }__attribute__((packed, aligned (4)));
 
 struct ipr_hostrcb_error {
@@ -622,6 +684,11 @@ struct ipr_hostrcb_error {
 		struct ipr_hostrcb_type_02_error type_02_error;
 		struct ipr_hostrcb_type_03_error type_03_error;
 		struct ipr_hostrcb_type_04_error type_04_error;
+		struct ipr_hostrcb_type_07_error type_07_error;
+		struct ipr_hostrcb_type_12_error type_12_error;
+		struct ipr_hostrcb_type_13_error type_13_error;
+		struct ipr_hostrcb_type_14_error type_14_error;
+		struct ipr_hostrcb_type_17_error type_17_error;
 	} u;
 }__attribute__((packed, aligned (4)));
 
@@ -655,6 +722,12 @@ struct ipr_hcam {
 #define IPR_HOST_RCB_OVERLAY_ID_3				0x03
 #define IPR_HOST_RCB_OVERLAY_ID_4				0x04
 #define IPR_HOST_RCB_OVERLAY_ID_6				0x06
+#define IPR_HOST_RCB_OVERLAY_ID_7				0x07
+#define IPR_HOST_RCB_OVERLAY_ID_12				0x12
+#define IPR_HOST_RCB_OVERLAY_ID_13				0x13
+#define IPR_HOST_RCB_OVERLAY_ID_14				0x14
+#define IPR_HOST_RCB_OVERLAY_ID_16				0x16
+#define IPR_HOST_RCB_OVERLAY_ID_17				0x17
 #define IPR_HOST_RCB_OVERLAY_ID_DEFAULT			0xFF
 
 	u8 reserved1[3];
@@ -743,6 +816,7 @@ struct ipr_resource_table {
 
 struct ipr_misc_cbs {
 	struct ipr_ioa_vpd ioa_vpd;
+	struct ipr_inquiry_page0 page0_data;
 	struct ipr_inquiry_page3 page3_data;
 	struct ipr_mode_pages mode_pages;
 	struct ipr_supported_device supp_dev;
@@ -813,6 +887,7 @@ struct ipr_trace_entry {
 struct ipr_sglist {
 	u32 order;
 	u32 num_sg;
+	u32 num_dma_sg;
 	u32 buffer_len;
 	struct scatterlist scatterlist[1];
 };
@@ -825,6 +900,13 @@ enum ipr_sdt_state {
 	DUMP_OBTAINED
 };
 
+enum ipr_cache_state {
+	CACHE_NONE,
+	CACHE_DISABLED,
+	CACHE_ENABLED,
+	CACHE_INVALID
+};
+
 /* Per-controller data */
 struct ipr_ioa_cfg {
 	char eye_catcher[8];
@@ -841,6 +923,7 @@ struct ipr_ioa_cfg {
 	u8 allow_cmds:1;
 	u8 allow_ml_add_del:1;
 
+	enum ipr_cache_state cache_state;
 	u16 type; /* CCIN of the card */
 
 	u8 log_level;
@@ -911,6 +994,7 @@ struct ipr_ioa_cfg {
 	u16 reset_retries;
 
 	u32 errors_logged;
+	u32 doorbell;
 
 	struct Scsi_Host *host;
 	struct pci_dev *pdev;
@@ -948,6 +1032,7 @@ struct ipr_cmnd {
 	struct timer_list timer;
 	void (*done) (struct ipr_cmnd *);
 	int (*job_step) (struct ipr_cmnd *);
+	int (*job_step_failed) (struct ipr_cmnd *);
 	u16 cmd_index;
 	u8 sense_buffer[SCSI_SENSE_BUFFERSIZE];
 	dma_addr_t sense_buffer_dma;
@@ -1083,11 +1168,7 @@ struct ipr_ucode_image_header {
 /*
  * Macros
  */
-#if IPR_DEBUG
-#define IPR_DBG_CMD(CMD) do { CMD; } while (0)
-#else
-#define IPR_DBG_CMD(CMD)
-#endif
+#define IPR_DBG_CMD(CMD) if (ipr_debug) { CMD; }
 
 #ifdef CONFIG_SCSI_IPR_TRACE
 #define ipr_create_trace_file(kobj, attr) sysfs_create_bin_file(kobj, attr)
@@ -1135,16 +1216,22 @@ struct ipr_ucode_image_header {
 #define ipr_res_dbg(ioa_cfg, res, fmt, ...) \
 	IPR_DBG_CMD(ipr_res_printk(KERN_INFO, ioa_cfg, res, fmt, ##__VA_ARGS__))
 
+#define ipr_phys_res_err(ioa_cfg, res, fmt, ...)			\
+{									\
+	if ((res).bus >= IPR_MAX_NUM_BUSES) {				\
+		ipr_err(fmt": unknown\n", ##__VA_ARGS__);		\
+	} else {							\
+		ipr_err(fmt": %d:%d:%d:%d\n",				\
+			##__VA_ARGS__, (ioa_cfg)->host->host_no,	\
+			(res).bus, (res).target, (res).lun);		\
+	}								\
+}
+
 #define ipr_trace ipr_dbg("%s: %s: Line: %d\n",\
 	__FILE__, __FUNCTION__, __LINE__)
 
-#if IPR_DBG_TRACE
-#define ENTER printk(KERN_INFO IPR_NAME": Entering %s\n", __FUNCTION__)
-#define LEAVE printk(KERN_INFO IPR_NAME": Leaving %s\n", __FUNCTION__)
-#else
-#define ENTER
-#define LEAVE
-#endif
+#define ENTER IPR_DBG_CMD(printk(KERN_INFO IPR_NAME": Entering %s\n", __FUNCTION__))
+#define LEAVE IPR_DBG_CMD(printk(KERN_INFO IPR_NAME": Leaving %s\n", __FUNCTION__))
 
 #define ipr_err_separator \
 ipr_err("----------------------------------------------------------\n")
@@ -1217,6 +1304,20 @@ static inline int ipr_is_gscsi(struct ip
 }
 
 /**
+ * ipr_is_naca_model - Determine if a resource is using NACA queueing model
+ * @res:	resource entry struct
+ *
+ * Return value:
+ * 	1 if NACA queueing model / 0 if not NACA queueing model
+ **/
+static inline int ipr_is_naca_model(struct ipr_resource_entry *res)
+{
+	if (ipr_is_gscsi(res) && IPR_QUEUEING_MODEL(res) == IPR_QUEUE_NACA_MODEL)
+		return 1;
+	return 0;
+}
+
+/**
  * ipr_is_device - Determine if resource address is that of a device
  * @res_addr:	resource address struct
  *
@@ -1226,7 +1327,7 @@ static inline int ipr_is_gscsi(struct ip
 static inline int ipr_is_device(struct ipr_res_addr *res_addr)
 {
 	if ((res_addr->bus < IPR_MAX_NUM_BUSES) &&
-	    (res_addr->target < IPR_MAX_NUM_TARGETS_PER_BUS))
+	    (res_addr->target < (IPR_MAX_NUM_TARGETS_PER_BUS - 1)))
 		return 1;
 
 	return 0;


-- 
Jens Axboe

