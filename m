Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280806AbRKTARV>; Mon, 19 Nov 2001 19:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280810AbRKTARK>; Mon, 19 Nov 2001 19:17:10 -0500
Received: from smtp-ham-2.netsurf.de ([194.195.64.98]:60331 "EHLO
	smtp-ham-2.netsurf.de") by vger.kernel.org with ESMTP
	id <S280806AbRKTAQy>; Mon, 19 Nov 2001 19:16:54 -0500
Date: Tue, 20 Nov 2001 01:16:29 +0100
From: Andreas Bombe <bombe@informatik.tu-muenchen.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.2 keventd fix
Message-ID: <20011120011629.A11470@storm.local>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the 2.2 version of keventd flush_scheduled_tasks() always oopses.  It
adds a tq_struct with NULL routine to kick keventd to life which is
skipped by 2.4 run_task_queue() but the 2.2 one tries to execute it.

The following patch fixes that, I also added some spin locking from the
2.4 version which seems to be added after the backport.  (patch against
2.2.20)


--- linux-2.2.orig/kernel/context.c	Sun May 27 03:21:32 2001
+++ linux-2.2/kernel/context.c	Mon Nov 19 04:04:37 2001
@@ -101,8 +101,10 @@
 		if (signal_pending(curtask)) {
 			while (waitpid(-1, (unsigned int *)0, __WALL|WNOHANG) > 0)
 				;
+			spin_lock_irq(&curtask->sigmask_lock);
 			flush_signals(curtask);
 			recalc_sigpending(curtask);
+			spin_unlock_irq(&curtask->sigmask_lock);
 		}
 	}
 }
@@ -119,7 +121,8 @@
  * The caller should hold no spinlocks and should hold no semaphores which could
  * cause the scheduled tasks to block.
  */
-static struct tq_struct dummy_task;
+static void dummy_routine(void *whatever) {}
+static struct tq_struct dummy_task = { routine: dummy_routine };
 
 void flush_scheduled_tasks(void)
 {


-- 
Andreas Bombe <bombe@informatik.tu-muenchen.de>    DSA key 0x04880A44
