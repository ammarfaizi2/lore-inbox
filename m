Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUJASEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUJASEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 14:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUJASEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 14:04:35 -0400
Received: from [145.85.127.2] ([145.85.127.2]:62899 "EHLO mail.il.fontys.nl")
	by vger.kernel.org with ESMTP id S266034AbUJASDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 14:03:47 -0400
Message-ID: <51675.217.121.83.210.1096653817.squirrel@217.121.83.210>
Date: Fri, 1 Oct 2004 20:03:37 +0200 (CEST)
Subject: [Patch] i386: Xbox support for 2.6.9-rc3
From: "Ed Schouten" <ed@il.fontys.nl>
To: linux-kernel@vger.kernel.org
Cc: torvalds@ppc970.osdl.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello guys,

I though it would be usefull to mail in a new patch for the Xbox, against
Linux 2.6.9-rc3.

This patch adds the config option CONFIG_X86_XBOX and allows you to
successfully boot the Linux kernel on your Xbox, mainly by blocking some
PCI devices and adding reboot/powerdown support.
---

 CREDITS                            |    8 +++++++
 arch/i386/Kconfig                  |   16 ++++++++++++--
 arch/i386/Makefile                 |    3 ++
 arch/i386/boot/compressed/Makefile |    7 ++++++
 arch/i386/mach-xbox/Makefile       |    5 ++++
 arch/i386/mach-xbox/reboot.c       |   41
+++++++++++++++++++++++++++++++++++++
 arch/i386/pci/direct.c             |   16 ++++++++++++++
 include/asm-i386/timex.h           |    2 +
 include/asm-i386/xbox.h            |   17 +++++++++++++++
 include/linux/pci_ids.h            |    1
 10 files changed, 114 insertions, 2 deletions

diff -u -r --new-file linux-2.6.9-rc3/CREDITS linux-2.6.9-rc3-xbox/CREDITS
--- linux-2.6.9-rc3/CREDITS	2004-09-30 05:05:20.000000000 +0200
+++ linux-2.6.9-rc3-xbox/CREDITS	2004-10-01 16:19:58.276661000 +0200
@@ -2945,6 +2945,14 @@
 E:
 D: Macintosh IDE Driver

+N: Ed Schouten
+E: ed@il.fontys.nl
+W: http://g-rave.nl/
+D: Imported Xbox workarounds
+S: Klinkerstraat 20
+S: 5361 GW Grave
+S: The Netherlands
+
 N: Peter De Schrijver
 E: stud11@cc4.kuleuven.ac.be
 D: Mitsumi CD-ROM driver patches March version
diff -u -r --new-file linux-2.6.9-rc3/arch/i386/Kconfig
linux-2.6.9-rc3-xbox/arch/i386/Kconfig
--- linux-2.6.9-rc3/arch/i386/Kconfig	2004-09-30 05:03:56.000000000 +0200
+++ linux-2.6.9-rc3-xbox/arch/i386/Kconfig	2004-10-01 16:19:58.343661000
+0200
@@ -55,6 +55,18 @@

 	  If unsure, choose "PC-compatible" instead.

+config X86_XBOX
+	bool "Microsoft Xbox"
+	help
+	  This option is needed to make Linux boot on a Microsoft Xbox.
+
+	  If you are not planning on running this kernel on a Microsoft Xbox,
+	  say N here, otherwise the kernel you build will not be bootable.
+
+	  For more information about Xbox Linux, visit:
+
+	  http://www.xbox-linux.org/
+
 config X86_VOYAGER
 	bool "Voyager (NCR)"
 	help
@@ -1143,7 +1155,7 @@

 config MCA
 	bool "MCA support"
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_XBOX)
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
@@ -1206,7 +1218,7 @@

 config X86_BIOS_REBOOT
 	bool
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_XBOX)
 	default y

 config X86_TRAMPOLINE
