Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbVKCB0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbVKCB0j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 20:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbVKCB0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 20:26:39 -0500
Received: from S01060013109fe3d4.vc.shawcable.net ([24.85.133.133]:37517 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S1751529AbVKCB0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 20:26:39 -0500
Date: Wed, 2 Nov 2005 17:32:32 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, weissman@gmail.com
Subject: [PATCH] i386 LVT entries remaining unmasked on reboot
Message-ID: <Pine.LNX.4.61.0511021210520.1526@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpt from bugzilla entry

http://bugzilla.kernel.org/show_bug.cgi?id=5518

"i386 version of Reboot-through-BIOS is unsafe: it forgets to mask
APIC LVT interrupts before jumping to a BIOS entry point. As a result,
BIOS ends up bombarded with interrupts early on boot. The BIOS does
not expect it since following a "normal" hardware cpu reset, all APIC
LVT registers have the Mask bit (16) set and can't generate interrupts.

For example, the version of Phoenix BIOS used by VMware enables interrupts
for the first time before masking/clearing APIC LVT. The APIC Timer LVT
register is still set up for a timer interrupt delivery with a high 
vector from the previous Linux incarnation (0xef in our case). The BIOS
has not fully initialized its IDT at this point and the real mode gate for
0xef remains all zeros. Vector 0xef dispatches BIOS to address 0:0, BIOS
takes a #GP and eventually hangs.

machine_shutdown() does attempt to shut down APIC before jumping to
BIOS, but it is ineffective"

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.14-rc5-mm1/arch/i386/kernel/apic.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc5-mm1/arch/i386/kernel/apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 apic.c
--- linux-2.6.14-rc5-mm1/arch/i386/kernel/apic.c	24 Oct 2005 15:38:38 -0000	1.1.1.1
+++ linux-2.6.14-rc5-mm1/arch/i386/kernel/apic.c	1 Nov 2005 08:02:21 -0000
@@ -559,14 +559,20 @@ void __devinit setup_local_APIC(void)
  * If Linux enabled the LAPIC against the BIOS default
  * disable it down before re-entering the BIOS on shutdown.
  * Otherwise the BIOS may get confused and not power-off.
+ * Additionally clear all LVT entries before disable_local_APIC
+ * for the case where Linux didn't enable the LAPIC.
  */
 void lapic_shutdown(void)
 {
-	if (!cpu_has_apic || !enabled_via_apicbase)
+	if (!cpu_has_apic)
 		return;
 
 	local_irq_disable();
-	disable_local_APIC();
+	clear_local_APIC();
+
+	if (enabled_via_apicbase)
+		disable_local_APIC();
+
 	local_irq_enable();
 }
 
