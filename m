Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTGGV4t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 17:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbTGGV4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 17:56:49 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:47266 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264536AbTGGV4q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 17:56:46 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 7 Jul 2003 15:03:42 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Daniel Phillips <phillips@arcor.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <200307072107.09855.phillips@arcor.de>
Message-ID: <Pine.LNX.4.55.0307071202450.4704@bigblue.dev.mcafeelabs.com>
References: <20030703023714.55d13934.akpm@osdl.org> <200307071955.58774.phillips@arcor.de>
 <Pine.LNX.4.55.0307071105110.4704@bigblue.dev.mcafeelabs.com>
 <200307072107.09855.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ trimmed cc ]

On Mon, 7 Jul 2003, Daniel Phillips wrote:

> > I'm just trying to figure out why :
> >
> > 1) RealPlayer does not skip on my 2.4.20
>                                     ^^^^^^
> We're talking about 2.5.

This is exactly my point. It seems that all I'm earing here is that the OS
cannot do the right thing alone. I'm asking you why other apps/OS/kernels
can make it work just fine ? And I am not running RealPlay as superuser.



> Partly.  We've been through that in pretty good detail.  There are
> combinations of hardware and kernel versions that happen to be pretty good at
> running sound, that doesn't mean the problem is dealt with so that corner
> cases don't come up.  A 99% solution is not good enough, that still will
> leave 10,000's of Linux users with poor sound performance.
>
> Zinf does things correctly: it has a big buffer and it tries to set an
> elevated priority for its sound servicing thread.  With 2.5, that isn't
> enough, and Con's tweaking isn't enough.  And that's not wrong, because the
> kernel *should not* try to identify realtime threads automagically.

If a big buffer is for example 32kb, this will give you about 350ms of
sustainable CPU blackout. That is pretty much difficult to hit. Having a
blackout of more than 300-400ms means that either the load is not
realistic or that the timeslice policy has to be tuned. Has anyone tried
to lower the maximum timeslice and to assign it in an exponential fashion ?
Example, maximum timeslice = 100-120ms with :

  ts
    ^
120 |                            .
    |                           .
    |                          .
    |                         .
    |                        .
    |                      .
    |                    .
    |                .
    |           .
 10 | .  .
    |
    ------------------------------------->
      |min                    max|        prio

In a scheduling model that is timeslice driven, two factors influence the
maximum CPU blackout time. One is the number of TASK_RUNNING tasks and the
other one is the timeslice avg length. Interactivity is ruled by the
ratio between the lo-priority timeslice and the hi-priority one. If we
lower the maximum timeslice and we assign it in an exponential way, we can
lower the avg timeslice by keeping "almost" intact the ratio (interactivity).
In this way you basically maintain timeslice ratios (interactivity) while
lowering the cycle time it takes to the scheduler to exhaust the active
array. And this time is basically our maximum blackout time.



> Zinf could go further and try to set a posix realtime scheduling mode, but
> that attempt would be blocked by the root requirement for realtime
> scheduling, which is ihmo due to braindamage in the definition of the posix
> realtime scheduling modes.  This last we *can* fix in the kernel, by creating
> a new realtime scheduling mode that is sane enough to be used by normal
> users.  Then sound applications would need to be changed to use it, which
> really is no big deal.

Again, while I see one application that survives skips, this makes me
think that other apps do not have the correct timing code.



> > Try to play with SNDCTL_DSP_SETFRAGMENT. Last time I checked the kernel
> > let you set a dma buf for 0.5 up to 1 sec of play (upper limited by 64Kb).
> > Feeding the sound card with 4Kb writes will make you skip after about 50ms
> > CPU blackout at 44KHz 16 bit. RealPlayer uses 16Kb feeding chunks that
> > makes it able to sustain up to 200ms of blackout.
>
> That's just fiddling, it doesn't deal with the basic problem.  Anyway, big
> buffers have their own annoyances.  Have you tried the graphic equalizer in
> xmms lately?  A one second lag on slider adjustment is not nice.

That's not fiddling. It is tuning your app so that it won't require
realtime when it is not needed. This is design in my books.



- Davide

