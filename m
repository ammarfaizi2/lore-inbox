Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbTEMAVP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 20:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbTEMAVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 20:21:15 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:53961 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262961AbTEMAVN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 20:21:13 -0400
Subject: [PATCH] linux-2.5.69_clear-smi-fix_A1
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James <jamesclv@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052785802.4169.12.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 May 2003 17:30:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All, 
	I've been having problems with ACPI on a box here in our lab. Some of
our more recent hardware requires that SMIs are routed through the
IOAPIC, thus when we clear_IO_APIC() at boot time, we clear the BIOS
initialized SMI pin. This basically clobbers the SMI so we can then
never make the transition into ACPI mode. 

This patch simply reads the apic entry in clear_IO_APIC to make sure the
delivery_mode isn't dest_SMI. If it is, we leave the apic entry alone
and return.

With this patch, the box boots and SMIs function properly.

Please consider for inclusion.

thanks
-john

Changes since _A0:
o yanked printk
o locked the io_apic_read calls to insure atomicity


diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Mon May 12 17:16:06 2003
+++ b/arch/i386/kernel/io_apic.c	Mon May 12 17:16:06 2003
@@ -219,6 +219,14 @@
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




