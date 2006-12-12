Return-Path: <linux-kernel-owner+w=401wt.eu-S1751417AbWLLPvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWLLPvz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 10:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWLLPvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 10:51:54 -0500
Received: from parabel.levigo.net ([62.206.214.16]:51656 "EHLO
	parabel.matrix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbWLLPvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 10:51:54 -0500
Date: Tue, 12 Dec 2006 16:00:23 +0100
From: Dirk Eibach <eibach@gdsys.de>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Message-Id: <20061212160023.2b96f091.eibach@gdsys.de>
Organization: Guntermann & Drunck GmbH
Mime-Version: 1.0
Subject: [PATCH] usblp: Add serial number to device ID
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-5; AVE: 7.3.0.15; VDF: 6.37.0.5; host: mailrelay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that some USB-printers, e.g. Canon PIXMA iP3000 don't add
their serial number to the IEEE-1284 device ID string as expected by
userspace apps like cups.
Because of this, connecting multiple printers of the same type to a
system does not work properly.

This patch adds the usb serial number to the device ID if it is left
out by the printer.

This patch applies to kernel 2.6.18.

Signed-off-by: Dirk Eibach <eibach@gdsys.de>
---
--- a/drivers/usb/class/usblp.c	2006-09-20 05:42:06.000000000 +0200
+++ b/drivers/usb/class/usblp.c	2006-12-12 15:27:23.000000000 +0100
@@ -1134,6 +1134,18 @@ static int usblp_cache_device_id_string(
 		length = USBLP_DEVICE_ID_SIZE - 1;
 	usblp->device_id_string[length] = '\0';
 
+	/* Insert serial number into the device ID string if the printer
+	 * is braindead enough to leave it out. */
+	if ( (usblp->dev->serial)
+		&& (length + strlen(usblp->dev->serial) + 6 < USBLP_DEVICE_ID_SIZE)
+		&& !strstr(usblp->device_id_string+2, "SERN:")
+		&& !strstr(usblp->device_id_string+2, "SER:") )
+	{
+		sprintf(usblp->device_id_string+length, "SERN:%s;", usblp->dev->serial);
+		length += 6 + strlen(usblp->dev->serial);
+		*((__be16 *)usblp->device_id_string) = cpu_to_be16(length);
+	}
+
 	dbg("usblp%d Device ID string [len=%d]=\"%s\"",
 		usblp->minor, length, &usblp->device_id_string[2]);
 



