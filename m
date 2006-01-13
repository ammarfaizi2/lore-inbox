Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422655AbWAMNCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbWAMNCG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 08:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbWAMNCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 08:02:06 -0500
Received: from mail.gmx.net ([213.165.64.21]:51072 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422653AbWAMNCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 08:02:04 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20060113124751.00bf2660@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 13 Jan 2006 14:01:52 +0100
To: Con Kolivas <kernel@kolivas.org>, Paolo Ornati <ornati@fastwebnet.it>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <200601132151.55742.kernel@kolivas.org>
References: <20060113114607.54c83fc8@localhost>
 <20051227190918.65c2abac@localhost>
 <200601131213.14832.kernel@kolivas.org>
 <20060113114607.54c83fc8@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0601-0, 01/02/2006), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:51 PM 1/13/2006 +1100, Con Kolivas wrote:
>On Friday 13 January 2006 21:46, Paolo Ornati wrote:
> > On Fri, 13 Jan 2006 12:13:11 +1100
> >
> > Con Kolivas <kernel@kolivas.org> wrote:
> > > Can you try the following patch on 2.6.15 please? I'm interested in how
> > > adversely this affects interactive performance as well as whether it
> > > helps your test case.
> >
> > "./a.out 5000 & ./a.out 5237 & ./a.out 5331 &"
> > "mount space/; sync; sleep 1; time dd if=space/bigfile of=/dev/null
> > bs=1M count=256; umount space/"
> >
> >   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> >  5445 paolo     16   0  2396  288  228 R 34.8  0.1   0:05.84 a.out
> >  5446 paolo     15   0  2396  288  228 S 32.8  0.1   0:05.53 a.out
> >  5444 paolo     16   0  2392  288  228 R 31.3  0.1   0:05.99 a.out
> >  5443 paolo     16   0 10416 1104  848 R  0.2  0.2   0:00.01 top
> >  5451 paolo     15   0  4948 1468  372 D  0.2  0.3   0:00.01 dd
> >
> > DD test takes ~20 s (instead of 8s).
> >
> > As you can see DD priority is now very good (15) but it still suffers
> > because also my test programs get good priority (15/16).
> >
> >
> > Things are BETTER on the real test case (transcode): this is because
> > transcode usually gets priority 16 and "dd" gets 15... so dd is quite
> > happy.
>
>This seems a reasonable compromise. In your "test app" case you are using
>quirky code to reproduce the worst case scenario. Given that with your quirky
>setup you are using 3 cpu hogs (effectively) then slowing down dd from 8s to
>20s seems an appropriate slowdown (as opposed to the many minutes you were
>getting previously).

I'm sorry, but I heartily disagree.  It's not a quirky setup, it's just 
code that exposes a weakness just like thud, starve, irman, 
irman2.  Selectively bumping dd up into the upper tier won't do the other 
things trivially starved to death one bit of good.  On a more positive 
note, I agree that dd should not be punished for waiting on disk.

>See my followup patches that I have posted following "[PATCH 0/5] sched -
>interactivity updates". The first 3 patches are what you tested. These
>patches are being put up for testing hopefully in -mm.

Then the (buggy) version of my simple throttling patch will need to come 
out.  (which is OK, I have a debugged potent++ version)

> > BUT what is STRANGE is this: usually transcode is stuck to priority 16
> > using about 88% of the CPU, but sometimes (don't know how to reproduce
> > it) its priority grows up to 25 and then stay to 25.
> >
> > When transcode priority is 25 the DD test is obviously happy: in
> > particular 2 things can happen (this is expected because I've observed
> > this thing before):
> >
> > 1) priority of transcode stay to 25 (when the file transcode is
> > reading from, through pipes, IS cached).
> >
> > 2) CPU usage and priority of transcode go down (the file transcode is
> > reading from ISN'T cached and DD massive disk usage interferes with
> > this reading). When DD finish trancode priority go back to 25.
>
>I suspect this is entirely dependent on the balance between time spent 
>reading
>on disk, waiting on pipe and so on.

Grumble.  Pipe sleep.  That's another pet peeve of mine.  Sleep is sleep 
whether it's spelled interruptible_pipe or uninterruptible_semaphore.

         -Mike 

