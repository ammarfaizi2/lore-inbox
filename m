Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVGLMNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVGLMNo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVGLMLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:11:50 -0400
Received: from styx.suse.cz ([82.119.242.94]:36511 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261373AbVGLMKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:10:14 -0400
Date: Tue, 12 Jul 2005 14:10:08 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: George Anzinger <george@mvista.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Lee Revell <rlrevell@joe-job.com>,
       Diego Calleja <diegocg@gmail.com>, azarah@nosferatu.za.org,
       akpm@osdl.org, cw@f00f.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050712121008.GA7804@ucw.cz>
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050708214908.GA31225@taniwha.stupidest.org> <20050708145953.0b2d8030.akpm@osdl.org> <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe> <20050709203920.394e970d.diegocg@gmail.com> <1120934466.6488.77.camel@mindpipe> <176640000.1121107087@flay> <42D310ED.2000407@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D310ED.2000407@mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 05:38:05PM -0700, George Anzinger wrote:

> I would like to interject an addition data point, and I will NOT be 
> subjective. The nature of the PIT is that it can _hit_ some frequencies 
> better than others.  We have had complaints about repeating timers not 
> keeping good time. These are not jitter issues, but drift issues.  The 
> standard says we may not return early from a timer so any timer will either 
> be on time or late.  The amount of lateness depends very much on the HZ 
> value.  Here is what the values are for the standard CLOCK_TICK_RATE:
> 
> HZ  	TICK RATE	jiffie(ns)	second(ns)	 error (ppbillion)
>  100	 1193180	10000000	1000000000	       0
>  200	 1193180	 5000098	1000019600	   19600
>  250	 1193180	 4000250	1000062500	   62500
>  500	 1193180	 1999703	1001851203	 1851203
> 1000	 1193180	  999848	1000847848	  847848
> 
> The jiffie values here are exactly what the kernel uses and are based on 
> the best one can do with the PIT hardware.

The PIT crystal runs at 14.3181818 MHz (CGA dotclock, found on ISA, ...)
and is divided by 12 to get PIT tick rate

	14.3181818 MHz / 12 = 1193182 Hz

The reality is that the crystal is usually off by 50-100 ppm from the
standard value, depending on temperature. 

    HZ   ticks/jiffie  1 second      error (ppm)
---------------------------------------------------
   100      11932      1.000015238      15.2
   200       5966      1.000015238      15.2
   250       4773      1.000057143      57.1
   300       3977      0.999931429     -68.6
   333       3583      0.999964114     -35.9
   500       2386      0.999847619    -152.4
  1000       1193      0.999847619    -152.4

Some HZ values indeed fit the tick frequency better than others, up to
333 the error is lost in the physical error of the crystal, for 500 and
1000, it definitely is larger, and thus noticeable.

Some (less round and nice) values of HZ would fit even better:

    HZ   ticks/jiffie  1 second      error (ppm)
---------------------------------------------------
    82      14551      1.000000152       0.2
    96      12429      1.000001829       1.8
   209       5709      0.999999314      -0.7
   363       3287      0.999999314      -0.7
   519       2299      0.999999314      -0.7
   864       1381      1.000001829       1.8

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
