Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVDBBni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVDBBni (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 20:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVDBBng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 20:43:36 -0500
Received: from 162.100.172.209.cust.nextweb.net ([209.172.100.162]:44640 "EHLO
	jlundell.local") by vger.kernel.org with ESMTP id S261646AbVDBBnd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 20:43:33 -0500
Mime-Version: 1.0
Message-Id: <p06230505be73a5c345c7@[10.2.3.6]>
Date: Fri, 1 Apr 2005 17:43:28 -0800
To: LKML <linux-kernel@vger.kernel.org>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: x86 TSC time warp puzzle
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, not actually a time warp, though it feels like one.

I'm doing some real-time bit-twiddling in a driver, using the TSC to 
measure out delays on the order of hundreds of nanoseconds. Because I 
want an upper limit on the delay, I disable interrupts around it.

The logic is something like:

	local_irq_save
	out(set a bit)
	t0 = TSC
	wait while (t = (TSC - t0)) < delay_time
	out(clear the bit)
	local_irq_restore

 From time to time, when I exit the delay, t is *much* bigger than 
delay_time. If delay_time is, say, 300ns, t is usually no more than 
325ns. But every so often, t can be 2000, or 10000, or even much 
higher.

The value of t seems to depend on the CPU involved, The worst case is 
with an Intel 915GV chipset, where t approaches 500 microseconds (!).

This is with ACPI and HT disabled, to avoid confounding interactions. 
I suspected NMI, of course, but I monitored the nmi counter, and 
mostly saw nothing (from time to time a random hit, but mostly not).

The longer delay is real. I can see the bit being set/cleared in the 
pseudocode above on a scope, and when the long delay happens, the bit 
is set for a correspondingly long time.

BTW, the symptom is independent of my IO. I wrote a test case that 
does diddles nothing but reading TSC, and get the same result.

Finally, on some CPUs, at least, the extra delay appears to be 
periodic. The 500us delay happens about every second. On a different 
machine (chipset) it happens at about 5 Hz. And the characteristic 
delay on each type of machine seems consistent.

Any ideas of where to look? Other lists to inquire on?

Thanks.
-- 
/Jonathan Lundell.
