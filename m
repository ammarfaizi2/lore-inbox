Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWJRQcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWJRQcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWJRQcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:32:03 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:3089 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422643AbWJRQb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:31:59 -0400
Subject: [PATCH-mm] remove incorrect warning in kernel/timer.c:688
From: Carsten Otte <cotte@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 18 Oct 2006 18:31:55 +0200
Message-Id: <1161189115.5880.6.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

the following patch in your broken-out series produces an incorrect
warning on s390:
dynticks-extend-next_timer_interrupt-to-use-a-reference-jiffie.patch

I get plenty of those on my syslog with 2.6.19-rc2-mm1:
Oct 18 17:13:19 t6360021 klogd: BUG: warning at kernel/timer.c:688/__next_timer_interrupt()
Oct 18 17:13:19 t6360021 klogd: 0000000000103502 000000001ff8dc20 0000000000000002 0000000000000000
Oct 18 17:13:19 t6360021 klogd:        000000001ff8dcc0 000000001ff8dc38 000000001ff8dc38 0000000000103574
Oct 18 17:13:19 t6360021 klogd:        0000000000000000 0000000000000000 0000000000000000 0000000000000000
Oct 18 17:13:19 t6360021 klogd:        000000001ff8dc20 000000000000000c 000000001ff8dc20 000000001ff8dc90
Oct 18 17:13:19 t6360021 klogd:        00000000004221e8 0000000000103574 000000001ff8dc20 000000001ff8dc70
Oct 18 17:13:19 t6360021 klogd: Call Trace:
Oct 18 17:13:19 t6360021 klogd: ([<0000000000103502>] show_trace+0x166/0x16c)
Oct 18 17:13:19 t6360021 klogd:  [<00000000001035ce>] show_stack+0xc6/0xf8
Oct 18 17:13:19 t6360021 klogd:  [<000000000010362e>] dump_stack+0x2e/0x3c
Oct 18 17:13:19 t6360021 klogd:  [<0000000000137104>] __next_timer_interrupt+0x13c/0x270
Oct 18 17:13:19 t6360021 klogd:  [<00000000001372da>] next_timer_interrupt+0xa2/0x124
Oct 18 17:13:19 t6360021 klogd:  [<0000000000105568>] nohz_idle_notify+0x17c/0x244
Oct 18 17:13:19 t6360021 klogd:  [<000000000041ce4c>] notifier_call_chain+0x64/0x88
Oct 18 17:13:19 t6360021 klogd:  [<000000000041ceb0>] atomic_notifier_call_chain+0x40/0x8c
Oct 18 17:13:19 t6360021 klogd:  [<0000000000105dde>] cpu_idle+0x82/0x1fc
Oct 18 17:13:19 t6360021 klogd:  [<0000000000110104>] start_secondary+0xb0/0xc4
Oct 18 17:13:19 t6360021 klogd:  [<0000000000000000>] 0x0
Oct 18 17:13:19 t6360021 klogd:  [<0000000000000000>] 0x0

Problem is, that the warning assumes that there are always pending timer
events on a system when a CPU is going idle. But this is not true in
general, the system may be waiting for an I/O interruption, or the CPU
may wait for an interprocessor signal.
The patch below removes the warning, please apply.

Signed-off-by: Carsten Otte <cotte@de.ibm.com>

---
diff -ruN linux-2.6.19-rc2-mm1/kernel/timer.c linux-2.6.19-rc2-mm1-fixed/kernel/timer.c
--- linux-2.6.19-rc2-mm1/kernel/timer.c 2006-10-18 18:14:26.000000000 +0200
+++ linux-2.6.19-rc2-mm1-fixed/kernel/timer.c   2006-10-18 18:18:02.000000000 +0200
@@ -685,7 +685,6 @@
                        }
                }
        }
-       WARN_ON(!found);

        return expires;
 }


