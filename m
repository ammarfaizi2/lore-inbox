Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTHZBX4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 21:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbTHZBX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 21:23:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:42192 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262344AbTHZBXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 21:23:54 -0400
Subject: [PATCH] linux-2.4.22_clear-smi-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1061861021.23049.213.camel@laptop.cornchips.homelinux.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Aug 2003 18:23:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, All,

      Some of our more recent hardware requires that SMIs are routed
through the IOAPIC, thus when we clear_IO_APIC() at boot time, we clear
the BIOS initialized SMI pin (which is unfortunately not described in
the MPS or ACPI tables). This basically clobbers the SMI, which can
cause problems with console redirection as well keeping us from being
able to transition into full ACPI mode. 

This patch (back ported from 2.5) simply reads the apic entry in
clear_IO_APIC to make sure the delivery_mode isn't dest_SMI. If it is,
we leave the apic entry alone and return. 

With this patch, booting with full ACPI works and SMIs function
properly. 

Please consider for acceptance.

thanks
-john


diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Mon Aug 25 14:10:12 2003
+++ b/arch/i386/kernel/io_apic.c	Mon Aug 25 14:10:12 2003
@@ -169,6 +169,14 @@
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
+	
+	/* Check delivery_mode to be sure we're not clearing an SMI pin */
+	spin_lock_irqsave(&ioapic_lock, flags);
+	*(((int*)&entry) + 0) = io_apic_read(apic, 0x10 + 2 * pin);
+	*(((int*)&entry) + 1) = io_apic_read(apic, 0x11 + 2 * pin);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+	if (entry.delivery_mode == dest_SMI)
+		return;
 
 	/*
 	 * Disable it in the IO-APIC irq-routing table:



