Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263000AbSJBIRS>; Wed, 2 Oct 2002 04:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263001AbSJBIRS>; Wed, 2 Oct 2002 04:17:18 -0400
Received: from angband.namesys.com ([212.16.7.85]:6330 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S263000AbSJBIRO>; Wed, 2 Oct 2002 04:17:14 -0400
Date: Wed, 2 Oct 2002 12:22:39 +0400
From: Oleg Drokin <green@namesys.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, jdike@karaya.com
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
Message-ID: <20021002122239.A25514@namesys.com>
References: <Pine.LNX.4.44.0210011653370.28821-102000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210011653370.28821-102000@localhost.localdomain>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Oct 01, 2002 at 06:24:50PM +0200, Ingo Molnar wrote:

> The pach converts roughly 80% of all tqueue-using code to workqueues - and
> all the places that are not converted to workqueues yet are places that do
> not compile in vanilla 2.5.40 anyway, due to unrelated changes. I've
> converted a fair number of drivers that do not compile in 2.5.40, and i
> think i've managed to convert every driver that compiles under 2.5.40.

Here are corresponding changes to UML code (that were not done by Ingo just
because this code cannot be compiled due to Makefile bug).

This patch is required to make UML compilable again in bk-current (after you
fix the Makefile, of course).
I tested the patch and UML works fine for me.

Bye,
    Oleg

===== arch/um/drivers/chan_kern.c 1.2 vs edited =====
--- 1.2/arch/um/drivers/chan_kern.c	Mon Sep 30 11:59:19 2002
+++ edited/arch/um/drivers/chan_kern.c	Wed Oct  2 12:08:57 2002
@@ -395,7 +395,7 @@
 	return(-1);
 }
 
-void chan_interrupt(struct list_head *chans, struct tq_struct *task,
+void chan_interrupt(struct list_head *chans, struct work_struct *task,
 		    struct tty_struct *tty, int irq, void *dev)
 {
 	struct list_head *ele, *next;
@@ -409,7 +409,7 @@
 		do {
 			if((tty != NULL) && 
 			   (tty->flip.count >= TTY_FLIPBUF_SIZE)){
-				schedule_task(task);
+				schedule_work(task);
 				goto out;
 			}
 			err = chan->ops->read(chan->fd, &c, chan->data);
===== arch/um/drivers/line.c 1.1 vs edited =====
--- 1.1/arch/um/drivers/line.c	Fri Sep  6 21:29:28 2002
+++ edited/arch/um/drivers/line.c	Wed Oct  2 12:02:14 2002
@@ -215,7 +215,7 @@
 			if(err) goto out;
 		}
 		enable_chan(&line->chan_list, line);
-		INIT_TQUEUE(&line->task, line_timer_cb, line);
+		INIT_WORK(&line->task, line_timer_cb, line);
 	}
 
 	if(!line->sigio){
===== arch/um/drivers/mconsole_kern.c 1.1 vs edited =====
--- 1.1/arch/um/drivers/mconsole_kern.c	Fri Sep  6 21:29:28 2002
+++ edited/arch/um/drivers/mconsole_kern.c	Wed Oct  2 12:06:54 2002
@@ -13,7 +13,7 @@
 #include "linux/ctype.h"
 #include "linux/interrupt.h"
 #include "linux/sysrq.h"
-#include "linux/tqueue.h"
+#include "linux/workqueue.h"
 #include "linux/module.h"
 #include "linux/proc_fs.h"
 #include "asm/irq.h"
@@ -42,7 +42,7 @@
 
 LIST_HEAD(mc_requests);
 
-void mc_task_proc(void *unused)
+void mc_work_proc(void *unused)
 {
 	struct mconsole_entry *req;
 	unsigned long flags;
@@ -60,10 +60,7 @@
 	} while(!done);
 }
 
-struct tq_struct mconsole_task = {
-	routine:	mc_task_proc,
-	data: 		NULL
-};
+DECLARE_WORK(mconsole_work, mc_work_proc, NULL);
 
 void mconsole_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
@@ -84,7 +81,7 @@
 			}
 		}
 	}
-	if(!list_empty(&mc_requests)) schedule_task(&mconsole_task);
+	if(!list_empty(&mc_requests)) schedule_work(&mconsole_work);
 	reactivate_fd(fd, MCONSOLE_IRQ);
 }
 
===== arch/um/include/chan_kern.h 1.1 vs edited =====
--- 1.1/arch/um/include/chan_kern.h	Fri Sep  6 21:29:28 2002
+++ edited/arch/um/include/chan_kern.h	Wed Oct  2 12:07:57 2002
@@ -22,7 +22,7 @@
 	void *data;
 };
 
-extern void chan_interrupt(struct list_head *chans, struct tq_struct *task,
+extern void chan_interrupt(struct list_head *chans, struct work_struct *task,
 			   struct tty_struct *tty, int irq, void *dev);
 extern int parse_chan_pair(char *str, struct list_head *chans, int pri, 
 			   int device, struct chan_opts *opts);
===== arch/um/include/line.h 1.1 vs edited =====
--- 1.1/arch/um/include/line.h	Fri Sep  6 21:29:28 2002
+++ edited/arch/um/include/line.h	Wed Oct  2 12:01:27 2002
@@ -7,7 +7,7 @@
 #define __LINE_H__
 
 #include "linux/list.h"
-#include "linux/tqueue.h"
+#include "linux/workqueue.h"
 #include "linux/tty.h"
 #include "asm/semaphore.h"
 #include "chan_user.h"
@@ -39,7 +39,7 @@
 	char *head;
 	char *tail;
 	int sigio;
-	struct tq_struct task;
+	struct work_struct task;
 	struct line_driver *driver;
 	int have_irq;
 };
