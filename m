Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933465AbWKNRxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933465AbWKNRxO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 12:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933466AbWKNRxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 12:53:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41412 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S933465AbWKNRxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 12:53:13 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, Komuro <komurojun-mbn@nifty.com>,
       tglx@linutronix.de, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use delayed disable mode of ioapic edge triggered interrupts
References: <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org>
	<1162985578.8335.12.camel@localhost.localdomain>
	<Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061108085235.GT4729@stusta.de>
	<7813413.118221162987983254.komurojun-mbn@nifty.com>
	<11940937.327381163162570124.komurojun-mbn@nifty.com>
	<Pine.LNX.4.64.0611130742440.22714@g5.osdl.org>
	<m13b8ns24j.fsf@ebiederm.dsl.xmission.com>
	<1163450677.7473.86.camel@earth>
	<m1bqnboxv5.fsf@ebiederm.dsl.xmission.com>
	<1163492040.28401.76.camel@earth>
	<Pine.LNX.4.64.0611140757040.31445@g5.osdl.org>
Date: Tue, 14 Nov 2006 10:52:12 -0700
In-Reply-To: <Pine.LNX.4.64.0611140757040.31445@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 14 Nov 2006 08:10:48 -0800 (PST)")
Message-ID: <m18xidlxv7.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds <torvalds@osdl.org> writes:

> Of course, for edge-triggered APIC interrupts, we _have_ to replay the irq 
> (since we don't have any way of even *knowing* whether we might get it 
> again), but for level-triggered and for the old legacy i8259 controller 
> that gets it right for edges anwyay, we should _not_ send the spurious 
> interrupt that is no longer active.
>
> And a lot of code has been tested with either just the i8259 (old machines 
> without any APIC) or with PCI-only devices (which are always level- 
> triggered), so the fact that edge-triggered things have always seen the 
> potential for spurious interrupts is not a reasong to say "well, they have 
> to handle it anyway". True PCI drivers generally do _not_ have to handle 
> the crazy case, and generally have never seen it.
>
> In other words, I think we should just make APIC-edge have the "please 
> delay masking and replay" bit, and nobody else.
>
> Can you send that patch (for both x86 and x86-64), and we can ask Komuro 
> to test it. That would be the "same behaviour as we've always had" thing, 
> which I think is also the _right_ behaviour.

Hopefully this is the trivial patch that solves the problem.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index ad84bc2..3b7a63e 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -1287,9 +1287,11 @@ static void ioapic_register_intr(int irq
 			trigger == IOAPIC_LEVEL)
 		set_irq_chip_and_handler_name(irq, &ioapic_chip,
 					 handle_fasteoi_irq, "fasteoi");
-	else
+	else {
+		irq_desc[irq].status |= IRQ_DELAYED_DISABLE;
 		set_irq_chip_and_handler_name(irq, &ioapic_chip,
 					 handle_edge_irq, "edge");
+	}
 	set_intr_gate(vector, interrupt[irq]);
 }
 
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 41bfc49..14654e6 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -790,9 +790,11 @@ static void ioapic_register_intr(int irq
 			trigger == IOAPIC_LEVEL)
 		set_irq_chip_and_handler_name(irq, &ioapic_chip,
 					      handle_fasteoi_irq, "fasteoi");
-	else
+	else {
+		irq_desc[irq].status |= IRQ_DELAYED_DISABLE;
 		set_irq_chip_and_handler_name(irq, &ioapic_chip,
 					      handle_edge_irq, "edge");
+	}
 }
 
 static void __init setup_IO_APIC_irqs(void)

