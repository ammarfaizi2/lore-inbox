Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161499AbWJUQwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161499AbWJUQwm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993143AbWJUQv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:51:59 -0400
Received: from ns2.suse.de ([195.135.220.15]:696 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S2993133AbWJUQvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:51:33 -0400
From: Andi Kleen <ak@suse.de>
References: <20061021 651.356252000@suse.de>
In-Reply-To: <20061021 651.356252000@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>, patches@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] [12/19] x86_64: Fix ENOSYS in system call tracing
Message-Id: <20061021165132.5F1B713CB4@wotan.suse.de>
Date: Sat, 21 Oct 2006 18:51:32 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Jan Beulich" <jbeulich@novell.com>

This patch:

- out of range system calls failing to return -ENOSYS under
  system call tracing

[AK: split out from another patch by Jan as separate bugfix]

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/entry.S |    2 ++
 1 files changed, 2 insertions(+)

Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -315,6 +315,8 @@ tracesys:			 
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
 	RESTORE_REST
 	cmpq $__NR_syscall_max,%rax
+	movq $-ENOSYS,%rcx
+	cmova %rcx,%rax
 	ja  1f
 	movq %r10,%rcx	/* fixup for C */
 	call *sys_call_table(,%rax,8)
