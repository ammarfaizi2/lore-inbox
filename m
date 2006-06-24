Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWFXVxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWFXVxx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 17:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWFXVxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 17:53:53 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36763 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964847AbWFXVxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 17:53:52 -0400
Date: Sat, 24 Jun 2006 23:48:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: [patch, 2.6.17-mm2] fix acct_collect() siglock bug
Message-ID: <20060624214853.GA19254@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5002]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the patch below fixes a siglock usage bug introduced in -mm2. The lock 
validator found it during bootup.

---------------
Subject: fix acct_collect() siglock bug
From: Ingo Molnar <mingo@elte.hu>

the lock validator noticed the following bug:

 =========================================================
 [ INFO: possible irq lock inversion dependency detected ]
 ---------------------------------------------------------
 swapper/0 just changed the state of lock:
  (tasklist_lock){..-?}, at: [<c01247c8>] send_group_sig_info+0xe/0x2f
 but this lock took another, soft-irq-unsafe lock in the past:
  (&sighand->siglock){--..}

 and interrupts could create inverse lock ordering between them.
 ...
  -> (init_sighand.siglock){....} ops: 18 {
 ...
       hardirq-on-W at:
                       [<c0130577>] lock_acquire+0x56/0x73
                       [<c03ec59c>] _spin_lock+0x24/0x32
                       [<c01374bd>] acct_collect+0x81/0x115
                       [<c011b4fa>] do_exit+0x19a/0x7b3
                       [<c01273ce>] ____call_usermodehelper+0xdf/0xe1
                       [<c01007f1>] kernel_thread_helper+0x5/0xb

it turns out that acct_collect() takes current->sighand->siglock
with interrupts enabled - a big no-no. Fix it by disabling
interrupts.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/acct.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/kernel/acct.c
===================================================================
--- linux.orig/kernel/acct.c
+++ linux/kernel/acct.c
@@ -549,7 +549,7 @@ void acct_collect(long exitcode, int gro
 		up_read(&current->mm->mmap_sem);
 	}
 
-	spin_lock(&current->sighand->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	if (group_dead)
 		pacct->ac_mem = vsize / 1024;
 	if (thread_group_leader(current)) {
@@ -567,7 +567,7 @@ void acct_collect(long exitcode, int gro
 	pacct->ac_stime = cputime_add(pacct->ac_stime, current->stime);
 	pacct->ac_minflt += current->min_flt;
 	pacct->ac_majflt += current->maj_flt;
-	spin_unlock(&current->sighand->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 /**
