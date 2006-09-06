Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWIFNEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWIFNEm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWIFNEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:04:42 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:23945 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750817AbWIFNEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:04:40 -0400
Date: Wed, 6 Sep 2006 14:56:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Howells <dhowells@redhat.com>
Cc: john stultz <johnstul@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] FRV: do_gettimeofday() should no longer use tickadj
Message-ID: <20060906125626.GA3718@elte.hu>
References: <20060906094301.GA8694@elte.hu> <1157507203.2222.11.camel@localhost> <20060905132530.GD9173@stusta.de> <20060901015818.42767813.akpm@osdl.org> <6260.1157470557@warthog.cambridge.redhat.com> <8430.1157534853@warthog.cambridge.redhat.com> <13982.1157545856@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13982.1157545856@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Howells <dhowells@redhat.com> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > btw., would be nice to convert it to genirq (and irqchips) too =B-) That 
> > would solve the kind of disable_irq_lockdep() breakage that was reported 
> > recently.
> 
> I can think of reasons for not using that stuff also.
> 
>  (1) Passing "struct pt_regs *regs" around is a complete waste of 
>      resources on FRV.  It's in GR28 at all times and can thus be 
>      accessed directly.

we'll get rid of that pt_regs thing centrally, from all drivers at once 
- there's upstream buy-in for that already, and Thomas already generated 
a test-patch for that a few months ago. But it's not a big issue right 
now.

>  (2) All the little operations functions cause unnecessary jumping, 
>      jumps that icache lookahead can't predict because they're 
>      register-indirect.

this shouldnt be a big issue either - we use indirect jumps all around 
the kernel. CPUs are either smart enough to predict it, or they simply 
dont have that high penalties. (and if they have high penalties but dont 
optimize for it then genirq will be the last of their worries. The VFS 
and the MM is full of function pointers.)

>  (3) ACK'ing and controlling interrupts has to be done by groups.

please be more specific, how is this not possible via genirq?

>  (4) No account is taken of interrupt priority.

hm, i'm not sure what you mean - could you be more specific?

>  (5) The FRV CPU doesn't tell me which IRQ source fired.  Much of the 
>      code I've got is stuff to try and work it out.  I could just 
>      blindly poll all the sources attached to a particular interrupt 
>      level, but that seemssomehow less efficient.

but ... somehow the current FRV code does figure out which IRQ source 
fired, right? How is that a hindrance for a genirq/irqchips based 
design?

> BTW, have you looked at my patch to fix lockdep yet?

oops, i missed it - just acked it. (This problem too was a side-effect 
of FRV having its own IRQ layer.)

	Ingo
