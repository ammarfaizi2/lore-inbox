Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbTJFNmX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 09:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbTJFNmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 09:42:23 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:60299 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S262068AbTJFNmR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 09:42:17 -0400
Message-ID: <3F817204.7090708@terra.com.br>
Date: Mon, 06 Oct 2003 10:45:40 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: model@cecmow.enet.dec.com, vadim@rbrf.ru, vadim@ipsun.ras.ru,
       Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]  Using possibly corrupted structures in sjcd CDROM driver
Content-Type: multipart/mixed;
 boundary="------------070909060700060807040009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070909060700060807040009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Andrew/Vadim,

	Patch against 2.6.0-test6.

	Check the return of copy_from_user in a few places to not use buggy 
structures if copy_from_user != 0. Found by smatch.

	Please consider applying,

	Thanks.

Felipe

--------------070909060700060807040009
Content-Type: text/plain;
 name="sjcd-corruption.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sjcd-corruption.patch"

--- linux-2.6.0-test6/drivers/cdrom/sjcd.c.orig	2003-10-06 10:35:54.000000000 -0300
+++ linux-2.6.0-test6/drivers/cdrom/sjcd.c	2003-10-06 10:38:43.000000000 -0300
@@ -842,8 +842,9 @@
 					    CDROM_AUDIO_NO_STATUS;
 				}
 
-				copy_from_user(&sjcd_msf, (void *) arg,
-					       sizeof(sjcd_msf));
+				if (copy_from_user(&sjcd_msf, (void *) arg,
+					       sizeof(sjcd_msf)))
+					return (-EFAULT);
 
 				sjcd_playing.start.min =
 				    bin2bcd(sjcd_msf.cdmsf_min0);
@@ -893,9 +894,9 @@
 					 sizeof(toc_entry))) == 0) {
 				struct sjcd_hw_disk_info *tp;
 
-				copy_from_user(&toc_entry, (void *) arg,
-					       sizeof(toc_entry));
-
+				if (copy_from_user(&toc_entry, (void *) arg,
+					       sizeof(toc_entry)))
+					return (-EFAULT);
 				if (toc_entry.cdte_track == CDROM_LEADOUT)
 					tp = &sjcd_table_of_contents[0];
 				else if (toc_entry.cdte_track <
@@ -948,8 +949,10 @@
 					 sizeof(subchnl))) == 0) {
 				struct sjcd_hw_qinfo q_info;
 
-				copy_from_user(&subchnl, (void *) arg,
-					       sizeof(subchnl));
+				if (copy_from_user(&subchnl, (void *) arg,
+					       sizeof(subchnl)))
+					return (-EFAULT);
+
 				if (sjcd_get_q_info(&q_info) < 0)
 					return (-EIO);
 
@@ -1005,8 +1008,9 @@
 					 sizeof(vol_ctrl))) == 0) {
 				unsigned char dummy[4];
 
-				copy_from_user(&vol_ctrl, (void *) arg,
-					       sizeof(vol_ctrl));
+				if (copy_from_user(&vol_ctrl, (void *) arg,
+					       sizeof(vol_ctrl)))
+					return (-EFAULT);
 				sjcd_send_4_cmd(SCMD_SET_VOLUME,
 						vol_ctrl.channel0, 0xFF,
 						vol_ctrl.channel1, 0xFF);

--------------070909060700060807040009--

