Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268405AbUHQUOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268405AbUHQUOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268404AbUHQUOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:14:46 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:12460 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268401AbUHQUOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:14:17 -0400
Subject: Re: boot time, process start time, and NOW time
From: Albert Cahalan <albert@users.sf.net>
To: john stultz <johnstul@us.ibm.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Andrew Morton OSDL <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       tim@physik3.uni-rostock.de, george anzinger <george@mvista.com>,
       david+powerix@blue-labs.org
In-Reply-To: <1092769231.2429.115.camel@cog.beaverton.ibm.com>
References: <1087948634.9831.1154.camel@cube>
	 <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>  <1092698648.2301.1250.camel@cube>
	 <1092769231.2429.115.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1092764462.5761.1553.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Aug 2004 13:41:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 15:00, john stultz wrote:
> On Mon, 2004-08-16 at 16:24, Albert Cahalan wrote:
> > On Mon, 2004-08-16 at 15:41, Andrew Morton wrote:
> > 
> > > Where did this all end up?  Complaints about
> > > wandering start times are persistent, and it'd
> > > be nice to get some fix in place...
> > 
> > If you're interested in reducing (not solving)
> > the problem for the 2.6.x series, you might change
> > HZ to something that works better with the PIT.
> > 
> > Here is a table showing % error for various HZ choices:
> > 
> > wrongness_%   HZ_diff   PIT_#   HZ     actual_HZ   
> > -0.00150855  -0.001509  11932   100    99.998491  
> > -0.00150855  -0.009474   1900   628   627.990526  
> > -0.00083809  -0.003051   3278   364   363.996949  
> > -0.00083809  -0.008389   1192  1001  1000.991611  
> > +0.00000000  +0.000000  14551    82    82.000000  
> > +0.00008381  +0.000304   3287   363   363.000304  
> > +0.00008381  +0.000435   2299   519   519.000435  
> > +0.00008381  +0.000525   1903   627   627.000525  
> > +0.01525566  +0.152557   1193  1000  1000.152557  
> > +0.01860917  +0.190558   1165  1024  1024.190558
> > 
> > As you can see, 1000 HZ and 1024 HZ are really bad.
> > They're worse than typical quartz crystal variation.
> > 
> > The old 100 HZ tick was just barely tolerable.
> > While 82 is perfect, it's a bit low. :-(
> > 
> > Some of the other choices are nice. How about 363,
> > 519, or 627?
> 
> What about 1001? That looks reasonably accurate.

Sure. (it's 10x worse, but the crystals aren't good
enough to tell the difference) Supposing that a
choice near 1000 HZ is good, here are some more:

wrongness_%   HZ_diff   PIT_#   HZ     actual_HZ   
-0.00217900  -0.021703   1198   996   995.978297
-0.00083809  -0.008389   1192  1001  1000.991611
-0.00050285  -0.006376    941  1268  1267.993624
+0.00050286  +0.005396   1112  1073  1073.005396
+0.00150859  +0.014950   1204   991   991.014950

I think it's better to drop down a bit, because people
have also been suffering problems with lost ticks.
The BIOS can grab the CPU for too long.

We need to deal well with a few different frequencies:

100    the old clock tick
59.94  NTSC field rate
50     PAL field rate

The theory is that you need a frequency of just over 2x
the one you'd like, but in practice you need about 4x.
So that's why I suggested 363, 519, and 627.

I'd really rather just run everything off the RTC or HPET,
with an arbitrary rate interrupt source, and just call into
the regular jiffies handling code as needed to catch up.
This would allow steering the jiffies tick to an exact
integer HZ. High-precision timers could be fired off of
the RTC or HPET interrupt if that is running faster.


