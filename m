Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161280AbWBUCS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161280AbWBUCS7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 21:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161281AbWBUCS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 21:18:59 -0500
Received: from ozlabs.org ([203.10.76.45]:21144 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161280AbWBUCS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 21:18:58 -0500
Date: Tue, 21 Feb 2006 13:19:04 +1100
From: Michael Neuling <mikey@neuling.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: dtor_core@ameritech.net, dmitry.torokhov@gmail.com, rth@redhat.com,
       Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
       "paulus@samba.org" <paulus@samba.org>
Subject: [PATCH] input: pcspkr device and driver separation
Message-Id: <20060221131904.2639e00d.mikey@neuling.org>
In-Reply-To: <d120d5000602161158x22216c4byabbe848d37ccf814@mail.gmail.com>
References: <20060208110815.5e70e36b.mikey@neuling.org>
	<d120d5000602101300k720ff4t5cbc279e8e9115f@mail.gmail.com>
	<20060213150308.337c2e58.mikey@neuling.org>
	<200602150118.53220.dtor_core@ameritech.net>
	<20060216161258.03919e2e.mikey@neuling.org>
	<20060216162807.f3bb15a3.mikey@neuling.org>
	<d120d5000602161158x22216c4byabbe848d37ccf814@mail.gmail.com>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current pcspkr code combines the device and driver registration.
This patch splits these, putting the device registration in the arch
specific code.

It seems opinion is divided as how much error checking needs to be
done when registering the device at boot.  This patch does a BUG_ON on
any device allocation failures for all architectures touched.  The
PowerPC guys are happy with this.

Mikey

Signed-off-by: Michael Neuling <mikey@neuling.org>

Split the pcskpr device and driver registration.  Adds device
registration for Alpha, MIPS and x86.  Also added for PowerPC which is
dependant on the pcspkr existing in the device-tree.
---
 arch/alpha/kernel/setup.c          |   12 ++++++++++++
 arch/i386/kernel/setup.c           |   12 ++++++++++++
 arch/mips/kernel/setup.c           |   12 ++++++++++++
 arch/powerpc/kernel/setup-common.c |   18 ++++++++++++++++++
 drivers/input/misc/pcspkr.c        |   27 +--------------------------
 5 files changed, 55 insertions(+), 26 deletions(-)

Index: linux-2.6-linus/arch/i386/kernel/setup.c
===================================================================
--- linux-2.6-linus.orig/arch/i386/kernel/setup.c
+++ linux-2.6-linus/arch/i386/kernel/setup.c
@@ -1630,6 +1630,18 @@ void __init setup_arch(char **cmdline_p)
 #endif
 }
 
+static __init int add_pcspkr(void)
+{
+	struct platform_device *pd;
+
+	pd = platform_device_alloc("pcspkr", -1);
+	BUG_ON(!pd);
+	BUG_ON(platform_device_add(pd));
+
+	return 0;
+}
+device_initcall(add_pcspkr);
+
 #include "setup_arch_post.h"
 /*
  * Local Variables:
Index: linux-2.6-linus/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-2.6-linus.orig/arch/powerpc/kernel/setup-common.c
+++ linux-2.6-linus/arch/powerpc/kernel/setup-common.c
@@ -469,3 +469,21 @@ static int __init early_xmon(char *p)
 }
 early_param("xmon", early_xmon);
 #endif
+
+static __init int add_pcspkr(void)
+{
+	struct device_node *np;
+	struct platform_device *pd;
+
+	np = of_find_compatible_node(NULL, NULL, "pnpPNP,100");
+	of_node_put(np);
+	if (!np)
+		return -ENODEV;
+
+	pd = platform_device_alloc("pcspkr", -1);
+	BUG_ON(!pd);
+	BUG_ON(platform_device_add(pd));
+
+	return 0;
+}
+device_initcall(add_pcspkr);
Index: linux-2.6-linus/drivers/input/misc/pcspkr.c
===================================================================
--- linux-2.6-linus.orig/drivers/input/misc/pcspkr.c
+++ linux-2.6-linus/drivers/input/misc/pcspkr.c
@@ -24,7 +24,6 @@ MODULE_AUTHOR("Vojtech Pavlik <vojtech@u
 MODULE_DESCRIPTION("PC Speaker beeper driver");
 MODULE_LICENSE("GPL");
 
-static struct platform_device *pcspkr_platform_device;
 static DEFINE_SPINLOCK(i8253_beep_lock);
 
 static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
@@ -135,35 +134,11 @@ static struct platform_driver pcspkr_pla
 
 static int __init pcspkr_init(void)
 {
-	int err;
-
-	err = platform_driver_register(&pcspkr_platform_driver);
-	if (err)
-		return err;
-
-	pcspkr_platform_device = platform_device_alloc("pcspkr", -1);
-	if (!pcspkr_platform_device) {
-		err = -ENOMEM;
-		goto err_unregister_driver;
-	}
-
-	err = platform_device_add(pcspkr_platform_device);
-	if (err)
-		goto err_free_device;
-
-	return 0;
-
- err_free_device:
-	platform_device_put(pcspkr_platform_device);
- err_unregister_driver:
-	platform_driver_unregister(&pcspkr_platform_driver);
-
-	return err;
+	return platform_driver_register(&pcspkr_platform_driver);
 }
 
 static void __exit pcspkr_exit(void)
 {
-	platform_device_unregister(pcspkr_platform_device);
 	platform_driver_unregister(&pcspkr_platform_driver);
 }
 
Index: linux-2.6-linus/arch/mips/kernel/setup.c
===================================================================
--- linux-2.6-linus.orig/arch/mips/kernel/setup.c
+++ linux-2.6-linus/arch/mips/kernel/setup.c
@@ -559,3 +559,15 @@ int __init dsp_disable(char *s)
 }
 
 __setup("nodsp", dsp_disable);
+
+static __init int add_pcspkr(void)
+{
+	struct platform_device *pd;
+
+	pd = platform_device_alloc("pcspkr", -1);
+	BUG_ON(!pd);
+	BUG_ON(platform_device_add(pd));
+
+	return 0;
+}
+device_initcall(add_pcspkr);
Index: linux-2.6-linus/arch/alpha/kernel/setup.c
===================================================================
--- linux-2.6-linus.orig/arch/alpha/kernel/setup.c
+++ linux-2.6-linus/arch/alpha/kernel/setup.c
@@ -1484,3 +1484,15 @@ alpha_panic_event(struct notifier_block 
 #endif
         return NOTIFY_DONE;
 }
+
+static __init int add_pcspkr(void)
+{
+	struct platform_device *pd;
+
+	pd = platform_device_alloc("pcspkr", -1);
+	BUGON(!pd);
+	BUGON(platform_device_add(pd));
+
+	return 0;
+}
+device_initcall(add_pcspkr);
