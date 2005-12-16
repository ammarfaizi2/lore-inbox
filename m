Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbVLPAaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVLPAaK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVLPAaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:30:10 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:65219 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S1751213AbVLPAaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:30:09 -0500
Message-ID: <43A20A89.4060904@shadowconnect.com>
Date: Fri, 16 Dec 2005 01:30:01 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] I2O: SPARC fixes
Content-Type: multipart/mixed;
 boundary="------------070302000207010604080002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070302000207010604080002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:
--------
- Fixed lot of BE <-> LE bugs which prevent it from working on SPARC.

Signed-off-by: Markus Lidel <Markus.Lidel@shadowconnect.com>

--------------070302000207010604080002
Content-Type: text/x-patch;
 name="i2o-sparc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-sparc.patch"

Index: linux-2.6/drivers/message/i2o/Kconfig
===================================================================
--- linux-2.6.orig/drivers/message/i2o/Kconfig
+++ linux-2.6/drivers/message/i2o/Kconfig
@@ -24,6 +24,18 @@ config I2O
 
 	  If unsure, say N.
 
+config I2O_LCT_NOTIFY_ON_CHANGES
+	bool "Enable LCT notification"
+	depends on I2O
+	default y
+	---help---
+	  Only say N here if you have a I2O controller from SUN. The SUN
+	  firmware doesn't support LCT notification on changes. If this option
+	  is enabled on such a controller the driver will hang up in a endless
+	  loop. On all other controllers say Y.
+
+	  If unsure, say Y.
+
 config I2O_EXT_ADAPTEC
 	bool "Enable Adaptec extensions"
 	depends on I2O
