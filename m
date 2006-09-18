Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965377AbWIREmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965377AbWIREmo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 00:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965378AbWIREmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 00:42:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:14767 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965377AbWIREmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 00:42:43 -0400
Subject: Re: [RFC] MMIO accessors & barriers documentation #2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <Pine.LNX.4.64.0609171919030.4388@g5.osdl.org>
References: <1158534913.14473.276.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0609171919030.4388@g5.osdl.org>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 14:42:19 +1000
Message-Id: <1158554539.6002.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-17 at 19:24 -0700, Linus Torvalds wrote:

> >  1- {read,write}{b,w,l,q} : MMIO accessors. Those accessors provide
> > all MMIO ordering requirements. They are thus called "fully ordered".
> > That is #1, #2 and #4 for writes and #1 and #3 for reads. 
> 
> Well, it's already not defined to be #4 right now on SGI boxes, and we 
> have that (badly named) mmiowb() thing to enforce #4, so I think we should 
> just accept that write[bwl]() it's _that_ ordered.
>
> And on x86, we _already_ depend on "wmb()" to be a "normal write to MMIO 
> write" barrier, which is technically wrong and bad. Again, thanks to 
> mmiowb(), normal memory accesses and MMIO accesses have already been 
> defined to not be in the same "ordering domain", so "wmb()" is technically 
> wrong and may not order a regular write wrt a MMIO (because it doesn't do 
> so for the other order: MMIO->spin_unlock).
> 
> So I think we should just admit that at least MMIO _stores_ are already 
> not entirely ordered, and not try to strengthen the rules for the current 
> setup (and just try to clarify the currently accepted semantics).

I'm a little bit confused as Alan seemed to imply that memory store vs.
MMIO were fully ordered on x86 and thus no barrier was needed (which was
the start of the discussion in the first place since on PowerPC, they
were not ordered until Paul's latest patch).

I tend to agree with Alan and others though that non-ordered accessors
will be a problem with driver writers who don't understand what it's all
about. David Miller even said that assuming anything else but strongly
ordered accessor was basically shooting ourselves in the foot :)

There have been two main cases biting us so far out of my list of 4,
which is #2 and #4 in my list of ordering requirements: memory store vs.
mmio (read or store) and mmio vs. spinlock. The former was/is handled in
some drivers with wmb() (which I dislike as wmb() should really only be
defined for the coherency domain) and not in others. The later was/is
handled in some drivers with mmiowb() (which I agree is badly named).

Thus we though it might be a more reasonable path to simply define
existing accessors as strongly ordered (and make them so on archs where
they aren't yet) and add some partially relaxed ones with semantics
precise enough to make them useful for drivers in non-arch specific
ways.

Now, you seem to say (unless I misunderstood) that x86 -does- have the
problem of storing to memory followed by an MMIO write not being in
order (wich means that tg3 would have been broken on x86 as well) which
I though wasn't the case.

So what do you recommend we do now ? Go back to step #1 and simply
define readl,writel and friends as not being ordered vs. memory loads
and then define a bunch of explicit barriers, which basically boils down
to using the semantics I defined in my document for class 2, partially
relaxed accessors (__readl/__writel/...) ? Or do we consider that it's
too much of a risk vs. driver writers and do implement my proposal,
making the current accessors slower on some archs but safer, and
starting to convert some drivers hot path to use the relaxed ones ?

Ben.


