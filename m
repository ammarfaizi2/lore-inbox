Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266601AbTGFD0P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 23:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266602AbTGFD0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 23:26:15 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:45232 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S266601AbTGFD0N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 23:26:13 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Daniel Phillips <phillips@arcor.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
Date: Sun, 6 Jul 2003 13:41:31 +1000
User-Agent: KMail/1.5.2
References: <20030703023714.55d13934.akpm@osdl.org> <200307060201.04219.kernel@kolivas.org> <200307051947.10726.phillips@arcor.de>
In-Reply-To: <200307051947.10726.phillips@arcor.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307061341.31243.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jul 2003 03:47, Daniel Phillips wrote:
> On Saturday 05 July 2003 18:01, Con Kolivas wrote:
> > Have you taken the next twist in the road? I posted a second patch which
> > should go on top of what's in 2.5.74-mm1 a couple of days ago. Just in
> > case, here is a link to it.
> >
> > http://kernel.kolivas.org/2.5/
> >
> > it's called patch-O2int-0307041440
>
> This one is a regression.  Window dragging now causes the same kind of
> dropouts as I saw on 2.5.73 mainline.  But see below.

X is still getting sustained priority in this one; This version addressed 
other more important issues. The next version may help when I've made it. 

>
> > It makes significant headway in smoothing the corner cases. I need
> > testing at each point before I can post another update, and am doing much
> > less frequent smaller updates now, with the aim of having no more than
> > one patch for each -mm, so I can have a decent sized audience for each
> > change.
> >
> > Andrew can you please apply this one on top in the next -mm if you are to
> > continue testing this patch series.
>
> Well...
>
> It should help you to know that up till now I've been running Zinf at
> priority 0 (of -20..19).  I just changed change that to -10, and all the
> dropouts went away.  Duh.  The thing is, Zinf is a (soft) realtime
> application, or at least the sound servicing part of it is.  It's hard to
> see how the kernel can ever figure that out automagically - it has to be
> told.  So I told it.
>
> My only reservation is that nice is not a very (ahem) nice way of doing
> this. We really want Zinf to take care of that itself.  Zinf knows it has a
> realtime component and it knows which component that is, so it needs to
> tell the kernel, presumeably via setpriority (nice is just a frontend to
> setpriority).  Blindly choosing some higher priority to run at is certainly
> crude, but for now it solves the problem, so I won't have to apologize to
> my wife about destroying her audio experience with the latest, greatest
> kernel.
>
> Not having to worry about detecting and babying along the realtime sound
> thread should make your job considerably easier.  OK, looking at the Zinf
> code I see that it does know about thread priority, via pthreads.  It's
> either not working, or it's not set to sensible defaults.  I'm looking into
> that.

Well if it gets real time scheduling all that goes away.. But of course that 
would mean it needs root or equivalent user access. Even the lowest priority 
real time apps get scheduled ahead of any nice priority boosted or 
interactive boosted normal scheduling apps. However I'm going to give X less 
buffer in the next version so it should get better without RT scheduling. 

WRT the other lkml threads, audio should work without skips on normal desktop 
loads without priority changes, without root privileges and without RT 
scheduling. Therefore I am still considering it a regression.

>
> Now, just so this doesn't get too easy for you, I have a nice little opengl
> application here:
>
>   http://nl.linux.org/~phillips/world.tgz
>   (3D engine - see screenshots on the same page)
>
> The "bounce" demo is suitable for testing how steady the framerate is. 
> It's working pretty well since 2.4.73, if you leave the window in one
> place, but scheduling gets challenging (i.e., sucks) when you drag the 3D
> window around. How should we fix that?  It's my code so I'm willing to add
> whatever priority control is appropriate.

I assume you're not asking for the scheduler to be tweaked for this. You want 
the 3d rendering to occur regardless of what is happening anywhere else? If 
it doesn't use much cpu time but wakes lots then in it's current form the 
scheduler will happily put this equal sharing with everything at nice 0. X 
intermittently gets cpu hungry so will make this slow down at the moment 
during those bursts. Your app will go ahead of everything else at a priority 
of -3. 

If it is cpu hungry, it will need at least -8 to get in on the act, and -13 to 
be ahead of everyone (not really recommended though).

Con

