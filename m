Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbVH2QMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbVH2QMf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVH2QMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:12:34 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:41098 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751289AbVH2QMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:12:09 -0400
Subject: [patch 16/16] Add hardware breakpoint support for i386
Date: Mon, 29 Aug 2005 09:12:08 -0700
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <resend.16.2982005.trini@kernel.crashing.org>
In-Reply-To: <resend.15.2982005.trini@kernel.crashing.org>
References: <resend.15.2982005.trini@kernel.crashing.org> <1.2982005.trini@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds hardware breakpoint support for i386.  This is not as well tested as
software breakpoints, but in some minimal testing appears to be functional.

---

 linux-2.6.13-trini/arch/i386/kernel/kgdb.c |   49 +++++++++++++++++++++++++
 1 files changed, 49 insertions(+)

diff -puN arch/i386/kernel/kgdb.c~i386 arch/i386/kernel/kgdb.c
--- linux-2.6.13/arch/i386/kernel/kgdb.c~i386	2005-08-10 10:53:22.000000000 -0700
+++ linux-2.6.13-trini/arch/i386/kernel/kgdb.c	2005-08-10 10:53:22.000000000 -0700
@@ -184,6 +184,54 @@ void kgdb_correct_hw_break(void)
 		asm volatile ("movl %0, %%db7\n"::"r" (dr7));
 }
 
+int kgdb_remove_hw_break(unsigned long addr)
+{
+	int i, idx = -1;
+	for (i = 0; i < 4; i++) {
+		if (breakinfo[i].addr == addr && breakinfo[i].enabled) {
+			idx = i;
+			break;
+		}
+	}
+	if (idx == -1)
+		return -1;
+
+	breakinfo[idx].enabled = 0;
+	return 0;
+}
+
+void kgdb_remove_all_hw_break(void)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		if (breakinfo[i].enabled) {
+			/* Do what? */
+			;
+		}
+		memset(&breakinfo[i], 0, sizeof(struct hw_breakpoint));
+	}
+}
+
+int kgdb_set_hw_break(unsigned long addr)
+{
+	int i, idx = -1;
+	for (i = 0; i < 4; i++) {
+		if (!breakinfo[i].enabled) {
+			idx = i;
+			break;
+		}
+	}
+	if (idx == -1)
+		return -1;
+
+	breakinfo[idx].enabled = 1;
+	breakinfo[idx].type = 1;
+	breakinfo[idx].len = 1;
+	breakinfo[idx].addr = addr;
+	return 0;
+}
+
 void kgdb_disable_hw_debug(struct pt_regs *regs)
 {
 	/* Disable hardware debugging while we are in kgdb */
@@ -298,4 +346,5 @@ int kgdb_arch_init(void)
 
 struct kgdb_arch arch_kgdb_ops = {
 	.gdb_bpt_instr = {0xcc},
+	.flags = KGDB_HW_BREAKPOINT,
 };
_
