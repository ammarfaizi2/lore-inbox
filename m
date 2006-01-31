Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWAaKxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWAaKxJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 05:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWAaKxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 05:53:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60381 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750739AbWAaKxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 05:53:08 -0500
Date: Tue, 31 Jan 2006 10:27:26 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, seife@suse.de
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-kernel@vger.kernel.org
Subject: [RFC/RFT] finally solve "swsusp fails with mysqld" problem
Message-ID: <20060131092726.GA2718@elf.ucw.cz>
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <200601302318.28922.rjw@sisk.pl> <20060130222541.GK2250@elf.ucw.cz> <200601310102.00646.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601310102.00646.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Place refrigerator hook at more clever place; avoids "system can't be
suspended while mysqld running" problem.

I'd like you to test it. It looks correct to me, and it is actually a
solution, not a workaround like my previous tries. It still does not
solve suspend while running stress tests.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 01d049aacf36961d361cfd382fcbf746afcbb61b
tree 67e3d1fcb65cebfab058f9a699534b1689494dad
parent 92dfb5b4ac96e200138006901837056825c758d3
author <pavel@amd.ucw.cz> Tue, 31 Jan 2006 10:18:22 +0100
committer <pavel@amd.ucw.cz> Tue, 31 Jan 2006 10:18:22 +0100

 arch/i386/kernel/signal.c |    3 ---
 fs/jbd/journal.c          |    1 +
 kernel/signal.c           |    4 ++--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/i386/kernel/signal.c b/arch/i386/kernel/signal.c
index adcd069..5ad8c65 100644
--- a/arch/i386/kernel/signal.c
+++ b/arch/i386/kernel/signal.c
@@ -615,9 +615,6 @@ int fastcall do_signal(struct pt_regs *r
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
-		goto no_signal;
-
 	if (!oldset)
 		oldset = &current->blocked;
 
diff --git a/fs/jbd/journal.c b/fs/jbd/journal.c
index e4b516a..20b5918 100644
--- a/fs/jbd/journal.c
+++ b/fs/jbd/journal.c
@@ -153,6 +153,7 @@ loop:
 	}
 
 	wake_up(&journal->j_wait_done_commit);
+	/* Race here? May someone already be waking at *next* commit? */
 	if (freezing(current)) {
 		/*
 		 * The simpler the better. Flushing journal isn't a
diff --git a/kernel/signal.c b/kernel/signal.c
index 717f1f3..6ef3c90 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1922,6 +1922,8 @@ int get_signal_to_deliver(siginfo_t *inf
 	sigset_t *mask = &current->blocked;
 	int signr = 0;
 
+	try_to_freeze();
+
 relock:
 	spin_lock_irq(&current->sighand->siglock);
 	for (;;) {
@@ -2307,7 +2309,6 @@ sys_rt_sigtimedwait(const sigset_t __use
 
 			timeout = schedule_timeout_interruptible(timeout);
 
-			try_to_freeze();
 			spin_lock_irq(&current->sighand->siglock);
 			sig = dequeue_signal(current, &these, &info);
 			current->blocked = current->real_blocked;

diff --git a/arch/x86_64/kernel/signal.c b/arch/x86_64/kernel/signal.c
index 5876df1..f4dd2ca 100644
--- a/arch/x86_64/kernel/signal.c
+++ b/arch/x86_64/kernel/signal.c
@@ -443,9 +443,6 @@ int do_signal(struct pt_regs *regs, sigs
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
-		goto no_signal;
-
 	if (!oldset)
 		oldset = &current->blocked;
 

-- 
Thanks, Sharp!
