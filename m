Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267659AbTAHCHD>; Tue, 7 Jan 2003 21:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267661AbTAHCHD>; Tue, 7 Jan 2003 21:07:03 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:29779
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267659AbTAHCG7>; Tue, 7 Jan 2003 21:06:59 -0500
Date: Tue, 7 Jan 2003 21:17:46 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.54: ide-scsi still buggy?
In-Reply-To: <20030108014005.GC725@mail.muni.cz>
Message-ID: <Pine.LNX.4.50.0301072116450.4046-100000@montezuma.mastecende.com>
References: <20030108014005.GC725@mail.muni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2003, Lukas Hejtmanek wrote:

> Hello,
>
> ide-scsi emulation does not work for drive /dev/hdg, why?
>
> kernel boot parameters:
> kernel /boot/vmlinuz-2.5.54bk3 ro root=/dev/hda1 ide=reverse vga=4 hdg=ide-scsi
>
> It freezes kernel (sysrq do nothing) after lines:
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: TEAC      Model: CD-W512EB         Rev: 2
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> scsi scan: host 0 channel 0 id 0 lun 0 identifier too long, length 60, max 50. Device might be improperly identified.
>
> while attaching it to /dev/hde works ok. Why?

This has been observed to cause an oops on some boxes and nothing on mine,
try this patch from Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	Wed Jan  1 23:54:23 2003
+++ b/drivers/scsi/scsi_scan.c	Sun Jan  5 14:22:21 2003
@@ -544,32 +544,6 @@
 }

 /**
- * scsi_check_id_size - check if size fits in the driverfs name
- * @sdev:	Scsi_Device to use for error message
- * @size:	the length of the id we want to store
- *
- * Description:
- *     Use a function for this since the same code is used in various
- *     places, and we only create one string and call to printk.
- *
- * Return:
- *     0 - fits
- *     1 - size too large
- **/
-static int scsi_check_id_size(Scsi_Device *sdev, int size)
-{
-	if (size > DEVICE_NAME_SIZE) {
-		printk(KERN_WARNING "scsi scan: host %d channel %d id %d lun %d"
-		       " identifier too long, length %d, max %d. Device might"
-		       " be improperly identified.\n", sdev->host->host_no,
-		       sdev->channel, sdev->id, sdev->lun, size,
-		       DEVICE_NAME_SIZE);
-		return 1;
-	} else
-		return 0;
-}
-
-/**
  * scsi_get_evpd_page - get a list of supported vpd pages
  * @sdev:	Scsi_Device to send an INQUIRY VPD
  * @sreq:	Scsi_Request associated with @sdev
@@ -715,17 +689,16 @@
  * scsi_check_fill_deviceid - check the id and if OK fill it
  * @sdev:	device to use for error messages
  * @id_page:	id descriptor for INQUIRY VPD DEVICE ID, page 0x83
- * @name:	store the id in name
+ * @name:	store the id in name (of size DEVICE_NAME_SIZE > 26)
  * @id_search:	store if the id_page matches these values
  *
  * Description:
  *     Check if @id_page matches the @id_search, if so store an id (uid)
- *     into name.
+ *     into name, that is all zero on entrance.
  *
  * Return:
  *     0: Success
  *     1: No match
- *     2: Failure due to size constraints
  **/
 static int scsi_check_fill_deviceid(Scsi_Device *sdev, char *id_page,
 	char *name, const struct scsi_id_search_values *id_search)
@@ -755,70 +728,41 @@
 	if ((id_page[0] & 0x0f) != id_search->code_set)
 		return 1;