diff -u -r --new-file linux-2.6.9-rc3/arch/i386/Makefile
linux-2.6.9-rc3-xbox/arch/i386/Makefile
--- linux-2.6.9-rc3/arch/i386/Makefile	2004-09-30 05:04:26.000000000 +0200
+++ linux-2.6.9-rc3-xbox/arch/i386/Makefile	2004-10-01 16:19:58.357661000
+0200
@@ -69,6 +69,9 @@
 mflags-$(CONFIG_X86_VOYAGER)	:= -Iinclude/asm-i386/mach-voyager
 mcore-$(CONFIG_X86_VOYAGER)	:= mach-voyager

+# Xbox subarch support
+core-$(CONFIG_X86_XBOX)		+= arch/i386/mach-xbox/
+
 # VISWS subarch support
 mflags-$(CONFIG_X86_VISWS)	:= -Iinclude/asm-i386/mach-visws
 mcore-$(CONFIG_X86_VISWS)	:= mach-visws
diff -u -r --new-file linux-2.6.9-rc3/arch/i386/boot/compressed/Makefile
linux-2.6.9-rc3-xbox/arch/i386/boot/compressed/Makefile
--- linux-2.6.9-rc3/arch/i386/boot/compressed/Makefile	2004-09-30
05:05:20.000000000 +0200
+++ linux-2.6.9-rc3-xbox/arch/i386/boot/compressed/Makefile	2004-10-01
16:19:58.369661000 +0200
@@ -7,6 +7,13 @@
 targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
 EXTRA_AFLAGS	:= -traditional

