Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTLLJex (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 04:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbTLLJex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 04:34:53 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:26051 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264515AbTLLJev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 04:34:51 -0500
Date: Fri, 12 Dec 2003 10:34:24 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Ken <ken@nova.org>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [2.4][PATCH] Xeon HT - SMT+SMP interrupt balancing
Message-ID: <20031212093424.GA12446@devserv.devel.redhat.com>
References: <3FD89EF5.30101@nova.org> <1071161984.5219.4.camel@laptop.fenrus.com> <3FD94681.3090008@nova.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD94681.3090008@nova.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 11:39:29PM -0500, Ken wrote:
> Arjan van de Ven wrote:
> >1) This got fixed in version 0.07

> 	So, the timer now migrates, but IRQ 24 isn't even shared by the 
> sibling, let alone the other "pair".  Well, all these interfaces are 
> GigE -- 2 fiber, 2 copper -- so, I re-classified "eth" as GIGE and 
> didn't see any improvement; however, if I follow your policy correctly, 
> shouldn't the sibling get some usage in either case?

No. Ethernet (and esp gigabit) has significant performance benefits from
being (and staying) on one cpu. What matters are lots of cacheline bounces,
and (even worse) packet(fragment) reordering that can happen if it moves around.


> 
> 	In any case, I consider the above behavior undesirable over time. 
> 	CPU0 is handling most of the system while CPU1 contributes little.   For 
> example, this snapshot:
> top - 23:11:16 up 12 min,  1 user,  load average: 0.26, 0.35, 0.19
> Tasks:  49 total,   3 running,  46 sleeping,   0 stopped,   0 zombie
> Cpu0 :   0.8% user,  34.8% system,   0.0% nice,  64.4% idle
> Cpu1 :   0.0% user,   0.0% system,   0.0% nice, 100.0% idle
> Cpu2 :  15.5% user,   4.1% system,   0.0% nice,  80.5% idle
> Cpu3 :   6.7% user,   2.4% system,   0.0% nice,  90.9% idle

your machine is very very idle. Also remember that with modern machines,
even if a machine is 0% you probably can keep adding load to it for a while,
because then you are increasing "batching" which is very very cache
efficient operation, with the current differences between L1/L2 cache speed
and main memory speed it's not unlikely you can do 2x or 3x more work than
you do the moment idle hits 0%. 


> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  0  0      0 1569184   5708  36728    0    0     0     0 14560 23163  6 10 84  0
>  0  0      0 1569184   5708  36728    0    0     0     0 14284 23734  8 11 81  0

this is a sign you may want to enable IRQ mitigation in your network
driver to increase batching (unless your application is very latency bound)


Greetings,
    Arjan van de Ven