-	name[0]  = hex_str[id_search->id_type];
+	/*
+	 * All OK - store ID
+	 */
+	name[0] = hex_str[id_search->id_type];
+
+	/*
+	 * Prepend the vendor and model before the id, since the id
+	 * might not be unique across all vendors and models.
+	 * The same code is used below, with a different size.
+	 */
+	if (id_search->id_type == SCSI_ID_VENDOR_SPECIFIC) {
+		strncat(name, sdev->vendor, 8);
+		strncat(name, sdev->model, 16);
+	}
+
+	i = 4;
+	j = strlen(name);
 	if ((id_page[0] & 0x0f) == SCSI_ID_ASCII) {
 		/*
 		 * ASCII descriptor.
 		 */
-		if (id_search->id_type == SCSI_ID_VENDOR_SPECIFIC) {
-			/*
-			 * Prepend the vendor and model before the id,
-			 * since the id might not be unique across all
-			 * vendors and models. The same code is used
-			 * below, with a differnt size.
-			 *
-			 * Need 1 byte for the idtype, 1 for trailing
-			 * '\0', 8 for vendor, 16 for model total 26, plus
-			 * the name descriptor length.
-			 */
-			if (scsi_check_id_size(sdev, 26 + id_page[3]))
-				return 2;
-			else {
-				strncat(name, sdev->vendor, 8);
-				strncat(name, sdev->model, 16);
-			}
-		} else if (scsi_check_id_size (sdev, (2 + id_page[3])))
-			/*
-			 * Need 1 byte for the idtype, 1 byte for
-			 * the trailing '\0', plus the descriptor length.
-			 */
-			return 2;
-		memcpy(&name[strlen(name)], &id_page[4], id_page[3]);
-		return 0;
-	} else if ((id_page[0] & 0x0f) == SCSI_ID_BINARY) {
-		if (id_search->id_type == SCSI_ID_VENDOR_SPECIFIC) {
-			/*
-			 * Prepend the vendor and model before the id.
-			 */
-			if (scsi_check_id_size(sdev, 26 + (id_page[3] * 2)))
-				return 2;
-			else {
-				strncat(name, sdev->vendor, 8);
-				strncat(name, sdev->model, 16);
-			}
-		} else if (scsi_check_id_size(sdev, 2 + (id_page[3] * 2)))
-			/*
-			 * Need 1 byte for the idtype, 1 for trailing
-			 * '\0', 8 for vendor, 16 for model total 26, plus
-			 * the name descriptor length.
-			 */
-			return 2;
+		while (i < 4 + id_page[3] && j < DEVICE_NAME_SIZE-1)
+			name[j++] = id_page[i++];
+	} else {
 		/*
 		 * Binary descriptor, convert to ASCII, using two bytes of
-		 * ASCII for each byte in the id_page. Store starting at
-		 * the end of name.
+		 * ASCII for each byte in the id_page.
 		 */
-		for(i = 4, j = strlen(name); i < 4 + id_page[3]; i++) {
+		while (i < 4 + id_page[3] && j < DEVICE_NAME_SIZE-2) {
 			name[j++] = hex_str[(id_page[i] & 0xf0) >> 4];
 			name[j++] = hex_str[id_page[i] & 0x0f];
+			i++;
 		}
-		return 0;
 	}
-	/*
-	 * Code set must have already matched.
-	 */
-	printk(KERN_ERR "scsi scan: scsi_check_fill_deviceid unexpected state.\n");
-	return 1;
+	return 0;
 }

 /**
@@ -834,7 +778,7 @@
  *     0: Failure
  *     1: Success
  **/
