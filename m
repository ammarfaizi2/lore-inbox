Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVDKH0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVDKH0u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 03:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVDKH0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 03:26:50 -0400
Received: from everest.sosdg.org ([66.93.203.161]:58527 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261715AbVDKH0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 03:26:47 -0400
From: "Coywolf Qi Hunt" <coywolf@lovecn.org>
Date: Mon, 11 Apr 2005 15:26:35 +0800
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Message-ID: <20050411071808.GA3890@lovecn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Scan-Signature: 44e89aee28cb3977aa72b7ef3649eedf
X-SA-Exim-Connect-IP: 66.93.203.161
X-SA-Exim-Mail-From: coywolf@lovecn.org
Subject: [patch] reparent_to_init-cleanup
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  2.7 SUBJ_HAS_UNIQ_ID Subject contains a unique ID
X-SA-Exim-Version: 4.2 (built Sun, 13 Feb 2005 18:23:43 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Split out from my oom-killer patch, this patch hides reparent_to_init(). reparent_to_init()
should only be called by daemonize(). This applies to 2.6.12-rc2-mm2 too.

Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>
---

 arch/i386/mach-voyager/voyager_thread.c |    1 -
 include/linux/sched.h                   |    1 -
 kernel/exit.c                           |    2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff -pruN 2.6.12-rc2-mm1/arch/i386/mach-voyager/voyager_thread.c 2.6.12-rc2-mm1-cy/arch/i386/mach-voyager/voyager_thread.c
--- 2.6.12-rc2-mm1/arch/i386/mach-voyager/voyager_thread.c	2004-08-20 14:39:58.000000000 +0800
+++ 2.6.12-rc2-mm1-cy/arch/i386/mach-voyager/voyager_thread.c	2005-04-08 18:53:06.000000000 +0800
@@ -126,7 +126,6 @@ thread(void *unused)
 
 	kvoyagerd_running = 1;
 
-	reparent_to_init();
 	daemonize(THREAD_NAME);
 
 	set_timeout = 0;
diff -pruN 2.6.12-rc2-mm1/include/linux/sched.h 2.6.12-rc2-mm1-cy/include/linux/sched.h
--- 2.6.12-rc2-mm1/include/linux/sched.h	2005-04-06 10:18:18.000000000 +0800
+++ 2.6.12-rc2-mm1-cy/include/linux/sched.h	2005-04-08 18:53:06.000000000 +0800
@@ -1068,7 +1068,6 @@ extern void exit_itimers(struct signal_s
 
 extern NORET_TYPE void do_group_exit(int);
 
-extern void reparent_to_init(void);
 extern void daemonize(const char *, ...);
 extern int allow_signal(int);
 extern int disallow_signal(int);
diff -pruN 2.6.12-rc2-mm1/kernel/exit.c 2.6.12-rc2-mm1-cy/kernel/exit.c
--- 2.6.12-rc2-mm1/kernel/exit.c	2005-04-06 10:18:20.000000000 +0800
+++ 2.6.12-rc2-mm1-cy/kernel/exit.c	2005-04-08 18:53:06.000000000 +0800
@@ -224,7 +224,7 @@ static inline int has_stopped_jobs(int p
  *
  * NOTE that reparent_to_init() gives the caller full capabilities.
  */
-void reparent_to_init(void)
+static inline void reparent_to_init(void)
 {
 	write_lock_irq(&tasklist_lock);
 
