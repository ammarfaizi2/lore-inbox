Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317205AbSEXQG2>; Fri, 24 May 2002 12:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317198AbSEXQF4>; Fri, 24 May 2002 12:05:56 -0400
Received: from jalon.able.es ([212.97.163.2]:33216 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S317181AbSEXQDw>;
	Fri, 24 May 2002 12:03:52 -0400
Date: Fri, 24 May 2002 18:02:23 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Robert Love <rml@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] updated O(1) scheduler for 2.4
Message-ID: <20020524160223.GA1761@werewolf.able.es>
In-Reply-To: <1021939600.967.5.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.21 Robert Love wrote:
>Updated versions of the O(1) scheduler for 2.4 are available at:
>
>http://www.kernel.org/pub/linux/kernel/people/rml/sched/ingo-O1/sched-O1-rml-2.4.18-4.patch
>http://www.kernel.org/pub/linux/kernel/people/rml/sched/ingo-O1/sched-O1-rml-2.4.19-pre8-1.patch
>
>for 2.4.18 and 2.4.19-pre8.  Please use a mirror.
>
>These patches include all included and pending bits from 2.4-ac and 2.5
>as well as my user-configurable maximum RT priority patch.  This is more
>up-to-date than any other tree, in fact. ;-)
>

I had to make this to get it built:

diff -urN linux-2.4.19-pre7/init/do_mounts.c linux/init/do_mounts.c
--- linux-2.4.19-pre7/init/do_mounts.c	Sat Apr 20 20:50:36 2002
+++ linux/init/do_mounts.c	Mon Apr 22 14:18:20 2002
@@ -774,10 +774,8 @@
 
 	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
-		while (pid != wait(&i)) {
-			current->policy |= SCHED_YIELD;
-			schedule();
-		}
+		while (pid != wait(&i))
+			yield();
 	}
 
 	sys_mount("..", ".", NULL, MS_MOVE, NULL);
diff -urN linux-2.4.19-pre7/arch/m68k/mm/fault.c linux/arch/m68k/mm/fault.c
--- linux-2.4.19-pre7/arch/m68k/mm/fault.c	Sat Apr 20 20:50:47 2002
+++ linux/arch/m68k/mm/fault.c	Mon Apr 22 14:19:29 2002
@@ -181,8 +181,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (current->pid == 1) {
-		current->policy |= SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre7/arch/mips/mm/fault.c linux/arch/mips/mm/fault.c
--- linux-2.4.19-pre7/arch/mips/mm/fault.c	Sat Apr 20 20:50:46 2002
+++ linux/arch/mips/mm/fault.c	Mon Apr 22 14:19:15 2002
@@ -211,8 +211,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (tsk->pid == 1) {
-		tsk->policy |= SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre7/arch/mips64/mm/fault.c linux/arch/mips64/mm/fault.c
--- linux-2.4.19-pre7/arch/mips64/mm/fault.c	Sat Apr 20 20:50:47 2002
+++ linux/arch/mips64/mm/fault.c	Mon Apr 22 14:19:55 2002
@@ -240,8 +240,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (tsk->pid == 1) {
-		tsk->policy |= SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}


and this to shut up gcc-3.1 about trying to EXPORT_ or use something undeclared:

--- linux-2.4.19-pre8-jam4/include/linux/sched.h.orig	2002-05-24 16:56:16.000000000 +0200
+++ linux-2.4.19-pre8-jam4/include/linux/sched.h	2002-05-24 17:02:12.000000000 +0200
@@ -644,6 +644,8 @@
 extern void FASTCALL(interruptible_sleep_on(wait_queue_head_t *q));
 extern long FASTCALL(interruptible_sleep_on_timeout(wait_queue_head_t *q,
 						    signed long timeout));
+extern int FASTCALL(wake_up_process(task_t * p));
+extern void FASTCALL(wake_up_forked_process(task_t * p));
 
 #define wake_up(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1)
 #define wake_up_nr(x, nr)		__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr)


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam4 #4 SMP vie may 24 17:02:32 CEST 2002 i686
