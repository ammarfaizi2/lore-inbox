Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWHAF7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWHAF7T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 01:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWHAF7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 01:59:18 -0400
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:35308 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751579AbWHAF7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 01:59:18 -0400
Date: Tue, 1 Aug 2006 01:52:32 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] ptrace: make pid of child process available for
  PTRACE_EVENT_VFORK_DONE
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Daniel Jacobowitz <dan@debian.org>,
       Linus Torvalds <torvalds@osdl.org>, Albert Cahalan <acahalan@gmail.com>
Message-ID: <200608010154_MC3-1-C6A9-2893@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When delivering PTRACE_EVENT_VFORK_DONE, provide pid of the child
process when tracer calls ptrace(PTRACE_GETEVENTMSG).  This is
already (accidentally) available when the tracer is tracing VFORK in
addition to VFORK_DONE.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.18-rc3-32.orig/kernel/fork.c
+++ 2.6.18-rc3-32/kernel/fork.c
@@ -1387,8 +1387,10 @@ long do_fork(unsigned long clone_flags,
 
 		if (clone_flags & CLONE_VFORK) {
 			wait_for_completion(&vfork);
-			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
+			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE)) {
+				current->ptrace_message = nr;
 				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
+			}
 		}
 	} else {
 		free_pid(pid);
-- 
Chuck