-int scsi_get_deviceid(Scsi_Device *sdev, Scsi_Request *sreq)
+static int scsi_get_deviceid(Scsi_Device *sdev, Scsi_Request *sreq)
 {
 	unsigned char *id_page;
 	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
@@ -879,14 +823,14 @@
 	}

 	/*
-	 * Search for a match in the proiritized id_search_list.
+	 * Search for a match in the prioritized id_search_list.
 	 */
 	for (id_idx = 0; id_idx < ARRAY_SIZE(id_search_list); id_idx++) {
 		/*
 		 * Examine each descriptor returned. There is normally only
 		 * one or a small number of descriptors.
 		 */
-		for(scnt = 4; scnt <= id_page[3] + 3;
+		for (scnt = 4; scnt <= id_page[3] + 3;
 			scnt += id_page[scnt + 3] + 4) {
 			if ((scsi_check_fill_deviceid(sdev, &id_page[scnt],
 			     sdev->sdev_driverfs_dev.name,
@@ -941,12 +885,11 @@
 {
 	unsigned char *serialnumber_page;
 	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
-	int max_lgth = 255;
+	const int max_lgth = 255;
+	int len;

- retry:
 	serialnumber_page = kmalloc(max_lgth, GFP_ATOMIC |
-			      (sdev->host->unchecked_isa_dma) ?
-			      GFP_DMA : 0);
+			      (sdev->host->unchecked_isa_dma) ? GFP_DMA : 0);
 	if (!serialnumber_page) {
 		printk(KERN_WARNING "scsi scan: Allocation failure identifying"
 		       " host %d channel %d id %d lun %d, device might be"
@@ -969,26 +912,19 @@

 	if (sreq->sr_result)
 		goto leave;
-	/*
-	 * check to see if response was truncated
-	 */
-	if (serialnumber_page[3] > max_lgth) {
-		max_lgth = serialnumber_page[3] + 4;
-		kfree(serialnumber_page);
-		goto retry;
-	}

 	/*
-	 * Need 1 byte for SCSI_UID_SER_NUM, 1 for trailing '\0', 8 for
-	 * vendor, 16 for model = 26, plus serial number size.
+	 * a check to see if response was truncated is superfluous,
+	 * since serialnumber_page[3] cannot be larger than 255
 	 */
-	if (scsi_check_id_size (sdev, (26 + serialnumber_page[3])))
-		goto leave;
+
 	sdev->sdev_driverfs_dev.name[0] = SCSI_UID_SER_NUM;
 	strncat(sdev->sdev_driverfs_dev.name, sdev->vendor, 8);
 	strncat(sdev->sdev_driverfs_dev.name, sdev->model, 16);
-	strncat(sdev->sdev_driverfs_dev.name, &serialnumber_page[4],
-		serialnumber_page[3]);
+	len = serialnumber_page[3];
+	if (len > DEVICE_NAME_SIZE-26)
+		len = DEVICE_NAME_SIZE-26;
+	strncat(sdev->sdev_driverfs_dev.name, &serialnumber_page[4], len);
 	kfree(serialnumber_page);
 	return 1;
  leave:
@@ -1002,23 +938,19 @@
  * @sdev:	get a default name for this device
  *
  * Description:
- *     Set the name of @sdev to the concatenation of the vendor, model,
- *     and revision found in @sdev.
+ *     Set the name of @sdev (of size DEVICE_NAME_SIZE > 29) to the
+ *     concatenation of the vendor, model, and revision found in @sdev.
  *
  * Return:
  *     1: Success
  **/
 int scsi_get_default_name(Scsi_Device *sdev)
 {
-	if (scsi_check_id_size(sdev, 29))
-		return 0;
-	else {
-		sdev->sdev_driverfs_dev.name[0] = SCSI_UID_UNKNOWN;
-		strncpy(&sdev->sdev_driverfs_dev.name[1], sdev->vendor, 8);
-		strncat(sdev->sdev_driverfs_dev.name, sdev->model, 16);
-		strncat(sdev->sdev_driverfs_dev.name, sdev->rev, 4);
-		return 1;
-	}
+	sdev->sdev_driverfs_dev.name[0] = SCSI_UID_UNKNOWN;
+	strncpy(&sdev->sdev_driverfs_dev.name[1], sdev->vendor, 8);
+	strncat(sdev->sdev_driverfs_dev.name, sdev->model, 16);
+	strncat(sdev->sdev_driverfs_dev.name, sdev->rev, 4);
+	return 1;
 }

 /**

-- 
function.linuxpower.ca
