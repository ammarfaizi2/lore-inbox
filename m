Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTD2Td2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 15:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbTD2Td2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 15:33:28 -0400
Received: from [63.96.239.5] ([63.96.239.5]:9168 "EHLO mc.com")
	by vger.kernel.org with ESMTP id S261591AbTD2Td0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 15:33:26 -0400
Message-Id: <200304291945.PAA27684@mc.com>
Content-Type: text/plain; charset=US-ASCII
From: mbs <mbs@mc.com>
To: rmoser <mlmoser@comcast.net>, Jae-Young Kim <jaykim@cs.purdue.edu>
Subject: Re: kernel timer accuracy
Date: Tue, 29 Apr 2003 14:47:54 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20030429165427.GA5923@punch.cs.purdue.edu> <200304291511440630.0459FBDF@smtp.comcast.net>
In-Reply-To: <200304291511440630.0459FBDF@smtp.comcast.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the semantic of most "timer" style operations (sleep, nanosleep, timer_xxx 
etc) are generally "not less than" or "no earlier than", i.e wait no less 
than 50ms, so anything over 50 is ok (usually within some defined window), 
but less than 50 is a big no no.

it seems that the insert mechanism probably sets "5 ticks from now" resulting 
in 4 complete jiffie intervals plus a partial, rather than "5 complete 
intervals plus whatever part remains of the interval I'm currently in"

this may be the correct and intended semantic for the mechanism he is using, 
but it is clearly not what he expected.

On Tuesday 29 April 2003 15:11, rmoser wrote:
> Note:  Not much of this makes sense or is useful.  Read it, maybe
> I'm wrong.  It's short.
>
> *********** REPLY SEPARATOR  ***********
>
> On 4/29/2003 at 11:54 AM Jae-Young Kim wrote:
> >Hi, I'm developing a kernel module that enforces filtered packets to
> >get delayed for a given short time. I'm using netfilter for packet
> >filtering and using mod_timer() for packet delay.
> >
> >The kernel module holds packet buffer (skb) in a linked list and
> >waits until the timer expires. If the timer expires, the module
> >releases the packets.
> >
> >What I'm struggling is about the accuracy of timer function. Since
> >default Linux timer interrupt frequency is set to 100 HZ, I know
> >the smallest timer interval is 10 msec. and the one jiffy tick is
> >also 10 msec. However, it looks like that there's a small amount of
> >error between real-time clock and jiffy tick.
> >
> >In my experiment, (I set the 50msec timer for each packet and I sent
> >one packet in every second), if I set 5 jiffies (= 50 msec) for my
> >packet delay, the timer correctly executes the callback function
> >after 5 jiffy ticks, however, the actual real-time measurment shows the
> >packet delay varies between 40msec and 50msec. Even worse, the actual
> >delay time variation has a trend. Please see the following data.
> >
> >pkt no.       jiffy      actual delay
> >----------------------------------------
> >1               5            50.2msec
> >...            ...             ...
> >300             5            45.1msec
> >...            ...             ...
> >500             5            41.6msec
> >...            ...             ...
> >566             5            40.6msec
> >567             5            40.4msec
> >568             5            50.3msec
> >569             5            50.3msec
> >...            ...             ...
>
> Looks normal.  Did someone point this at 50?  Because it looks normal
> centered at 45.  Maybe you should try centering the delay at 50?  (For a
> start... 5 mS for 50 mS is too much for me)  At least in large lengths of
> time, it would then balance out.  Graph this function:
>
> f(x) = 1/(sqrt(2*pi)) * pow(e, 0.5 * pow(x,2))
>
> That should illustrate normality.  If you make a distribution curve of
> actual times, does it look like that?  If so, try first to make it center
> around 50, then try to decrease the standard deviation (which is reflected
> by having more fluctuations be closer to the mean).
>
> >Here, the packet delay starts from around 50msec, but gradually decreased
> >to 40msec, and then abruptly adjusted to 50msec. The same
> >decrese-and-abruptly-
> >adjusted trend was repeated.
> >
> >Is there any person have experienced the same problem?
> >It looks like that the accuray below 10msec is not guaranteed, but I'd
> >like to
> >know why this kind of trend happens (I initially thought the error should
> >be
> >randomly distributed between 40msec to 60msec) and how the kernel adjust
> >the timer when the error term becomes over 10msec.
>
> That'd be impossible.  The computer is absolutely incapable of producing a
> random number on its own, much less several [million].  :-p  It may be
> semi- random or apparently-random though.
>
> >- Jay
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/**************************************************
**   Mark Salisbury       ||      mbs@mc.com     **
** If you would like to sponsor me for the       **
** Mass Getaway, a 150 mile bicycle ride from    **
** Boston to Provincetown for Multiple Sclerosis **
** contact me to donate                          **
**************************************************/
