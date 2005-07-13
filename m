Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVGMTOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVGMTOz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVGMTNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:13:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6076 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262375AbVGMTL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:11:27 -0400
Date: Wed, 13 Jul 2005 12:10:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <20050713184227.GB2072@ucw.cz>
Message-ID: <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050712121008.GA7804@ucw.cz>
 <200507122239.03559.kernel@kolivas.org> <200507122253.03212.kernel@kolivas.org>
 <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com>
 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz> <20050713184227.GB2072@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Jul 2005, Vojtech Pavlik wrote:
>
> No, but 1/1000Hz = 1000000ns, while 1/864Hz = 1157407.407ns. If you have
> a counter that counts the ticks in nanoseconds (xtime ...), the first
> will be exact, the second will be accumulating an error.

It's not even that we have a counter like that, it's the simple fact that
we have a standard interface to user space that is based on milli-, micro-
and nanoseconds.

(For "poll()", "struct timeval" and "struct timespec" respectively).

It's totally pointless saying that we can do 864 Hz "exactly", when the
fact is that all the timeouts we ever get from user space aren't in that 
format. So the only thing that matters is how close to a millisecond we 
can get, not how close to some random number.

So we do a lot of conversions from "struct timeval" to "jiffies", and if
you don't take the error in that conversion into account, then you're
ignoring what is likely a _bigger_ error.

Long-term time drift is a known issue, and is unavoidable since you don't 
even know the exact frequency of the crystal, since that is not only not 
that exact in the first place, it depends on temperature etc. So long-term 
time drift is something that we inevitably have to use things like NTP to 
handle, if you want an exact clock.

And in short-term things, the timeval/jiffie conversion is likely to be a 
_bigger_ issue than the crystal frequency conversion.

So we should aim for a HZ value that makes it easy to convert to and from
the standard user-space interface formats. 100Hz, 250Hz and 1000Hz are all
good values for that reason. 864 is not.

		Linus
