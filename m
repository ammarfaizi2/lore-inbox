Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263131AbVGOCBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbVGOCBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 22:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbVGOCBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 22:01:44 -0400
Received: from tomts36.bellnexxia.net ([209.226.175.93]:23764 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263131AbVGOCAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 22:00:50 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       vojtech@suse.cz, david.lang@digitalinsight.com, davidsen@tmr.com,
       kernel@kolivas.org, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org, christoph@lameter.com
In-Reply-To: <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>
References: <42D3E852.5060704@mvista.com> <42D540C2.9060201@tmr.com>
	 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	 <20050713184227.GB2072@ucw.cz>
	 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	 <1121282025.4435.70.camel@mindpipe>
	 <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <9a874849050714170465c979c3@mail.gmail.com>
	 <1121386505.4535.98.camel@mindpipe>
	 <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 22:00:55 -0400
Message-Id: <1121392856.7934.11.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 17:24 -0700, Linus Torvalds wrote:
> 
> On Thu, 14 Jul 2005, Lee Revell wrote:
> 
> Trust me. When I say that the right thing to do is to just have a fixed 
> (but high) HZ value, and just changing the timer rate, I'm -right-.
> 
> I'm always right. This time I'm just even more right than usual.

Of course you are, jiffies are simple and efficient.

But it may be worthwhile to provide better/simpler API for relative
timeouts and also better hide the implementation details of the tick
system.


If i sum-up the discussion from my POV:

- use a 32-bit tick counter on 32-bit platforms and use a 64-bit counter
on 64-bit platforms

- keep the constant HZ=1000 (mS resolution) on 32-bit platforms

- remove the assumption that timer interrupts and jiffies are 1:1 thing
(jiffies may be incremented by >1 ticks at timer interrupt)

- determine jiffies_increment at boot

- have a slow clock mode to help power management (adjust
jiffies_increment by the slowdown factor)

- it may be useful to bump up HZ to 1e6 (uS res.) or 1e9 (nS res.) on
64-bit platforms, if there are benefits such as better accuracy during
time units conversions or if a higher frequency timer hardware is
available/viable.

- it may be also useful to bump HZ on -RT (Real-time) kernels, or with
-HRT (High-resolution timers support). Users of those kernel are willing
to pay the cost of the overhead to have better resolution

- avoid direct usage of the jiffies variable, instead use jiffies()
(inline or MACRO), IMO monotonic_clock() would be a better name

- provide a relative timeout API (see my previous post, or Alan's
suggestions)

- remove most of the direct use of jiffies through the code and replace
them with msleep(), relative timer, etc

- use human units for those APIs


- Eric St-Laurent


