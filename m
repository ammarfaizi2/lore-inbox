Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274697AbRITXPf>; Thu, 20 Sep 2001 19:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274698AbRITXPZ>; Thu, 20 Sep 2001 19:15:25 -0400
Received: from [195.223.140.107] ([195.223.140.107]:22518 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274697AbRITXPL>;
	Thu, 20 Sep 2001 19:15:11 -0400
Date: Fri, 21 Sep 2001 01:15:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Andrew Morton <akpm@zip.com.au>, Chris Mason <mason@suse.com>,
        Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
Message-ID: <20010921011514.M729@athlon.random>
In-Reply-To: <20010920170812.CCCACE641B@ns1.suse.com> <3BAA29C2.A9718F49@zip.com.au> <1001019170.6090.134.camel@phantasy> <200109202112.f8KLCXG16849@zero.tech9.net> <1001024694.6048.246.camel@phantasy> <20010921003742.I729@athlon.random> <1001026597.6048.278.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1001026597.6048.278.camel@phantasy>; from rml@tech9.net on Thu, Sep 20, 2001 at 06:56:04PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 06:56:04PM -0400, Robert Love wrote:
> On Thu, 2001-09-20 at 18:37, Andrea Arcangeli wrote:
> > On Thu, Sep 20, 2001 at 06:24:48PM -0400, Robert Love wrote:
> > >
> > > if (current->need_resched && current->lock_depth == 0) {
> > > 	unlock_kernel();
> > > 	lock_kernel();
> > > }
> 
> > nitpicking: the above is fine but it isn't complete, it may work for
> > most cases but for a generic function it would be better implemented
> > similarly to release_kernel_lock_save/restore so you take care of
> > lock_depth > 0 too:
> 
> Let me explain a little about the patch, and then I am interested in if
> your opinion changes.
> 
> When unlock_kernel() is called, the preemption code will be enabled and
> check if the preemption count is non-zero -- its handled just like a

All I'm saying is that you should check for >= 0, not == 0.

But anwyays it's pretty depressing to see such a costly check needed to
get latency right with the preemptive kernel approch, with
non-preemptive kernel we'd need to just check need_resched and a call
schedule in the unlikely case so it would be even lighter :) and no
fixed costs in UP spinlocks, per-cpu datastrctures etc... The point of
preemptive kernel would be just to prevent us to put such kind of
explicit (costly) checks in the code. My theory was that the cpu-costly
loops are mostly protected by some lock anyways and the fact you're
writing such horrid (but helpful) code is a kind of proof.

Andrea
