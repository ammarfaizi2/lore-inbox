Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317436AbSGXRng>; Wed, 24 Jul 2002 13:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317446AbSGXRng>; Wed, 24 Jul 2002 13:43:36 -0400
Received: from spirit.qbfox.com ([212.67.200.51]:56592 "EHLO spirit.qbfox.com")
	by vger.kernel.org with ESMTP id <S317436AbSGXRnf>;
	Wed, 24 Jul 2002 13:43:35 -0400
Message-Id: <200207241746.SAA02162@spirit.qbfox.com>
From: Per Gregers Bilse <bilse@qbfox.com>
Date: Wed, 24 Jul 2002 18:46:44 +0100
In-Reply-To: <Pine.LNX.3.95.1020724092843.8629A-100000@chaos.analogic.com>
Organization: qbfox
X-Mailer: Mail User's Shell (7.2.2 4/12/91)
To: root@chaos.analogic.com
Subject: Re: 2.4.18 clock warps 4294 seconds
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Jul 24,  9:37am, "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> Do you have a time-daemon running that synchronizes your machine to
> some other?

NTP is running on both machines.

> Run this program as:
> ./xxx &>xxx.log &
> 
> ...and see if your machine is really jumping.

I have effectively the same in the code already running.  Once the
problem on the server started (yesterday), I added some sanity
(abbreviated for clarity):

    waitinterP = rt_needbgwalk() ? &zerosec : &onesec;
    ...
    sval = pselect(sockhi,&readset,&writeset,&exceptset,waitinterP,0);
    ...
#ifdef SHAKY_CLOCK
    newnow = time((time_t*)0);
    if ( newnow > now + 100 ) {  /* Some H/W bug on some mboards? */
      if ( warpcount % 1000 == 0 )
        error("timewarp fwd %d: now %d new %d",warpcount,now,newnow);
      warpcount++;
      now += sval == 0 ? waitinterP->tv_sec : 0;
    }
    else {
      ....
      now = newnow;
    }
#else
    now = time((time_t*)0);
#endif


Here's one snippet of output:

timewarp fwd 0: now 1027434974 new 1027439268
timewarp fwd 1000: now 1027434977 new 1027439271
timewarp fwd 2000: now 1027434978 new 1027439272


I know it's a tall order, but believe me, it really is happening.
I've always had it on my workstation, ever since I started using it,
first with a 2.4.7-10 kernel.  It's happened many many times that I
would slide the mouse down to the bottom of the screen and the autohiding
taskbar would appear, clock to the right, and the next second the clock
would jump forward an hour and some minutes.  I thought it was an obscure
bug in X or Gnome until it happened on the server.

As mentioned, the workaround suggested by the posting from 1999 seems
to be doing the trick (and the sanity code I added to my stuff handles
the problem by guessing), so it isn't a big issue for me, but I would
imagine other people with the same hardware are being bitten by it.

Thanks for your note.

  -- Per G. Bilse

