Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265982AbUBCKIT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 05:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265986AbUBCKIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 05:08:18 -0500
Received: from mx1.elte.hu ([157.181.1.137]:49547 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265982AbUBCKIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 05:08:17 -0500
Date: Tue, 3 Feb 2004 10:35:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>,
       dipankar@in.ibm.com
Subject: Re: New v. v. experimental HOTPLUG CPU megapatch.
Message-ID: <20040203093502.GA4399@elte.hu>
References: <20040202154040.GA5895@elte.hu> <20040203074322.27A892C13E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203074322.27A892C13E@lists.samba.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin 2.60
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> Patch against 2.6.2-rc2-mm2.  Works basically, gives "APIC error on
> CPU1: 08(08)" under stress.  Clues welcome.

APIC error 08 is receive error. Ie. most likely there was a pending IPI
(or pending hwirq) to that CPU but the CPU was zapped and the APIC
reset. I'd suggest to add "sti;nop;cli" instructions after the IO-APIC
masks have been redirected [note the nop - the interrupt-enable boundary
on x86 is two instructions from sti] - to flush out pending hardirqs and
IPIs. After this point nothing is supposed to reach this CPU. Enabling
irqs at this point should not cause any races, because you do this
first, right?

the pending cross-CPU-IPI case should not happen if the infrastructure
is correct, external hardirqs are not an issue unless it's an
edge-triggered device. So the worst-case with your current code could be
a lost timer IRQ or a lost edge-triggered PCI irq (old ne2k cards).

	Ingo
