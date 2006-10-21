Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993158AbWJUQyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993158AbWJUQyG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993150AbWJUQvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:51:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:4280 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S2993149AbWJUQvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:51:40 -0400
From: Andi Kleen <ak@suse.de>
References: <20061021 651.356252000@suse.de>
In-Reply-To: <20061021 651.356252000@suse.de>
To: patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [19/19] x86_64: Revert timer routing behaviour back to 2.6.16 state
Message-Id: <20061021165139.C60A713CB4@wotan.suse.de>
Date: Sat, 21 Oct 2006 18:51:39 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


By default route the 8254 over the 8259 and only disable
it on ATI boards where this causes double timer interrupts.

This should unbreak some Nvidia boards where the timer doesn't
seem to tick of it isn't enabled in the 8259. At least one
VIA board also seemed to have a little trouble with the disabled
8259.

For 2.6.20 we'll try both dynamically without black listing, but I think 
for .19 this is the safer approach because it has been already well tested 
in earlier kernels. This also makes the x86-64 behaviour the same
as i386.

Command line options can change all this of course.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/early-quirks.c |    9 +++++----
 arch/x86_64/kernel/io_apic.c      |    2 +-
 include/asm-x86_64/proto.h        |    2 ++
 3 files changed, 8 insertions(+), 5 deletions(-)

Index: linux/arch/x86_64/kernel/early-quirks.c
===================================================================
--- linux.orig/arch/x86_64/kernel/early-quirks.c
+++ linux/arch/x86_64/kernel/early-quirks.c
@@ -61,10 +61,11 @@ static void nvidia_bugs(void)
 
 static void ati_bugs(void)
 {
-#if 1 /* for testing */
-	printk("ATI board detected\n");
-#endif
-	/* No bugs right now */
+	if (timer_over_8254 == 1) {
+		timer_over_8254 = 0;
+		printk(KERN_INFO
+	 	"ATI board detected. Disabling timer routing over 8254.\n");
+	}
 }
 
 struct chipset {
Index: linux/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/io_apic.c
+++ linux/arch/x86_64/kernel/io_apic.c
@@ -57,7 +57,7 @@ static int no_timer_check;
 
 static int disable_timer_pin_1 __initdata;
 
-int timer_over_8254 __initdata = 0;
+int timer_over_8254 __initdata = 1;
 
 /* Where if anywhere is the i8259 connect in external int mode */
 static struct { int pin, apic; } ioapic_i8259 = { -1, -1 };
Index: linux/include/asm-x86_64/proto.h
===================================================================
--- linux.orig/include/asm-x86_64/proto.h
+++ linux/include/asm-x86_64/proto.h
@@ -122,6 +122,8 @@ extern int fix_aperture;
 extern int reboot_force;
 extern int notsc_setup(char *);
 
+extern int timer_over_8254;
+
 extern int gsi_irq_sharing(int gsi);
 
 extern void smp_local_timer_interrupt(void);
