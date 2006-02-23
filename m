Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbWBWBEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWBWBEE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 20:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWBWBD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 20:03:59 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:19116 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751481AbWBWBD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 20:03:58 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Thu, 23 Feb 2006 02:02:57 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 1/2] sd: fix memory corruption by sd_read_cache_type
To: stable@kernel.org, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Jody McIntyre <scjody@modernduck.com>
Message-ID: <tkrat.014f03dc41356221@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.689) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sd: fix memory corruption by sd_read_cache_type

Let sd check more thoroughly before using mode_sense responses for data
length calculation. Fixes memory corruption ("slab error in
cache_free_debugcheck") or kernel panic when buggy disks are connected,
notably Initio SBP-2 bridges.
http://bugzilla.kernel.org/show_bug.cgi?id=6114
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=182005

Taken from a patch by Al Viro <viro@ftp.linux.org.uk>.
http://marc.theaimsgroup.com/?l=linux-scsi&m=114055884611429

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Patch is applicable to 2.6.14, 2.6.15, 2.6.16.

Index: linux-2.6.16-rc4/drivers/scsi/sd.c
===================================================================
--- linux-2.6.16-rc4.orig/drivers/scsi/sd.c	2006-02-22 22:27:42.000000000 +0100
+++ linux-2.6.16-rc4/drivers/scsi/sd.c	2006-02-22 22:29:10.000000000 +0100
@@ -1342,6 +1342,8 @@ sd_read_cache_type(struct scsi_disk *sdk
 
 	/* Take headers and block descriptors into account */
 	len += data.header_length + data.block_descriptor_length;
+	if (len > 512)
+		goto bad_sense;
 
 	/* Get the data */
 	res = sd_do_mode_sense(sdp, dbd, modepage, buffer, len, &data, &sshdr);
@@ -1354,6 +1356,12 @@ sd_read_cache_type(struct scsi_disk *sdk
 		int ct = 0;
 		int offset = data.header_length + data.block_descriptor_length;
 
+		if (offset >= 512 - 2) {
+			printk(KERN_ERR "%s: malformed MODE SENSE response",
+				diskname);
+			goto defaults;
+		}
+
 		if ((buffer[offset] & 0x3f) != modepage) {
 			printk(KERN_ERR "%s: got wrong page\n", diskname);
 			goto defaults;


