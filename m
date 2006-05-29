Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWE2JOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWE2JOw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 05:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWE2JOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 05:14:51 -0400
Received: from gw.goop.org ([64.81.55.164]:38556 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750794AbWE2JOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 05:14:51 -0400
Message-ID: <447ABB7C.2040905@goop.org>
Date: Mon, 29 May 2006 02:14:36 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Borislav Deianov <borislav@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] Support enable/disable of WAN module in ibm_acpi
Content-Type: multipart/mixed;
 boundary="------------020308010202050208040705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020308010202050208040705
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

New Lenovo Thinkpads have an optional WAN module (a Sierra Wireless 
MC5720 EV-DO modem), which can be turned on and off much like the 
Bluetooth module.  This patch adds a "wan" entry to /proc/acpi/ibm, 
which is pretty much a cut'n'paste of the corresponding bluetooth code.

    J


--------------020308010202050208040705
Content-Type: text/x-patch;
 name="ibm-acpi-wan.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ibm-acpi-wan.patch"

Allow a WAN module to enabled/disabled on a Thinkpad X60.

The WAN (Sierra Wireless EV-DO) module is very similar to the
Bluetooth module.  It appears on the USB bus when enabled.  It can be
controlled via hot key, or directly via ACPI.  This change enables
direct control via ACPI.

I have tested it on my Lenovo Thinkpad X60; I guess it will probably
work on other Thinkpad models which come with this module installed.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

diff -r 401a0868b8be drivers/acpi/ibm_acpi.c
--- a/drivers/acpi/ibm_acpi.c	Mon May 29 06:35:52 2006 +0700
+++ b/drivers/acpi/ibm_acpi.c	Mon May 29 01:36:12 2006 -0700
@@ -567,6 +567,69 @@ static int bluetooth_write(char *buf)
 	return 0;
 }
 
+static int wan_supported;
+
+static int wan_init(void)
+{
+	wan_supported = hkey_handle &&
+	    acpi_evalf(hkey_handle, NULL, "GWAN", "qv");
+
+	return 0;
+}
+
+static int wan_status(void)
+{
+	int status;
+
+	if (!wan_supported ||
+	    !acpi_evalf(hkey_handle, &status, "GWAN", "d"))
+		status = 0;
+
+	return status;
+}
+
+static int wan_read(char *p)
+{
+	int len = 0;
+	int status = wan_status();
+
+	if (!wan_supported)
+		len += sprintf(p + len, "status:\t\tnot supported\n");
+	else if (!(status & 1))
+		len += sprintf(p + len, "status:\t\tnot installed\n");
+	else {
+		len += sprintf(p + len, "status:\t\t%s\n", enabled(status, 1));
+		len += sprintf(p + len, "commands:\tenable, disable\n");
+	}
+
+	return len;
+}
+
+static int wan_write(char *buf)
+{
+	int status = wan_status();
+	char *cmd;
+	int do_cmd = 0;
+
+	if (!wan_supported)
+		return -ENODEV;
+
+	while ((cmd = next_cmd(&buf))) {
+		if (strlencmp(cmd, "enable") == 0) {
+			status |= 2;
+		} else if (strlencmp(cmd, "disable") == 0) {
+			status &= ~2;
+		} else
+			return -EINVAL;
+		do_cmd = 1;
+	}
+
+	if (do_cmd && !acpi_evalf(hkey_handle, NULL, "SWAN", "vd", status))
+		return -EIO;
+
+	return 0;
+}
+
 static int video_supported;
 static int video_orig_autosw;
 
@@ -1561,6 +1624,13 @@ static struct ibm_struct ibms[] = {
 	 .init = bluetooth_init,
 	 .read = bluetooth_read,
 	 .write = bluetooth_write,
+	 },
+	{
+	 .name = "wan",
+	 .init = wan_init,
+	 .read = wan_read,
+	 .write = wan_write,
+	 .experimental = 1,
 	 },
 	{
 	 .name = "video",

--------------020308010202050208040705--
