Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264241AbTLYJq5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 04:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTLYJq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 04:46:57 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:8432 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264241AbTLYJqz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 04:46:55 -0500
Message-ID: <3FEAB1D6.9030209@mvista.com>
Date: Thu, 25 Dec 2003 01:45:58 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       dilinger@voxel.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] more CardServices() removals (drivers/net/wireless)
References: <1072229780.5300.69.camel@spiral.internal> <20031223182817.0bd3dd3c.akpm@osdl.org> <3FE8FC2E.3080701@pobox.com> <20031223184827.4cfb87e2.akpm@osdl.org> <3FE9022A.7010604@pobox.com> <20031223202305.489c409f.akpm@osdl.org> <20031224043349.GI18208@waste.org>
In-Reply-To: <20031224043349.GI18208@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Tue, Dec 23, 2003 at 08:23:05PM -0800, Andrew Morton wrote:
> 
>>Jeff Garzik <jgarzik@pobox.com> wrote:
>>
>>>Patch:
>>> http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-netdrvr-exp1.patch.bz2
>>
>>Thanks, I mmified that.  It let me drop a shower of other stuff, which is
>>always welcome.  Please send in new versions as-and-when needed.
>>
>>I dropped all of kgdboe:
>>
>>	kgdb-over-ethernet.patch
>>	kgdb-over-ethernet-fixes.patch
>>	kgdb-CONFIG_NET_POLL_CONTROLLER.patch
>>	kgdb-handle-stopped-NICs.patch
>>	eepro100-poll-controller.patch
>>	tlan-poll_controller.patch
>>	tulip-poll_controller.patch
>>	tg3-poll_controller.patch
>>	8139too-poll_controller.patch
>>	kgdb-eth-smp-fix.patch
>>	kgdb-eth-reattach.patch
>>	kgdb-skb_reserve-fix.patch
>>
>>Matt, would you be able to take a look at resurrecting kgdboe based on the
>>netpoll infrastructure sometime please?
> 
> 
> Yep, I'm working on it this very moment for my -tiny tree on top of
> Jeff's latest. Should have another cut soon.
>  
> 
>>George, I'm sorely tempted to fold all of these:
>>
>>	kgdb-buff-too-big.patch
>>	kgdb-warning-fix.patch
>>	kgdb-build-fix.patch
>>	kgdb-spinlock-fix.patch
>>	kgdb-fix-debug-info.patch
>>	kgdb-cpumask_t.patch
>>	kgdb-x86_64-fixes.patch
>>
>>into the base kgdb patch.   Beware ;)
> 
> 
> I did that here too, and I believe mbligh has as well.
> 
I got side tracked by a customer with money :)  The fold is fine with me, but I 
would like to know what went in.

By the way, in my looking at the network link stuff, I started wondering if it 
could not be done without modifying the card stuff.  Here is what I see:

The poll routine just calls the interrupt handler.  We only need the address of 
that routine and a generic poll function to do the indirect call.  That address, 
once the link is up, can be found in the interrupt tables using the irq.

I haven't looked in detail at where we might find the address earlier, but I 
suspect it may be possible.

There is an issue around when we can start talking to gdb.  I am not sure when 
the net cards are initialized, but it is after memory is available from the slab 
manager.  I am not sure what else needs to be up, need help here.  I keep 
finding myself wondering about a small memory manager to allow the network card 
to come up a bit sooner (like first C code).

We would also need to arrange to have the needed network parameters at that 
time, but we can do this using the CONFIG stuff, then override with command line 
if that is desired.

Thoughts and hints are welcome.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

