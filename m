Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTGBIGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 04:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264806AbTGBIGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 04:06:40 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:9808 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S263945AbTGBIGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 04:06:32 -0400
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Washing suspend code
From: <ffrederick@prov-liege.be>
Date: Wed, 2 Jul 2003 10:43:11 CEST
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S263945AbTGBIGc/20030702080632Z+4079@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-replacing INTERESTING macro by touchable_process fx
-moving flags declaration fx global
-yield after 'time_after'
-some code washing
-removing 'lock comment' we already do the read_lock() on tasklist


--- linux-2.5.73/kernel/suspend.c	2003-06-22 20:32:38.000000000 +0200
+++ edited/kernel/suspend.c	2003-07-02 10:07:44.000000000 +0200
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
@@ -164,15 +167,6 @@ static const char name_resume[] = "Resum
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
@@ -197,12 +191,20 @@ void refrigerator(unsigned long flag)
 	PRINTK("%s left refrigerator\n", current->comm);
 	current->state = save;
 }
+int touchable_process (struct task_struct *p)
+{
+	return(!((p->flags & PF_IOTHREAD) || (p == current) || (p->state == TASK_ZOMBIE)))
+
+}
 
-/* 0 = success, else # of processes that we failed to stop */
+/* Trying to freeze all processes without kernel threads, zombies and current 
+ * Returns 0 : Success
+ *         # : 
+ */
 int freeze_processes(void)
 {
-       int todo;
-       unsigned long start_time;
+	int todo;
+	unsigned long start_time, flags;
 	struct task_struct *g, *p;
 	
 	printk( "Stopping tasks: " );
@@ -211,26 +213,23 @@ int freeze_processes(void)
 		todo = 0;
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
-			unsigned long flags;
-			INTERESTING(p);
-			if (p->flags & PF_FROZEN)
-				continue;
-
-			/* FIXME: smp problem here: we may not access other process' flags
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
+				spin_lock_irqsave(&p->sighand->siglock, flags);
+				signal_wake_up(p, 0);
+				spin_unlock_irqrestore(&p->sighand->siglock, flags);
+				todo++;
+			}
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
-		yield();			/* Yield is okay here */
 		if (time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
 			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
 			return todo;
 		}
+		yield();
 	} while(todo);
 	
 	printk( "|\n" );
@@ -245,12 +244,13 @@ void thaw_processes(void)
 	printk( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
-		INTERESTING(p);
-		
-		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
-		else
-			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
-		wake_up_process(p);
+		if(touchable_process(p)){
+			if (p->flags & PF_FROZEN) 
+				p->flags &= ~PF_FROZEN;
+			else
+				printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
+			wake_up_process(p);
+		}
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);


___________________________________



