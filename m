Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbVJSRsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVJSRsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVJSRsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:48:40 -0400
Received: from mail-red.bigfish.com ([216.148.222.61]:59505 "EHLO
	mail90-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751191AbVJSRsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:48:39 -0400
X-BigFish: V
Message-ID: <435686F5.3040102@am.sony.com>
Date: Wed, 19 Oct 2005 10:48:37 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, george@mvista.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru
Subject: Re: kernel/timer.c design
References: <Pine.LNX.4.61.0510171948040.1386@scrub.home> <4353F936.3090406@am.sony.com> <Pine.LNX.4.61.0510172138210.1386@scrub.home> <20051017201330.GB8590@elte.hu> <Pine.LNX.4.61.0510172227010.1386@scrub.home> <20051018084655.GA28933@elte.hu> <Pine.LNX <20051019104938.GA30185@elte.hu>
In-Reply-To: <20051019104938.GA30185@elte.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Thanks for the excellent description of the timer wheel
implementation.

Ingo Molnar wrote:
> One cost is the burstiness of processing: a single step of cascading can 
> take many timers to be processed (if they happen to be in that same 
> bucket)...

> But there's a hidden win as well from this approach: if a timer is 
> removed before it expires, we've saved the remaining cascading steps!  
> This happens surprisingly often: on a busy networked server, the 
> majority of the timers never expire, and are removed before they have to 
> be cascaded even once.

Unfortunately, this means that the actual costs of the wheel
implementation vary depending on the relationship between HZ,
the average timeout duration, and the bucket mappings (which,
as you say, can be adjusted for size reasons.)  This is one of
the downsides of the wheel implementation.  It's very difficult
to tell in advance whether a particular timer load
will cascade or not, making the costs (although bounded)
unexpectedly variable.

One solution (even suggested by Linus) for high resolution
timers was to increase HZ and skip timer ticks.  Unfortunately,
this has a dramatic affect on the cost of cascading, and on
the maximum duration available for timers.  (By increasing
HZ, you push more timers to higher tiers in the wheel, which
means you potentially end up cascading them more often,
even when they are removed before expiry.) These types
of unexpected consequences are one good reason for avoiding
use of the wheel for high res timers.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

