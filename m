Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbULARCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbULARCq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 12:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbULARCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 12:02:46 -0500
Received: from mailfe04.swip.net ([212.247.154.97]:38113 "EHLO
	mailfe04.swip.net") by vger.kernel.org with ESMTP id S261328AbULARCa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 12:02:30 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: [PATCH] Possible off by one in drivers/parport/probe.c
From: Alexander Nyberg <alexn@dsv.su.se>
To: linux-kernel@vger.kernel.org
Cc: campbell@torque.net, tim@cyberelk.net, Philip.Blundell@pobox.com
Content-Type: text/plain
Date: Wed, 01 Dec 2004 18:02:15 +0100
Message-Id: <1101920536.718.61.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes a theoretical bug indicated in:
http://bugme.osdl.org/show_bug.cgi?id=240

It prevents overflow in case the required buffer is larger than the passed
buffer. This I found to be the minimally intrusive change.

If anyone could test this change using parport with "IEEE 1284 transfer modes"
(CONFIG_PARPORT_1284) hardware it would be nice.


Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>

===== drivers/parport/probe.c 1.6 vs edited =====
--- 1.6/drivers/parport/probe.c	2004-10-28 09:39:58 +02:00
+++ edited/drivers/parport/probe.c	2004-12-01 17:02:43 +01:00
@@ -164,8 +164,16 @@ ssize_t parport_device_id (int devnum, c
 		if (retval != 2) goto end_id;
 
 		idlen = (length[0] << 8) + length[1] - 2;
-		if (idlen < len)
+		/* 
+		 * Check if the caller-allocated buffer is large enough
+		 * otherwise bail out or there will be an at least off by one.
+		 */
+		if (idlen + 1 < len)
 			len = idlen;
+		else {
+			retval = -ENOMEM;
+			goto out;
+		}
 		retval = parport_read (dev->port, buffer, len);
 
 		if (retval != len)
@@ -205,11 +213,12 @@ ssize_t parport_device_id (int devnum, c
 		buffer[len] = '\0';
 		parport_negotiate (dev->port, IEEE1284_MODE_COMPAT);
 	}
-	parport_release (dev);
 
 	if (retval > 2)
 		parse_data (dev->port, dev->daisy, buffer);
 
+out:
+	parport_release (dev);
 	parport_close (dev);
 	return retval;
 }


