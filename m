Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbUKCLif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbUKCLif (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 06:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbUKCLiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 06:38:20 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:37064 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261554AbUKCLiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 06:38:11 -0500
Date: Wed, 3 Nov 2004 03:37:36 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>,
       user-mode-linux-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to kill host-OS processes
Message-ID: <20041103113736.GA23041@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kill(..., SIGKILL) doesn't work to kill host-OS processes created in
the exec path in TT mode --- for this we need PTRACE_KILL (it did work
in previous kernels, but not by design).  Without this process will
accumulate on the host-OS (although the won't be visible inside UML).

Signed-off-by: Chris Wedgwood <cw@f00f.org>
---

Yes, there are other fixes along these lines which are needed but one
at a time as we test these...

Index: cw-current/arch/um/kernel/tt/exec_user.c
===================================================================
--- cw-current.orig/arch/um/kernel/tt/exec_user.c	2004-11-03 02:10:18.064830204 -0800
+++ cw-current/arch/um/kernel/tt/exec_user.c	2004-11-03 02:12:10.447716745 -0800
@@ -35,7 +35,8 @@
 		tracer_panic("do_exec failed to get registers - errno = %d",
 			     errno);
 
-	kill(old_pid, SIGKILL);
+	if (ptrace(PTRACE_KILL, old_pid, NULL, NULL))
+		printk("Warning: ptrace(PTRACE_KILL, %d, ...) saw %d\n", errno);
 
 	if(ptrace_setregs(new_pid, regs) < 0)
 		tracer_panic("do_exec failed to start new proc - errno = %d",
