Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTEFVtr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTEFVtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:49:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:57830 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262015AbTEFVtp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:49:45 -0400
Subject: [RFC][PATCH] linux-2.5.69_clear-smi-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: James <jamesclv@us.ibm.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Grover <andrew.grover@intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052258319.4503.7.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 May 2003 14:58:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	I've been having problems with ACPI on a box here in our lab, it ends
up that when we clear_IO_APIC() at boot time, we clear the SMI pin that
is setup by the BIOS. This basically clobbers the SMI and we can then
never make the transition into ACPI mode. 

I'm not sure if this is the right solution, but I figured I'd post it
and take the flamage if I'm just being dumb. Basically in
clear_IO_APIC_pin, I read the apic entry to make sure the delivery_mode
isn't dest_SMI. If it is, we leave the apic entry alone and return.

With this patch, the box boots and SMIs appear to function properly.

Let me know if you have any thoughts or suggestions.

thanks
-john


diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Tue May  6 14:46:58 2003
+++ b/arch/i386/kernel/io_apic.c	Tue May  6 14:46:58 2003
@@ -219,6 +219,14 @@
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
+	
+	/* Check delivery_mode to be sure we're not clearing an SMI pin */
+	*(((int*)&entry) + 0) = io_apic_read(apic, 0x10 + 2 * pin);
+	*(((int*)&entry) + 1) = io_apic_read(apic, 0x11 + 2 * pin);
+	if (entry.delivery_mode == dest_SMI){
+		printk(KERN_INFO "apic %i pin %i is an SMI pin!\n", apic, pin);
+		return;
+	}
 
 	/*
 	 * Disable it in the IO-APIC irq-routing table:



