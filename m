Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUHaEzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUHaEzf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 00:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUHaEzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 00:55:35 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:28337 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S266543AbUHaEzd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 00:55:33 -0400
Date: Mon, 30 Aug 2004 21:55:30 -0700
Message-Id: <200408310455.i7V4tUPk001916@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Daniel Jacobowitz <dan@debian.org>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
In-Reply-To: Daniel Jacobowitz's message of  Tuesday, 31 August 2004 00:22:06 -0400 <20040831042206.GA10577@nevyn.them.org>
X-Zippy-Says: My pants just went to high school in the Carlsbad Caverns!!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unless it's been changed since I last pulled, you should also fix up
> has_stopped_jobs.  I think it's broken by the introduction of
> TASK_TRACED.

Actually, I don't think it was broken at all.  It has an old kludge to
avoid considering trace-stopped threads as stopped for purposes of deciding
to generate signals for an orphaned process group.  I think that the useful
thing is for it not to consider any TASK_TRACED thread as stopped here either.
That's what it will already do, and the old kludge can go now:

--- linux-2.6-ptracefix/kernel/exit.c.~1~
+++ linux-2.6-ptracefix/kernel/exit.c
@@ -199,17 +199,6 @@ static inline int has_stopped_jobs(int p
 	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
 		if (p->state != TASK_STOPPED)
 			continue;
-
-		/* If p is stopped by a debugger on a signal that won't
-		   stop it, then don't count p as stopped.  This isn't
-		   perfect but it's a good approximation.  */
-		if (unlikely (p->ptrace)
-		    && p->exit_code != SIGSTOP
-		    && p->exit_code != SIGTSTP
-		    && p->exit_code != SIGTTOU
-		    && p->exit_code != SIGTTIN)
-			continue;
-
 		retval = 1;
 		break;
 	}


Thanks,
Roland
