Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUHaAjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUHaAjL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 20:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUHaAjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 20:39:11 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:19450 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265817AbUHaAjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 20:39:04 -0400
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
From: Albert Cahalan <albert@users.sf.net>
To: john stultz <johnstul@us.ibm.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       george anzinger <george@mvista.com>, Andrew Morton OSDL <akpm@osdl.org>,
       Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
       albert@users.sourceforge.net, hirofumi@mail.parknet.co.jp,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr, david+powerix@blue-labs.org
In-Reply-To: <1093909116.14662.105.camel@cog.beaverton.ibm.com>
References: <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>
	 <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>
	 <412285A5.9080003@mvista.com>
	 <1092782243.2429.254.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de>
	 <1092787863.2429.311.camel@cog.beaverton.ibm.com>
	 <1092781172.2301.1654.camel@cube>
	 <1092791363.2429.319.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0408180927450.14935@gockel.physik3.uni-rostock.de>
	 <20040819191537.GA24060@elektroni.ee.tut.fi>
	 <20040826040436.360f05f7.akpm@osdl.org>
	 <Pine.LNX.4.53.0408261311040.21236@gockel.physik3.uni-rostock.de>
	 <Pine.LNX.4.53.0408310037280.5596@gockel.physik3.uni-rostock.de>
	 <1093909116.14662.105.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1093912654.434.7022.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Aug 2004 20:37:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 19:38, john stultz wrote:

> This isn't going to happen instantly by any means. I'm trying to
> get the time of day rework finished as soon as I can, but I've
> got the day job to do as well. In the mean time, we can staple gun
> any user visible exported HZ/jiffies values so they are accurate
> (using ACTHZ or gettimeofday), and also look into changing HZ to a
> less error-ful value.  HZ=1001 has been suggested and looks quite  
> promising (although /net/schec/estimator.c wants a power of 4).

Well, pick something else. Here's a list of choices with
error under 0.0025%, in the 240..1300 range, that can be
evenly divided by four.

Dropping back a bit would be good, to better tolerate        
systems with firmware that steals enough time to cause
lost clock ticks.

I like 400, 488, and 556. 864 and 1112 are decent too.
It might be useful having 400 as a multiple of 100.

I don't think /net/sched/estimator.c needs such
great accuracy. If that were sacrificed, one could
do much better with HZ at 363, 519, or 627.

%error       HZerror     PIT#    HZ   actual
-0.00217900  -0.007234   3594   332   331.992766
-0.00217900  -0.014469   1797   664   663.985531
-0.00217900  -0.021703   1198   996   995.978297
-0.00184378  -0.014676   1499   796   795.985324
-0.00150855  -0.004586   3925   304   303.995414
-0.00150855  -0.005732   3140   380   379.994268
-0.00150855  -0.006034   2983   400   399.993966
-0.00150855  -0.009474   1900   628   627.990526
-0.00150855  -0.011465   1570   760   759.988535
-0.00150855  -0.018947    950  1256  1255.981053
-0.00083809  -0.002581   3874   308   307.997419
-0.00083809  -0.003051   3278   364   363.996949
-0.00083809  -0.004794   2086   572   571.995206
-0.00083809  -0.004995   2002   596   595.995005
-0.00083809  -0.005163   1937   616   615.994837
-0.00083809  -0.006101   1639   728   727.993899
-0.00083809  -0.009588   1043  1144  1143.990412
-0.00083809  -0.009990   1001  1192  1191.990010
-0.00050285  -0.006376    941  1268  1267.993624
-0.00016762  -0.000483   4143   288   287.999517
-0.00016762  -0.000724   2762   432   431.999276
-0.00016762  -0.001448   1381   864   863.998552
+0.00050286  +0.001488   4031   296   296.001488
+0.00050286  +0.002796   2146   556   556.002796
+0.00050286  +0.005592   1073  1112  1112.005592
+0.00150859  +0.018163    991  1204  1204.018163
+0.00184384  +0.004499   4890   244   244.004499
+0.00184384  +0.008998   2445   488   488.008998
+0.00184384  +0.012022   1830   652   652.012022
+0.00184384  +0.013497   1630   732   732.013497
+0.00184384  +0.022495    978  1220  1220.022495
+0.00217909  +0.027282    953  1252  1252.027282


