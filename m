Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285516AbSALJyc>; Sat, 12 Jan 2002 04:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285424AbSALJyX>; Sat, 12 Jan 2002 04:54:23 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:23680 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S285369AbSALJyG>;
	Sat, 12 Jan 2002 04:54:06 -0500
Message-Id: <m16PKqN-000OVeC@amadeus.home.nl>
Date: Sat, 12 Jan 2002 09:52:55 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: landley@trommello.org (Rob Landley)
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there> you wrote:

> The preempt patch is really "SMP on UP".

Ok I've seen this misconception quite a lot now. THIS IS NOT TRUE. For one,
constructs that are ok on SMP are not automatically ok with the -preempt
patch, like per-cpu data. And there's a LOT more of that than you think.
Basically with preempt you change the locking rules from under all existing
code. Most will work, even more will appear to work as preemption isn't
an event THAT common (by this I mean the chance of getting preempted in your
4 lines of C code where you have per cpu data).

Also, once you add locks around the  per-cpu data, for the core code it
might be close to smp. For drivers it's not though. Drivers assume that when
they do

outb(foo,bar);
outb(foo2,bar2);

that those happen "close" to eachother in time. Especially in initialisation
paths (where the driver thread is the only thread that can see the
datastructures/device) there's no spinlocks helt so preempt can trigger
here. Sure in the current situation you can get an interrupt but the linux
interrupt delay is not more than, say, 1ms while a schedule-out can take a
second or two easily. Do we know all devices can stand such delays ?
I dare to say we don't as the hardware requirements currently aren't coded
in the drivers.

Add to that that there's no actual benefit of -preempt over the -lowlat
patch latency wise (you REALLY need to combine them or -preempt sucks raw
eggs for latency)....

Greetings,
   Arjan van de Ven
