Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWBZXSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWBZXSl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWBZXRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:17:49 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:6035 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932301AbWBZXRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:17:48 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 27 Feb 2006 00:16:10 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.15.4 update] sd: fix memory corruption with broken mode
 page headers
To: stable@kernel.org
cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
       James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <4400E34B.1000400@s5r6.in-berlin.de>
Message-ID: <tkrat.ac90e0d775a5c272@s5r6.in-berlin.de>
References: <tkrat.014f03dc41356221@s5r6.in-berlin.de>
 <20060225021009.GV3883@sorel.sous-sol.org>
 <4400E34B.1000400@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.735) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sd: fix memory corruption with broken mode page headers

There's a problem in sd where we blindly believe the length of the
headers and block descriptors.  Some devices return insane values for
these and cause our length to end up greater than the actual buffer
size, so check to make sure.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Also removed the buffer size magic number (512) and added DPOFUA of
zero to the defaults

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

rediff for 2.6.15.x without DPOFUA bit, taken from commit
489708007785389941a89fa06aedc5ec53303c96

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
fixes http://bugzilla.kernel.org/show_bug.cgi?id=6114 and
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=182005

Index: linux-2.6.15.4/drivers/scsi/sd.c
===================================================================
--- linux-2.6.15.4.orig/drivers/scsi/sd.c	2006-02-26 23:58:40.000000000 +0100
+++ linux-2.6.15.4/drivers/scsi/sd.c	2006-02-27 00:03:07.000000000 +0100
@@ -88,6 +88,11 @@
 #define SD_MAX_RETRIES		5
 #define SD_PASSTHROUGH_RETRIES	1
 
+/*
+ * Size of the initial data buffer for mode and read capacity data
+ */
+#define SD_BUF_SIZE		512
+
 static void scsi_disk_release(struct kref *kref);
 
 struct scsi_disk {
@@ -1299,7 +1304,7 @@ sd_do_mode_sense(struct scsi_device *sdp
 
 /*
  * read write protect setting, if possible - called only in sd_revalidate_disk()
- * called with buffer of length 512
+ * called with buffer of length SD_BUF_SIZE
  */
 static void
 sd_read_write_protect_flag(struct scsi_disk *sdkp, char *diskname,
@@ -1357,7 +1362,7 @@ sd_read_write_protect_flag(struct scsi_d
 
 /*
  * sd_read_cache_type - called only from sd_revalidate_disk()
- * called with buffer of length 512
+ * called with buffer of length SD_BUF_SIZE
  */
 static void
 sd_read_cache_type(struct scsi_disk *sdkp, char *diskname,
@@ -1402,6 +1407,8 @@ sd_read_cache_type(struct scsi_disk *sdk
 
 	/* Take headers and block descriptors into account */
 	len += data.header_length + data.block_descriptor_length;
+	if (len > SD_BUF_SIZE)
+		goto bad_sense;
 
 	/* Get the data */
 	res = sd_do_mode_sense(sdp, dbd, modepage, buffer, len, &data, &sshdr);
@@ -1414,6 +1421,12 @@ sd_read_cache_type(struct scsi_disk *sdk
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
@@ -1472,7 +1485,7 @@ static int sd_revalidate_disk(struct gen
 	if (!scsi_device_online(sdp))
 		goto out;
 
-	buffer = kmalloc(512, GFP_KERNEL | __GFP_DMA);
+	buffer = kmalloc(SD_BUF_SIZE, GFP_KERNEL | __GFP_DMA);
 	if (!buffer) {
 		printk(KERN_WARNING "(sd_revalidate_disk:) Memory allocation "
 		       "failure.\n");


