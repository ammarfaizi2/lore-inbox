Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130699AbRCEVsc>; Mon, 5 Mar 2001 16:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130692AbRCEVsV>; Mon, 5 Mar 2001 16:48:21 -0500
Received: from smtp-rt-12.wanadoo.fr ([193.252.19.60]:34781 "EHLO
	tamaris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130693AbRCEVsF>; Mon, 5 Mar 2001 16:48:05 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cort Dougan <cort@fsmlabs.com>
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Question about IRQ_PENDING/IRQ_REPLAY
Date: Mon, 5 Mar 2001 22:47:32 +0100
Message-Id: <19350128151916.22355@smtp.wanadoo.fr>
In-Reply-To: <20010305140050.G14772@ftsoj.fsmlabs.com>
In-Reply-To: <20010305140050.G14772@ftsoj.fsmlabs.com>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>We have about 12 interrupt controllers we end up using on PPC.  I'm
>suspicious of any effort to base Linux/PPC generic interrupt control code
>paths on a software architecture that's been tested with 3.  More to the
>point, we get ASIC's that roll in a standard interrupt controller and add
>some "improvements" at the same time.

Well, I personally don't see what would be a problem... Of course, the 
current i386 irq.c cannot be re-used completel "as is". The bit of code
that gets the actual irq number has to be arch specific. But most of the
locking issues are completely platform neutral.

I personally see that code as a good framework that provides many features
that may or may not be neccessary depending on the level of brokenness of
a given interrupt controller.

>As for SMP, I'm sure x86 has seen a lot more testing.  I'm not going to
>sacrifice time-tested stability so we can look just like x86 and get clean
>SMP locking.  We've lost stability already because of some PPC folks'
>excitement at getting us to behave like x86 in irq.c.

We lost stability ? Hrm... If we had ever a problem with SMP, it was in the
openpic code, and apparently, due to a HW bug. I don't think the new irq.c
code in itself caused us to lose stability. I actually do think it improved
the locking, and so, stability.

>As for a generic irq.c, as a guiding light, I'm all for it.  It'll
>certainly help work with RTLinux.  It'll also help new architectures by
>giving them a snap-together port construction kit.  I'm still not going to
>sacrifice stability in the short-term for this nice feature in the
>long-run.  I'm pretty sure we agree on this.

Well, we have been running this new irq.c which I partially based on
i386 for some monthes now, and had enough time to iron out most problems.
Again, all the stability problems we had so far were related to the openpic
implementation, I don't remember seeing one stability problem reported so
far that was related to irq.c. And I've been running a couple of dual
G4s without much trouble for some time now. 
We do (did ?) have a problem with irq distribution on SMP with openpic. I'm
not sure we yet know exactly why, according to both you and IBM people, we
are running over an HW bug of the openpic core. I see nothing in irq.c
that can cause this.

On the other hand, the new irq.c brings the irq depth handling, the ability
to call enable/disable from within the handler (I've been wanting that for
some time for the PMU driver), proper spinlock'ing, etc...
And last, but not least, consistent semantics of enable/disable irq
exposed to drivers (especially things like disable_irq() actually waiting
for that irq to be completed on any other CPU).

