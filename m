Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWDMPHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWDMPHa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 11:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWDMPHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 11:07:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6277 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750836AbWDMPH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 11:07:29 -0400
Date: Thu, 13 Apr 2006 16:07:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pids: simplify do_each_task_pid/while_each_task_pid
Message-ID: <20060413150722.GA5217@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
References: <20060413163727.GA1365@oleg> <20060413133814.GA29914@infradead.org> <20060413175431.GA108@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413175431.GA108@oleg>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 09:54:31PM +0400, Oleg Nesterov wrote:
> > 
> > #define for_each_task_pid(task, pid, type, pos) \
> > 	hlist_for_each_entry_rcu((task), (pos),  \
> > 		(&(pid))->tasks[type], pids[type].node) {
> > 
> > and move the find_pid to the caller?  That would make the code a whole lot
> > more readable.
> 
> Then the caller should check find_pid() doesn't return NULL. But yes,
> we can hide this check inside for_each_task_pid().
> 
> But what about current users of do_each_task_pid ? We can't just remove
> these macros.

They'd have to switch over to the new variant.  There's just 18 callers
ayway, currently, and with a patch like the one below that number firther
decreases :)


Index: linux-2.6/drivers/char/tty_io.c
===================================================================
--- linux-2.6.orig/drivers/char/tty_io.c	2006-04-13 16:22:12.000000000 +0200
+++ linux-2.6/drivers/char/tty_io.c	2006-04-13 16:39:57.000000000 +0200
@@ -1174,6 +1174,17 @@
 
 EXPORT_SYMBOL(tty_hung_up_p);
 
+static void clear_session_ttys(pid_t session)
+{
+	struct task_struct *p;
+
+	read_lock(&tasklist_lock);
+	do_each_task_pid(session, PIDTYPE_SID, p) {
+		p->signal->tty = NULL;
+	} while_each_task_pid(session, PIDTYPE_SID, p);
+	read_unlock(&tasklist_lock);
+}
+
 /*
  * This function is typically called only by the session leader, when
  * it wants to disassociate itself from its controlling tty.
@@ -1190,7 +1201,6 @@
 void disassociate_ctty(int on_exit)
 {
 	struct tty_struct *tty;
-	struct task_struct *p;
 	int tty_pgrp = -1;
 
 	lock_kernel();
@@ -1224,11 +1234,7 @@
 	tty->pgrp = -1;
 
 	/* Now clear signal->tty under the lock */
-	read_lock(&tasklist_lock);
-	do_each_task_pid(current->signal->session, PIDTYPE_SID, p) {
-		p->signal->tty = NULL;
-	} while_each_task_pid(current->signal->session, PIDTYPE_SID, p);
-	read_unlock(&tasklist_lock);
+	clear_session_ttys(current->signal->session);
 	mutex_unlock(&tty_mutex);
 	unlock_kernel();
 }
@@ -1927,17 +1933,9 @@
 	 * tty.
 	 */
 	if (tty_closing || o_tty_closing) {
-		struct task_struct *p;
-
-		read_lock(&tasklist_lock);
-		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
-			p->signal->tty = NULL;
-		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
+		clear_session_ttys(tty->session);
 		if (o_tty)
-			do_each_task_pid(o_tty->session, PIDTYPE_SID, p) {
-				p->signal->tty = NULL;
-			} while_each_task_pid(o_tty->session, PIDTYPE_SID, p);
-		read_unlock(&tasklist_lock);
+			clear_session_ttys(o_tty->session);
 	}
 
 	mutex_unlock(&tty_mutex);
@@ -2348,8 +2346,6 @@
 
 static int tiocsctty(struct tty_struct *tty, int arg)
 {
-	task_t *p;
-
 	if (current->signal->leader &&
 	    (current->signal->session == tty->session))
 		return 0;
@@ -2364,18 +2360,12 @@
 		 * This tty is already the controlling
 		 * tty for another session group!
 		 */
-		if ((arg == 1) && capable(CAP_SYS_ADMIN)) {
-			/*
-			 * Steal it away
-			 */
-
-			read_lock(&tasklist_lock);
-			do_each_task_pid(tty->session, PIDTYPE_SID, p) {
-				p->signal->tty = NULL;
-			} while_each_task_pid(tty->session, PIDTYPE_SID, p);
-			read_unlock(&tasklist_lock);
-		} else
+		if (arg != 1 || !capable(CAP_SYS_ADMIN))
 			return -EPERM;
+		/*
+		 * Steal it away
+		 */
+		clear_session_ttys(tty->session);
 	}
 	task_lock(current);
 	current->signal->tty = tty;

