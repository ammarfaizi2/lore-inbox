Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265473AbVBDUEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265473AbVBDUEV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbVBDUDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:03:22 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:18180 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S264284AbVBDUAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:00:37 -0500
Subject: [patch 3/8] uml: Fix SKAS sig-handler reentrancy [before 2.6.11]
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 04 Feb 2005 19:35:46 +0100
Message-Id: <20050204183546.4980F310B8@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This adds code which enables SIGSEGV reception to the SKAS sig_handler_common,
which matches the tt code.

I still need to figure out why the SA_NODEFER flag was backed out in favor of this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/skas/trap_user.c |    8 ++++++++
 1 files changed, 8 insertions(+)

diff -puN arch/um/kernel/skas/trap_user.c~uml-no-defer arch/um/kernel/skas/trap_user.c
--- linux-2.6.11/arch/um/kernel/skas/trap_user.c~uml-no-defer	2005-02-04 06:14:11.966064760 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/skas/trap_user.c	2005-02-04 06:14:11.969064304 +0100
@@ -20,6 +20,14 @@ void sig_handler_common_skas(int sig, vo
 	int save_errno = errno;
 	int save_user;
 
+	/* This is done because to allow SIGSEGV to be delivered inside a SEGV
+	 * handler.  This can happen in copy_user, and if SEGV is disabled,
+	 * the process will die.
+	 * XXX Figure out why this is better than SA_NODEFER
+	 */
+	if(sig == SIGSEGV)
+		change_sig(SIGSEGV, 1);
+
 	r = &TASK_REGS(get_current())->skas;
 	save_user = r->is_user;
 	r->is_user = 0;
_
