Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUH3EjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUH3EjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 00:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUH3EjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 00:39:15 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:55025 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266366AbUH3EjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 00:39:08 -0400
Date: Mon, 30 Aug 2004 00:43:32 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Mackall <mpm@selenic.com>, Andi Kleen <ak@suse.de>
Subject: [PATCH][1/3] Completely out of line spinlocks / generic
Message-ID: <Pine.LNX.4.58.0408292359320.24992@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 drivers/oprofile/timer_int.c      |    2 +-
 include/asm-generic/vmlinux.lds.h |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc1-mm1/include/asm-generic/vmlinux.lds.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/include/asm-generic/vmlinux.lds.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.h
--- linux-2.6.9-rc1-mm1/include/asm-generic/vmlinux.lds.h	26 Aug 2004 13:13:09 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1/include/asm-generic/vmlinux.lds.h	28 Aug 2004 20:00:47 -0000
@@ -80,3 +80,8 @@
 		VMLINUX_SYMBOL(__sched_text_start) = .;			\
 		*(.sched.text)						\
 		VMLINUX_SYMBOL(__sched_text_end) = .;
+
+#define SPINLOCK_TEXT							\
+		VMLINUX_SYMBOL(__spinlock_text_start) = .;		\
+		*(.spinlock.text)					\
+		VMLINUX_SYMBOL(__spinlock_text_end) = .;
Index: linux-2.6.9-rc1-mm1/drivers/oprofile/timer_int.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/drivers/oprofile/timer_int.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 timer_int.c
--- linux-2.6.9-rc1-mm1/drivers/oprofile/timer_int.c	26 Aug 2004 13:13:41 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1/drivers/oprofile/timer_int.c	28 Aug 2004 20:00:47 -0000
@@ -19,7 +19,7 @@ static int timer_notify(struct notifier_
 {
 	struct pt_regs * regs = (struct pt_regs *)data;
 	int cpu = smp_processor_id();
-	unsigned long eip = instruction_pointer(regs);
+	unsigned long eip = profile_pc(regs);

 	oprofile_add_sample(eip, !user_mode(regs), 0, cpu);
 	return 0;
