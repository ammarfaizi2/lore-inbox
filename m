Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267840AbUGWQsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267840AbUGWQsT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 12:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267841AbUGWQsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 12:48:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:34986 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267840AbUGWQsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 12:48:03 -0400
Date: Fri, 23 Jul 2004 18:44:50 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Paul Mackeras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>
Subject: Re: reserve legacy io regions on powermac
Message-ID: <20040723164450.GA3836@suse.de>
References: <20040721091249.GA1336@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040721091249.GA1336@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jul 21, Olaf Hering wrote:

> 
> Anton pointed this out.
> 
> ppc32 can boot one single binary on prep, chrp and pmac boards.
> pmac has no legacy io, probing for PC style legacy hardware leads to a
> hard crash.
> Several patches exist to prevent serial, floppy, ps2, parport and other
> drivers from probing these io ports.
> I think the simplest fix for 2.6 is a request_region of the problematic
> areas.

This one works for me with serial console and a pccard modem.


diff -purN linux-2.6.7/arch/ppc/kernel/setup.c linux-2.6.8-rc2/arch/ppc/kernel/setup.c
--- linux-2.6.7/arch/ppc/kernel/setup.c	2004-07-23 18:30:32.983641453 +0200
+++ linux-2.6.8-rc2/arch/ppc/kernel/setup.c	2004-07-23 18:25:40.371381030 +0200
@@ -477,6 +477,8 @@ platform_init(unsigned long r3, unsigned
 
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
 extern char *of_stdout_device;
+int do_not_try_pc_legacy_8250_console;
+EXPORT_SYMBOL(do_not_try_pc_legacy_8250_console);
 
 static int __init set_preferred_console(void)
 {
@@ -518,10 +520,14 @@ static int __init set_preferred_console(
 					return -ENODEV;
 			}
 		}
-	} else if (strcmp(name, "ch-a") == 0)
+	} else if (strcmp(name, "ch-a") == 0) {
+		do_not_try_pc_legacy_8250_console = 1;
 		offset = 0;
-	else if (strcmp(name, "ch-b") == 0)
+	}
+	else if (strcmp(name, "ch-b") == 0) {
+		do_not_try_pc_legacy_8250_console = 1;
 		offset = 1;
+	}
 	else
 		return -ENODEV;
 	return add_preferred_console("ttyS", offset, NULL);
diff -purN linux-2.6.7/arch/ppc/platforms/pmac_pci.c linux-2.6.8-rc2/arch/ppc/platforms/pmac_pci.c
--- linux-2.6.7/arch/ppc/platforms/pmac_pci.c	2004-06-16 07:19:23.000000000 +0200
+++ linux-2.6.8-rc2/arch/ppc/platforms/pmac_pci.c	2004-07-23 16:40:18.092808076 +0200
@@ -888,6 +888,9 @@ pmac_pcibios_fixup(void)
 {
 	/* Fixup interrupts according to OF tree */
 	pcibios_fixup_OF_interrupts();
+	request_region(0x0UL, 0x2e0UL, "reserved legacy io");
+	request_region(0x300UL, 0xe0UL, "reserved legacy io");
+	request_region(0x400UL, 0x10000UL-0x400UL, "reserved legacy io");
 }
 
 int __pmac
diff -purN linux-2.6.7/drivers/serial/8250.c linux-2.6.8-rc2/drivers/serial/8250.c
--- linux-2.6.7/drivers/serial/8250.c	2004-07-23 18:30:39.200571363 +0200
+++ linux-2.6.8-rc2/drivers/serial/8250.c	2004-07-23 18:22:22.607426922 +0200
@@ -36,6 +36,10 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
+#ifndef NO_PC_LEGACY_SERIAL_8250_CONSOLE
+#define do_not_try_pc_legacy_8250_console (0)
+#endif
+
 #if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
 #endif
@@ -2017,6 +2021,10 @@ static struct console serial8250_console
 
 static int __init serial8250_console_init(void)
 {
+	if(do_not_try_pc_legacy_8250_console) {
+		printk("%s: nothing to do on this board\n",__FUNCTION__);
+		return -ENODEV;
+	}
 	serial8250_isa_init_ports();
 	register_console(&serial8250_console);
 	return 0;
@@ -2166,6 +2174,11 @@ static int __init serial8250_init(void)
 {
 	int ret, i;
 
+	if(do_not_try_pc_legacy_8250_console) {
+		printk("%s: nothing to do on this board\n",__FUNCTION__);
+		return -ENODEV;
+	}
+
 	printk(KERN_INFO "Serial: 8250/16550 driver $Revision: 1.90 $ "
 		"%d ports, IRQ sharing %sabled\n", (int) UART_NR,
 		share_irqs ? "en" : "dis");
diff -purN linux-2.6.7/include/asm-ppc/io.h linux-2.6.8-rc2/include/asm-ppc/io.h
--- linux-2.6.7/include/asm-ppc/io.h	2004-07-23 18:30:41.815545307 +0200
+++ linux-2.6.8-rc2/include/asm-ppc/io.h	2004-07-23 18:21:56.999578333 +0200
@@ -399,6 +399,10 @@ static inline int isa_check_signature(un
 	return 0;
 }
 
+#define NO_PC_LEGACY_SERIAL_8250_CONSOLE 1
+extern int do_not_try_pc_legacy_8250_console;
+
+
 #endif /* _PPC_IO_H */
 
 #ifdef CONFIG_8260_PCI9

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
