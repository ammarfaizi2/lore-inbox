Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbUKCMJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbUKCMJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 07:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbUKCMJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 07:09:40 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:9694 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261562AbUKCMJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 07:09:32 -0500
Date: Wed, 3 Nov 2004 04:08:29 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       Blaisorblade <blaisorblade_spam@yahoo.it>,
       user-mode-linux-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to kill host-OS processes (take #2)
Message-ID: <20041103120829.GA23182@taniwha.stupidest.org>
References: <20041103113736.GA23041@taniwha.stupidest.org> <1099482457.16445.1.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099482457.16445.1.camel@imp.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 11:47:38AM +0000, Anton Altaparmakov wrote:

> You have two %d but only one argument.  You seem to have forgotten
> an "old_pid, " in there.

doh!  it's a warning if something iffy happens (which so far for me it
hasn't) which explains why i missed it...  not sure why i didn't get a
build warning though...  thanks!

---
kill(..., SIGKILL) doesn't work to kill host-OS processes created in
the exec path in TT mode --- for this we need PTRACE_KILL (it did work
in previous kernels, but not by design).  Without this process will
accumulate on the host-OS (although the won't be visible inside UML).

Signed-off-by: Chris Wedgwood <cw@f00f.org>
---

Index: cw-current/arch/um/kernel/tt/exec_user.c
===================================================================
--- cw-current.orig/arch/um/kernel/tt/exec_user.c	2004-11-03 02:10:18.064830204 -0800
+++ cw-current/arch/um/kernel/tt/exec_user.c	2004-11-03 04:05:00.435843464 -0800
@@ -35,7 +35,8 @@
 		tracer_panic("do_exec failed to get registers - errno = %d",
 			     errno);
 
-	kill(old_pid, SIGKILL);
+	if (ptrace(PTRACE_KILL, old_pid, NULL, NULL))
+		printk("Warning: ptrace(PTRACE_KILL, %d, ...) saw %d\n", old_pid, errno);
 
 	if(ptrace_setregs(new_pid, regs) < 0)
 		tracer_panic("do_exec failed to start new proc - errno = %d",