+# Microsoft Xbox workaround:
+# Xbox v1.1+ crashes while decompressing the kernel when paging is off.
+# By disabling optimization we can fix this.
+ifeq ($(CONFIG_X86_XBOX),y)
+	CFLAGS_misc.o  := -O0
+endif
+
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32

 $(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
diff -u -r --new-file linux-2.6.9-rc3/arch/i386/mach-xbox/Makefile
linux-2.6.9-rc3-xbox/arch/i386/mach-xbox/Makefile
--- linux-2.6.9-rc3/arch/i386/mach-xbox/Makefile	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.9-rc3-xbox/arch/i386/mach-xbox/Makefile	2004-10-01
16:20:20.268661000 +0200
@@ -0,0 +1,5 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y				:= reboot.o
diff -u -r --new-file linux-2.6.9-rc3/arch/i386/mach-xbox/reboot.c
linux-2.6.9-rc3-xbox/arch/i386/mach-xbox/reboot.c
--- linux-2.6.9-rc3/arch/i386/mach-xbox/reboot.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.9-rc3-xbox/arch/i386/mach-xbox/reboot.c	2004-10-01
16:19:58.373661000 +0200
@@ -0,0 +1,41 @@
+/*
+ * arch/i386/mach-xbox/reboot.c
+ * Ed Schouten <ed@il.fontys.nl>
+ *
+ * Originally done by:
+ * Olivier Fauchon <olivier.fauchon@free.fr>
+ * Anders Gustafsson <andersg@0x63.nu>
+ *
+ */
+
+#include <asm/io.h>
+#include <asm-i386/xbox.h>
+
+/* we don't use any of those, but dmi_scan.c needs 'em */
+void (*pm_power_off)(void);
+int reboot_thru_bios;
+
+static void xbox_pic_cmd(u8 command)
+{
+	outw_p(((XBOX_PIC_ADDRESS) << 1), XBOX_SMB_HOST_ADDRESS);
+	outb_p(SMC_CMD_POWER, XBOX_SMB_HOST_COMMAND);
+	outw_p(command, XBOX_SMB_HOST_DATA);
+	outw_p(inw(XBOX_SMB_IO_BASE), XBOX_SMB_IO_BASE);
+	outb_p(0x0a, XBOX_SMB_GLOBAL_ENABLE);
+}
+
+void machine_restart(char * __unused)
+{
+	printk(KERN_INFO "Sending POWER_CYCLE to XBOX-PIC.\n");
+	xbox_pic_cmd(SMC_SUBCMD_POWER_CYCLE);
+}
+
+void machine_power_off(void)
+{
+	printk(KERN_INFO "Sending POWER_OFF to XBOX-PIC.\n");
+	xbox_pic_cmd(SMC_SUBCMD_POWER_OFF);
+}
+
+void machine_halt(void)
+{
+}
diff -u -r --new-file linux-2.6.9-rc3/arch/i386/pci/direct.c
linux-2.6.9-rc3-xbox/arch/i386/pci/direct.c
--- linux-2.6.9-rc3/arch/i386/pci/direct.c	2004-09-30 05:04:23.000000000
+0200
+++ linux-2.6.9-rc3-xbox/arch/i386/pci/direct.c	2004-10-01
16:21:22.341661000 +0200
@@ -20,6 +20,22 @@
 	if (!value || (bus > 255) || (devfn > 255) || (reg > 255))
 		return -EINVAL;

+#ifdef CONFIG_X86_XBOX
+	/*
+	 * Workaround for the Microsoft Xbox:
+	 * Prevent it from tampering with some devices.
+	 */
+	if ((bus == 0) && !PCI_SLOT(devfn) &&
+			((PCI_FUNC(devfn) == 1) || (PCI_FUNC(devfn) == 2)))
+		return -EINVAL;
+
+	if ((bus == 1) && (PCI_SLOT(devfn) || PCI_FUNC(devfn)))
+		return -EINVAL;
+
+	if (bus >= 2)
+		return -EINVAL;
+#endif
+
 	spin_lock_irqsave(&pci_config_lock, flags);

 	outl(PCI_CONF1_ADDRESS(bus, devfn, reg), 0xCF8);
diff -u -r --new-file linux-2.6.9-rc3/include/asm-i386/timex.h
linux-2.6.9-rc3-xbox/include/asm-i386/timex.h
--- linux-2.6.9-rc3/include/asm-i386/timex.h	2004-09-30 05:04:25.000000000
+0200
+++ linux-2.6.9-rc3-xbox/include/asm-i386/timex.h	2004-10-01
16:19:58.439661000 +0200
@@ -11,6 +11,8 @@

 #ifdef CONFIG_X86_ELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
+#elif CONFIG_X86_XBOX
+#  define CLOCK_TICK_RATE 1125000 /* Microsoft Xbox */
 #else
 #  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */
 #endif
diff -u -r --new-file linux-2.6.9-rc3/include/asm-i386/xbox.h
linux-2.6.9-rc3-xbox/include/asm-i386/xbox.h
--- linux-2.6.9-rc3/include/asm-i386/xbox.h	1970-01-01 01:00:00.000000000
+0100
+++ linux-2.6.9-rc3-xbox/include/asm-i386/xbox.h	2004-10-01
16:19:58.443661000 +0200
@@ -0,0 +1,17 @@
+/*
+ * include/asm-i386/xbox.h
+ * Ed Schouten <ed@il.fontys.nl>
+ */
+
+#define XBOX_SMB_IO_BASE               0xC000
+#define XBOX_SMB_HOST_ADDRESS          (0x4 + XBOX_SMB_IO_BASE)
+#define XBOX_SMB_HOST_COMMAND          (0x8 + XBOX_SMB_IO_BASE)
+#define XBOX_SMB_HOST_DATA             (0x6 + XBOX_SMB_IO_BASE)
+#define XBOX_SMB_GLOBAL_ENABLE         (0x2 + XBOX_SMB_IO_BASE)
+
+#define XBOX_PIC_ADDRESS               0x10
+
+#define SMC_CMD_POWER                  0x02
+#define SMC_SUBCMD_POWER_RESET         0x01
+#define SMC_SUBCMD_POWER_CYCLE         0x40
+#define SMC_SUBCMD_POWER_OFF           0x80
diff -u -r --new-file linux-2.6.9-rc3/include/linux/pci_ids.h
linux-2.6.9-rc3-xbox/include/linux/pci_ids.h
--- linux-2.6.9-rc3/include/linux/pci_ids.h	2004-09-30 05:06:05.000000000
+0200
+++ linux-2.6.9-rc3-xbox/include/linux/pci_ids.h	2004-10-01
16:19:58.505661000 +0200
@@ -1138,6 +1138,7 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL	0x0258
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL	0x0259
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL	0x025B
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE3_XBOX	0x02A0

 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_8849		0x8849