Index: linux-2.6/drivers/message/i2o/device.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/device.c
+++ linux-2.6/drivers/message/i2o/device.c
@@ -341,56 +341,83 @@ int i2o_device_parse_lct(struct i2o_cont
 {
 	struct i2o_device *dev, *tmp;
 	i2o_lct *lct;
-	int i;
-	int max;
+	u32 *dlct = c->dlct.virt;
+	int max = 0, i = 0;
+	u16 table_size;
+	u32 buf;
 
 	down(&c->lct_lock);
 
 	kfree(c->lct);
 
-	lct = c->dlct.virt;
+	buf = le32_to_cpu(*dlct++);
+	table_size = buf & 0xffff;
 
-	c->lct = kmalloc(lct->table_size * 4, GFP_KERNEL);
-	if (!c->lct) {
+	lct = c->lct = kmalloc(table_size * 4, GFP_KERNEL);
+	if (!lct) {
 		up(&c->lct_lock);
 		return -ENOMEM;
 	}
 
-	if (lct->table_size * 4 > c->dlct.len) {
-		memcpy(c->lct, c->dlct.virt, c->dlct.len);
-		up(&c->lct_lock);
-		return -EAGAIN;
-	}
-
-	memcpy(c->lct, c->dlct.virt, lct->table_size * 4);
+	lct->lct_ver = buf >> 28;
+	lct->boot_tid = buf >> 16 & 0xfff;
+	lct->table_size = table_size;
+	lct->change_ind = le32_to_cpu(*dlct++);
+	lct->iop_flags = le32_to_cpu(*dlct++);
 
-	lct = c->lct;
-
-	max = (lct->table_size - 3) / 9;
+	table_size -= 3;
 
 	pr_debug("%s: LCT has %d entries (LCT size: %d)\n", c->name, max,
 		 lct->table_size);
 
-	/* remove devices, which are not in the LCT anymore */
-	list_for_each_entry_safe(dev, tmp, &c->devices, list) {
+	while (table_size > 0) {
+		i2o_lct_entry *entry = &lct->lct_entry[max];
 		int found = 0;
 
-		for (i = 0; i < max; i++) {
-			if (lct->lct_entry[i].tid == dev->lct_data.tid) {
+		buf = le32_to_cpu(*dlct++);
+		entry->entry_size = buf & 0xffff;
+		entry->tid = buf >> 16 & 0xfff;
+
+		entry->change_ind = le32_to_cpu(*dlct++);
+		entry->device_flags = le32_to_cpu(*dlct++);
+
+		buf = le32_to_cpu(*dlct++);
+		entry->class_id = buf & 0xfff;
+		entry->version = buf >> 12 & 0xf;
+		entry->vendor_id = buf >> 16;
+
+		entry->sub_class = le32_to_cpu(*dlct++);
+
+		buf = le32_to_cpu(*dlct++);
+		entry->user_tid = buf & 0xfff;
+		entry->parent_tid = buf >> 12 & 0xfff;
+		entry->bios_info = buf >> 24;
+
+		memcpy(&entry->identity_tag, dlct, 8);
+		dlct += 2;
+
+		entry->event_capabilities = le32_to_cpu(*dlct++);
+
+		/* add new devices, which are new in the LCT */
+		list_for_each_entry_safe(dev, tmp, &c->devices, list) {
+			if (entry->tid == dev->lct_data.tid) {
 				found = 1;
 				break;
 			}
 		}
 
 		if (!found)
-			i2o_device_remove(dev);
+			i2o_device_add(c, entry);
+
+		table_size -= 9;
+		max++;
 	}
 
-	/* add new devices, which are new in the LCT */
-	for (i = 0; i < max; i++) {
+	/* remove devices, which are not in the LCT anymore */
+	list_for_each_entry_safe(dev, tmp, &c->devices, list) {
 		int found = 0;
 
-		list_for_each_entry_safe(dev, tmp, &c->devices, list) {
+		for (i = 0; i < max; i++) {
 			if (lct->lct_entry[i].tid == dev->lct_data.tid) {
 				found = 1;
 				break;
@@ -398,8 +425,9 @@ int i2o_device_parse_lct(struct i2o_cont
 		}
 
 		if (!found)
-			i2o_device_add(c, &lct->lct_entry[i]);
+			i2o_device_remove(dev);
 	}
+
 	up(&c->lct_lock);
 
 	return 0;
@@ -422,9 +450,6 @@ int i2o_parm_issue(struct i2o_device *i2
 		   int oplen, void *reslist, int reslen)
 {
 	struct i2o_message *msg;
-	u32 *res32 = (u32 *) reslist;
-	u32 *restmp = (u32 *) reslist;
-	int len = 0;
 	int i = 0;
 	int rc;
 	struct i2o_dma res;
@@ -448,7 +473,6 @@ int i2o_parm_issue(struct i2o_device *i2
 	msg->body[i++] = cpu_to_le32(0x00000000);
 	msg->body[i++] = cpu_to_le32(0x4C000000 | oplen);	/* OperationList */
 	memcpy(&msg->body[i], oplist, oplen);
-
 	i += (oplen / 4 + (oplen % 4 ? 1 : 0));
 	msg->body[i++] = cpu_to_le32(0xD0000000 | res.len);	/* ResultList */
 	msg->body[i++] = cpu_to_le32(res.phys);
@@ -466,36 +490,7 @@ int i2o_parm_issue(struct i2o_device *i2
 	memcpy(reslist, res.virt, res.len);
 	i2o_dma_free(dev, &res);
 
-	/* Query failed */
-	if (rc)
-		return rc;
-	/*
-	 * Calculate number of bytes of Result LIST
-	 * We need to loop through each Result BLOCK and grab the length
-	 */
-	restmp = res32 + 1;
-	len = 1;
-	for (i = 0; i < (res32[0] & 0X0000FFFF); i++) {
-		if (restmp[0] & 0x00FF0000) {	/* BlockStatus != SUCCESS */
-			printk(KERN_WARNING
-			       "%s - Error:\n  ErrorInfoSize = 0x%02x, "
-			       "BlockStatus = 0x%02x, BlockSize = 0x%04x\n",
-			       (cmd ==
-				I2O_CMD_UTIL_PARAMS_SET) ? "PARAMS_SET" :
-			       "PARAMS_GET", res32[1] >> 24,
-			       (res32[1] >> 16) & 0xFF, res32[1] & 0xFFFF);
-
-			/*
-			 *      If this is the only request,than we return an error
-			 */
-			if ((res32[0] & 0x0000FFFF) == 1) {
-				return -((res32[1] >> 16) & 0xFF);	/* -BlockStatus */
-			}
-		}
-		len += restmp[0] & 0x0000FFFF;	/* Length of res BLOCK */
-		restmp += restmp[0] & 0x0000FFFF;	/* Skip to next BLOCK */
-	}
-	return (len << 2);	/* bytes used by result list */
+	return rc;
 }
 
 /*
@@ -504,28 +499,25 @@ int i2o_parm_issue(struct i2o_device *i2
 int i2o_parm_field_get(struct i2o_device *i2o_dev, int group, int field,
 		       void *buf, int buflen)
 {
-	u16 opblk[] = { 1, 0, I2O_PARAMS_FIELD_GET, group, 1, field };
+	u32 opblk[] = { cpu_to_le32(0x00000001),
+		cpu_to_le32((u16) group << 16 | I2O_PARAMS_FIELD_GET),
+		cpu_to_le32((s16) field << 16 | 0x00000001)
+	};
 	u8 *resblk;		/* 8 bytes for header */
-	int size;
-
-	if (field == -1)	/* whole group */
-		opblk[4] = -1;
+	int rc;
 
 	resblk = kmalloc(buflen + 8, GFP_KERNEL | GFP_ATOMIC);
 	if (!resblk)
 		return -ENOMEM;
 
-	size = i2o_parm_issue(i2o_dev, I2O_CMD_UTIL_PARAMS_GET, opblk,
-			      sizeof(opblk), resblk, buflen + 8);
+	rc = i2o_parm_issue(i2o_dev, I2O_CMD_UTIL_PARAMS_GET, opblk,
+			    sizeof(opblk), resblk, buflen + 8);
 
 	memcpy(buf, resblk + 8, buflen);	/* cut off header */
 
 	kfree(resblk);
 
-	if (size > buflen)
-		return buflen;
-
-	return size;
+	return rc;
 }
 
 /*
Index: linux-2.6/drivers/message/i2o/exec-osm.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/exec-osm.c
+++ linux-2.6/drivers/message/i2o/exec-osm.c
@@ -77,7 +77,7 @@ static struct i2o_exec_wait *i2o_exec_wa
 
 	wait = kmalloc(sizeof(*wait), GFP_KERNEL);
 	if (!wait)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	memset(wait, 0, sizeof(*wait));
 
@@ -271,8 +271,8 @@ static ssize_t i2o_exec_show_vendor_id(s
 	struct i2o_device *dev = to_i2o_device(d);
 	u16 id;
 
-	if (i2o_parm_field_get(dev, 0x0000, 0, &id, 2)) {
-		sprintf(buf, "0x%04x", id);
+	if (!i2o_parm_field_get(dev, 0x0000, 0, &id, 2)) {
+		sprintf(buf, "0x%04x", le16_to_cpu(id));
 		return strlen(buf) + 1;
 	}
 
@@ -293,8 +293,8 @@ static ssize_t i2o_exec_show_product_id(
 	struct i2o_device *dev = to_i2o_device(d);
 	u16 id;
 
-	if (i2o_parm_field_get(dev, 0x0000, 1, &id, 2)) {
-		sprintf(buf, "0x%04x", id);
+	if (!i2o_parm_field_get(dev, 0x0000, 1, &id, 2)) {
+		sprintf(buf, "0x%04x", le16_to_cpu(id));
 		return strlen(buf) + 1;
 	}
 
@@ -364,7 +364,9 @@ static void i2o_exec_lct_modified(struct
 	if (i2o_device_parse_lct(c) != -EAGAIN)
 		change_ind = c->lct->change_ind + 1;
 
+#ifdef CONFIG_I2O_LCT_NOTIFY_ON_CHANGES
 	i2o_exec_lct_notify(c, change_ind);
+#endif
 };
 
 /**
@@ -512,7 +514,8 @@ static int i2o_exec_lct_notify(struct i2
 
 	dev = &c->pdev->dev;
 
-	if (i2o_dma_realloc(dev, &c->dlct, sb->expected_lct_size, GFP_KERNEL))
+	if (i2o_dma_realloc
+	    (dev, &c->dlct, le32_to_cpu(sb->expected_lct_size), GFP_KERNEL))
 		return -ENOMEM;
 
 	msg = i2o_msg_get_wait(c, I2O_TIMEOUT_MESSAGE_GET);
Index: linux-2.6/drivers/message/i2o/i2o_block.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/i2o_block.c
+++ linux-2.6/drivers/message/i2o/i2o_block.c
@@ -1050,8 +1050,8 @@ static int i2o_block_probe(struct device
 	int rc;
 	u64 size;
 	u32 blocksize;
-	u32 flags, status;
 	u16 body_size = 4;
+	u16 power;
 	unsigned short max_sectors;
 
 #ifdef CONFIG_I2O_EXT_ADAPTEC
@@ -1109,22 +1109,20 @@ static int i2o_block_probe(struct device
 	 *      Ask for the current media data. If that isn't supported
 	 *      then we ask for the device capacity data
 	 */
-	if (i2o_parm_field_get(i2o_dev, 0x0004, 1, &blocksize, 4) ||
-	    i2o_parm_field_get(i2o_dev, 0x0000, 3, &blocksize, 4)) {
-		blk_queue_hardsect_size(queue, blocksize);
+	if (!i2o_parm_field_get(i2o_dev, 0x0004, 1, &blocksize, 4) ||
+	    !i2o_parm_field_get(i2o_dev, 0x0000, 3, &blocksize, 4)) {
+		blk_queue_hardsect_size(queue, le32_to_cpu(blocksize));
 	} else
 		osm_warn("unable to get blocksize of %s\n", gd->disk_name);
 
-	if (i2o_parm_field_get(i2o_dev, 0x0004, 0, &size, 8) ||
-	    i2o_parm_field_get(i2o_dev, 0x0000, 4, &size, 8)) {
-		set_capacity(gd, size >> KERNEL_SECTOR_SHIFT);
+	if (!i2o_parm_field_get(i2o_dev, 0x0004, 0, &size, 8) ||
+	    !i2o_parm_field_get(i2o_dev, 0x0000, 4, &size, 8)) {
+		set_capacity(gd, le64_to_cpu(size) >> KERNEL_SECTOR_SHIFT);
 	} else
 		osm_warn("could not get size of %s\n", gd->disk_name);
 
-	if (!i2o_parm_field_get(i2o_dev, 0x0000, 2, &i2o_blk_dev->power, 2))
-		i2o_blk_dev->power = 0;
-	i2o_parm_field_get(i2o_dev, 0x0000, 5, &flags, 4);
-	i2o_parm_field_get(i2o_dev, 0x0000, 6, &status, 4);
+	if (!i2o_parm_field_get(i2o_dev, 0x0000, 2, &power, 2))
+		i2o_blk_dev->power = power;
 
 	i2o_event_register(i2o_dev, &i2o_block_driver, 0, 0xffffffff);
 
Index: linux-2.6/drivers/message/i2o/i2o_scsi.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/i2o_scsi.c
+++ linux-2.6/drivers/message/i2o/i2o_scsi.c
@@ -113,7 +113,7 @@ static struct i2o_scsi_host *i2o_scsi_ho
 
 	list_for_each_entry(i2o_dev, &c->devices, list)
 	    if (i2o_dev->lct_data.class_id == I2O_CLASS_BUS_ADAPTER) {
-		if (i2o_parm_field_get(i2o_dev, 0x0000, 0, &type, 1)
+		if (!i2o_parm_field_get(i2o_dev, 0x0000, 0, &type, 1)
 		    && (type == 0x01))	/* SCSI bus */
 			max_channel++;
 	}
@@ -146,7 +146,7 @@ static struct i2o_scsi_host *i2o_scsi_ho
 	i = 0;
 	list_for_each_entry(i2o_dev, &c->devices, list)
 	    if (i2o_dev->lct_data.class_id == I2O_CLASS_BUS_ADAPTER) {
-		if (i2o_parm_field_get(i2o_dev, 0x0000, 0, &type, 1)
+		if (!i2o_parm_field_get(i2o_dev, 0x0000, 0, &type, 1)
 		    && (type == 0x01))	/* only SCSI bus */
 			i2o_shost->channel[i++] = i2o_dev;
 
@@ -238,13 +238,15 @@ static int i2o_scsi_probe(struct device 
 			u8 type;
 			struct i2o_device *d = i2o_shost->channel[0];
 
-			if (i2o_parm_field_get(d, 0x0000, 0, &type, 1)
+			if (!i2o_parm_field_get(d, 0x0000, 0, &type, 1)
 			    && (type == 0x01))	/* SCSI bus */
-				if (i2o_parm_field_get(d, 0x0200, 4, &id, 4)) {
+				if (!i2o_parm_field_get(d, 0x0200, 4, &id, 4)) {
 					channel = 0;
 					if (i2o_dev->lct_data.class_id ==
 					    I2O_CLASS_RANDOM_BLOCK_STORAGE)
-						lun = i2o_shost->lun++;
+						lun =
+						    cpu_to_le64(i2o_shost->
+								lun++);
 					else
 						lun = 0;
 				}
@@ -253,10 +255,10 @@ static int i2o_scsi_probe(struct device 
 		break;
 
 	case I2O_CLASS_SCSI_PERIPHERAL:
-		if (i2o_parm_field_get(i2o_dev, 0x0000, 3, &id, 4) < 0)
+		if (i2o_parm_field_get(i2o_dev, 0x0000, 3, &id, 4))
 			return -EFAULT;
 
-		if (i2o_parm_field_get(i2o_dev, 0x0000, 4, &lun, 8) < 0)
+		if (i2o_parm_field_get(i2o_dev, 0x0000, 4, &lun, 8))
 			return -EFAULT;
 
 		parent = i2o_iop_find_device(c, i2o_dev->lct_data.parent_tid);
@@ -281,20 +283,22 @@ static int i2o_scsi_probe(struct device 
 		return -EFAULT;
 	}
 
-	if (id >= scsi_host->max_id) {
-		osm_warn("SCSI device id (%d) >= max_id of I2O host (%d)", id,
-			 scsi_host->max_id);
+	if (le32_to_cpu(id) >= scsi_host->max_id) {
+		osm_warn("SCSI device id (%d) >= max_id of I2O host (%d)",
+			 le32_to_cpu(id), scsi_host->max_id);
 		return -EFAULT;
 	}
 
-	if (lun >= scsi_host->max_lun) {
-		osm_warn("SCSI device id (%d) >= max_lun of I2O host (%d)",
-			 (unsigned int)lun, scsi_host->max_lun);
+	if (le64_to_cpu(lun) >= scsi_host->max_lun) {
+		osm_warn("SCSI device lun (%lu) >= max_lun of I2O host (%d)",
+			 (long unsigned int)le64_to_cpu(lun),
+			 scsi_host->max_lun);
 		return -EFAULT;
 	}
 
 	scsi_dev =
-	    __scsi_add_device(i2o_shost->scsi_host, channel, id, lun, i2o_dev);
+	    __scsi_add_device(i2o_shost->scsi_host, channel, le32_to_cpu(id),
+			      le64_to_cpu(lun), i2o_dev);
 
 	if (IS_ERR(scsi_dev)) {
 		osm_warn("can not add SCSI device %03x\n",
@@ -306,7 +310,8 @@ static int i2o_scsi_probe(struct device 
 			  "scsi");
 
 	osm_info("device added (TID: %03x) channel: %d, id: %d, lun: %d\n",
-		 i2o_dev->lct_data.tid, channel, id, (unsigned int)lun);
+		 i2o_dev->lct_data.tid, channel, le32_to_cpu(id),
+		 (unsigned int)le64_to_cpu(lun));
 
 	return 0;
 };

--------------070302000207010604080002--
