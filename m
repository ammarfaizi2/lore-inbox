Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265002AbUFGTNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbUFGTNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 15:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbUFGTNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 15:13:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:22917 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265002AbUFGTM4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 15:12:56 -0400
Subject: Re: Too much error in __const_udelay() ?
From: john stultz <johnstul@us.ibm.com>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>,
       greg kh <greg@kroah.com>, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <20040605152326.GA11239@dominikbrodowski.de>
References: <1086419565.2234.133.camel@cog.beaverton.ibm.com>
	 <20040605152326.GA11239@dominikbrodowski.de>
Content-Type: text/plain
Message-Id: <1086635568.2234.171.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 07 Jun 2004 12:12:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-05 at 08:23, Dominik Brodowski wrote:
> Hi,
> 
> > However I've started to see some problems w/ 2.6 and USB on x440/x445s,
> > both of which use the 100Mhz cyclone time source. Further digging has
> > pointed to the fact that certain important udelay()s in the USB
> > subsystem aren't actually waiting long enough. 
> 
> Certain? AFAICS _no_ call to a delay routine actually passed a big enough
> argument. Or am I missing something? Also, __ndelay seems to be affected 
> as well: it returns zero for 550 nsec even for the TSC variant in your 
> test.c.

Indeed its likely. 

> > So I'm no math wiz. What's the proper fix here? 
> 
> Below are three changes I'd like to discuss. I'll build a fresh kernel with
> all three changes enabled + PM_TIMER soon.

Ah, your test output is a bit confusing (changes to __const_udealy
affect the output of my_udelay), but I think I understand it. Forgive me
if I miss-interpret. 

> Change 1:
> 
> Move the multiplication with HZ up into the mull instruction:
> 
> unsigned long  __const_udelay(unsigned long xloops)
> {
> 	int d0;
> 	__asm__("mull %0"
> 		:"=d" (xloops), "=&a" (d0)
> 		:"1" (xloops),"0" (LPJ * HZ));
>         return __delay(xloops);
> }

This does make a good bit of difference! Good catch!


> Change 2:
> 
> Round up in __udelay. While it can be argued that some time is also
> spent in the delay functions, it's better to spend _at least_ the specified
> time sleeping, in my humble opinion. 
> 
> 
> -	return __const_udelay2(usecs * 0x000010c6);  /* 2**32 / 1000000 */
> +	return __const_udelay2(usecs * 0x000010c7);  /* 2**32 / 1000000 (rounded up)*/
> 

This change looks right to me. 


> Change 3:
> 
> Asserting at least 1 loop is spent: in really small ndelay() calls to
> low-mhz timers, this might be better.
> 
>         return __delay(xloops ? xloops : 1);

I agree w/ Pavel that rounding up sounds better, but I can't get the
math to work, so this may be the best solution. 

I'm also spinning up a patch w/ these changes to test, let me know how
your testing went and I'll do the same.
-john


