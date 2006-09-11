Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWIKKtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWIKKtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 06:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWIKKtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 06:49:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:956 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750997AbWIKKtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 06:49:50 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060909054642.GA8859@elte.hu> 
References: <20060909054642.GA8859@elte.hu>  <20060906125626.GA3718@elte.hu> <20060906094301.GA8694@elte.hu> <1157507203.2222.11.camel@localhost> <20060905132530.GD9173@stusta.de> <20060901015818.42767813.akpm@osdl.org> <6260.1157470557@warthog.cambridge.redhat.com> <8430.1157534853@warthog.cambridge.redhat.com> <13982.1157545856@warthog.cambridge.redhat.com> <17274.1157553962@warthog.cambridge.redhat.com> 
To: Ingo Molnar <mingo@elte.hu>
Cc: David Howells <dhowells@redhat.com>, john stultz <johnstul@us.ibm.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] FRV: do_gettimeofday() should no longer use tickadj 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 11 Sep 2006 11:46:44 +0100
Message-ID: <9051.1157971604@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:

> i cannot find Thomas' recent 2.6 one (Thomas, do you have a link to 
> it?), but i did one 5 years ago:
> 
>  http://people.redhat.com/mingo/irq-rewrite-patches/irq-cleanup-2.4.15-B1.bz2
> 
> in general it's a large but otherwise pretty dumb patch.

I wrote my own patch to test this last Friday.  I found that removing all the
regs pointer passing from the interrupt code reduced interrupt entry with a
warm cache by 1 cpu cycle out of 87, and interrupt exit by 19 cycles out of 99.

I can't tell from that exactly how many instructions/memory accesses have been
removed since the FRV permits two instructions to be executed in one cycle
under some circumstances, and two registers to be stored/loaded in one
instruction.

But the main gain in the exit path has to be due to recovery of the clobbered
regs parameter due to a call inside a loop, possibly in handle_IRQ_event().

I'd expect i386 to do better in cycle reduction because it has fewer registers
and so getting one back should gain more.

David
