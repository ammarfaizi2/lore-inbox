Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbTAFCXl>; Sun, 5 Jan 2003 21:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbTAFCXl>; Sun, 5 Jan 2003 21:23:41 -0500
Received: from franka.aracnet.com ([216.99.193.44]:37834 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265705AbTAFCXk>; Sun, 5 Jan 2003 21:23:40 -0500
Date: Sun, 05 Jan 2003 18:32:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Timer interrupt cleanups [0/3]
Message-ID: <194400000.1041820329@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I tested these on the NUMA-Q and they seem to work.
Basically (as discussed previously) they rename the stuff off
the global timer to global_timer_* and the stuff off the
local timer to local_timer_*. Then I tried to clean up the
cross-calling ifdef madness. There are various corner cases,
so it's possible I screwed something up, but I think it's OK.

Original calling graph looked like this, I'll update this for
each patch to show what happens. Feel free to flame me, everyone.

--------------------

Assuming we're SMP with a local apic timer all firing away:

timer_interrupt
	do_timer_interrupt
		{ack the interrupt}
		do_timer_interrupt_hook
			do_timer
				jiffies_64++;
				update_times
		{update CMOS clock}    (In the interrupt still ??!!)

apic_timer_interrupt
	smp_apic_timer_interrupt
		{ack the interrupt}
		smp_local_timer_interrupt
			x86_do_profile
			update_process_times

--------------------

On UP with local apic timer:

timer_interrupt
	do_timer_interrupt
		{ack the interrupt}
		do_timer_interrupt_hook
			do_timer
				jiffies_64++;
				update_process_times
				update_times
		{update CMOS clock}    (In the interrupt still ??!!)

apic_timer_interrupt
	smp_apic_timer_interrupt
		{ack the interrupt}
		smp_local_timer_interrupt
			x86_do_profile

--------------------

On a UP 386 with stale crusty breadcrumbs, and no local timer:
	
timer_interrupt
	do_timer_interrupt
		{ack the interrupt}
		do_timer_interrupt_hook
			do_timer
				jiffies_64++;
				update_process_times
				update_times
			x86_do_profile()
		{update CMOS clock}    (In the interrupt still ??!!)

--------------------

