Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275973AbRKHQgX>; Thu, 8 Nov 2001 11:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276094AbRKHQgN>; Thu, 8 Nov 2001 11:36:13 -0500
Received: from mmohlmann.demon.nl ([212.238.27.16]:29448 "HELO
	brand.mmohlmann.demon.nl") by vger.kernel.org with SMTP
	id <S275973AbRKHQgE>; Thu, 8 Nov 2001 11:36:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Mathijs Mohlmann <mathijs@knoware.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: why reschedule a disabled tasklet?
Date: Thu, 8 Nov 2001 17:36:08 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011108163552.B7B0B231A4@brand.mmohlmann.demon.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi all,

	Attached is a patch i use to get my sparc LX to boot (against 2.4.14). 
Without it the SUN does not work. I'm not sure if this is the right way to 
fix it, but i fail to see way softirq should be raised again if there are no 
enabled  tasklets left. Am i missing anything?

	The SUN got in a deadlock. The schedule() function didn't return
execution to spawn_ksoftirqd, because ksoftirqd kept on doing do_softirqd to 
handle a disabled tasklet (sun_kbd_bh).

	Both my i386 and sun4m seem to run stable with this patch.

	me



diff -ruN linux-2.4.14/kernel/softirq.c linux/kernel/softirq.c
--- linux-2.4.14/kernel/softirq.c	Thu Nov  8 15:58:24 2001
+++ linux/kernel/softirq.c	Thu Nov  8 15:59:40 2001
@@ -193,10 +193,9 @@
 				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
 					BUG();
 				t->func(t->data);
-				tasklet_unlock(t);
-				continue;
 			}
 			tasklet_unlock(t);
+			continue;
 		}
 
 		local_irq_disable();
