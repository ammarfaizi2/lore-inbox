Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265580AbTHWS3t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 14:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263599AbTHWS3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 14:29:48 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33408
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265580AbTHWS0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 14:26:53 -0400
Date: Fri, 22 Aug 2003 18:25:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Cc: TeJun Huh <tejun@aratech.co.kr>
Subject: Re: Possible race condition in i386 global_irq_lock handling.
Message-ID: <20030822162546.GQ29612@dualathlon.random>
References: <3F44FAF3.8020707@colorfullife.com> <20030821172721.GI29612@dualathlon.random> <20030821234824.37497c08.skraw@ithnet.com> <20030822011840.GA14540@atj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822011840.GA14540@atj.dyndns.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks TeJun,

just one comment

On Fri, Aug 22, 2003 at 10:18:40AM +0900, TeJun Huh wrote:
>  3. remove irqs_running() test from synchronize_irq()

I'm not convinced this one is needed. An irq can still run on another
cpu but the cli();sti() may execute while it's here:

	irq running		synchronize_irq()
	--------------		-----------------
	do_IRQ
	handle_IRQ_event
				cli()
				sti()

	irq_enter -> way too late

in short, doing irqs_running() doesn't seem to weaken the semantics of
synchronize_irq() to me.

I think it should be changed this way instead:

void synchronize_irq(void)
{
	smp_mb();
	if (irqs_running()) {
		/* Stupid approach */
		cli();
		sti();
	}
}

to be sure to read the local irq area after the previous code (the
test_and_set_bit of the global_irq_lock of a cli() in your version would
achieve the same implicit smp_mb too, so maybe your only point for doing
cli()/sti() was to execute the smp_mb before the irqs_running?).  the
above version is more finegrined and it looks equivalent to yours.

Andrea
