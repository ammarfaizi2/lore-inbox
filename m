Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965194AbWILAAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbWILAAF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 20:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWILAAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 20:00:02 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:61887 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S965194AbWILAAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 20:00:00 -0400
Date: Tue, 12 Sep 2006 00:59:20 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>,
       Eric Sandall <eric@sandall.us>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Suspend to ram with 2.6 kernels
Message-ID: <20060911235920.GA24597@srcf.ucam.org>
References: <44FF8586.8090800@sandall.us> <20060907193333.GI8793@ucw.cz> <450536D0.4020705@domdv.de> <200609112227.15572.rjw@sisk.pl> <4505E304.7000302@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4505E304.7000302@domdv.de>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 12:28:20AM +0200, Andreas Steinmetz wrote:

> Nope,
> but the hint from this thread was good: s2ram works with
> "acpi_skip_timer_override" and probably "enable_timer_pin_1" (I have to
> try without this one, yet). Radeon, however, remains as a problem.

Can you test with the following patch (without 
acpi_skip_timer_override)?

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
