Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWBZOfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWBZOfE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 09:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWBZOfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 09:35:04 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:30948 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751136AbWBZOfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 09:35:01 -0500
Subject: Re: [stable] [PATCH 1/2] sd: fix memory corruption by
	sd_read_cache_type
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Chris Wright <chrisw@sous-sol.org>, stable@kernel.org,
       Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <20060226053138.GM27946@ftp.linux.org.uk>
References: <tkrat.014f03dc41356221@s5r6.in-berlin.de>
	 <20060225021009.GV3883@sorel.sous-sol.org>
	 <4400E34B.1000400@s5r6.in-berlin.de>
	 <Pine.LNX.4.64.0602251600480.22647@g5.osdl.org>
	 <1140930888.3279.4.camel@mulgrave.il.steeleye.com>
	 <20060226053138.GM27946@ftp.linux.org.uk>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 08:34:10 -0600
Message-Id: <1140964451.3337.5.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 05:31 +0000, Al Viro wrote:
> No.  It's sd.c assuming that mode page header is sane, without any
> checks.  And yes, it does give memory corruption if it's not.

Well, OK, I agree allowing us to request data longer than the actual
buffer is a problem.  However, I don't exactly see how this actually
causes corruption, since even the initio bridge only sends 12 bytes of
data, so we should stop with a data underrun at that point (however big
the buffer is)

> Initio-related part is in scsi_lib.c (and in recovery part of sd.c
> changes).  That one is about how we can handle gracefully a broken
> device that gives no header at all.
> 
> Checks for ->block_descriptors_length are just making sure we won't try
> to do any access past the end of buffer, no matter what crap we got from
> device.

I agree; how about this for the actual patch (for 2.6.16) ... I put two
more tidy ups into it ...

James

---

[SCSI] sd: Add sanity checking to mode sense return data

From: Al Viro <viro@ftp.linux.org.uk>

There's a problem in sd where we blindly believe the length of the
headers and block descriptors.  Some devices return insane values for
these and cause our length to end up greater than the actual buffer
size, so check to make sure.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Also removed the buffer size magic number (512) and added DPOFUA of
zero to the defaults

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
Index: linux-2.6/drivers/scsi/sd.c
===================================================================
--- linux-2.6.orig/drivers/scsi/sd.c
+++ linux-2.6/drivers/scsi/sd.c
@@ -89,6 +89,11 @@
 #define SD_MAX_RETRIES		5
 #define SD_PASSTHROUGH_RETRIES	1
 
+/*
+ * Size of the initial data buffer for mode and read capacity data
+ */
+#define SD_BUF_SIZE		512
+
 static void scsi_disk_release(struct kref *kref);
 
 struct scsi_disk {
@@ -1239,7 +1244,7 @@ sd_do_mode_sense(struct scsi_device *sdp
 
 /*
  * read write protect setting, if possible - called only in sd_revalidate_disk()
- * called with buffer of length 512
+ * called with buffer of length SD_BUF_SIZE
  */
 static void
 sd_read_write_protect_flag(struct scsi_disk *sdkp, char *diskname,
@@ -1297,7 +1302,7 @@ sd_read_write_protect_flag(struct scsi_d
 
 /*
  * sd_read_cache_type - called only from sd_revalidate_disk()
- * called with buffer of length 512
+ * called with buffer of length SD_BUF_SIZE
  */
 static void
 sd_read_cache_type(struct scsi_disk *sdkp, char *diskname,
@@ -1342,6 +1347,8 @@ sd_read_cache_type(struct scsi_disk *sdk
 
 	/* Take headers and block descriptors into account */
 	len += data.header_length + data.block_descriptor_length;
+	if (len > SD_BUF_SIZE)
+		goto bad_sense;
 
 	/* Get the data */
 	res = sd_do_mode_sense(sdp, dbd, modepage, buffer, len, &data, &sshdr);
@@ -1354,6 +1361,12 @@ sd_read_cache_type(struct scsi_disk *sdk
 		int ct = 0;
 		int offset = data.header_length + data.block_descriptor_length;
 
+		if (offset >= SD_BUF_SIZE - 2) {
+			printk(KERN_ERR "%s: malformed MODE SENSE response",
+				diskname);
+			goto defaults;
+		}
+
 		if ((buffer[offset] & 0x3f) != modepage) {
 			printk(KERN_ERR "%s: got wrong page\n", diskname);
 			goto defaults;
@@ -1398,6 +1411,7 @@ defaults:
 	       diskname);
 	sdkp->WCE = 0;
 	sdkp->RCD = 0;
+	sdkp->DPOFUA = 0;
 }
 
 /**
@@ -1421,7 +1435,7 @@ static int sd_revalidate_disk(struct gen
 	if (!scsi_device_online(sdp))
 		goto out;
 
-	buffer = kmalloc(512, GFP_KERNEL | __GFP_DMA);
+	buffer = kmalloc(SD_BUF_SIZE, GFP_KERNEL | __GFP_DMA);
 	if (!buffer) {
 		printk(KERN_WARNING "(sd_revalidate_disk:) Memory allocation "
 		       "failure.\n");


