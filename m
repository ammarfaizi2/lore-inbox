Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVATAji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVATAji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVATAjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:39:37 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:34555 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262007AbVATAjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:39:12 -0500
Message-ID: <41EEFDAB.40504@mvista.com>
Date: Wed, 19 Jan 2005 16:39:07 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Andrea Arcangeli <andrea@suse.de>, Tony Lindgren <tony@atomide.com>,
       Pavel Machek <pavel@suse.cz>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dynamic tick patch
References: <20050119000556.GB14749@atomide.com>	 <20050119094342.GB25623@elf.ucw.cz> <20050119171323.GB14545@atomide.com>	 <20050119174858.GB12647@dualathlon.random>  <41EEE648.2010309@mvista.com> <1106177171.16877.274.camel@tglx.tec.linutronix.de>
In-Reply-To: <1106177171.16877.274.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Wed, 2005-01-19 at 14:59 -0800, George Anzinger wrote:
> 
>>I don't think you will ever get good time if you EVER reprogramm the PIT.
> 
> 
> Why not ? If you have a continous time source, which keeps track of
> "ticks" regardless the CPU state, why should PIT reprogramming be evil ?

First it takes too long.  Second, you are (usually) programming it to run at 
1/HZ but you do this somewhere between the ticks (and, likely you don't really 
know where between them you are).  This last means, on the average, that you 
lose 1/2 a tick time, i.e. the tick interrupt will happen 1/2 a tick late for 
each reprogramm done.

If you say, well, lets just use the TSC (or some other timer) you have the 
problem that in x86 boxes those don't rely on "rocks" selected for time keeping, 
so you have an inaccurate clock to this degree.  Also, in the case of the TSC, 
at boot time we "try" to figure out how many cycles of TSC it takes to do a PIT 
cycle by "looking" as the PIT in a loop while we catch the TSC.  Problem is that 
the I/O sync needed to look at the PIT is several TSC cycles long and we don't 
really know how close we got.  Even using the max PIT time of around 50 ms the 
error on my 800 MHZ PII is 10 or more TSC cycles.

At one point I tried to get the PIT to sync back up by doing a short cycle 
followed by the normal cycle.  I.e. I loaded the counter for the time remaining 
in the jiffie, started the PIT and then loaded the 1/HZ latch count on top of 
it.  The spec says the new count should be loaded by the chip when the current 
one expires.  This sort of worked, but I still got feedback on clock drift. 
Also, there are some PITs out there that don't do this correctly.  And in the 
load part, you have to wait for the first program to start prior to loading the 
second one.  This is a busy loop waiting for an I/O event, i.e. much too long.

We should also keep in mind that we really want the timer tick to happen as 
close as possible to the jiffies++ as possible.  Especially if we are doing high 
res timers, any delay here will show up as late timers.
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

