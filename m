Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbTHZAsz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 20:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbTHZAsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 20:48:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:29583 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262261AbTHZAsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 20:48:53 -0400
Subject: linux-2.4.22_ioapic-affinity-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1061858911.23048.202.camel@laptop.cornchips.homelinux.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Aug 2003 17:48:32 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, All,
	
	In set_ioapic_affinity() we take a cpu mask which we normally pass into
the apic. However, on xapics in clustered physical mode (ie: x440s) we
need to convert this mask into a physical apicid before sending it to
the apic. If clustered_apic_mode is XAPIC, this patch selects the lowest
cpu in the mask and routes the interrupts there. This avoids
timedoubling and other interrupt misdirection seen on x440s after
playing with /proc/irq/x/smp_affinity. 

Please apply.

thanks
-john


diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Fri Aug 22 19:05:33 2003
+++ b/arch/i386/kernel/io_apic.c	Fri Aug 22 19:05:33 2003
@@ -1365,6 +1365,13 @@
 static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
 {
 	unsigned long flags;
+
+	/* pick a single cpu for clustered xapics */
+	if(clustered_apic_mode == CLUSTERED_APIC_XAPIC){
+		int cpu = ffs(mask)-1;
+		mask = cpu_to_physical_apicid(cpu);
+	}
+
 	/*
 	 * Only the first 8 bits are valid.
 	 */



