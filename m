Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265402AbUFHXoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265402AbUFHXoW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 19:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbUFHXoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 19:44:22 -0400
Received: from ozlabs.org ([203.10.76.45]:19900 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265402AbUFHXoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 19:44:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16582.20441.569108.903222@cargo.ozlabs.ibm.com>
Date: Wed, 9 Jun 2004 09:46:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
       benh@kernel.crashing.org, olh@suse.de
Subject: [PATCH][PPC32] serial console autodetection
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Olaf Hering <olh@suse.de>:

We have something like this in our kernel since many months.
It sets the console device to what OF uses. ppc64 does the same, and it
works ok. serial is found on CHRP, ch-a is used on all powermacs.

diff -p -purN linux-2.6.6-bk8/arch/ppc/kernel/setup.c linux-2.6.6-bk8.autoconsole/arch/ppc/kernel/setup.c
--- linux-2.6.6-bk8/arch/ppc/kernel/setup.c	2004-05-22 09:18:42.000000000 +0200
+++ linux-2.6.6-bk8.autoconsole/arch/ppc/kernel/setup.c	2004-05-22 09:29:18.000000000 +0200
@@ -16,6 +16,7 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/cpu.h>
+#include <linux/console.h>
 
 #include <asm/residual.h>
 #include <asm/io.h>
@@ -474,6 +475,60 @@ platform_init(unsigned long r3, unsigned
 		break;
 	}
 }
+
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+extern char *of_stdout_device;
+
+static int __init set_preferred_console(void)
+{
+	struct device_node *prom_stdout;
+	char *name;
+	int offset;
+
+	/* The user has requested a console so this is already set up. */
+	if (strstr(saved_command_line, "console="))
+		return -EBUSY;
+
+	prom_stdout = find_path_device(of_stdout_device);
+	if (!prom_stdout)
+		return -ENODEV;
+
+	name = (char *)get_property(prom_stdout, "name", NULL);
+	if (!name)
+		return -ENODEV;
+
+	if (strcmp(name, "serial") == 0) {
+		int i;
+		u32 *reg = (u32 *)get_property(prom_stdout, "reg", &i);
+		if (i > 8) {
+			switch (reg[1]) {
+				case 0x3f8:
+					offset = 0;
+					break;
+				case 0x2f8:
+					offset = 1;
+					break;
+				case 0x898:
+					offset = 2;
+					break;
+				case 0x890:
+					offset = 3;
+					break;
+				default:
+					/* We dont recognise the serial port */
+					return -ENODEV;
+			}
+		}
+	} else if (strcmp(name, "ch-a") == 0)
+		offset = 0;
+	else if (strcmp(name, "ch-b") == 0)
+		offset = 1;
+	else
+		return -ENODEV;
+	return add_preferred_console("ttyS", offset, NULL);
+}
+console_initcall(set_preferred_console);
+#endif /* CONFIG_SERIAL_CORE_CONSOLE */
 #endif /* CONFIG_PPC_MULTIPLATFORM */
 
 struct bi_record *find_bootinfo(void)
diff -p -purN linux-2.6.6-bk8/arch/ppc/syslib/prom_init.c linux-2.6.6-bk8.autoconsole/arch/ppc/syslib/prom_init.c
--- linux-2.6.6-bk8/arch/ppc/syslib/prom_init.c	2004-05-22 09:18:42.000000000 +0200
+++ linux-2.6.6-bk8.autoconsole/arch/ppc/syslib/prom_init.c	2004-05-22 09:26:54.000000000 +0200
@@ -118,7 +118,7 @@ ihandle prom_stdout __initdata = 0;
 char *prom_display_paths[FB_MAX] __initdata = { 0, };
 phandle prom_display_nodes[FB_MAX] __initdata;
 unsigned int prom_num_displays __initdata = 0;
-static char *of_stdout_device __initdata = 0;
+char *of_stdout_device __initdata = 0;
 static ihandle prom_disp_node __initdata = 0;
 
 unsigned int rtas_data;   /* physical pointer */
@@ -880,6 +880,11 @@ prom_init(int r3, int r4, prom_entry pp)
 	for (i = 0; i < prom_num_displays; ++i)
 		prom_display_paths[i] = PTRUNRELOC(prom_display_paths[i]);
 
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+	/* Relocate the of stdout for console autodetection */
+	of_stdout_device = PTRUNRELOC(of_stdout_device);
+#endif
+
 	prom_print("returning 0x");
 	prom_print_hex(phys);
 	prom_print("from prom_init\n");
