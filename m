Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbSKRQWe>; Mon, 18 Nov 2002 11:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262828AbSKRQWe>; Mon, 18 Nov 2002 11:22:34 -0500
Received: from h-64-105-34-70.SNVACAID.covad.net ([64.105.34.70]:43975 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262859AbSKRQWd>; Mon, 18 Nov 2002 11:22:33 -0500
Date: Mon, 18 Nov 2002 08:28:57 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Patch(2.5.48): Restore module device ID tables
Message-ID: <20021118082857.A3192@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.5.48 temporarily (according to the ChangeLog) loses
support for module device ID tables.  There are used so that the right
modules will be loaded for your PCI and, USB devices (for example)
without needing to maintain custom configuration files.

	This patch ameliorates this loss by restoring the
MODULE_{DEVICE,GENERIC}_TABLE macros.  This way, you can run the
existing depmod program, and it will build the approprite device ID
files.  I have verified that compiling drivers/net/rrunner.o,
installing it and running depmod results in a sensible looking entry
in modules.pcimap.  I am attempting to build a boot a system based on
Rusty Rusell's module-init tools and Keith Owen's depmod, but I may
not be able to return to that task until later in the day, so I'm
posting this patch now.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="module.h.diff"

--- linux-2.5.48/include/linux/module.h	2002-11-17 20:29:52.000000000 -0800
+++ linux/include/linux/module.h	2002-11-18 08:05:19.000000000 -0800
@@ -26,8 +26,6 @@
 #define MODULE_AUTHOR(name)
 #define MODULE_DESCRIPTION(desc)
 #define MODULE_SUPPORTED_DEVICE(name)
-#define MODULE_GENERIC_TABLE(gtype,name)
-#define MODULE_DEVICE_TABLE(type,name)
 #define MODULE_PARM_DESC(var,desc)
 #define print_symbol(format, addr)
 #define print_modules()
@@ -40,14 +38,28 @@
 };
 
 #ifdef MODULE
+
+#define MODULE_GENERIC_TABLE(gtype,name)	\
+static const unsigned long __module_##gtype##_size \
+  __attribute__ ((unused)) = sizeof(struct gtype##_id); \
+static const struct gtype##_id * __module_##gtype##_table \
+  __attribute__ ((unused)) = name
+
 /* This is magically filled in by the linker, but THIS_MODULE must be
    a constant so it works in initializers. */
 extern struct module __this_module;
 #define THIS_MODULE (&__this_module)
-#else
+
+#else  /* !MODULE */
+
+#define MODULE_GENERIC_TABLE(gtype,name)
 #define THIS_MODULE ((struct module *)0)
+
 #endif
 
+#define MODULE_DEVICE_TABLE(type,name)		\
+  MODULE_GENERIC_TABLE(type##_device,name)
+
 #ifdef CONFIG_MODULES
 /* Get/put a kernel symbol (calls must be symmetric) */
 void *__symbol_get(const char *symbol);

--AhhlLboLdkugWU4S--
