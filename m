Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVBTVxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVBTVxX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 16:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVBTVxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 16:53:23 -0500
Received: from mailfe06.swip.net ([212.247.154.161]:62403 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261932AbVBTVxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 16:53:18 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: Re: 2.6.11-rc3-mm2: lockup in sys_timer_settime
From: Alexander Nyberg <alexn@dsv.su.se>
To: roland@redhat.com
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <421704B3.20500@goop.org>
References: <421704B3.20500@goop.org>
Content-Type: text/plain
Date: Sun, 20 Feb 2005 22:53:01 +0100
Message-Id: <1108936381.2272.20.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When running a Posix conformance test (from posixtestsuite), the kernel
> locks up with:
> 
> BUG: soft lockup detected on CPU#0
> 
> Pid:  1873, comm: 10-1.test
> EIP: 0060:[<c0126fda>] CPU: 0
> EIP is at sys_timer_settime+0xfa+0x1f0
>  EFLAGS: 00000282  Not tainted (2.6.11-rc3-mm2)
> EAX: 00000282 EBX: 00000001 ECX: ffffffff EDX: 00000000
> ESI: 00000000 EDI: 00000000 EBP: f17eafbc DS: 007b ES: 007b
> CR0: 8005003b CR2: b7fac1f0 CR3: 311b3000 CR4: 000006d0
> 
> in test conformance/interfaces/timer_create/10-1.c (attached).
> 
> It doesn't lockup with 2.6.11-rc4; I notice the rc3-mm2 has a lot of
> Posix-timer related changes.

Hi Roland

The problem arises from code touching the union in alloc_posix_timer() 
which makes firing go non-zero. When firing is checked in posix_cpu_timer_set()
it will be positive causing an infinite loop.

So either the below fix or preferably move the INIT_LIST_HEAD(x) from alloc_posix_timer()
to somewhere later where it doesn't disturb the other union members.


Index: linux-2.6.10/kernel/posix-cpu-timers.c
===================================================================
--- linux-2.6.10.orig/kernel/posix-cpu-timers.c	2005-02-20 22:23:30.000000000 +0100
+++ linux-2.6.10/kernel/posix-cpu-timers.c	2005-02-20 22:27:03.000000000 +0100
@@ -323,6 +323,7 @@
 	INIT_LIST_HEAD(&new_timer->it.cpu.entry);
 	new_timer->it.cpu.incr.sched = 0;
 	new_timer->it.cpu.expires.sched = 0;
+	new_timer->it.cpu.firing = 0;
 
 	read_lock(&tasklist_lock);
 	if (CPUCLOCK_PERTHREAD(new_timer->it_clock)) {


