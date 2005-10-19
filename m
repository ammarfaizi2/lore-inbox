Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbVJSAEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbVJSAEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 20:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbVJSAEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 20:04:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:22008 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751511AbVJSAEr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 20:04:47 -0400
Message-ID: <43558D53.9070209@mvista.com>
Date: Tue, 18 Oct 2005 17:03:31 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Bird <tim.bird@am.sony.com>
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com, paulmck@us.ibm.com,
       hch@infradead.org, oleg@tv-sign.ru
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
References: <20051018084655.GA28933@elte.hu> <43558AD8.3010307@am.sony.com>
In-Reply-To: <43558AD8.3010307@am.sony.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Bird wrote:
> Ingo Molnar wrote:
> 
>>My claim is that if you _know_ that a timer will expire most likely, you 
>>want it to order at insertion time - i.e. you want to have a tree 
>>structure. If you _know_ that a timer will most likely _not_ expire, 
>>then you can avoid the tree overhead by 'delaying' the decision of 
>>sorting timers, to the point in the future where we really are forced to
>>do so.
>>
>>The result of this mathematical paradox is that we end up with two data 
>>structures: one is the timer wheel (kernel/timers.c) for 
>>timeout/exception related use; the other one is ktimers 
>>(kernel/ktimers.c), for expiry oriented use.
> 
> 
> I'd like to make an observation on another
> difference between the wheel and the rbtree.  Note that
> the wheel implementation inherently coalesces timeouts
> that are near each other, due to it's relatively
> low resolution (at tick granularity - which is
> still pretty low resolution on embedded hardware -
> usually 10 milliseconds.)
> 
> One concern I have with the rbtree is that this
> automatic coalescing is lost, and there may be
> unanticipated overhead in the move to support
> high resolution timers.

I think the coalescing is really done by the resolution rounding.  There will always be the list 
removal overhead, but short of a duplex tree (i.e. one entry per time with dup times linked from the 
first (Ug)) you will always have that.  What you want to coalesce is the interrupt overhead, not the 
list overhead, the former being MUCH larger.  The difference here is that we don't see the 
resolution reflected in the tree structure, but that, I think, is good.
> 
> Whether some form of coalescing should be
> preserved for timers, even when the system
> supports higher resolution, will be a
> function of the number of timers and their
> intended use.  I don't see any support for that
> in the current patch, but maybe I'm missing
> something.
> 
> =============================
~
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
