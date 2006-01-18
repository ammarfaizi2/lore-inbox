Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030468AbWASAAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbWASAAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbWARX7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:59:41 -0500
Received: from [151.97.230.9] ([151.97.230.9]:12521 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1030484AbWARX7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:59:36 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 5/8] uml: TT - SYSCALL_DEBUG - fix buglet introduced in cleanup
Date: Thu, 19 Jan 2006 00:55:12 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060118235510.4626.86544.stgit@zion.home.lan>
In-Reply-To: <20060118235132.4626.74049.stgit@zion.home.lan>
References: <20060118235132.4626.74049.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes a bug introduced in commit e32dacb9f481fd6decb41adb28e720c923d34f54 -
index is initialized based on syscall before syscall is calculated.

I'm bothering with this mainly because it gives a correct warning when the config
option is enabled, even if the code is for a almost unused debugging option.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/tt/syscall_kern.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/tt/syscall_kern.c b/arch/um/kernel/tt/syscall_kern.c
index 3d29c90..3fda9a0 100644
--- a/arch/um/kernel/tt/syscall_kern.c
+++ b/arch/um/kernel/tt/syscall_kern.c
@@ -23,16 +23,20 @@ void syscall_handler_tt(int sig, struct 
 	int syscall;
 #ifdef CONFIG_SYSCALL_DEBUG
 	int index;
-  	index = record_syscall_start(syscall);
 #endif
 	sc = UPT_SC(&regs->regs);
 	SC_START_SYSCALL(sc);
 
+	syscall = UPT_SYSCALL_NR(&regs->regs);
+
+#ifdef CONFIG_SYSCALL_DEBUG
+	index = record_syscall_start(syscall);
+#endif
+
 	syscall_trace(&regs->regs, 0);
 
 	current->thread.nsyscalls++;
 	nsyscalls++;
-	syscall = UPT_SYSCALL_NR(&regs->regs);
 
 	if((syscall >= NR_syscalls) || (syscall < 0))
 		result = -ENOSYS;

