Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317505AbSGXSsQ>; Wed, 24 Jul 2002 14:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317506AbSGXSsQ>; Wed, 24 Jul 2002 14:48:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28923 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317505AbSGXSsM>;
	Wed, 24 Jul 2002 14:48:12 -0400
Message-ID: <3D3EF711.19FAB352@mvista.com>
Date: Wed, 24 Jul 2002 11:50:57 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Per Gregers Bilse <bilse@qbfox.com>
CC: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 clock warps 4294 seconds
References: <200207241746.SAA02162@spirit.qbfox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Gregers Bilse wrote:
> 
> Hi,
> 
> On Jul 24,  9:37am, "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> > Do you have a time-daemon running that synchronizes your machine to
> > some other?
> 
> NTP is running on both machines.

I doubt that NTP has anything to do with this.  It looks
like the TSC difference used to fill in the sub 1/HZ time
info is overflowing.  This would give a negative difference
(well it would if not unsigned) which would work out to the
4294 sec warp.  But on a 800 MHz box this means that it has
missed 2.68 (or so) seconds worth of ticks.  At the warp
back, it would NOT make them up, however the ntp code should
notice and start a correction sequence.  To confirm this you
might look at the ntp logs, AND/OR you could modify the test
code to query the other machine and report the time
difference.  Something this big should show up, even if the
network is slow.  Let us know if you try either of these.

Interestingly if this is the case, fixing the TSC difference
code to use 64 bits is not the whole solution, as we also
would need to account for the missed ticks.

And, no, this would not show up in the file times as they
use xtime without the sub 1/HZ correction.

-g
> 
> > Run this program as:
> > ./xxx &>xxx.log &
> >
> > ...and see if your machine is really jumping.
> 
> I have effectively the same in the code already running.  Once the
> problem on the server started (yesterday), I added some sanity
> (abbreviated for clarity):
> 
>     waitinterP = rt_needbgwalk() ? &zerosec : &onesec;
>     ...
>     sval = pselect(sockhi,&readset,&writeset,&exceptset,waitinterP,0);
>     ...
> #ifdef SHAKY_CLOCK
>     newnow = time((time_t*)0);
>     if ( newnow > now + 100 ) {  /* Some H/W bug on some mboards? */
>       if ( warpcount % 1000 == 0 )
>         error("timewarp fwd %d: now %d new %d",warpcount,now,newnow);
>       warpcount++;
>       now += sval == 0 ? waitinterP->tv_sec : 0;
>     }
>     else {
>       ....
>       now = newnow;
>     }
> #else
>     now = time((time_t*)0);
> #endif
> 
> Here's one snippet of output:
> 
> timewarp fwd 0: now 1027434974 new 1027439268
> timewarp fwd 1000: now 1027434977 new 1027439271
> timewarp fwd 2000: now 1027434978 new 1027439272
> 
> I know it's a tall order, but believe me, it really is happening.
> I've always had it on my workstation, ever since I started using it,
> first with a 2.4.7-10 kernel.  It's happened many many times that I
> would slide the mouse down to the bottom of the screen and the autohiding
> taskbar would appear, clock to the right, and the next second the clock
> would jump forward an hour and some minutes.  I thought it was an obscure
> bug in X or Gnome until it happened on the server.
> 
> As mentioned, the workaround suggested by the posting from 1999 seems
> to be doing the trick (and the sanity code I added to my stuff handles
> the problem by guessing), so it isn't a big issue for me, but I would
> imagine other people with the same hardware are being bitten by it.
> 
> Thanks for your note.
> 
>   -- Per G. Bilse
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
