Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWKMVMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWKMVMp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWKMVMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:12:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19641 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932313AbWKMVMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:12:44 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ingo Molnar <mingo@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Komuro <komurojun-mbn@nifty.com>,
       tglx@linutronix.de, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc5: known regressions :SMP kernel can not generate ISA irq
References: <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org>
	<1162985578.8335.12.camel@localhost.localdomain>
	<Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061108085235.GT4729@stusta.de>
	<7813413.118221162987983254.komurojun-mbn@nifty.com>
	<11940937.327381163162570124.komurojun-mbn@nifty.com>
	<Pine.LNX.4.64.0611130742440.22714@g5.osdl.org>
	<m13b8ns24j.fsf@ebiederm.dsl.xmission.com>
	<1163450677.7473.86.camel@earth>
Date: Mon, 13 Nov 2006 14:11:42 -0700
In-Reply-To: <1163450677.7473.86.camel@earth> (Ingo Molnar's message of "Mon,
	13 Nov 2006 21:44:37 +0100")
Message-ID: <m1bqnboxv5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@redhat.com> writes:

> On Mon, 2006-11-13 at 10:11 -0700, Eric W. Biederman wrote:
>> > So when you "mask" an edge-triggered IRQ, you can't really mask it
>> at all, 
>> > because if you did that, you'd lose it forever if the IRQ comes in
>> while 
>> > you masked it. Instead, we're supposed to leave it active, and set a
>> flag, 
>> > and IF the IRQ comes in, we just remember it, and mask it at that
>> point 
>> > instead, and then on unmasking, we have to replay it by sending a 
>> > self-IPI.
>> >
>> > Maybe that part got broken by some of the IRQ changes by Eric. 
>> 
>> Hmm.  The other possibility is that this is a genirq migration issue.
>> 
>> Yep.  That looks like it.   In the genirq migration the edge and
>> level triggered cases got merged and previously disable_edge_ioapic
>> was a noop.  Ouch.
>
> hm, that should be solved by the generic edge-triggered flow handler as
> well: we never mask an IRQ first time around, we only mask it if
> we /already/ have the 'soft' IRQ_PENDING flag set. (in that case the
> lost edge is not an issue because we have the information already - and
> the masking will prevent a screaming edge source)
>
> but maybe this concept has not been pushed through to the disable/enable
> irq logic itself? (it's only present in the flow handler) Thomas, do you
> concur?

I just looked. I think the logic is actually in there as well.
I keep forgetting disable != mask.

I looks like what is really missing is that we aren't setting
IRQ_DELAYED_DISABLE.

So I think what we really need to do is just set IRQ_DELAYED_DISABLE.
Does the patch below look right?


Eric


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
