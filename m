Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287912AbSABTKa>; Wed, 2 Jan 2002 14:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287903AbSABTKO>; Wed, 2 Jan 2002 14:10:14 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:49126 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S282978AbSABTJR>;
	Wed, 2 Jan 2002 14:09:17 -0500
Date: Wed, 2 Jan 2002 20:09:15 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200201021909.UAA18859@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: [PATCH] DMI/APIC updates 3 of 4: early-dmi-scan
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This is part 3 of 4 of a patch set for 2.5.2-pre6 to move the
x86 DMI scan to an earlier point in the boot sequence. This is
motivated by the UP APIC code, which must be disabled on some
machines with broken BIOSen, but there are also other cases that
would benefit from it. Tested. Please apply.

This third patch (patch-early-dmi-scan) changes the boot sequence
so that the DMI scan is called from setup_arch() instead of being
a module_init(). This allows the DMI data to be used to control if
and how the core hardware is initialised. In dmi_scan.c, ioremap()
and kmalloc() are replaced by bt_ioremap() and alloc_bootmem().
This requires the boot-time-ioremap patch I posted previously,

/Mikael

diff -ruN linux-2.5.2-pre6/arch/i386/kernel/dmi_scan.c linux-2.5.2-pre6.early-dmi-scan/arch/i386/kernel/dmi_scan.c
--- linux-2.5.2-pre6/arch/i386/kernel/dmi_scan.c	Wed Jan  2 00:43:14 2002
+++ linux-2.5.2-pre6.early-dmi-scan/arch/i386/kernel/dmi_scan.c	Wed Jan  2 00:57:49 2002
@@ -9,6 +9,7 @@
 #include <linux/pm.h>
 #include <asm/keyboard.h>
 #include <asm/system.h>
+#include <linux/bootmem.h>
 
 unsigned long dmi_broken;
 int is_sony_vaio_laptop;
@@ -51,7 +52,7 @@
 	u8 *data;
 	int i=1;
 		
-	buf = ioremap(base, len);
+	buf = bt_ioremap(base, len);
 	if(buf==NULL)
 		return -1;
 
@@ -83,7 +84,7 @@
 		data+=2;
 		i++;
 	}
-	iounmap(buf);
+	bt_iounmap(buf, len);
 	return 0;
 }
 
@@ -155,7 +156,7 @@
 		return;
 	if (dmi_ident[slot])
 		return;
-	dmi_ident[slot] = kmalloc(strlen(p)+1, GFP_KERNEL);
+	dmi_ident[slot] = alloc_bootmem(strlen(p)+1);
 	if(dmi_ident[slot])
 		strcpy(dmi_ident[slot], p);
 	else
@@ -728,12 +729,9 @@
 	}
 }
 
-static int __init dmi_scan_machine(void)
+void __init dmi_scan_machine(void)
 {
 	int err = dmi_iterate(dmi_decode);
 	if(err == 0)
 		dmi_check_blacklist();
-	return err;
 }
-
-module_init(dmi_scan_machine);
diff -ruN linux-2.5.2-pre6/arch/i386/kernel/setup.c linux-2.5.2-pre6.early-dmi-scan/arch/i386/kernel/setup.c
--- linux-2.5.2-pre6/arch/i386/kernel/setup.c	Wed Jan  2 00:43:14 2002
+++ linux-2.5.2-pre6.early-dmi-scan/arch/i386/kernel/setup.c	Wed Jan  2 00:57:49 2002
@@ -155,6 +155,7 @@
 unsigned char aux_device_present;
 
 extern void mcheck_init(struct cpuinfo_x86 *c);
+extern void dmi_scan_machine(void);
 extern int root_mountflags;
 extern char _text, _etext, _edata, _end;
 extern int blk_nohighio;
@@ -921,6 +922,7 @@
 	conswitchp = &dummy_con;
 #endif
 #endif
+	dmi_scan_machine();
 }
 
 static int cachesize_override __initdata = -1;
