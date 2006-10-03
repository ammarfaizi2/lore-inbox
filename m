Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWJCKnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWJCKnz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 06:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWJCKnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 06:43:55 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:60304 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030286AbWJCKny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 06:43:54 -0400
Date: Tue, 3 Oct 2006 12:35:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch] clockevents: drivers for i386, fix #2
Message-ID: <20061003103503.GA6350@elte.hu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de> <20061002210053.16e5d23c.akpm@osdl.org> <20061003084729.GA24961@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003084729.GA24961@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> yeah, i suspect it works again if you disable:
> 
>  CONFIG_X86_UP_APIC=y
>  CONFIG_X86_UP_IOAPIC=y
>  CONFIG_X86_LOCAL_APIC=y
>  CONFIG_X86_IO_APIC=y
> 
> as the slowdown has the feeling of a runaway lapic timer irq.
> 
> from code review so far we can only see an udelay(10) difference in 
> the initialization sequence of the PIT - we'll send a fix for that but 
> i dont think that's the cause of the bug.

the patch below fixes that particular bug. But ... the symptoms you are 
describing have the feeling of being apic related.

	Ingo

-------------------->
Subject: clockevents: drivers for i386, fix #2
From: Ingo Molnar <mingo@elte.hu>

add back a mistakenly removed udelay(10) to the PIT initialization
sequence.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/kernel/i8253.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux/arch/i386/kernel/i8253.c
===================================================================
--- linux.orig/arch/i386/kernel/i8253.c
+++ linux/arch/i386/kernel/i8253.c
@@ -45,6 +45,7 @@ static void init_pit_timer(enum clock_ev
 		outb_p(0x34, PIT_MODE);
 		udelay(10);
 		outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
+		udelay(10);
 		outb(LATCH >> 8 , PIT_CH0);	/* MSB */
 		break;
 
