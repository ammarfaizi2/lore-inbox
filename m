Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267367AbTBNULU>; Fri, 14 Feb 2003 15:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267390AbTBNULU>; Fri, 14 Feb 2003 15:11:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60680 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267367AbTBNULS>; Fri, 14 Feb 2003 15:11:18 -0500
Date: Fri, 14 Feb 2003 20:21:10 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: RFC/CFT 1/1: SIGWINCH - behaviour change
Message-ID: <20030214202110.G14659@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I keep on tripping over an annoying "feature" of our tty layer - if
you have a session running with multiple jobs (eg, three ssh sessions)
and you resize the window, SIGWINCH is only sent to the foreground
process, be it the shell, or one of the ssh sessions.

This means if you perform the following actions in order:

- open window.
- start two telnet sessions, suspending the first.
- resize the window.

the active telnet session gets the right terminal size on the remote
pty, and is reflected under bash.

- suspend the current telnet, resume the first session.

this session has the wrong terminal size on the remote pty because
the telnet process didn't get the SIGWINCH.

openssh doesn't seem to suffer from this because it always checks
the window size after resuming; I guess someone reported it as a
bug against openssh.

A similar thing happens when bash isn't running in the foreground
either; however since bash neither automatically check the window
size when commands complete nor listens for SIGWINCH during command
execution, this patch doesn't solve this problem.  I believe there
is an option which can be set to correct this though.

POSIX doesn't appear to specify to which processes SIGWINCH is
sent, so here's a patch which sends SIGWINCH to the session rather
than the process group.

Comments?  Should bash and telnet be fixed (if we care about telnet
anymore)?

--- orig/drivers/char/tty_io.c	Fri Feb 14 16:31:25 2003
+++ linux/drivers/char/tty_io.c	Fri Feb 14 19:57:52 2003
@@ -1503,10 +1503,17 @@
 	return 0;
 }
 
+/*
+ * In the case of pty's, "tty" is the master side
+ * and "real_tty" is the slave side.
+ */
 static int tiocswinsz(struct tty_struct *tty, struct tty_struct *real_tty,
 	struct winsize * arg)
 {
 	struct winsize tmp_ws;
+	struct task_struct *p;
+	struct list_head *l;
+	struct pid *pid;
 
 	if (copy_from_user(&tmp_ws, arg, sizeof(*arg)))
 		return -EFAULT;
@@ -1521,8 +1528,21 @@
 #endif
 	if (tty->pgrp > 0)
 		kill_pg(tty->pgrp, SIGWINCH, 1);
-	if ((real_tty->pgrp != tty->pgrp) && (real_tty->pgrp > 0))
-		kill_pg(real_tty->pgrp, SIGWINCH, 1);
+
+	/*
+	 * Send SIGWINCH to the whole session on the slave tty.
+	 * However, in the case of slave pty's, be careful not
+	 * to send two SIGWINCH to the same process group.
+	 */
+	if (real_tty->session > 0) {
+		read_lock(&tasklist_lock);
+		for_each_task_pid(real_tty->session, PIDTYPE_SID, p, l, pid) {
+			if (p->pgrp != tty->pgrp)
+				group_send_sig_info(SIGWINCH, (void *)1L, p);
+		}
+		read_unlock(&tasklist_lock);
+	}
+
 	tty->winsize = tmp_ws;
 	real_tty->winsize = tmp_ws;
 	return 0;

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

