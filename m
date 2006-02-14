Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161065AbWBNPTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbWBNPTI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbWBNPTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:19:07 -0500
Received: from fog.sekrit.org ([66.92.77.184]:16584 "EHLO fog.sekrit.org")
	by vger.kernel.org with ESMTP id S1161065AbWBNPTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:19:06 -0500
Date: Tue, 14 Feb 2006 10:19:04 -0500
From: Gerald Britton <gbritton@alum.mit.edu>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Hugh Dickins <hugh@veritas.com>, phil.el@wanadoo.fr,
       gbritton@alum.mit.edu
Cc: linux-kernel@vger.kernel.org, oprofile-list@lists.sourceforge.net
Subject: [PATCH] x86: fix oprofile kernel callgraph regression
Message-ID: <20060214151904.GA30639@fog.sekrit.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060212190520.244fcaec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212190520.244fcaec.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix x86 oprofile regression introduced by:
  commit c34d1b4d165c67b966bca4aba026443d7ff161eb
  [PATCH] mm: kill check_user_page_readable

That commit reorganized tests for the userspace stack walking moving all
those tests into dump_backtrace(), however, dump_backtrace() was used for
both userspace and kernel stalk walking.  The result is typically no
recorded callgraph information for kernel samples.

Revive the original function as dump_kernel_backtrace() and rename the
other to dump_user_backtrace() to avoid future confusion.

Signed-off-by: Gerald Britton <gbritton@alum.mit.edu>
---
 backtrace.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)
--- a/arch/i386/oprofile/backtrace.c	2006-02-13 19:27:40.000000000 -0500
+++ b/arch/i386/oprofile/backtrace.c	2006-02-13 19:30:32.000000000 -0500
@@ -20,7 +20,20 @@ struct frame_head {
 } __attribute__((packed));
 
 static struct frame_head *
-dump_backtrace(struct frame_head * head)
+dump_kernel_backtrace(struct frame_head * head)
+{
+	oprofile_add_trace(head->ret);
+
+	/* frame pointers should strictly progress back up the stack
+	 * (towards higher addresses) */
+	if (head >= head->ebp)
+		return NULL;
+
+	return head->ebp;
+}
+
+static struct frame_head *
+dump_user_backtrace(struct frame_head * head)
 {
 	struct frame_head bufhead[2];
 
@@ -105,10 +118,10 @@ x86_backtrace(struct pt_regs * const reg
 
 	if (!user_mode_vm(regs)) {
 		while (depth-- && valid_kernel_stack(head, regs))
-			head = dump_backtrace(head);
+			head = dump_kernel_backtrace(head);
 		return;
 	}
 
 	while (depth-- && head)
-		head = dump_backtrace(head);
+		head = dump_user_backtrace(head);
 }
