Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbTLQN50 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 08:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbTLQN50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 08:57:26 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:6529
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264314AbTLQN5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 08:57:23 -0500
Date: Wed, 17 Dec 2003 08:56:34 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.6.0-test11-mm1
In-Reply-To: <20031217014350.028460b2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0312170853370.2159@montezuma.fsmlabs.com>
References: <20031217014350.028460b2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hullo Andrew,
	I believe this was the intention;

On Wed, 17 Dec 2003, Andrew Morton wrote:

> mpparse_es7000.patch
>   mpparse: fix IRQ breakage from the es7000 merge

For ES7000 add an offset of 16 to the irq in order to setup a mapping where
ISA/legacy interrupts are in the 0-15 range and PCI 16 and above. This was
a cleanup fix in order to facilitate easy differentiating between legacy
and non legacy interrupt setup.

===
The ES7000 merge added a bit of code of offset the IRQ numbers.  We're not
too sure why; it wasn't changelogged.

But it broke other systems, so this patch arranges for that code to only be
activated on es7000 machines.



 arch/i386/kernel/dmi_scan.c    |    1 +
 arch/i386/kernel/mpparse.c     |    7 +++++--
 arch/i386/mach-es7000/es7000.c |    2 --
 include/asm-i386/system.h      |    1 +
 4 files changed, 7 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/dmi_scan.c~mpparse_es7000 arch/i386/kernel/dmi_scan.c
--- 25/arch/i386/kernel/dmi_scan.c~mpparse_es7000	2003-11-21 01:30:11.000000000 -0800
+++ 25-akpm/arch/i386/kernel/dmi_scan.c	2003-11-21 01:30:11.000000000 -0800
@@ -16,6 +16,7 @@ EXPORT_SYMBOL(dmi_broken);

 int is_sony_vaio_laptop;
 int is_unsafe_smbus;
+int es7000_plat = 0;

 struct dmi_header
 {
diff -puN arch/i386/kernel/mpparse.c~mpparse_es7000 arch/i386/kernel/mpparse.c
--- 25/arch/i386/kernel/mpparse.c~mpparse_es7000	2003-11-21 01:30:11.000000000 -0800
+++ 25-akpm/arch/i386/kernel/mpparse.c	2003-11-21 01:30:11.000000000 -0800
@@ -1129,8 +1129,11 @@ void __init mp_parse_prt (void)
 			continue;
 		ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;

-		if (!ioapic && (irq < 16))
-			irq += 16;
+		if (es7000_plat) {
+			if (!ioapic && (irq < 16))
+				irq += 16;
+		}
+
 		/*
 		 * Avoid pin reprogramming.  PRTs typically include entries
 		 * with redundant pin->irq mappings (but unique PCI devices);
diff -puN arch/i386/mach-es7000/es7000.c~mpparse_es7000 arch/i386/mach-es7000/es7000.c
--- 25/arch/i386/mach-es7000/es7000.c~mpparse_es7000	2003-11-21 01:30:11.000000000 -0800
+++ 25-akpm/arch/i386/mach-es7000/es7000.c	2003-11-21 01:30:11.000000000 -0800
@@ -51,8 +51,6 @@ struct mip_reg		*host_reg;
 int 			mip_port;
 unsigned long		mip_addr, host_addr;

-static int		es7000_plat;
-
 /*
  * Parse the OEM Table
  */
diff -puN include/asm-i386/system.h~mpparse_es7000 include/asm-i386/system.h
--- 25/include/asm-i386/system.h~mpparse_es7000	2003-11-21 01:30:11.000000000 -0800
+++ 25-akpm/include/asm-i386/system.h	2003-11-21 01:30:11.000000000 -0800
@@ -470,6 +470,7 @@ void enable_hlt(void);

 extern unsigned long dmi_broken;
 extern int is_sony_vaio_laptop;
+extern int es7000_plat;

 #define BROKEN_ACPI_Sx		0x0001
 #define BROKEN_INIT_AFTER_S1	0x0002

_
