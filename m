Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWFAWZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWFAWZn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWFAWZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:25:43 -0400
Received: from smtp1.ensim.com ([65.164.64.254]:39468 "EHLO aero.ensim.com")
	by vger.kernel.org with ESMTP id S1750801AbWFAWZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:25:42 -0400
From: Borislav Deianov <borislav@users.sourceforge.net>
Date: Thu, 1 Jun 2006 15:25:15 -0700
To: len.brown@intel.com, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH REPOST] Support enable/disable of WAN module in ibm_acpi
Message-ID: <20060601222515.GC5790@aero.ensim.com>
References: <447F5EDE.4010900@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447F5EDE.4010900@goop.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 02:40:46PM -0700, Jeremy Fitzhardinge wrote:
> New Lenovo Thinkpads have an optional WAN module (a Sierra Wireless
> MC5720 EV-DO modem), which can be turned on and off much like the
> Bluetooth module.  This patch adds a "wan" entry to /proc/acpi/ibm,
> which is pretty much a cut'n'paste of the corresponding bluetooth code.

I'm not able to test this myself, but it looks good. Len, please
apply.

Thanks,
Borislav

--

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
+		len += sprintf(p + len, "status:\t\t%s\n", enabled(status, 
1));
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

