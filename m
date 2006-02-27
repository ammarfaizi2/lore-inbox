Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWB0WcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWB0WcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWB0Wb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:31:59 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:9345 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932464AbWB0Wb5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:57 -0500
Message-Id: <20060227223405.357906000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:35 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: [patch 35/39] [PATCH] sd: fix memory corruption with broken mode page headers
Content-Disposition: inline; filename=sd-fix-memory-corruption-with-broken-mode-page-headers.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

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
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
fixes http://bugzilla.kernel.org/show_bug.cgi?id=6114 and
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=182005

 drivers/scsi/sd.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

--- linux-2.6.15.4.orig/drivers/scsi/sd.c
+++ linux-2.6.15.4/drivers/scsi/sd.c
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

--
