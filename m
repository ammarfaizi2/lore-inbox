Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267667AbTBFWbN>; Thu, 6 Feb 2003 17:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267668AbTBFWbN>; Thu, 6 Feb 2003 17:31:13 -0500
Received: from crack.them.org ([65.125.64.184]:10218 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267667AbTBFWbK>;
	Thu, 6 Feb 2003 17:31:10 -0500
Date: Thu, 6 Feb 2003 17:40:47 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Ptrace updates: has_stopped_jobs [1/5]
Message-ID: <20030206224047.GA22762@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <20030206223924.GA22688@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206223924.GA22688@nevyn.them.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted this patch a couple of weeks ago, here it is again.  The basic
problem it's solving is this: suppose you have GDB debugging an application,
using the new PTRACE_EVENT_FORK.  The application forks.  There can be a
point where GDB resumes the parent, which gets scheduled, and exits, before
GDB gets a chance to resume the child.  has_stopped_jobs causes the kernel
to decide the still-stopped-in-GDB child (which will be an orphaned pgrp) is
going to be lost, so it sends a SIGHUP and SIGCONT to it, confusing GDB
terribly.  Normally those signals wouldn't be sent.


The longer explanation:

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


# --------------------------------------------
# 03/01/18	drow@nevyn.them.org	1.957
# Tweak has_stopped_jobs for use with debugging
# --------------------------------------------

diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	Thu Feb  6 16:57:39 2003
+++ b/kernel/exit.c	Thu Feb  6 16:57:39 2003
@@ -203,6 +203,17 @@
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
