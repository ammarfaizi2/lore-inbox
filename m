Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVGNRDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVGNRDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 13:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVGNRDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 13:03:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23970 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261564AbVGNRDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 13:03:14 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
In-Reply-To: <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
	 <20050714005106.GA16085@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>
	 <1121304825.4435.126.camel@mindpipe>
	 <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
	 <1121326938.3967.12.camel@laptopd505.fenrus.org>
	 <20050714121340.GA1072@ucw.cz>
	 <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 19:02:41 +0200
Message-Id: <1121360561.3967.55.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 09:37 -0700, Linus Torvalds wrote:


> There should be an _absolute_ interface

I'm not arguing there shouldn't be an absolute interface. I'm arguing
that *most* uses are relative, and as such a relative interface makes
sense for those cases.


> Btw, this is exactly why the jiffy-based thing is _good_. The kernel 
> timers _are_ absolute, and you make them relative by adding "jiffies".

again there is absolutely nothing wrong with having absolute timers and
a general notion of absolute time. Jiffies is one way of achieving that,
and it's the current linux way. I see the "absolute timers are good"
argument sort of separate from "jiffies / HZ are good" argument; there
is no principal reason why such an interface couldn't be in say usec.


> There's absolutely nothing wrong with "jiffies", and anybody who thinks 
> that
> 
> 	msleep(20);
> 
> is fundamentally better than
>
> 	timeout = jiffies + HZ/50;

I *will* argue that for relative delays in drivers, msleep() is better.
The reason is different than you think of; the argument why I consider
msleep() better as interface for relative delays in drivers is that it
is harder for a driver writer to get wrong, by virtue of it being
simpler. jiffies and HZ conversion is one of those areas that driver
writers very often get wrong. (multiply by HZ not divide for example,
but there's a few dozen ways it can and does go wrong). A relative msec
based interface is a LOT harder to get wrong, and also often is closer
to what the datasheet of the hardware says. I'm not going to say "all
driver writers are stupid" because they're not; however too many of them
just act like they are too much of the time. That doesn't mean that
there is no room for a "powerful interface" next to a simple one, and I
hope you're not fully against adding a simple interface on top of a more
powerful one if that simple interface is a way to reduce mistakes and
thus bugs in drivers.


> just doesn't realize that the latter is a bit more complicated exactly 
> because the latter is a hell of a lot more POWERFUL. Trying to get rid of 
> jiffies for some religious reason is _stupid_.

I have nothing religious against jiffies per se. My argument however is
that with a few simple, relative interfaces *in addition* to an absolute
interface, almost all drivers suddenly are isolated from jiffies and HZ
because they simply don't care. Because they really DON'T care about
absolute time. At all. 

Doing this will in turn open up flexibility in experimenting with how
one implements the timer stuff; there's suddenly a lot less code to
touch in doing so. Also such relative interface can match the intent a
lot better and separated from the actual implementation. 


