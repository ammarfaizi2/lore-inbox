Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263144AbVGNUPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbVGNUPy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbVGNUPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:15:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46989 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263143AbVGNUPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:15:01 -0400
Date: Thu, 14 Jul 2005 13:13:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: john stultz <johnstul@us.ibm.com>
cc: Arjan van de Ven <arjan@infradead.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       lkml <linux-kernel@vger.kernel.org>, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <1121370122.7673.161.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0507141307060.19183@g5.osdl.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com>  <1121286258.4435.98.camel@mindpipe>
 <20050713134857.354e697c.akpm@osdl.org>  <20050713211650.GA12127@taniwha.stupidest.org>
  <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> 
 <20050714005106.GA16085@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> 
 <1121304825.4435.126.camel@mindpipe>  <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
  <1121326938.3967.12.camel@laptopd505.fenrus.org>  <20050714121340.GA1072@ucw.cz>
  <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>  <1121360561.3967.55.camel@laptopd505.fenrus.org>
 <1121370122.7673.161.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jul 2005, john stultz wrote:
> 
> We'll I'd probably put it as: "they do care about absolute time, but
> they do not care about ticks or timer interrupt frequency"

Well, the thing is, you have to count time some sane way.

You can do it by having very expensive data structures that say "real
time", but then you have some serious confusion when it comes to things
like whether it's wallclock time (which might have shifts and other
interesting issues) or some "virtual cpu time". You also end up having a
much much more expensive interface, ie "time_after()" ends up being a much
more complicated test.

So the _sane_ way to do timeouts is to define an _arbitrary_ clock that is 
just an integer counter. None of this "nanoseconds + full seconds" crap. 
None of this stupid confusion with "real time". You select something that 
is conceptually _clearly_ somethign else, and that will never get confused 
when root sets the time backwards or anything like that.

In other words, you select the thing we call "jiffies".

Face it, it is just _superior_ to the alternatives. The alternative is to
have some "fake time" aka "struct timespec", and always have to worry
about normalization and complicated comparisons, and using more memory 
too, btw.

There is no way to avoid having some kind of counter to specify time.  
NONE. The only choice is what you base your notion of time on, and how you
represent it. Do you represent it as two separate counters and try to make
it look like "fractions of seconds", or do you represent it as a single
counter, and make it look like "ticks".

And the single counter is _simpler_. The alternatives have absolutely 
_zero_ upsides. Name _one_. 

		Linus
