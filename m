Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270267AbUJEQnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270267AbUJEQnQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269289AbUJEQiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 12:38:23 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:29128 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S270169AbUJEQhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 12:37:45 -0400
Subject: [patch 1/1] uml: remove SIGPROF from change_signals
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 05 Oct 2004 18:30:21 +0200
Message-Id: <20041005163021.B5E6FB00C@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>, Jeff Dike <jdike@addtoit.com>

Since local_irq_save() and local_irq_disable() should match (apart from saving
the flags), get/set_signals must match [un]block_signals, i.e. change_signals;
since get/set_signals don't enable/disable SIGPROF (and this behaviour is safe
as explained in the comment the patch adds, since the profiling code does not
interact with the kernel code), not even change_signals must toggle it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/kernel/signal_user.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/signal_user.c~uml-remove-SIGPROF-change_signals arch/um/kernel/signal_user.c
--- uml-linux-2.6.8.1/arch/um/kernel/signal_user.c~uml-remove-SIGPROF-change_signals	2004-09-21 18:11:58.000000000 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/signal_user.c	2004-09-21 18:11:58.000000000 +0200
@@ -57,6 +57,10 @@ int change_sig(int signal, int on)
 	return(!sigismember(&old, signal));
 }
 
+/* Both here and in set/get_signal we don't touch SIGPROF, because we must not
+ * disable profiling; it's safe because the profiling code does not interact
+ * with the kernel code at all.*/
+
 static void change_signals(int type)
 {
 	sigset_t mask;
@@ -65,7 +69,6 @@ static void change_signals(int type)
 	sigaddset(&mask, SIGVTALRM);
 	sigaddset(&mask, SIGALRM);
 	sigaddset(&mask, SIGIO);
-	sigaddset(&mask, SIGPROF);
 	if(sigprocmask(type, &mask, NULL) < 0)
 		panic("Failed to change signal mask - errno = %d", errno);
 }
_
