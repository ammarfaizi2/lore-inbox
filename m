Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbWDMXP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWDMXP3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWDMXKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:10:55 -0400
Received: from cantor2.suse.de ([195.135.220.15]:17871 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965021AbWDMXKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:10:39 -0400
Date: Thu, 13 Apr 2006 16:09:38 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Andrea Arcangeli <andrea@suse.de>, Roland McGrath <roland@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 21/22] fix non-leader exec under ptrace
Message-ID: <20060413230938.GV5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-non-leader-exec-under-ptrace.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

This reverts most of commit 30e0fca6c1d7d26f3f2daa4dd2b12c51dadc778a.
It broke the case of non-leader MT exec when ptraced.
I think the bug it was intended to fix was already addressed by commit
788e05a67c343fa22f2ae1d3ca264e7f15c25eaf.

Signed-off-by: Roland McGrath <roland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 kernel/ptrace.c |    7 ++-----
 kernel/signal.c |    4 ++--
 2 files changed, 4 insertions(+), 7 deletions(-)

--- linux-2.6.16.5.orig/kernel/ptrace.c
+++ linux-2.6.16.5/kernel/ptrace.c
@@ -57,10 +57,6 @@ void ptrace_untrace(task_t *child)
 			signal_wake_up(child, 1);
 		}
 	}
-	if (child->signal->flags & SIGNAL_GROUP_EXIT) {
-		sigaddset(&child->pending.signal, SIGKILL);
-		signal_wake_up(child, 1);
-	}
 	spin_unlock(&child->sighand->siglock);
 }
 
@@ -82,7 +78,8 @@ void __ptrace_unlink(task_t *child)
 		SET_LINKS(child);
 	}
 
-	ptrace_untrace(child);
+	if (child->state == TASK_TRACED)
+		ptrace_untrace(child);
 }
 
 /*
--- linux-2.6.16.5.orig/kernel/signal.c
+++ linux-2.6.16.5/kernel/signal.c
@@ -1942,9 +1942,9 @@ relock:
 			/* Let the debugger run.  */
 			ptrace_stop(signr, signr, info);
 
-			/* We're back.  Did the debugger cancel the sig or group_exit? */
+			/* We're back.  Did the debugger cancel the sig?  */
 			signr = current->exit_code;
-			if (signr == 0 || current->signal->flags & SIGNAL_GROUP_EXIT)
+			if (signr == 0)
 				continue;
 
 			current->exit_code = 0;

--
