Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWAYVbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWAYVbq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 16:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWAYVbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 16:31:46 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:26311 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932118AbWAYVbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 16:31:45 -0500
Subject: [PATCH] kprobes: Fix return probes on x86_64 __switch_to
From: Jim Keniston <jkenisto@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Prasanna Panchamukhi <ppancham@in.ibm.com>
Content-Type: multipart/mixed; boundary="=-YO34rFK4pKUmja93HY13"
Organization: 
Message-Id: <1138224702.2879.3.camel@dyn9047018079.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 25 Jan 2006 13:31:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YO34rFK4pKUmja93HY13
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch against 2.6.16-rc1-mm3 fixes a bug in the x86_64
implementation of kprobes that can cause an Oops or crash when a return
probe is installed on __switch_to().  On x86_64, when __switch_to()
is called, we're running on the next task's stack but current points
to the previous task.  The fix handles this special case, causing the
kretprobe_instance to be hashed with the next task, where it will be
sought when __switch_to() returns.  Please apply.

Acked-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>


--=-YO34rFK4pKUmja93HY13
Content-Disposition: attachment; filename=kretprobes-x86_64-switch_to.patch
Content-Type: text/plain; name=kretprobes-x86_64-switch_to.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


Fixes a bug in the x86_64 implementation of kprobes that can cause
an Oops or crash when a return probe is installed on __switch_to().
On x86_64, when __switch_to() is called, we're running on one task's
stack but current points to a different task.  The fix adds code to
handle this special case.

---

 arch/x86_64/kernel/kprobes.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletion(-)

diff -puN arch/x86_64/kernel/kprobes.c~kretprobes-x86_64-switch_to arch/x86_64/kernel/kprobes.c
--- linux-2.6.16-rc1/arch/x86_64/kernel/kprobes.c~kretprobes-x86_64-switch_to	2006-01-25 10:26:56.000000000 -0800
+++ linux-2.6.16-rc1-jimk/arch/x86_64/kernel/kprobes.c	2006-01-25 10:27:17.000000000 -0800
@@ -272,8 +272,20 @@ void __kprobes arch_prepare_kretprobe(st
         struct kretprobe_instance *ri;
 
         if ((ri = get_free_rp_inst(rp)) != NULL) {
+		extern struct task_struct *__switch_to(
+			struct task_struct *prev_p, struct task_struct *next_p);
                 ri->rp = rp;
-                ri->task = current;
+		if (unlikely(rp->kp.addr == (kprobe_opcode_t*) __switch_to)) {
+			/*
+			 * We're entering __switch_to().
+			 * We've already switched to the next task's stack.
+			 * At this point, current = prev_p (%rdi), but when
+			 * we return, current = next_p (%rsi).  So point ri
+			 * at the next task so we can find ri upon return.
+			 */
+			ri->task = (struct task_struct *) regs->rsi;
+		} else
+			ri->task = current;
 		ri->ret_addr = (kprobe_opcode_t *) *sara;
 
 		/* Replace the return addr with trampoline addr */
_

--=-YO34rFK4pKUmja93HY13--

