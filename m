Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVHXRD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVHXRD7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVHXRD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:03:59 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:34283 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751212AbVHXRD4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:03:56 -0400
Date: Wed, 24 Aug 2005 10:03:52 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Frederik Schueler <fs@lowpingbastards.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: new qla2xxx driver breaks SAN setup with 2 controllers
Message-ID: <20050824170352.GA16652@us.ibm.com>
References: <20050823112535.GB13391@mail.lowpingbastards.de> <20050823200040.GA8310@us.ibm.com> <20050824095520.GD13391@mail.lowpingbastards.de> <20050824100112.GA27216@infradead.org> <20050824124803.GE13391@mail.lowpingbastards.de> <20050824125022.GA29817@infradead.org> <20050824130823.GF13391@mail.lowpingbastards.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824130823.GF13391@mail.lowpingbastards.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 03:08:23PM +0200, Frederik Schueler wrote:
> Hello,
> 
> no change.

What was logged? Any errors?

Try setting scsi logging_level for scan, after boot/load:

     sysctl -w dev.scsi.logging_level=0x1c0

Then reload the qla driver, and post logs.

If the qlogic driver returned DID_NO_CONNECT while scanning (or similar
errors), we stop the scan, but there is no code like that in the mainline
qlogic driver.

Can you also try this patch to use REPORT LUN scan even if no storage on
LUN 0?  Herre posted a similar patch that keeps LUN 0 around after the
scan, this version does not; I was going to post this after 2.6.13 was
out.

Also, you can pass devinfo additions as a module param (or boot time
param).

diff -uprN -X /home/patman/dontdiff linux-2.6.13-rc6-git13/drivers/scsi/scsi_scan.c lun0-linux-2.6.13-rc6-git13/drivers/scsi/scsi_scan.c
--- linux-2.6.13-rc6-git13/drivers/scsi/scsi_scan.c	2005-08-21 03:20:19.000000000 -0700
+++ lun0-linux-2.6.13-rc6-git13/drivers/scsi/scsi_scan.c	2005-08-24 09:22:23.000000000 -0700
@@ -64,14 +64,14 @@
  * SCSI_SCAN_NO_RESPONSE: no valid response received from the target, this
  * includes allocation or general failures preventing IO from being sent.
  *
- * SCSI_SCAN_TARGET_PRESENT: target responded, but no device is available
+ * SCSI_SCAN_LUN_IGNORED: target responded, but no device is available
  * on the given LUN.
  *
  * SCSI_SCAN_LUN_PRESENT: target responded, and a device is available on a
  * given LUN.
  */
 #define SCSI_SCAN_NO_RESPONSE		0
-#define SCSI_SCAN_TARGET_PRESENT	1
+#define SCSI_SCAN_LUN_IGNORED		1
 #define SCSI_SCAN_LUN_PRESENT		2
 
 static char *scsi_null_device_strs = "nullnullnullnull";
@@ -585,7 +585,7 @@ static void scsi_probe_lun(struct scsi_r
 
 	/*
 	 * The scanning code needs to know the scsi_level, even if no
-	 * device is attached at LUN 0 (SCSI_SCAN_TARGET_PRESENT) so
+	 * device is attached at LUN 0 (SCSI_SCAN_LUN_IGNORED) so
 	 * non-zero LUNs can be scanned.
 	 */
 	sdev->scsi_level = inq_result[2] & 0x07;
@@ -776,6 +776,19 @@ static int scsi_add_lun(struct scsi_devi
 	return SCSI_SCAN_LUN_PRESENT;
 }
 
+/*
+ * scsi_scan_remove: Helper funciton to free up sdev's that are not added
+ * as sys devices. That is, we never call scsi_probe_and_add_lun for these
+ * sdev's.
+ */
+static void scsi_scan_remove(struct scsi_device *sdev)
+{
+	if (sdev->host->hostt->slave_destroy)
+		sdev->host->hostt->slave_destroy(sdev);
+	transport_destroy_device(&sdev->sdev_gendev);
+	put_device(&sdev->sdev_gendev);
+}
+
 /**
  * scsi_probe_and_add_lun - probe a LUN, if a LUN is found add it
  * @starget:	pointer to target device structure
@@ -788,9 +801,12 @@ static int scsi_add_lun(struct scsi_devi
  *     Call scsi_probe_lun, if a LUN with an attached device is found,
  *     allocate and set it up by calling scsi_add_lun.
  *
+ * Note: LUN 0 is special cased so it can be used for a REPORT LUN scan,
+ *     the caller must release the sdev if we return SCSI_SCAN_LUN_IGNORED.
+ *
  * Return:
  *     SCSI_SCAN_NO_RESPONSE: could not allocate or setup a Scsi_Device
- *     SCSI_SCAN_TARGET_PRESENT: target responded, but no device is
+ *     SCSI_SCAN_LUN_IGNORED: target responded, but no device is
  *         attached at the LUN
  *     SCSI_SCAN_LUN_PRESENT: a new Scsi_Device was allocated and initialized
  **/
@@ -860,7 +876,7 @@ static int scsi_probe_and_add_lun(struct
 		SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO
 					"scsi scan: peripheral qualifier of 3,"
 					" no device added\n"));
