Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266925AbTGGJWB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 05:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266920AbTGGJWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 05:22:01 -0400
Received: from imap.gmx.net ([213.165.64.20]:34255 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266932AbTGGJV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 05:21:57 -0400
Message-Id: <5.2.1.1.2.20030707110403.02843af0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 07 Jul 2003 11:40:49 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200307071319.57511.kernel@kolivas.org>
References: <1057516609.818.4.camel@teapot.felipe-alfaro.com>
 <200307070317.11246.kernel@kolivas.org>
 <1057516609.818.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:19 PM 7/7/2003 +1000, Con Kolivas wrote:
>On Mon, 7 Jul 2003 04:36, Felipe Alfaro Solana wrote:
> > On Sun, 2003-07-06 at 19:16, Con Kolivas wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > Attached is an incremental patch against 2.5.74-mm2 with more
> > > interactivity work. Audio should be quite resistant to skips with this,
> > > and it should not induce further unfairness.
> > >
> > > Changes:
> > > The sleep_avg buffer was not needed with the improved semantics in O2int
> > > so it has been removed entirely as it created regressions in O2int.
> > >
> > > A small change to the idle detection code to only make tasks with enough
> > > accumulated sleep_avg become idle.
> > >
> > > Minor cleanups and clarified code.
> > >
> > >
> > > Other issues:
> > > Jerky mouse with heavy page rendering in web browsers remains. This is a
> > > different issue to the audio and will need some more thought.
> > >
> > > The patch is also available for download here:
> > > http://kernel.kolivas.org/2.5
> > >
> > > Note for those who wish to get smooth X desktop feel now for their own
> > > use, the granularity patch on that website will do wonders on top of
> > > O3int, but a different approach will be needed for mainstream
> > > consumption.
> >
> > I'm seeing extreme X starvation with this patch under 2.5.74-mm2 when
> > starting a CPU hogger:
> >
> > 1. Start a KDE session.
> > 2. Launch a Konsole
> > 3. Launch Konqueror
> > 4. Launch XMMS
> > 5. Make XMMS play an MP3 file
> > 6. On the Konsole terminal, run "while true; do a=2; done"
> >
> > When the "while..." is run, X starves completely for ~5 seconds (e.g.
> > the mouse cursor doesn't respond to my input events). After those 5
> > seconds, the mouse cursor goes jerky for a while (~2 seconds) and then
> > the system gets responsive.
>
>Aha!
>
>Thanks to Felipe who picked this up I was able to find the one bug causing me
>grief. The idle detection code was allowing the sleep_avg to get to
>ridiculously high levels. This is corrected in the following replacement
>O3int patch. Note this fixes the mozilla issue too. Kick arse!!

I took this out for a spin in stock 74.  If I do while true; do sh -c 'ps l 
$$'; date; sleep 1; done, the shell is running at priority 22.  In the face 
of any load, that leads to quite long response times.  With a make -j5 
bzImage running, I frequently saw response times of over a second.  In X, 
with a make -j2 bzImage running, opening a new shell takes too long, and X 
loses interactive status considerably quicker than stock when doing window 
wiggle.  Init is at 20, and kernel threads bounce around between 15 and 20 
depending on how active they are (doesn't seem good considering they're 
using practically no cpu).

Thud is still dead, but maybe _too_ dead ;-)  I never saw it get above the 
lowest priority, which is very unfair considering the amount of sleeping it 
does.

         -Mike 

