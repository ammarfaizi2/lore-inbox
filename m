Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbUCIXLX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 18:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbUCIXLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 18:11:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:52679 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262285AbUCIXJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 18:09:15 -0500
Date: Tue, 9 Mar 2004 15:11:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Philipp Baer <phbaer@npw.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel oops
Message-Id: <20040309151106.468cf467.akpm@osdl.org>
In-Reply-To: <404E41A7.80707@npw.net>
References: <404E41A7.80707@npw.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Baer <phbaer@npw.net> wrote:
>
> I have a strage problem with the kernel version 2.6.3. Whensoever
> chkrootkit is run, the following kernel oops is thrown:

Could you try this patch?


diff -puN drivers/char/tty_io.c~proc_pid_stat-oops-fix drivers/char/tty_io.c
--- 25/drivers/char/tty_io.c~proc_pid_stat-oops-fix	Tue Mar  9 15:10:12 2004
+++ 25-akpm/drivers/char/tty_io.c	Tue Mar  9 15:10:12 2004
@@ -481,12 +481,15 @@ void do_tty_hangup(void *data)
 	if (tty->session > 0) {
 		struct list_head *l;
 		for_each_task_pid(tty->session, PIDTYPE_SID, p, l, pid) {
-			if (p->tty == tty)
-				p->tty = NULL;
-			if (!p->leader)
-				continue;
-			send_group_sig_info(SIGHUP, SEND_SIG_PRIV, p);
-			send_group_sig_info(SIGCONT, SEND_SIG_PRIV, p);
+			task_t *task = p;
+			do {
+				if (task->tty == tty)
+					task->tty = NULL;
+				if (task->leader) {
+					send_group_sig_info(SIGHUP, SEND_SIG_PRIV, task);
+					send_group_sig_info(SIGCONT, SEND_SIG_PRIV, task);
+				}
+			} while_each_thread(p, task);
 			if (tty->pgrp > 0)
 				p->tty_old_pgrp = tty->pgrp;
 		}
@@ -591,8 +594,12 @@ void disassociate_ctty(int on_exit)
 	tty->pgrp = -1;
 
 	read_lock(&tasklist_lock);
-	for_each_task_pid(current->session, PIDTYPE_SID, p, l, pid)
-		p->tty = NULL;
+	for_each_task_pid(current->session, PIDTYPE_SID, p, l, pid) {
+		task_t *task = p;
+		do
+			task->tty = NULL;
+		while_each_thread(p, task);
+	}
 	read_unlock(&tasklist_lock);
 	unlock_kernel();
 }
@@ -1260,11 +1267,20 @@ static void release_dev(struct file * fi
 		struct pid *pid;
 
 		read_lock(&tasklist_lock);
-		for_each_task_pid(tty->session, PIDTYPE_SID, p, l, pid)
-			p->tty = NULL;
-		if (o_tty)
-			for_each_task_pid(o_tty->session, PIDTYPE_SID, p,l, pid)
-				p->tty = NULL;
+		for_each_task_pid(tty->session, PIDTYPE_SID, p, l, pid) {
+			task_t *task = p;
+			do
+				task->tty = NULL;
+			while_each_thread(p, task);
+		}
+		if (o_tty) {
+			for_each_task_pid(o_tty->session, PIDTYPE_SID, p,l, pid) {
+				task_t *task = p;
+				do
+					task->tty = NULL;
+				while_each_thread(p, task);
+			}
+		}
 		read_unlock(&tasklist_lock);
 	}
 
@@ -1615,8 +1631,12 @@ static int tiocsctty(struct tty_struct *
 			 */
 
 			read_lock(&tasklist_lock);
-			for_each_task_pid(tty->session, PIDTYPE_SID, p, l, pid)
-				p->tty = NULL;
+			for_each_task_pid(tty->session, PIDTYPE_SID, p, l, pid) {
+				task_t *task = p;
+				do
+					task->tty = NULL;
+				while_each_thread(p, task);
+			}
 			read_unlock(&tasklist_lock);
 		} else
 			return -EPERM;

_

