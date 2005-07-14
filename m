Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVGNBzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVGNBzX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 21:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVGNBzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 21:55:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37294 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261356AbVGNBym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 21:54:42 -0400
Date: Wed, 13 Jul 2005 18:54:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       vojtech@suse.cz, david.lang@digitalinsight.com, davidsen@tmr.com,
       kernel@kolivas.org, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <1121304825.4435.126.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
References: <42D540C2.9060201@tmr.com>  <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
  <20050713184227.GB2072@ucw.cz>  <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
  <1121282025.4435.70.camel@mindpipe>  <d120d50005071312322b5d4bff@mail.gmail.com>
  <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
  <20050713211650.GA12127@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> 
 <20050714005106.GA16085@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> <1121304825.4435.126.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Jul 2005, Lee Revell wrote:
> 
> Interesting.  First they say it's impractical to reprogram the PIT, then
> they later imply that's exactly what Windows does, though for some
> reason they don't come out and say it.

I suspect that it is impractical to reprogram the PIT on a very fine
granularity.

Btw, if somebody really gets excited about all this, let me say (once 
again) what I think might be an acceptable situation.

First off, I'm _not_ a believer in "sub-HZ ticks". Quite the reverse. I 
think we should have HZ be some high value, but we would _slow_down_ the 
tick when not needed, and count by 2's, 3's or even 10's when there's not 
a lot going on.

In other words, I don't think we want a _highfrequency_ timer, I want a
_lower_ frequency mode.

So let's say that we raise HZ to 2000, or somethign that we decide is the
upper limit of sanity. We then have some timer logic entity that notices
that nothing is going to care for the next 100 ticks, so we go into "slow
mode", and reprogram the timer to tick at a frequency of 100Hz, but when
it does tick, we just count it as 20.

IOW, nothing ever sees any "variable frequency", and there's never any 
question about what the timer tick is: the timer tick is 2kHz as far as 
everybody is concerned. It's just that the ticks sometimes come in 
"bunches of 20".

This also means that there is never any issue of the timer running wild. 
The _most_ it will ever run at is limited quite naturally, and some crazy 
user asking for a 1ns itimer won't make any difference at all to the 
system.

		Linus
