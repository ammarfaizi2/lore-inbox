Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263167AbRFMVjn>; Wed, 13 Jun 2001 17:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263886AbRFMVjd>; Wed, 13 Jun 2001 17:39:33 -0400
Received: from ppp72-5-72.miem.edu.ru ([194.226.32.72]:1796 "EHLO yahoo.com")
	by vger.kernel.org with ESMTP id <S263167AbRFMVjX>;
	Wed, 13 Jun 2001 17:39:23 -0400
From: Stas Sergeev <stas_orel@yahoo.com>
Reply-To: stas.orel@mailcity.com
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] do proper cleanups before requesting irq
Date: Thu, 14 Jun 2001 00:42:31 +0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: Pavel Machek <pavel@suse.cz>
In-Reply-To: <01061202405801.06615@localhost.localdomain> <20010612160643.B33@toy.ucw.cz>
In-Reply-To: <20010612160643.B33@toy.ucw.cz>
MIME-Version: 1.0
Message-Id: <01061401021400.03960@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > The problem is that there are comparisons of pointers to task_struct when
> > deciding if the task is alive. If one task dies and other one starts, it is
> > possible (is it?) that the task structure of the newly created task resides
> > at the very address where was the dead one's, so comparing pointers is not
> > reliable. This patch changes it to comparisons of task's pids.
> > Can anyone, please, atleast tell me if this patch is correct?
> it might be better but it is not correct. pids are reused, too
Many thanks for reply.
If everything can be reused then it seems that the correct approach is to do a
cleanup when the task terminates, not when other one tries to request an irq.
The following patch does exactly this.
Please, once again, is this correct now?

------------------------------------------------------
--- linux/arch/i386/kernel/irq.h	Fri May 12 21:38:59 2000
+++ linux/arch/i386/kernel/irq.h	Wed Jun 13 18:44:06 2001
@@ -85,6 +85,7 @@
 extern void init_IRQ_SMP(void);
 extern int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
 extern int setup_x86_irq(unsigned int, struct irqaction *);
+extern void release_x86_irqs(struct task_struct *);
 
 /*
  * Various low-level irq details needed by irq.c, process.c,
--- linux/arch/i386/kernel/process.c	Mon Dec 11 17:29:12 2000
+++ linux/arch/i386/kernel/process.c	Wed Jun 13 18:58:00 2001
@@ -544,6 +544,7 @@
 
 void release_thread(struct task_struct *dead_task)
 {
+    release_x86_irqs(dead_task);
 }
 
 /*
--- linux/arch/i386/kernel/vm86.c	Sat May  5 06:31:51 2001
+++ linux/arch/i386/kernel/vm86.c	Wed Jun 13 19:01:26 2001
@@ -618,6 +618,14 @@
 	}
 	read_unlock(&tasklist_lock);
 	return ret;
+}
+
+void release_x86_irqs(struct task_struct *task)
+{
+	int i;
+	for (i=3; i<16; i++)
+	    if (vm86_irqs[i].tsk == task)
+		free_vm86_irq(i);
 }
 
 static inline void handle_irq_zombies(void)
