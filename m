Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTGAOHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 10:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbTGAOHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 10:07:42 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:668 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S261292AbTGAOHf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 10:07:35 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B0140538A@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [Patch] suspend.c washing
Date: Tue, 1 Jul 2003 16:06:17 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Here's a patch against 2.5.73 suspend.If someone has some seconds to
loose...

		-replacing 'INTERESTING' macro by touchable_process fx
		-moving flags declaration fx global
		-yield after 'time_after'
		-some code washing		
		-removing 'lock comment' we already do the read_lock() on
tasklist

--- ./../../linux-2.5.73/kernel/suspend.c	2003-06-22
20:32:38.000000000 +0200
+++ suspend.c	2003-07-01 15:55:50.000000000 +0200
@@ -29,6 +29,9 @@
  * Alex Badea <vampire@go.ro>:
  * Fixed runaway init
  *
+ * Fabian Frédérick <ffrederick@users.sourceforge.net>
+ * Washing code in freeze_processes
+ * 
  * More state savers are welcome. Especially for the scsi layer...
  *
  * For TODOs,FIXMEs also look in Documentation/swsusp.txt
@@ -164,15 +167,6 @@
  * Refrigerator and related stuff
  */
 
-#define INTERESTING(p) \
-			/* We don't want to touch kernel_threads..*/ \
-			if (p->flags & PF_IOTHREAD) \
-				continue; \
-			if (p == current) \
-				continue; \
-			if (p->state == TASK_ZOMBIE) \
-				continue;
-
 /* Refrigerator is place where frozen processes are stored :-). */
 void refrigerator(unsigned long flag)
 {
@@ -197,12 +191,20 @@
 	PRINTK("%s left refrigerator\n", current->comm);
 	current->state = save;
 }
+int touchable_process (struct task_struct *p)
+{
+	return(!(p->flags & PF_IOTHREAD) || (p == current) || (p->state ==
TASK_ZOMBIE))
+
+}
 
-/* 0 = success, else # of processes that we failed to stop */
+/* Trying to freeze all processes without kernel threads, zombies and
current 
+ * Returns 0 : Success
+ *         # : Tasks we were unable to freeze 
+ */
 int freeze_processes(void)
 {
-       int todo;
-       unsigned long start_time;
+	int todo;
+	unsigned long start_time, flags;
 	struct task_struct *g, *p;
 	
 	printk( "Stopping tasks: " );
@@ -211,26 +213,23 @@
 		todo = 0;
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
-			unsigned long flags;
-			INTERESTING(p);
-			if (p->flags & PF_FROZEN)
-				continue;
-
-			/* FIXME: smp problem here: we may not access other
process' flags
-			   without locking */
-			p->flags |= PF_FREEZE;
-			spin_lock_irqsave(&p->sighand->siglock, flags);
-			signal_wake_up(p, 0);
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			todo++;
+			if(touchable_process(p)){
+				if (p->flags & PF_FROZEN)
+					continue;
+				p->flags |= PF_FREEZE;
+				spin_lock_irqsave(&p->sighand->siglock,
flags);
+				signal_wake_up(p, 0);
+				spin_unlock_irqrestore(&p->sighand->siglock,
flags);
+				todo++;
+			}
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
-		yield();			/* Yield is okay here */
 		if (time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
 			printk(KERN_ERR " stopping tasks failed (%d tasks
remaining)\n", todo );
 			return todo;
 		}
+		yield();
 	} while(todo);
 	
 	printk( "|\n" );
@@ -245,12 +244,13 @@
 	printk( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
-		INTERESTING(p);
-		
-		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
-		else
-			printk(KERN_INFO " Strange, %s not stopped\n",
p->comm );
-		wake_up_process(p);
+		if(touchable_process(p)){
+			if (p->flags & PF_FROZEN) 
+				p->flags &= ~PF_FROZEN;
+			else
+				printk(KERN_INFO " Strange, %s not
stopped\n", p->comm );
+			wake_up_process(p);
+		}
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);


