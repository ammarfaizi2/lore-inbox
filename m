Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268195AbRGWLMC>; Mon, 23 Jul 2001 07:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268196AbRGWLLw>; Mon, 23 Jul 2001 07:11:52 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:60605 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S268195AbRGWLLm>;
	Mon, 23 Jul 2001 07:11:42 -0400
Message-ID: <3B5C0696.B50DA3DB@mandrakesoft.com>
Date: Mon, 23 Jul 2001 07:12:22 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Rusty Russell <rusty@rustcorp.com.au>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 softirq incorrectness.
In-Reply-To: <Pine.LNX.4.33.0107231113150.27373-100000@chaos.tp1.ruhr-uni-bochum.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Kai Germaschewski wrote:
> 
> On Mon, 23 Jul 2001, Andrea Arcangeli wrote:
> 
> > here the one in netif_rx:
> >
> >                       __cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
> >                       local_irq_restore(flags);
> > [...]
> 
> > The first netif_rx is required to run from interrupt handler (otherwise
> > we should have executed cpu_raise_softirq and not __cpu_raise_softirq)
> > so we cannot miss the do_softirq in the return path from do_IRQ() and so
> > we cannot wait for the next incoming interrupt (if we have a overflow of
> > the do_softirq loop ksoftirqd will take care of it without waiting for
> > the next interrupt as it could instead happen in old 2.4 kernels).
> 
> Hmmh, wait a second. I take it that means calling netif_rx not from
> hard-irq context, but e.g. from bh is a bug? (Even if the only consequence
> is delaying the processing by up to one timer tick?)
> 
> If so, I believe this bug exists in a couple of a places. One example is -
> of course - the ISDN code, where netif_rx() is called from bh context. But
> I would think that e.g. ppp_generic is affected as well.

no, as long as you mark the bh (or local_enable/disable_bh) you will run
the softirqs.

-- 
Jeff Garzik      | "I wouldn't be so judgemental
Building 1024    |  if you weren't such a sick freak."
MandrakeSoft     |             -- goats.com