-		res = SCSI_SCAN_TARGET_PRESENT;
+		res = SCSI_SCAN_LUN_IGNORED;
 		goto out_free_result;
 	}
 
@@ -879,17 +895,14 @@ static int scsi_probe_and_add_lun(struct
  out_free_sreq:
 	scsi_release_request(sreq);
  out_free_sdev:
-	if (res == SCSI_SCAN_LUN_PRESENT) {
+	if ((res == SCSI_SCAN_LUN_PRESENT) ||
+	    ((lun == 0) && (res == SCSI_SCAN_LUN_IGNORED))) {
 		if (sdevp) {
 			scsi_device_get(sdev);
 			*sdevp = sdev;
 		}
-	} else {
-		if (sdev->host->hostt->slave_destroy)
-			sdev->host->hostt->slave_destroy(sdev);
-		transport_destroy_device(&sdev->sdev_gendev);
-		put_device(&sdev->sdev_gendev);
-	}
+	} else
+		scsi_scan_remove(sdev);
  out:
 	return res;
 }
@@ -1266,6 +1279,8 @@ struct scsi_device *__scsi_add_device(st
 	get_device(&starget->dev);
 	down(&shost->scan_mutex);
 	res = scsi_probe_and_add_lun(starget, lun, NULL, &sdev, 1, hostdata);
+	if ((lun == 0) && (res == SCSI_SCAN_LUN_IGNORED))
+		scsi_scan_remove(sdev);
 	if (res != SCSI_SCAN_LUN_PRESENT)
 		sdev = ERR_PTR(-ENODEV);
 	up(&shost->scan_mutex);
@@ -1337,7 +1352,8 @@ void scsi_scan_target(struct device *par
 		/*
 		 * Scan for a specific host/chan/id/lun.
 		 */
-		scsi_probe_and_add_lun(starget, lun, NULL, NULL, rescan, NULL);
+		res = scsi_probe_and_add_lun(starget, lun, NULL, &sdev,
+					     rescan, NULL);
 		goto out_reap;
 	}
 
@@ -1345,8 +1361,11 @@ void scsi_scan_target(struct device *par
 	 * Scan LUN 0, if there is some response, scan further. Ideally, we
 	 * would not configure LUN 0 until all LUNs are scanned.
 	 */
-	res = scsi_probe_and_add_lun(starget, 0, &bflags, &sdev, rescan, NULL);
-	if (res == SCSI_SCAN_LUN_PRESENT) {
+	lun = 0;
+	res = scsi_probe_and_add_lun(starget, lun, &bflags, &sdev, rescan,
+				     NULL);
+	WARN_ON(!sdev && res != SCSI_SCAN_NO_RESPONSE);
+	if (sdev && res != SCSI_SCAN_NO_RESPONSE)
 		if (scsi_report_lun_scan(sdev, bflags, rescan) != 0)
 			/*
 			 * The REPORT LUN did not scan the target,
@@ -1354,20 +1373,12 @@ void scsi_scan_target(struct device *par
 			 */
 			scsi_sequential_lun_scan(starget, bflags,
 				       	res, sdev->scsi_level, rescan);
-	} else if (res == SCSI_SCAN_TARGET_PRESENT) {
-		/*
-		 * There's a target here, but lun 0 is offline so we
-		 * can't use the report_lun scan.  Fall back to a
-		 * sequential lun scan with a bflags of SPARSELUN and
-		 * a default scsi level of SCSI_2
-		 */
-		scsi_sequential_lun_scan(starget, BLIST_SPARSELUN,
-				SCSI_SCAN_TARGET_PRESENT, SCSI_2, rescan);
-	}
 	if (sdev)
 		scsi_device_put(sdev);
 
  out_reap:
+	if ((lun == 0) && (res == SCSI_SCAN_LUN_IGNORED))
+		scsi_scan_remove(sdev);
 	/* now determine if the target has any children at all
 	 * and if not, nuke it */
 	scsi_target_reap(starget);

-- Patrick Mansfield
