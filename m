Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVISDPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVISDPj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 23:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVISDPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 23:15:38 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:1230 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932304AbVISDPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 23:15:38 -0400
Subject: PATCH: Fix race in cpu_down (hotplug cpu)
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1127099735.9696.54.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 19 Sep 2005 13:15:36 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

There is a race condition in taking down a cpu (kernel/cpu.c::cpu_down).
A cpu can already be idling when we clear its online flag, and we do not
force the idle task to reschedule. This results in __cpu_die timing out.
A simple fix is to force the idle task on the cpu going to reschedule.

Without the patch below, Suspend2 get into a deadlock at resume time
when this issue occurs. I could not complete 20 cycles without seeing
the issue. With the patch below, I have completed 75 cycles on the trot
without problems.

Please apply.

Signed-off-by: Nigel Cunningham <ncunningham@cyclades.com>

diff -ruNp 9910-hotplug-cpu-race.patch-old/kernel/cpu.c 9910-hotplug-cpu-race.patch-new/kernel/cpu.c
--- 9910-hotplug-cpu-race.patch-old/kernel/cpu.c	2005-08-29 10:29:58.000000000 +1000
+++ 9910-hotplug-cpu-race.patch-new/kernel/cpu.c	2005-09-19 12:15:08.000000000 +1000
@@ -126,6 +126,9 @@ int cpu_down(unsigned int cpu)
 	while (!idle_cpu(cpu))
 		yield();
 
+	/* CPU may have idled before we set its offline flag. */
+	set_tsk_need_resched(idle_task(cpu));
+
 	/* This actually kills the CPU. */
 	__cpu_die(cpu);
 



