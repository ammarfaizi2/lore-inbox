Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266657AbUIAB4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266657AbUIAB4b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 21:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266595AbUIAB4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 21:56:31 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:56476 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S266657AbUIAB42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 21:56:28 -0400
Date: Tue, 31 Aug 2004 18:56:21 -0700
Message-Id: <200409010156.i811uLdd014564@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
In-Reply-To: Roland McGrath's message of  Tuesday, 31 August 2004 17:27:54 -0700 <200409010027.i810RsWT001980@magilla.sf.frob.com>
X-Fcc: ~/Mail/linus
Emacs: an inspiring example of form following function... to Hell.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have a program like yours to test that it was broken with my patch
(now in 2.6.9-rc1-mm2).  But the following additional patch relative to
2.6.9-rc1-mm2 should do it.  I've tested that it doesn't create any new
problems.  I don't have something right handy that tests the case in
question, but you've said that you do.

This makes any ptrace operation that finds the target in TASK_STOPPED state
morph it into TASK_TRACED state before doing anything.  This necessitates
reverting the last_siginfo accesses to check instead of assume last_siginfo
is set, since it's no longer impossible to be in TASK_TRACED without being
stopped in ptrace_stop (though there are no associated races to worry
about).


Thanks,
Roland

--- linux-2.6.9-rc1-mm2/kernel/ptrace.c.~1~	2004-08-31 18:18:10.000000000 -0700
+++ linux-2.6.9-rc1-mm2/kernel/ptrace.c	2004-08-31 18:51:46.922556896 -0700
@@ -81,13 +81,20 @@ int ptrace_check_attach(struct task_stru
 	 * be changed by us so it's not changing right after this.
 	 */
 	read_lock(&tasklist_lock);
-	if ((child->ptrace & PT_PTRACED) && child->parent == current)
+	if ((child->ptrace & PT_PTRACED) && child->parent == current &&
+	    child->signal != NULL) {
 		ret = 0;
+		spin_lock_irq(&child->sighand->siglock);
+		if (child->state == TASK_STOPPED) {
+			child->state = TASK_TRACED;
+		} else if (child->state != TASK_TRACED && !kill) {
+			ret = -ESRCH;
+		}
+		spin_unlock_irq(&child->sighand->siglock);
+	}
 	read_unlock(&tasklist_lock);
 
 	if (!ret && !kill) {
-		if (child->state != TASK_TRACED)
-			return -ESRCH;
 		wait_task_inactive(child);
 	}
 
@@ -298,13 +305,15 @@ static int ptrace_setoptions(struct task
 
 static int ptrace_getsiginfo(struct task_struct *child, siginfo_t __user * data)
 {
-	BUG_ON(child->last_siginfo == NULL);
+	if (child->last_siginfo == NULL)
+		return -EINVAL;
 	return copy_siginfo_to_user(data, child->last_siginfo);
 }
 
 static int ptrace_setsiginfo(struct task_struct *child, siginfo_t __user * data)
 {
-	BUG_ON(child->last_siginfo == NULL);
+	if (child->last_siginfo == NULL)
+		return -EINVAL;
 	if (copy_from_user(child->last_siginfo, data, sizeof (siginfo_t)) != 0)
 		return -EFAULT;
 	return 0;
