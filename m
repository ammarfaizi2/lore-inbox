Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267356AbUJIUGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267356AbUJIUGS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUJIUFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:05:34 -0400
Received: from [145.85.127.2] ([145.85.127.2]:65252 "EHLO mail.il.fontys.nl")
	by vger.kernel.org with ESMTP id S267354AbUJIUEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:04:12 -0400
Message-ID: <51262.217.121.83.210.1097352243.squirrel@217.121.83.210>
Date: Sat, 9 Oct 2004 22:04:03 +0200 (CEST)
Subject: [Patch 4/5] xbox: add reboot code
From: "Ed Schouten" <ed@il.fontys.nl>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Microsoft Xbox uses a different method to reboot or halt the system.
Therefore, we need to add some functions to alternatively shutdown the
system.

You can also download this patch at:
http://linux.g-rave.nl/patches/patch-xbox-reboot.diff
---

 arch/i386/Makefile           |    3 +++
 arch/i386/mach-xbox/Makefile |    5 +++++
 arch/i386/mach-xbox/reboot.c |   39 +++++++++++++++++++++++++++++++++++++++
 include/asm-i386/xbox.h      |   17 +++++++++++++++++
 4 files changed, 64 insertions(+)

diff -u -r --new-file linux-2.6.9-rc3/arch/i386/Makefile
linux-2.6.9-rc3-ed0/arch/i386/Makefile
--- linux-2.6.9-rc3/arch/i386/Makefile	2004-09-30 05:04:26.000000000 +0200
+++ linux-2.6.9-rc3-ed0/arch/i386/Makefile	2004-10-09 21:08:11.380284000
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
diff -u -r --new-file linux-2.6.9-rc3/arch/i386/mach-xbox/Makefile
linux-2.6.9-rc3-ed0/arch/i386/mach-xbox/Makefile
--- linux-2.6.9-rc3/arch/i386/mach-xbox/Makefile	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.9-rc3-ed0/arch/i386/mach-xbox/Makefile	2004-10-09
21:08:11.401284000 +0200
@@ -0,0 +1,5 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y				:= reboot.o
diff -u -r --new-file linux-2.6.9-rc3/arch/i386/mach-xbox/reboot.c
linux-2.6.9-rc3-ed0/arch/i386/mach-xbox/reboot.c
--- linux-2.6.9-rc3/arch/i386/mach-xbox/reboot.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.9-rc3-ed0/arch/i386/mach-xbox/reboot.c	2004-10-09
21:08:30.105284000 +0200
@@ -0,0 +1,39 @@
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
+	xbox_pic_cmd(SMC_SUBCMD_POWER_CYCLE);
+}
+
+void machine_power_off(void)
+{
+	xbox_pic_cmd(SMC_SUBCMD_POWER_OFF);
+}
+
+void machine_halt(void)
+{
+}
diff -u -r --new-file linux-2.6.9-rc3/include/asm-i386/xbox.h
linux-2.6.9-rc3-ed0/include/asm-i386/xbox.h
--- linux-2.6.9-rc3/include/asm-i386/xbox.h	1970-01-01 01:00:00.000000000
+0100
+++ linux-2.6.9-rc3-ed0/include/asm-i386/xbox.h	2004-10-09
21:08:11.448284000 +0200
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
