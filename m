Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWIKXH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWIKXH7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWIKXH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:07:59 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:45008 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S964826AbWIKXH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:07:58 -0400
Date: Tue, 12 Sep 2006 00:07:45 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Andi Kleen <ak@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: [PATCH] - restore i8259A eoi status on resume
Message-ID: <20060911230745.GA24001@srcf.ucam.org>
References: <20060910141533.GA6594@srcf.ucam.org> <200609110746.58548.ak@suse.de> <20060911110530.GA15320@srcf.ucam.org> <200609112202.50756.ak@suse.de> <20060911222351.GA23679@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060911222351.GA23679@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got it. i8259A_resume calls init_8259A(0) unconditionally, even if 
auto_eoi has been set. Keep track of the current status and restore that 
on resume. This fixes it for AMD64 and i386.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/arch/i386/kernel/i8259.c b/arch/i386/kernel/i8259.c
index 323ef8a..41485c7 100644
--- a/arch/i386/kernel/i8259.c
+++ b/arch/i386/kernel/i8259.c
@@ -46,6 +46,8 @@ static void end_8259A_irq (unsigned int 
 
 #define shutdown_8259A_irq	disable_8259A_irq
 
+static int i8259A_auto_eoi;
+
 static void mask_and_ack_8259A(unsigned int);
 
 unsigned int startup_8259A_irq(unsigned int irq)
@@ -254,7 +256,7 @@ static void save_ELCR(char *trigger)
 
 static int i8259A_resume(struct sys_device *dev)
 {
-	init_8259A(0);
+	init_8259A(i8259A_auto_eoi);
 	restore_ELCR(irq_trigger);
 	return 0;
 }
@@ -302,6 +304,8 @@ void init_8259A(int auto_eoi)
 {
 	unsigned long flags;
 
+	i8259A_auto_eoi = auto_eoi;
+	
 	spin_lock_irqsave(&i8259A_lock, flags);
 
 	outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
diff --git a/arch/x86_64/kernel/i8259.c b/arch/x86_64/kernel/i8259.c
index 5ecd34a..75f77da 100644
--- a/arch/x86_64/kernel/i8259.c
+++ b/arch/x86_64/kernel/i8259.c
@@ -129,6 +129,8 @@ #undef IRQLIST_14
 
 DEFINE_SPINLOCK(i8259A_lock);
 
+static int i8259A_auto_eoi;
+
 static void end_8259A_irq (unsigned int irq)
 {
 	if (irq > 256) { 
@@ -342,6 +344,8 @@ void init_8259A(int auto_eoi)
 {
 	unsigned long flags;
 
+	i8259A_auto_eoi = auto_eoi;
+
 	spin_lock_irqsave(&i8259A_lock, flags);
 
 	outb(0xff, 0x21);	/* mask all of 8259A-1 */
@@ -400,7 +404,7 @@ static void save_ELCR(char *trigger)
 
 static int i8259A_resume(struct sys_device *dev)
 {
-	init_8259A(0);
+	init_8259A(i8259A_auto_eoi);
 	restore_ELCR(irq_trigger);
 	return 0;
 }


-- 
Matthew Garrett | mjg59@srcf.ucam.org
