Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131276AbRDQKXH>; Tue, 17 Apr 2001 06:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131348AbRDQKW6>; Tue, 17 Apr 2001 06:22:58 -0400
Received: from CPE-61-9-150-66.vic.bigpond.net.au ([61.9.150.66]:2827 "EHLO
	mozart") by vger.kernel.org with ESMTP id <S131276AbRDQKWy>;
	Tue, 17 Apr 2001 06:22:54 -0400
Message-Id: <m14nIRX-001RovC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: npollitt@engr.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process pinning 
In-Reply-To: Your message of "Mon, 09 Apr 2001 17:08:23 MST."
             <20010409170823.C2316@engr.sgi.com> 
Date: Wed, 11 Apr 2001 21:05:47 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20010409170823.C2316@engr.sgi.com> you write:
> Changes to array.c expose cpus_allowed in proc/pid/stat.  

Call me old fashioned, but I prefer my bitmasks in hex.

Please also consider changing:

still_running:
	c = goodness(prev, this_cpu, prev->active_mm);
	next = prev;

to:

still_running:
	if (prev & (1 << this_cpu)) {
		c = goodness(prev, this_cpu, prev->active_mm);
		next = prev;
	}

Otherwise, you will keep scheduling a RT process forever on a
disallowed CPU on which it is already running.  And even a non-RT
process will stick on its disallowed CPU as long as nothing else runs
there.

Learnt this the hard way from the hotplug CPU patch...
Rusty.
--
Premature optmztion is rt of all evl. --DK
