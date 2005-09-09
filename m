Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030701AbVIIWMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030701AbVIIWMG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030720AbVIIWMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:12:05 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:64155 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1030701AbVIIWMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:12:03 -0400
Date: Fri, 9 Sep 2005 17:11:44 -0500
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 7/8] cciss: One Button Disaster Recovery support
Message-ID: <20050909221144.GG4616@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 7 of 8
This patch adds support for "One Button Disaster Recovery" devices
to the cciss driver.  (OBDR devices are tape drives which can
pretend to be cd-rom devices temporarily.  Once booted the device
can be reverted to a tape drive and data recovery operations can
be automatically begun.)
This is an enhancement request by a vendor/partner working on
One Button Disaster Recovery.
Please consider for inclusion.

Signed-off-by: Stephen M. Cameron <steve.cameron@hp.com>
Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss_scsi.c |   41 +++++++++++++++++++++++++++++------------
 1 files changed, 29 insertions(+), 12 deletions(-)
--------------------------------------------------------------------------------
diff -burNp lx2613-p006/drivers/block/cciss_scsi.c lx2613/drivers/block/cciss_scsi.c
--- lx2613-p006/drivers/block/cciss_scsi.c	2005-09-09 16:09:13.365616000 -0500
+++ lx2613/drivers/block/cciss_scsi.c	2005-09-09 16:20:35.292948160 -0500
@@ -878,7 +878,7 @@ cciss_scsi_interpret_error(CommandList_s
 
 static int
 cciss_scsi_do_inquiry(ctlr_info_t *c, unsigned char *scsi3addr, 
-		 InquiryData_struct *buf)
+		 unsigned char *buf, unsigned char bufsize)
 {
 	int rc;
 	CommandList_struct *cp;
@@ -901,11 +901,10 @@ cciss_scsi_do_inquiry(ctlr_info_t *c, un
 	cdb[1] = 0;
 	cdb[2] = 0;
 	cdb[3] = 0;
-	cdb[4] = sizeof(*buf) & 0xff;
+	cdb[4] = bufsize;
 	cdb[5] = 0;
 	rc = cciss_scsi_do_simple_cmd(c, cp, scsi3addr, cdb, 
-				6, (unsigned char *) buf, 
-				sizeof(*buf), XFER_READ);
+				6, buf, bufsize, XFER_READ);
 
 	if (rc != 0) return rc; /* something went wrong */
 
@@ -1001,9 +1000,10 @@ cciss_update_non_disk_devices(int cntl_n
 	   that though.  
 
 	 */
-
+#define OBDR_TAPE_INQ_SIZE 49
+#define OBDR_TAPE_SIG "$DR-10"
 	ReportLunData_struct *ld_buff;
-	InquiryData_struct *inq_buff;
+	unsigned char *inq_buff;
 	unsigned char scsi3addr[8];
 	ctlr_info_t *c;
 	__u32 num_luns=0;
@@ -1021,7 +1021,7 @@ cciss_update_non_disk_devices(int cntl_n
 		return;
 	}
 	memset(ld_buff, 0, reportlunsize);
-	inq_buff = kmalloc(sizeof( InquiryData_struct), GFP_KERNEL);
+	inq_buff = kmalloc(OBDR_TAPE_INQ_SIZE, GFP_KERNEL);
         if (inq_buff == NULL) {
                 printk(KERN_ERR "cciss: out of memory\n");
                 kfree(ld_buff);
@@ -1052,19 +1052,36 @@ cciss_update_non_disk_devices(int cntl_n
 
 		/* for each physical lun, do an inquiry */
 		if (ld_buff->LUN[i][3] & 0xC0) continue;
-		memset(inq_buff, 0, sizeof(InquiryData_struct));
+		memset(inq_buff, 0, OBDR_TAPE_INQ_SIZE);
 		memcpy(&scsi3addr[0], &ld_buff->LUN[i][0], 8);
 
-		if (cciss_scsi_do_inquiry(hba[cntl_num], 
-			scsi3addr, inq_buff) != 0)
-		{
+		if (cciss_scsi_do_inquiry(hba[cntl_num], scsi3addr, inq_buff, 
+			(unsigned char) OBDR_TAPE_INQ_SIZE) != 0) {
 			/* Inquiry failed (msg printed already) */
 			devtype = 0; /* so we will skip this device. */
 		} else /* what kind of device is this? */
-			devtype = (inq_buff->data_byte[0] & 0x1f);
+			devtype = (inq_buff[0] & 0x1f);
 
 		switch (devtype)
 		{
+		  case 0x05: /* CD-ROM */ {
+
+			/* We don't *really* support actual CD-ROM devices,
+			 * just this "One Button Disaster Recovery" tape drive
+			 * which temporarily pretends to be a CD-ROM drive.
+			 * So we check that the device is really an OBDR tape 
+			 * device by checking for "$DR-10" in bytes 43-48 of 
+			 * the inquiry data.
+			 */ 
+				char obdr_sig[7]; 
+
+				strncpy(obdr_sig, &inq_buff[43], 6);
+				obdr_sig[6] = '\0';
+				if (strncmp(obdr_sig, OBDR_TAPE_SIG, 6) != 0) 
+					/* Not OBDR device, ignore it. */
+					break;
+			}
+			/* fall through . . . */
 		  case 0x01: /* sequential access, (tape) */
 		  case 0x08: /* medium changer */
 			if (ncurrent >= CCISS_MAX_SCSI_DEVS_PER_HBA) {
