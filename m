Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbVJKFFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbVJKFFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 01:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVJKFFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 01:05:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3738 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751357AbVJKFFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 01:05:43 -0400
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] wait4 PTRACE_ATTACH race fix
X-Zippy-Says: I smell a RANCID CORN DOG!
Message-Id: <20051011050526.7F047180989@magilla.sf.frob.com>
Date: Mon, 10 Oct 2005 22:05:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back about a year ago when I last fiddled heavily with the do_wait code, I
was thinking too hard about the wrong thing and I now think I introduced a
bug whose inverse thought I was fixing.  Apparently noone was looking too
hard over much shoulder, so as to cite my bogus reasoning at the time.  In
the race condition when PTRACE_ATTACH is about to steal a child and then
the child hits a tracing event (what my_ptrace_child checks for), the real
parent does need to set its flag noting it has some eligible live children.
Otherwise a spurious ECHILD error is possible, since the child in question
is not yet on the ptrace_children list.

Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/kernel/exit.c
+++ linux-2.6/kernel/exit.c
@@ -1370,6 +1370,15 @@ repeat:
 
 			switch (p->state) {
 			case TASK_TRACED:
+				/*
+				 * When we hit the race with PTRACE_ATTACH,
+				 * we will not report this child.  But the
+				 * race means it has not yet been moved to
+				 * our ptrace_children list, so we need to
+				 * set the flag here to avoid a spurious ECHILD
+				 * when the race happens with the only child.
+				 */
+				flag = 1;
 				if (!my_ptrace_child(p))
 					continue;
 				/*FALLTHROUGH*/
