Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWA2SOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWA2SOz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 13:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWA2SOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 13:14:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19620 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751102AbWA2SOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 13:14:54 -0500
Subject: [PATCH] ibm-acpi brightness fix
From: David Zeuthen <david@fubar.dk>
To: borislav@users.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 29 Jan 2006 13:14:31 -0500
Message-Id: <1138558472.9858.23.camel@daxter.boston.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 (2.5.4-10) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The ibm-acpi driver allows user space to set the brightness of the
display but the way it currently works is by fading from one of the
eight levels to the other. While this effect is visually pleasing it's
probably best taken care of by user space itself (and users of
gnome-power-manager will notice that this is exactly what it does).

This patch removes the fading. Patch is against ibm-acpi 0.11 but it
also applies to the drivers/acpi/ibm_acpi.c file in Linus' tree. I've
tested this on a IBM Thinkpad T41. Please apply.

(Please keep me in the Cc - I'm not subscribed to the LKML)

    David

Signed-Off-By: David Zeuthen <david@fubar.dk>

--- ibm-acpi-0.11.orig/ibm_acpi.c	2005-03-17 05:06:16.000000000 -0500
+++ ibm-acpi-0.11/ibm_acpi.c	2006-01-29 12:55:53.000000000 -0500
@@ -1351,7 +1351,7 @@ static int brightness_read(char *p)
 
 static int brightness_write(char *buf)
 {
-	int cmos_cmd, inc, i;
+	int cmos_cmd;
 	u8 level;
 	int new_level;
 	char *cmd;
@@ -1372,13 +1372,11 @@ static int brightness_write(char *buf)
 			return -EINVAL;
 
 		cmos_cmd = new_level > level ? BRIGHTNESS_UP : BRIGHTNESS_DOWN;
-		inc = new_level > level ? 1 : -1;
-		for (i = level; i != new_level; i += inc) {
-			if (!cmos_eval(cmos_cmd))
-				return -EIO;
-			if (!acpi_ec_write(brightness_offset, i + inc))
-				return -EIO;
-		}
+
+		if (!cmos_eval(cmos_cmd))
+			return -EIO;
+		if (!acpi_ec_write(brightness_offset, new_level))
+			return -EIO;
 	}
 
 	return 0;

