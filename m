Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTFYVAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 17:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbTFYVAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 17:00:15 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:63742 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265069AbTFYVAJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 17:00:09 -0400
Subject: [PATCH] linux_2.4.22-pre2_clear-smi-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1056575114.27508.13.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Jun 2003 14:05:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, all,

	This is a backported fix from 2.5. Some of our more recent hardware
requires that SMIs are routed through the IOAPIC, thus when we
clear_IO_APIC() at boot time, we clear the BIOS initialized SMI pin.
This basically clobbers the SMI so we can then never make the transition
into ACPI mode. Additionally various other SMI functions cease to work. 
This patch simply reads the apic entry in clear_IO_APIC to make sure the
delivery_mode isn't dest_SMI. If it is, we leave the apic entry alone
and return.

With this patch, the box boots and SMIs function properly.

Please consider for inclusion.

thanks
-john

diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Wed Jun 25 13:27:07 2003
+++ b/arch/i386/kernel/io_apic.c	Wed Jun 25 13:27:07 2003
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



