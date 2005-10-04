Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVJDB4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVJDB4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 21:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVJDB4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 21:56:52 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:36596 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751138AbVJDB4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 21:56:52 -0400
Message-ID: <4341E120.3060500@mvista.com>
Date: Mon, 03 Oct 2005 18:55:44 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com, paulmck@us.ibm.com,
       Christoph Hellwig <hch@infradead.org>, oleg@tv-sign.ru,
       tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509301825290.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0509301825290.3728@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> 
> Could you explain a little the resolution handling behind in your patch?
> If I read SUS correctly clock resolution and timer resolution don't have 
> to be the same, the first is returned by clock_getres() and the latter 
> only documented somewhere (and AFAICT our implementation always returned 
> the wrong value).
> IMO this also means we can don't have to make the rounding that 
> complicated. Actually it could be done automatically by the timer, e.g. 
> interval timer are reprogrammed at (now + interval) and the timer 
> resolution will automatically round it up.

As I understand it the resolution should apply to timers assigned to the given clock.  I assume most 
clock reads will return the best resolution possible, but we can only know what that is (in user 
land) by looking at at series of clock reads and making an educated guess (if indeed we care).

For timers, on the other hand, resolution serves two purposes: a) it tells the user/ application 
what to expect and allows him to take evasive action (such as asking for the timer to expire a "res" 
amount sooner) to get what he wants/needs.  b) for the kernel, it allows timers to be grouped such 
that we can limit the number of interrupts we need to service to handle timers.  Some of this might 
be possible by relying on the hardware, but a lot of hardware may actually be able to handle 
nanosecond resolution.  At that point you end up grouping by latency and getting to the point were, 
for no good reason, you have the possibility of timer storms.  For no good reason, i.e. the user 
really doesn't need or want that level of resolution, being happy with, for example 10 microseconds 
or some such.  This is why, in the HRT patch, the same can be said of the new ability to set HZ at 
configure time.
> 
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
