Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319099AbSIJLu0>; Tue, 10 Sep 2002 07:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319100AbSIJLu0>; Tue, 10 Sep 2002 07:50:26 -0400
Received: from robur.slu.se ([130.238.98.12]:18702 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S319099AbSIJLuZ>;
	Tue, 10 Sep 2002 07:50:25 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15741.57164.402952.136812@robur.slu.se>
Date: Tue, 10 Sep 2002 14:02:20 +0200
To: "David S. Miller" <davem@redhat.com>
Cc: manfred@colorfullife.com, haveblue@us.ibm.com, hadi@cyberus.ca,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
In-Reply-To: <20020906.123428.28085660.davem@redhat.com>
References: <3D78F55C.4020207@colorfullife.com>
	<20020906.113829.65591342.davem@redhat.com>
	<3D790499.8020501@colorfullife.com>
	<20020906.123428.28085660.davem@redhat.com>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Manfred Spraul:

>> But what if the backlog queue is empty all the time? Then NAPI thinks 
>> that the system is idle, and reenables the interrupts after each packet :-(

Yes and this happens even with without NAPI. Just set RxIntDelay=X and send 
pkts at >= X+1 interval.

>>   Dave, do you have interrupt rates from the clients with and without NAPI?

DaveM:
> Robert does.


Yes we get into this interesting discussion now... Since with NAPI we can 
safely use RxIntDelay=0 (e1000 terminologi). With the classical IRQ we simply 
had to add latency (RxIntDelay of 64-128 us common for GIGE) this just to 
survive at higher speeds  (GIGE max is 1.48 Mpps) and with the interrupt latency 
also comes higher network latencies... IMO this delay was a "work-around" 
for the old interrupt scheme.

So we now have the option of removing it... But we are trading less latency 
for for more interrupts. So yes Manfred is correct...

So is there a decent setting/compromise? 

Well first approximation is just to do just what DaveM suggested.
RxIntDelay=0. This solved many problems with buggy hardware and complicated 
tuning and RxIntDelay used to be combined with other mitigation parameters to 
compensate for different packets sizes etc. This leading to very "fragile" 
performance where a NIC could perform excellent w. single TCP stream but 
to be seriously broke in many other tests. So tuning to just one "test" 
can cause a lot of mis-tuning as well. 

Anyway. A tulip NAPI variant added mitigation when we reached "some load" to 
avoid the static interrupt delay. (Still keeping things pretty simple):
 
Load   "Mode"
-------------------
Lo  1) RxIntDelay=0
Mid 2) RxIntDelay=fix (When we had X pkts on the RX ring)
Hi  3) Consecutive polling. No RX interrupts.

Is it worth the effort? 

For SMP w/o affinity the delay could eventually reduce the cache bouncing 
since the packets becomes more "batched" at cost the of latency of course. 
We use RxIntDelay=0 for production use. (IP-forwarding on UP)

Cheers.

						--ro


