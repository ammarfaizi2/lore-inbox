Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269216AbTGUFRT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 01:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269259AbTGUFRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 01:17:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:39326 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269216AbTGUFRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 01:17:15 -0400
Message-Id: <5.2.1.1.2.20030721064532.01bfc600@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 21 Jul 2003 07:36:31 +0200
To: Davide Libenzi <davidel@xmailserver.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O6int for interactivity 
Cc: Valdis.Kletnieks@vt.edu,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0307201715130.3548@bigblue.dev.mcafeelabs.co
 m>
References: <5.2.1.1.2.20030719184847.01ad4ce8@pop.gmx.net>
 <5.2.1.1.2.20030718221052.01a88eb8@pop.gmx.net>
 <200307181739.h6IHdFq3006996@turing-police.cc.vt.edu>
 <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <200307170030.25934.kernel@kolivas.org>
 <200307170030.25934.kernel@kolivas.org>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
 <5.2.1.1.2.20030718174433.01b12878@pop.gmx.net>
 <Pine.LNX.4.55.0307180951050.5608@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.55.0307181004200.5608@bigblue.dev.mcafeelabs.com>
 <200307181739.h6IHdFq3006996@turing-police.cc.vt.edu>
 <5.2.1.1.2.20030718221052.01a88eb8@pop.gmx.net>
 <5.2.1.1.2.20030719184847.01ad4ce8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:21 PM 7/20/2003 -0700, Davide Libenzi wrote:
>On Sat, 19 Jul 2003, Mike Galbraith wrote:
>
> > >Everything that will make the scheduler to say "ok, I gave enough time to
> > >interactive tasks, now I'm really going to spin one from the masses" will
> > >work. Having a clean solution would not be an option here.
> >
> > ... just as soon as I get my decidedly unclean work-around functioning at
> > least as well as it did for plain old irman.   irman2 is _much_ more evil
> > than irman ever was (wow, good job!).  I thought it'd be a half an hour
> > tops.  This little bugger shows active starvation, expired starvation,
> > priority inflation, _and_ interactive starvation (i have to keep inventing
> > new terms to describe things i see.. jeez this is a good testcase).
>
>Yes, the problem is not only the expired tasks starvation. Anything in
>the active array that reside underneath the lower priority value of the
>range irman2 tasks oscillate inbetween, will experience a "CPU time eclipse".
>And you do not even need a smoked glass to look at it :)

Here there's no oscillation that I can see.  It climbs steadily to prio 16 
and stays there forever, with the hog running down at the bottom.  I did a 
quick requirement that a non-interactive task must run every HZ ticks at 
least, with a sliding "select non-interactive" window staying open for 
HZ/10 ticks, and retrieving an expired task if necessary instead of 
expiring interactive tasks (or forcing the array switch) thinking it'd be 
enough.

Wrong answer.  For most things, it would be good enough I think, but with 
the hog being part of irman2, I have to not only pull from the expired 
array if no non-interactive task is available, I have to always pull once 
the deadline is hit.  I'm also going to have to put another check for queue 
runtime to beat the darn thing.  I ran irman2 with a bonnie -s 300 and a 
kernel compile...  After a half an hour, the compile was making steady (but 
too slow because the irman2 periodic cpu hog was getting too much of what 
gcc was intended to get;) progress, but the poor bonnie was starving at 
prio 17.  A sleep_avg vs cpu%*100 sanity check will help that, but not cure.

All this to avoid the pain (agony actually) of an array switch.

         -Mike

(someone should wrap me upside the head with a clue-x-4. this darn thing 
shouldn't be worth more than 10 lines of ugliness.  i'm obviously past 
that... and headed toward the twilight-zone at warp 9.  wheee;) 

