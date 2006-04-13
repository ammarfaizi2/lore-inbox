Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbWDMXLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWDMXLA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWDMXK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:10:59 -0400
Received: from mx1.suse.de ([195.135.220.2]:15558 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965020AbWDMXKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:10:25 -0400
Date: Thu, 13 Apr 2006 16:09:24 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Pavel Machek <pavel@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 19/22] Fix suspend with traced tasks
Message-ID: <20060413230924.GT5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="Fix-suspend-with-traced-tasks.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
strace /bin/bash misbehaves after resume; this fixes it.

(akpm: it's scary calling refrigerator() in state TASK_TRACED, but it seems to
do the right thing).

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 kernel/power/process.c |    3 +--
 kernel/signal.c        |    1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16.5.orig/kernel/power/process.c
+++ linux-2.6.16.5/kernel/power/process.c
@@ -25,8 +25,7 @@ static inline int freezeable(struct task
 	    (p->flags & PF_NOFREEZE) ||
 	    (p->exit_state == EXIT_ZOMBIE) ||
 	    (p->exit_state == EXIT_DEAD) ||
-	    (p->state == TASK_STOPPED) ||
-	    (p->state == TASK_TRACED))
+	    (p->state == TASK_STOPPED))
 		return 0;
 	return 1;
 }
--- linux-2.6.16.5.orig/kernel/signal.c
+++ linux-2.6.16.5/kernel/signal.c
@@ -1688,6 +1688,7 @@ static void ptrace_stop(int exit_code, i
 	/* Let the debugger run.  */
 	set_current_state(TASK_TRACED);
 	spin_unlock_irq(&current->sighand->siglock);
+	try_to_freeze();
 	read_lock(&tasklist_lock);
 	if (likely(current->ptrace & PT_PTRACED) &&
 	    likely(current->parent != current->real_parent ||

--
