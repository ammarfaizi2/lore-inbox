Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131756AbRDPRwQ>; Mon, 16 Apr 2001 13:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131806AbRDPRwG>; Mon, 16 Apr 2001 13:52:06 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:35601 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131756AbRDPRv5>; Mon, 16 Apr 2001 13:51:57 -0400
Message-ID: <3ADB30B8.109D48E3@mvista.com>
Date: Mon, 16 Apr 2001 10:49:44 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Pavel Machek <pavel@suse.cz>, SodaPop <soda@xirr.com>,
        alexey@datafoundation.com, linux-kernel@vger.kernel.org
Subject: Re: [test-PATCH] Re: [QUESTION] 2.4.x nice level
In-Reply-To: <Pine.LNX.4.21.0104161118180.14442-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Thu, 12 Apr 2001, Pavel Machek wrote:
> 
> > > One rule of optimization is to move any code you can outside the loop.
> > > Why isn't the nice_to_ticks calculation done when nice is changed
> > > instead of EVERY recalc.?  I guess another way to ask this is, who needs
> >
> > This way change is localized very nicely, and it is "obviously right".
> 
> Except for two obvious things:
> 
> 1. we need to load the nice level anyway
> 2. a shift takes less cycles than a load on most
>    CPUs
> 
Gosh, what am I missing here?  I think "top" and "ps" want to see the
"nice" value so it needs to be available and since the NICE_TO_TICK()
function looses information (i.e. is not reversible) we can not compute
it from ticks.  Still, yes we need to load something, but is it nice? 
Why not the result of the NICE_TO_TICK()?  

A shift and a subtract are fast, yes, but this loop runs over all tasks
(not just the run list).  This loop can put a real dent in preemption
times AND the notion of turning on interrupts while it is done can run
into some interesting race conditions.  (This is why the MontaVista
scheduler does the loop without dropping the lock, AFTER optimizing the
h... out of it.)

What am I missing?

George
