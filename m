Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261228AbREUMYZ>; Mon, 21 May 2001 08:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261297AbREUMYP>; Mon, 21 May 2001 08:24:15 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:64010 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S261295AbREUMYB>;
	Mon, 21 May 2001 08:24:01 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200105211223.f4LCNjW29237@oboe.it.uc3m.es>
Subject: [PATCH] allow acpi to be turned off at boot
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Mon, 21 May 2001 14:23:45 +0200 (MET DST)
CC: dwmw2@redhat.com, andrew.grover@intel.com
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI seemed a fine thing until I found that it doesn't allow for
hibernation or suspension of my laptop, and there is no way
(apparently) to turn it off at boot and let APM take over. Here's
a patch to allow "acpi=off" at boot. There's room for more parsing
in the code.

I didn't notice the problem until ACPI actually started working :-) for
my laptop (tosh portege) in recent kernels.  Previously I'd always
compiled it in anyway, but it never loaded itself.

Have this until the code gets modularized.

Peter


--- linux-2.4.4/drivers/acpi/driver.c.pre-ptb	Sat May 19 21:00:00 2001
+++ linux-2.4.4/drivers/acpi/driver.c	Mon May 21 14:15:02 2001
@@ -24,6 +24,8 @@
  * - Fix interruptible_sleep_on() races
  * Andrew Grover <andrew.grover@intel.com> 2001-2-28
  * - Major revamping
+ * Peter Breuer <ptb@it.uc3m.es> 2001-5-20
+ * - parse boot time params.
  */
 
 #include <linux/config.h>
@@ -59,6 +61,23 @@
 
 FADT_DESCRIPTOR acpi_fadt;
 
+static int acpi_disabled;
+#ifndef MODULE
+static int __init acpi_setup(char *str) {
+   while (str && *str) {
+       if (strncmp(str, "off", 3) == 0)
+          acpi_disabled = 1;
+       str = strchr(str, ',');
+       if (str)
+          str += strspn(str, ", \t");
+   }
+   return 1;
+}
+
+__setup("acpi=", acpi_setup);
+#endif
+
+
 /*
  * Start the interpreter
  */
@@ -73,6 +92,11 @@
 		printk(KERN_NOTICE "ACPI: APM is already active, exiting\n");
 		return -ENODEV;
 	}
+
+       if (acpi_disabled) {
+          	printk(KERN_NOTICE "ACPI: disabled on user request.\n");
+          	return -ENODEV;
+       }                
 
 	if (!ACPI_SUCCESS(acpi_initialize_subsystem())) {
 		printk(KERN_ERR "ACPI: Driver initialization failed\n");
