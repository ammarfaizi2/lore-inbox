Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbUCTXKM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 18:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbUCTXKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 18:10:12 -0500
Received: from aun.it.uu.se ([130.238.12.36]:2488 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263262AbUCTXKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 18:10:06 -0500
Date: Sun, 21 Mar 2004 00:10:03 +0100 (MET)
Message-Id: <200403202310.i2KNA3sp006345@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: [PATCH][2.4.26-pre5][x86_64] pci=noapci bogus warning
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

2.4.26-pre5 on x86_64 does implement pci=noacpi, but
using the option triggers a scary message from PCI that
the option is unknown. (It's really e820.c and ACPI
that implement it.)

This is highly confusing when once's trying to figure
out which combination of apic/noapic, acpi=, and pci=
leads to a working system :-(

The patch below fixes this by updating pci-pc.c to
handle "pci=noacpi" like i386 does.

[My MSI K8T-NEO-FIS2R needs ACPI for poweroff (since
there's no APM in the x86_64 kernel), and then pci=noacpi
to prevent ACPI from overriding the perfectly good MP
table's data and mess up the timer and the NIC.]

/Mikael

diff -ruN linux-2.4.26-pre5/arch/x86_64/kernel/pci-pc.c linux-2.4.26-pre5.x86_64-pci=noacpi-fix/arch/x86_64/kernel/pci-pc.c
--- linux-2.4.26-pre5/arch/x86_64/kernel/pci-pc.c	2003-11-29 00:28:11.000000000 +0100
+++ linux-2.4.26-pre5.x86_64-pci=noacpi-fix/arch/x86_64/kernel/pci-pc.c	2004-03-20 23:22:27.000000000 +0100
@@ -645,6 +645,9 @@
 	} else if (!strncmp(str, "lastbus=", 8)) {
 		pcibios_last_bus = simple_strtol(str+8, NULL, 0);
 		return NULL;
+	} else if (!strncmp(str, "noacpi", 6)) {
+		acpi_noirq_set();
+		return NULL;
 	}
 	return str;
 }
