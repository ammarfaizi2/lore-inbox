Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWIKLzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWIKLzH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 07:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWIKLzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 07:55:07 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:2187 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S1751214AbWIKLzG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 07:55:06 -0400
Date: Mon, 11 Sep 2006 13:53:54 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] Prevent legacy io access on pmac
Message-ID: <20060911115354.GA23884@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The ppc32 common config runs also on PReP/CHRP, which uses PC style IO
devices.  The probing is bogus, it crashes or floods dmesg.

ppc can boot one single binary on prep, chrp and pmac boards.
ppc64 can boot one single binary on pseries and G5 boards.
pmac has no legacy io, probing for PC style legacy hardware leads to a
hard crash:

* add check for parport_pc, exit on pmac.
32bit chrp has no ->check_legacy_ioport, the probe is always called.
64bit chrp has check_legacy_ioport, check for a "parallel" node

* add check for isapnp, only PReP boards may have real ISA slots.
32bit PReP will have no ->check_legacy_ioport, the probe is always called.

* update code in i8042_platform_init. Run ->check_legacy_ioport first, always
call request_region. No functional change. Remove whitespace before i8042_reset init.


Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/platforms/pseries/setup.c |    6 ++++++
 drivers/input/serio/i8042-io.h         |   13 +++++--------
 drivers/parport/parport_pc.c           |    4 ++++
 drivers/pnp/pnpbios/core.c             |    8 ++++++++
 include/asm-powerpc/io.h               |    2 ++
 5 files changed, 25 insertions(+), 8 deletions(-)

Index: linux-2.6.18-rc6/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-2.6.18-rc6.orig/arch/powerpc/platforms/pseries/setup.c
+++ linux-2.6.18-rc6/arch/powerpc/platforms/pseries/setup.c
@@ -401,6 +401,12 @@ static int pSeries_check_legacy_ioport(u
 			return -ENODEV;
 		of_node_put(np);
 		break;
+	case PARALLEL_BASE:
+		np = of_find_node_by_type(NULL, "parallel");
+		if (np == NULL)
+			return -ENODEV;
+		of_node_put(np);
+		break;
 	}
 	return 0;
 }
Index: linux-2.6.18-rc6/drivers/input/serio/i8042-io.h
===================================================================
--- linux-2.6.18-rc6.orig/drivers/input/serio/i8042-io.h
+++ linux-2.6.18-rc6/drivers/input/serio/i8042-io.h
@@ -67,25 +67,22 @@ static inline int i8042_platform_init(vo
  * On some platforms touching the i8042 data register region can do really
  * bad things. Because of this the region is always reserved on such boxes.
  */
-#if !defined(__sh__) && !defined(__alpha__) && !defined(__mips__) && !defined(CONFIG_PPC_MERGE)
-	if (!request_region(I8042_DATA_REG, 16, "i8042"))
-		return -EBUSY;
-#endif
-
-        i8042_reset = 1;
-
 #if defined(CONFIG_PPC_MERGE)
 	if (check_legacy_ioport(I8042_DATA_REG))
 		return -EBUSY;
+#endif
+#if !defined(__sh__) && !defined(__alpha__) && !defined(__mips__)
 	if (!request_region(I8042_DATA_REG, 16, "i8042"))
 		return -EBUSY;
 #endif
+
+	i8042_reset = 1;
 	return 0;
 }
 
 static inline void i8042_platform_exit(void)
 {
-#if !defined(__sh__) && !defined(__alpha__) && !defined(CONFIG_PPC64)
+#if !defined(__sh__) && !defined(__alpha__)
 	release_region(I8042_DATA_REG, 16);
 #endif
 }
Index: linux-2.6.18-rc6/drivers/parport/parport_pc.c
===================================================================
--- linux-2.6.18-rc6.orig/drivers/parport/parport_pc.c
+++ linux-2.6.18-rc6/drivers/parport/parport_pc.c
@@ -3374,6 +3374,10 @@ __setup("parport_init_mode=",parport_ini
 
 static int __init parport_pc_init(void)
 {
+#if defined(CONFIG_PPC_MERGE)
+	if (check_legacy_ioport(PARALLEL_BASE))
+		return -EBUSY;
+#endif
 	if (parse_parport_params())
 		return -EINVAL;
 
Index: linux-2.6.18-rc6/include/asm-powerpc/io.h
===================================================================
--- linux-2.6.18-rc6.orig/include/asm-powerpc/io.h
+++ linux-2.6.18-rc6/include/asm-powerpc/io.h
@@ -11,6 +11,8 @@
 
 /* Check of existence of legacy devices */
 extern int check_legacy_ioport(unsigned long base_port);
+#define PARALLEL_BASE	0x378
+#define PNPBIOS_BASE	0xf000	/* only relevant for PReP */
 
 #ifndef CONFIG_PPC64
 #include <asm-ppc/io.h>
Index: linux-2.6.18-rc6/drivers/pnp/pnpbios/core.c
===================================================================
--- linux-2.6.18-rc6.orig/drivers/pnp/pnpbios/core.c
+++ linux-2.6.18-rc6/drivers/pnp/pnpbios/core.c
@@ -526,6 +526,10 @@ static int __init pnpbios_init(void)
 {
 	int ret;
 
+#if defined(CONFIG_PPC_MERGE)
+	if (check_legacy_ioport(PNPBIOS_BASE))
+		return -ENODEV;
+#endif
 	if (pnpbios_disabled || dmi_check_system(pnpbios_dmi_table)) {
 		printk(KERN_INFO "PnPBIOS: Disabled\n");
 		return -ENODEV;
@@ -575,6 +579,10 @@ subsys_initcall(pnpbios_init);
 
 static int __init pnpbios_thread_init(void)
 {
+#if defined(CONFIG_PPC_MERGE)
+	if (check_legacy_ioport(PNPBIOS_BASE))
+		return 0;
+#endif
 	if (pnpbios_disabled)
 		return 0;
 #ifdef CONFIG_HOTPLUG
