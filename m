Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbTESP4u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 11:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTESP4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 11:56:50 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:45988 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP id S261220AbTESP4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 11:56:39 -0400
Message-ID: <3EC901BB.8040100@mvista.com>
Date: Mon, 19 May 2003 11:09:31 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux.nics@intel.com
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add boot command line parsing for the e100 driver
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050007020402040103050902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050007020402040103050902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Annoyed by the fact that I could set configuration parameters for a
compiled-in e100 driver, I've added boot-line parameter parsing.  The
patch is attached.  It would be very helpful if this could be applied. 
This is relative to 2.5.68, but should be pretty portable.

-Corey

--------------050007020402040103050902
Content-Type: text/plain;
 name="e100-bootparm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e100-bootparm.diff"

--- linux.orig/drivers/net/e100/e100_main.c	Mon Apr 21 11:20:11 2003
+++ linux/drivers/net/e100/e100_main.c	Mon May 19 10:57:33 2003
@@ -174,7 +174,7 @@
  * over and over (plus this helps to avoid typo bugs).
  */
 #define E100_PARAM(X, S)                                        \
-        static const int X[E100_MAX_NIC + 1] = E100_PARAM_INIT; \
+        static int X[E100_MAX_NIC + 1] = E100_PARAM_INIT; \
         MODULE_PARM(X, "1-" __MODULE_STRING(E100_MAX_NIC) "i"); \
         MODULE_PARM_DESC(X, S);
 
@@ -375,6 +375,77 @@
 E100_PARAM(BundleSmallFr, "Disable or enable interrupt bundling of small frames");
 E100_PARAM(BundleMax, "Maximum number for CPU saver's packet bundling");
 E100_PARAM(IFS, "Disable or enable the adaptive IFS algorithm");
+
+#if !defined(MODULE)
+static int next_e100_setup = 0;
+
+#define E100_BOOT_PARAM(parm, strparm) \
+	if (strcmp(strparm, name) == 0) {				\
+		int val;						\
+		char *end;						\
+		val = simple_strtoul(strval, &end, 0);			\
+		if (*end != '\0') {					\
+			printk("Invalid value for parm num %d, name"	\
+			       " %s, parm ignored\n", count, name);	\
+			continue;					\
+		}							\
+		printk("  Setting %s to %d\n", strparm, val);		\
+		parm[i] = val;						\
+		continue;						\
+	}
+		
+static int __init
+e100_boot_setup(char *str)
+{
+	int i = next_e100_setup;
+	int count = -1;
+	char *p;
+	char *name;
+	char *strval;
+
+	if (i >= E100_MAX_NIC) {
+		printk("Attempted to configure too many e100 devices\n");
+		return -ENODEV;
+	}
+
+	printk("e100 boot setup for device %d\n", i);
+
+	next_e100_setup++;
+
+	for (p=strsep(&str, ":,"); p; p=strsep(&str, ":,")) {
+		count++;
+		name = p;
+		name = strsep(&p, "=");
+		if (!name) {
+			printk("  error: Empty parm %d, ignored\n", count);
+			continue;
+		}
+		strval = strsep(&p, "");
+		if (!strval) {
+			printk("  error: No value for parm %d, ignored\n",
+			       count);
+			continue;
+		}
+		
+		E100_BOOT_PARAM(TxDescriptors, "TxDescriptors");
+		E100_BOOT_PARAM(RxDescriptors, "RxDescriptors");
+		E100_BOOT_PARAM(XsumRX, "XsumRX");
+		E100_BOOT_PARAM(e100_speed_duplex, "e100_speed_duplex");
+		E100_BOOT_PARAM(ucode, "ucode");
+		E100_BOOT_PARAM(ber, "ber");
+		E100_BOOT_PARAM(flow_control, "flow_control");
+		E100_BOOT_PARAM(IntDelay, "IntDelay");
+		E100_BOOT_PARAM(BundleSmallFr, "BundleSmallFr");
+		E100_BOOT_PARAM(BundleMax, "BundleMax");
+		E100_BOOT_PARAM(IFS, "IFS");
+		printk("  Invalid parameter name %s, ignored\n", name);
+	}
+
+	return 0;
+}
+
+__setup("e100=", e100_boot_setup);
+#endif
 
 /**
  * e100_exec_cmd - issue a comand
--- linux.orig/Documentation/networking/e100.txt	Wed Mar 26 08:00:53 2003
+++ linux/Documentation/networking/e100.txt	Mon May 19 10:50:47 2003
@@ -110,6 +110,17 @@
 resources for the second adapter. This configuration favors the second 
 adapter. The driver supports up to 16 network adapters concurrently.
 
+If the driver is compiled into the kernel, you may also specify these
+on the boot command line for linux using the 'e100' parameter,
+followed by the "option=val" separated by commas or colons.  You may
+put the e100 parameter on the command line multiple times, each one
+configures the next device.  For instance, you can say:
+
+    e100=ucode=0 e100=ucode=1,IntDelay=700
+
+to turn of the microcode download on the first device, and turn on the
+microcode download and set the delay to 700 on the second device.
+
 The default value for each parameter is generally the recommended setting,
 unless otherwise noted.
 

--------------050007020402040103050902--

