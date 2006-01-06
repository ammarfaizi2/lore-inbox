Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752467AbWAFQbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbWAFQbX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbWAFQaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:30:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36031 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752447AbWAFQaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:30:02 -0500
Date: Fri, 6 Jan 2006 16:29:36 GMT
Message-Id: <200601061629.k06GTaaG011380@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 10/17] FRV: Force serial driver inclusion 
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch forces the 8230 serial driver to be built in if the on-CPU
UARTs are to be used. It can't be used as a module because the arch setup
needs to call into it.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-serial-2615.diff
 arch/frv/Kconfig        |    5 +++++
 arch/frv/kernel/setup.c |    2 ++
 2 files changed, 7 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/Kconfig linux-2.6.15-frv/arch/frv/Kconfig
--- /warthog/kernels/linux-2.6.15/arch/frv/Kconfig	2005-08-30 13:56:10.000000000 +0100
+++ linux-2.6.15-frv/arch/frv/Kconfig	2006-01-06 14:43:43.000000000 +0000
@@ -274,6 +274,11 @@ config GPREL_DATA_NONE
 
 endchoice
 
+config FRV_ONCPU_SERIAL
+	bool "Use on-CPU serial ports"
+	select SERIAL_8250
+	default y
+
 config PCI
 	bool "Use PCI"
 	depends on MB93090_MB00
diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/kernel/setup.c linux-2.6.15-frv/arch/frv/kernel/setup.c
--- /warthog/kernels/linux-2.6.15/arch/frv/kernel/setup.c	2005-08-30 13:56:10.000000000 +0100
+++ linux-2.6.15-frv/arch/frv/kernel/setup.c	2006-01-06 14:43:43.000000000 +0000
@@ -787,6 +787,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	/* register those serial ports that are available */
+#ifdef CONFIG_FRV_ONCPU_SERIAL
 #ifndef CONFIG_GDBSTUB_UART0
 	__reg(UART0_BASE + UART_IER * 8) = 0;
 	early_serial_setup(&__frv_uart0);
@@ -795,6 +796,7 @@ void __init setup_arch(char **cmdline_p)
 	__reg(UART1_BASE + UART_IER * 8) = 0;
 	early_serial_setup(&__frv_uart1);
 #endif
+#endif
 
 #if defined(CONFIG_CHR_DEV_FLASH) || defined(CONFIG_BLK_DEV_FLASH)
 	/* we need to initialize the Flashrom device here since we might
