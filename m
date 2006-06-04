Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932266AbWFDVpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWFDVpa (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 17:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWFDVpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 17:45:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:44010 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932266AbWFDVp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 17:45:29 -0400
Date: Sun, 4 Jun 2006 23:44:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@redhat.com>,
        Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c disable_irq()
Message-ID: <20060604214448.GA6602@elte.hu>
References: <1149112582.3114.91.camel@laptopd505.fenrus.org> <1149345421.13993.81.camel@localhost.localdomain> <20060603215323.GA13077@devserv.devel.redhat.com> <1149374090.14408.4.camel@localhost.localdomain> <1149413649.3109.92.camel@laptopd505.fenrus.org> <1149426961.27696.7.camel@localhost.localdomain> <1149437412.23209.3.camel@localhost.localdomain> <1149438131.29652.5.camel@localhost.localdomain> <1149456375.23209.13.camel@localhost.localdomain> <1149456532.29652.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149456532.29652.29.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5004]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 2006-06-04 at 22:26 +0100, Alan Cox wrote:
> > Ar Sul, 2006-06-04 am 12:22 -0400, ysgrifennodd Steven Rostedt:
> > > But can't this machine still cause an interrupt storm if the interrupt
> > > comes on a wrong line, and we don't call the handler for the interrupt
> > > source because we are now honoring disable_irq?
> > 
> > Yes - that is why we can't honour disable_irq in this case but have to
> > hope 8)
> > 
> 
> Hmm, maybe this can be solved with something like what the -rt patch 
> does with threading interrupts and the interrupt mask.  I'm not 
> suggesting threading interrupts.  But, if the misrouted irq comes 
> across a disabled_irq, that it sets some flag, and doesn't unmask the 
> interrupt when finished.  Have enable_irq see the flag and have it 
> unmask the interrupt if it is safe to do so.
> 
> This all may be pretty hacky, but it's trying to fix code for hardware 
> that is already hacky.  Note, that this would need to be compiled in 
> as on option to actually implement any of this crap.

no ... lets not mix threaded IRQs in here. The model of executing an 
interrupt handler has nothing to do with the irq flow itself. Whatever 
can be done with a threaded handler can be done via atomic ISRs too.

pretty much the only correct solution seems to be to go with Arjan's 
suggestion and make the 'disabled' property per-action, instead of the 
current per-desc thing. (obviously the physical act of masking an 
interrupt line is fundamentally per-desc, but the act of running an 
action "behind the back" of a masked line is still OK.) Unfortunately 
this would also mean the manual conversion of 300+ places that use 
disable_irq()/enable_irq() currently ... so it's no small work. (and the 
hardest part of the work is to find a safe method to convert them 
without introducing bugs)

	Ingo
