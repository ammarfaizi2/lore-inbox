Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbTBQID7>; Mon, 17 Feb 2003 03:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbTBQID7>; Mon, 17 Feb 2003 03:03:59 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:13214
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266917AbTBQID6>; Mon, 17 Feb 2003 03:03:58 -0500
Date: Mon, 17 Feb 2003 03:12:22 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH][2.5] Don't schedule tasks on offline cpus
Message-ID: <Pine.LNX.4.50.0302170244440.18087-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to allow a cpu going offline to keep doing scheduler work so 
let it exit early, otherwise we'd keep pulling in tasks every timer tick.

diff -u -r1.1.1.1 sched.c
--- linux-2.5.61-trojan/kernel/sched.c	15 Feb 2003 12:32:44 -0000	1.1.1.1
+++ linux-2.5.61-trojan/kernel/sched.c	15 Feb 2003 16:04:51 -0000
@@ -939,6 +948,11 @@
 	struct list_head *head, *curr;
 	task_t *tmp;
 
+	/* CPU going down is a special case: we don't pull more tasks
+	   onboard */
+	if (unlikely(!cpu_online(this_cpu)))
+		goto out;
+
 	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance,
 					cpus_to_balance(this_cpu, this_rq));
 	if (!busiest)
