Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbWASAAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWASAAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbWARX7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:59:42 -0500
Received: from [151.97.230.9] ([151.97.230.9]:16105 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1030489AbWARX7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:59:36 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 8/8] uml: avoid "CONFIG_NR_CPUS undeclared" bogus error messages
Date: Thu, 19 Jan 2006 00:55:23 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060118235522.4626.2825.stgit@zion.home.lan>
In-Reply-To: <20060118235132.4626.74049.stgit@zion.home.lan>
References: <20060118235132.4626.74049.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Olaf Hering <olh@suse.de>

Olaf reported UML doesn't build for him with a clear analisys of what happened -
we're using NR_CPUS in files linked against glibc headers. Seems like it defines
CONFIG_SMP but not CONFIG_NR_CPUS, so we get CONFIG_NR_CPUS undeclared.

The fix is to move the declaration away from that header file and move it in
asm-um headers, and to add that header where needed.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/kern_util.h |    2 --
 arch/um/kernel/reboot.c     |    1 +
 include/asm-um/smp.h        |    2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/kern_util.h b/arch/um/include/kern_util.h
index c649108..07176d9 100644
--- a/arch/um/include/kern_util.h
+++ b/arch/um/include/kern_util.h
@@ -31,8 +31,6 @@ extern int timer_irq_inited;
 extern int jail;
 extern int nsyscalls;
 
-extern struct task_struct *idle_threads[NR_CPUS];
-
 #define UML_ROUND_DOWN(addr) ((void *)(((unsigned long) addr) & PAGE_MASK))
 #define UML_ROUND_UP(addr) \
 	UML_ROUND_DOWN(((unsigned long) addr) + PAGE_SIZE - 1)
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 6f1a3a2..3ef73bf 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -5,6 +5,7 @@
 
 #include "linux/module.h"
 #include "linux/sched.h"
+#include "asm/smp.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "kern.h"
diff --git a/include/asm-um/smp.h b/include/asm-um/smp.h
index d879eba..aeda665 100644
--- a/include/asm-um/smp.h
+++ b/include/asm-um/smp.h
@@ -23,6 +23,8 @@ extern inline void smp_cpus_done(unsigne
 {
 }
 
+extern struct task_struct *idle_threads[NR_CPUS];
+
 #endif
 
 #endif

