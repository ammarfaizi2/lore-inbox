Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274721AbRIUAjc>; Thu, 20 Sep 2001 20:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274723AbRIUAjW>; Thu, 20 Sep 2001 20:39:22 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34800 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S274721AbRIUAjJ>; Thu, 20 Sep 2001 20:39:09 -0400
Message-ID: <3BAA8BDA.5EED2879@mvista.com>
Date: Thu, 20 Sep 2001 17:37:46 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Robert Love <rml@tech9.net>,
        "Dieter =?iso-8859-1?Q?N=FCtzel?=" <Dieter.Nuetzel@hamburg.de>,
        Andrew Morton <akpm@zip.com.au>, Chris Mason <mason@suse.com>,
        Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
In-Reply-To: <20010920170812.CCCACE641B@ns1.suse.com> <3BAA29C2.A9718F49@zip.com.au> <1001019170.6090.134.camel@phantasy> <200109202112.f8KLCXG16849@zero.tech9.net> <1001024694.6048.246.camel@phantasy> <20010921003742.I729@athlon.random> <1001026597.6048.278.camel@phantasy> <20010921011514.M729@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Thu, Sep 20, 2001 at 06:56:04PM -0400, Robert Love wrote:
> > On Thu, 2001-09-20 at 18:37, Andrea Arcangeli wrote:
> > > On Thu, Sep 20, 2001 at 06:24:48PM -0400, Robert Love wrote:
> > > >
> > > > if (current->need_resched && current->lock_depth == 0) {
> > > >   unlock_kernel();
> > > >   lock_kernel();
> > > > }
> >
> > > nitpicking: the above is fine but it isn't complete, it may work for
> > > most cases but for a generic function it would be better implemented
> > > similarly to release_kernel_lock_save/restore so you take care of
> > > lock_depth > 0 too:
> >
> > Let me explain a little about the patch, and then I am interested in if
> > your opinion changes.
> >
> > When unlock_kernel() is called, the preemption code will be enabled and
> > check if the preemption count is non-zero -- its handled just like a
> 
> All I'm saying is that you should check for >= 0, not == 0.
> 
> But anwyays it's pretty depressing to see such a costly check needed to
> get latency right with the preemptive kernel approch, with
> non-preemptive kernel we'd need to just check need_resched and a call
> schedule in the unlikely case so it would be even lighter :) and no
> fixed costs in UP spinlocks, per-cpu datastrctures etc... The point of
> preemptive kernel would be just to prevent us to put such kind of
> explicit (costly) checks in the code. My theory was that the cpu-costly
> loops are mostly protected by some lock anyways and the fact you're
> writing such horrid (but helpful) code is a kind of proof.
> 
Actually, I rather think that the problem is lock granularity.  These
issues are present in the SMP systems as well.  A good solution would be
one that shortened the spinlock time.  No horrid preempt code, just
tight fast code.

And the ones to address these issues are the owners of the code.  Those
who want the lower latency are left, thur lack of knowledge and time,
with crude tools like the conditional_schedule().

George
