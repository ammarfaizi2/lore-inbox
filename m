Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266932AbSKKSQf>; Mon, 11 Nov 2002 13:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbSKKSQf>; Mon, 11 Nov 2002 13:16:35 -0500
Received: from crack.them.org ([65.125.64.184]:30731 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S266932AbSKKSQd>;
	Mon, 11 Nov 2002 13:16:33 -0500
Date: Mon, 11 Nov 2002 13:23:45 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: has_stopped_jobs update for debugging
Message-ID: <20021111182345.GA8205@nevyn.them.org>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

POSIX has this terribly useful thing to say:

# If the exit of the process causes a process group to become orphaned, and if
# any member of the newly-orphaned process group is stopped, then a SIGHUP
# signal followed by a SIGCONT signal shall be sent to each process in the
# newly-orphaned process group.

The Rationale is at least a little chattier.  See
  http://www.opengroup.org/onlinepubs/007904975/functions/exit.html#tag_03_131
if you want to read it.

Basically, this is so that a stopped process group won't unintentionally
stay stopped when its shell no longer has a connection to it.  For whatever
that's worth.

I think this patch is well within the spirit of that definition.  If a
process is stopped, but there is a debugger attached to it and the stopping
signal is not one that would normally stop the process, then don't count it
as a stopped job.  Without this, when you continue past a fork() call and
the parent quickly exits, the child will get an unaccountable SIGHUP.

It's not perfect, of course - the application might be SIG_IGN'ing SIGTSTP,
but stopped in the debugger for it anyway.  It's not worth being that
complicated here, though.

Linus, please apply.

===== exit.c 1.73 vs edited =====
--- 1.73/kernel/exit.c	Thu Oct 17 03:48:55 2002
+++ edited/exit.c	Mon Nov 11 11:35:22 2002
@@ -200,6 +200,17 @@
 	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
 		if (p->state != TASK_STOPPED)
 			continue;
+
+		/* If p is stopped by a debugger on a signal that won't
+		   stop it, then don't count p as stopped.  This isn't
+		   perfect but it's a good approximation.  */
+		if (unlikely (p->ptrace)
+		    && p->exit_code != SIGSTOP
+		    && p->exit_code != SIGTSTP
+		    && p->exit_code != SIGTTOU
+		    && p->exit_code != SIGTTIN)
+			continue;
+
 		retval = 1;
 		break;
 	}


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
