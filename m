Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268344AbUHQQ5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268344AbUHQQ5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 12:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268346AbUHQQ5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 12:57:18 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:2054 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268344AbUHQQ4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 12:56:30 -0400
Date: Tue, 17 Aug 2004 17:56:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Christoph Hellwig <hch@infradead.org>, Warren Togami <wtogami@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Merge I2O patches from -mm
Message-ID: <20040817175624.A24038@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Markus Lidel <Markus.Lidel@shadowconnect.com>,
	Warren Togami <wtogami@redhat.com>, linux-kernel@vger.kernel.org
References: <411F37CC.3020909@redhat.com> <20040817125303.A21238@infradead.org> <412208A6.7020104@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <412208A6.7020104@shadowconnect.com>; from Markus.Lidel@shadowconnect.com on Tue, Aug 17, 2004 at 03:31:18PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below adds a __scsi_add_device that can "preload" sdev->hostdata.


--- 1.127/drivers/scsi/scsi_scan.c	2004-06-25 13:56:28 +02:00
+++ edited/drivers/scsi/scsi_scan.c	2004-08-17 20:41:07 +02:00
@@ -200,7 +200,7 @@
  *     scsi_Device pointer, or NULL on failure.
  **/
 static struct scsi_device *scsi_alloc_sdev(struct Scsi_Host *shost,
-	       	uint channel, uint id, uint lun)
+	       	uint channel, uint id, uint lun, void *hostdata)
 {
 	struct scsi_device *sdev, *device;
 	unsigned long flags;
@@ -224,6 +224,8 @@
 	INIT_LIST_HEAD(&sdev->starved_entry);
 	spin_lock_init(&sdev->list_lock);
 
+	/* usually NULL and set by ->slave_alloc instead */
+	sdev->hostdata = hostdata;
 
 	/* if the device needs this changing, it may do so in the
 	 * slave_configure function */
@@ -697,7 +699,7 @@
  **/
 static int scsi_probe_and_add_lun(struct Scsi_Host *host,
 		uint channel, uint id, uint lun, int *bflagsp,
-		struct scsi_device **sdevp, int rescan)
+		struct scsi_device **sdevp, int rescan, void *hostdata)
 {
 	struct scsi_device *sdev;
 	struct scsi_request *sreq;
@@ -726,7 +728,7 @@
 		}
 	}
 
-	sdev = scsi_alloc_sdev(host, channel, id, lun);
+	sdev = scsi_alloc_sdev(host, channel, id, lun, hostdata);
 	if (!sdev)
 		goto out;
 	sreq = scsi_allocate_request(sdev, GFP_ATOMIC);
@@ -874,7 +876,7 @@
 	 */
 	for (lun = 1; lun < max_dev_lun; ++lun)
 		if ((scsi_probe_and_add_lun(shost, channel, id, lun,
-		      NULL, NULL, rescan) != SCSI_SCAN_LUN_PRESENT) &&
+		      NULL, NULL, rescan, NULL) != SCSI_SCAN_LUN_PRESENT) &&
 		    !sparse_lun)
 			return;
 }
@@ -1085,7 +1087,7 @@
 			int res;
 
 			res = scsi_probe_and_add_lun(sdev->host, sdev->channel,
-				sdev->id, lun, NULL, NULL, rescan);
+				sdev->id, lun, NULL, NULL, rescan, NULL);
 			if (res == SCSI_SCAN_NO_RESPONSE) {
 				/*
 				 * Got some results, but now none, abort.
@@ -1111,14 +1113,15 @@
 	return 0;
 }
 
-struct scsi_device *scsi_add_device(struct Scsi_Host *shost,
-				    uint channel, uint id, uint lun)
+struct scsi_device *__scsi_add_device(struct Scsi_Host *shost, uint channel,
+		uint id, uint lun, void *hostdata)
 {
 	struct scsi_device *sdev;
 	int res;
 
 	down(&shost->scan_mutex);
-	res = scsi_probe_and_add_lun(shost, channel, id, lun, NULL, &sdev, 1);
+	res = scsi_probe_and_add_lun(shost, channel, id, lun, NULL,
+				     &sdev, 1, hostdata);
 	if (res != SCSI_SCAN_LUN_PRESENT)
 		sdev = ERR_PTR(-ENODEV);
 	up(&shost->scan_mutex);
@@ -1178,7 +1181,7 @@
 		 * Scan for a specific host/chan/id/lun.
 		 */
 		scsi_probe_and_add_lun(shost, channel, id, lun, NULL, NULL,
-				       rescan);
+				       rescan, NULL);
 		return;
 	}
 
@@ -1187,7 +1190,7 @@
 	 * would not configure LUN 0 until all LUNs are scanned.
 	 */
 	res = scsi_probe_and_add_lun(shost, channel, id, 0, &bflags, &sdev,
-				     rescan);
+				     rescan, NULL);
 	if (res == SCSI_SCAN_LUN_PRESENT) {
 		if (scsi_report_lun_scan(sdev, bflags, rescan) != 0)
 			/*
@@ -1316,7 +1319,7 @@
 {
 	struct scsi_device *sdev;
 
-	sdev = scsi_alloc_sdev(shost, 0, shost->this_id, 0);
+	sdev = scsi_alloc_sdev(shost, 0, shost->this_id, 0, NULL);
 	if (sdev) {
 		sdev->borken = 0;
 	}
===== drivers/scsi/scsi_syms.c 1.49 vs edited =====
--- 1.49/drivers/scsi/scsi_syms.c	2004-06-27 00:40:24 +02:00
+++ edited/drivers/scsi/scsi_syms.c	2004-08-17 20:50:22 +02:00
@@ -73,7 +73,7 @@
 
 EXPORT_SYMBOL(scsi_io_completion);
 
-EXPORT_SYMBOL(scsi_add_device);
+EXPORT_SYMBOL(__scsi_add_device);
 EXPORT_SYMBOL(scsi_remove_device);
 EXPORT_SYMBOL(scsi_device_cancel);
 
--- 1.19/include/scsi/scsi_device.h	2004-07-07 18:24:13 +02:00
+++ edited/include/scsi/scsi_device.h	2004-08-17 20:42:18 +02:00
@@ -129,8 +129,10 @@
 #define transport_class_to_sdev(class_dev) \
 	container_of(class_dev, struct scsi_device, transport_classdev)
 
-extern struct scsi_device *scsi_add_device(struct Scsi_Host *,
-		uint, uint, uint);
+extern struct scsi_device *__scsi_add_device(struct Scsi_Host *,
+		uint, uint, uint, void *hostdata);
+#define scsi_add_device(host, channel, target, lun) \
+	__scsi_add_device(host, channel, target, lun, NULL)
 extern void scsi_remove_device(struct scsi_device *);
 extern int scsi_device_cancel(struct scsi_device *, int);
 
