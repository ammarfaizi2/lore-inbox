Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTJ2Tjm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 14:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTJ2Tjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 14:39:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:10716 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261492AbTJ2Tjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 14:39:40 -0500
Date: Wed, 29 Oct 2003 11:38:50 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: john stultz <johnstul@us.ibm.com>, Joe Korty <joe.korty@ccur.com>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: gettimeofday resolution seriously degraded in test9
Message-Id: <20031029113850.047282c4.shemminger@osdl.org>
In-Reply-To: <20031029100745.GA6674@iram.es>
References: <20031027234447.GA7417@rudolph.ccur.com>
	<1067300966.1118.378.camel@cog.beaverton.ibm.com>
	<20031027171738.1f962565.shemminger@osdl.org>
	<20031028115558.GA20482@iram.es>
	<20031028102120.01987aa4.shemminger@osdl.org>
	<20031029100745.GA6674@iram.es>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Oct 2003 11:07:45 +0100
Gabriel Paubert <paubert@iram.es> wrote:


> Consider the following:
> 
> - t-2: interrupt A arrives and starts being serviced
> - t-1: interrupt B arrives but delayed in the APIC
> - t: timer interrupt arrives (it is delayed too)
> - t+x1: return from interrupt A
> - t+x2: interrupt B serviced
> - gettimeofday for time stamping, the returned value will actually 
>   be frozen at t-1 for HZ=1000 or t-5 for HZ=100, while the actual
>   time is t+something with something maybe up to a few tens of
>   microseconds, instead of t+x2-1 or t+x2-5 which would be 
>   clearly better.
> - t+x3: timer interrupt, time steps suddenly now (or in
>   the following BH, can't remember) from t-1 to the correct
>   value, creating a fairly large discontinuity.
> 
> So what I'm asking you is to change the code so that the discontinuities
> are minimized. That's quite important for some applications; actually
> in my case the out-of-order gettimeofday don't matter as long as the
> steps are small because I don't sample fast enough to be affected
> by them, but getting the timestamp wrong by tens of microseconds is bad 
> for evaluating the derivatives of the value read from a position encoder, 
> as needed for servo loops for example.

The suggestion of using time interpolation (like ia64) would make the discontinuities
smaller, but still relying on fine grain gettimeofday for controlling servo loops
with NTP running seems risky. Perhaps what you want to use is the monotonic_clock
which gives better resolution (nanoseconds) and doesn't get hit by NTP. 

A bigger possible change would be for the timer->offset functions to return nanoseconds,
then the offset adjustment code could smooth it out. It would save a divide.


