Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbUKDBzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUKDBzS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 20:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUKDBzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 20:55:18 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:58259
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262043AbUKDBzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:55:07 -0500
Subject: [patch 11/20] uml: remove SIGPROF from change_signals
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:40 +0100
Message-Id: <20041103231740.3112355C7D@zion.localdomain>
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

 vanilla-linux-2.6.9-paolo/arch/um/kernel/signal_user.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/signal_user.c~uml-remove-SIGPROF-change_signals arch/um/kernel/signal_user.c
--- vanilla-linux-2.6.9/arch/um/kernel/signal_user.c~uml-remove-SIGPROF-change_signals	2004-11-03 23:44:59.984441096 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/signal_user.c	2004-11-03 23:44:59.986440792 +0100
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
