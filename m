Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272336AbTHEAyX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 20:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272335AbTHEAyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 20:54:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:24798 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272333AbTHEAxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 20:53:48 -0400
Date: Mon, 4 Aug 2003 17:58:40 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Fix up refrigerator to work with ^Z-ed processes
In-Reply-To: <20030726225115.GA501@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0308041756080.23977-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> This makes refrigerator work with ^Z-ed processes (and not eat
> disks). Thanks to (have to find out who, I should sleep and not be
> splitting patches). [Hand edited, apply by hand; or there should be
> script for recomputing @@ X,Y Z,T @@'s somewhere].
> 
> schedule() added makes processes start at exactly that point, making
> printouts nicer.

This didn't apply, so in making the changes by hand, I took the liberty to 
rename interesting_process() to freezeable() to make it a bit easier to 
read. Revised patch below. 


	-pat

ChangeSet 1.1516, 2003/08/04 16:08:22-07:00, mochel@osdl.org

[power] Fix up refrigerator to work with ^Z-ed processes

Originally from Pavel Machek: 

schedule() added makes processes start at exactly that point, making
printouts nicer.


 kernel/power/process.c |   35 +++++++++++++++++++++--------------
 1 files changed, 21 insertions(+), 14 deletions(-)


diff -Nru a/kernel/power/process.c b/kernel/power/process.c
--- a/kernel/power/process.c	Mon Aug  4 17:45:10 2003
+++ b/kernel/power/process.c	Mon Aug  4 17:45:10 2003
@@ -23,14 +23,16 @@
  */
 #define TIMEOUT	(6 * HZ)
 
-#define INTERESTING(p) \
-			/* We don't want to touch kernel_threads..*/ \
-			if (p->flags & PF_IOTHREAD) \
-				continue; \
-			if (p == current) \
-				continue; \
-			if (p->state == TASK_ZOMBIE) \
-				continue;
+
+static inline int freezeable(struct task_struct * p)
+{
+	if ((p == current) || 
+	    (p->flags & PF_IOTHREAD) || 
+	    (p->state == TASK_ZOMBIE) ||
+	    (p->state == TASK_DEAD))
+		return 0;
+	return 1;
+}
 
 /* Refrigerator is place where frozen processes are stored :-). */
 void refrigerator(unsigned long flag)
@@ -71,8 +73,10 @@
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			unsigned long flags;
-			INTERESTING(p);
-			if (p->flags & PF_FROZEN)
+			if (!freezeable(p))
+				continue;
+			if ((p->flags & PF_FROZEN) ||
+			    (p->state == TASK_STOPPED))
 				continue;
 
 			/* FIXME: smp problem here: we may not access other process' flags
@@ -104,15 +108,18 @@
 	printk( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
-		INTERESTING(p);
-		
-		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
-		else
+		if (!freezeable(p))
+			continue;
+		if (p->flags & PF_FROZEN) {
+			p->flags &= ~PF_FROZEN;
+			wake_up_process(p);
+		} else
 			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
 		wake_up_process(p);
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
+	schedule();
 	printk( " done\n" );
 	MDELAY(500);
 }

