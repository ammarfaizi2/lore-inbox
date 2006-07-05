Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWGENYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWGENYc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 09:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWGENYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 09:24:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38566 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964851AbWGENYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 09:24:31 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/5] FRV: Fix FRV arch compile errors
Date: Wed, 05 Jul 2006 14:24:12 +0100
To: torvalds@osdl.org, akpm@osdl.org, bernds_cb1@t-online.de
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060705132412.31510.9311.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060705132409.31510.22698.stgit@warthog.cambridge.redhat.com>
References: <20060705132409.31510.22698.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The attached patch fixes some FRV arch compile errors, including:

 (*) Marking nr_kernel_pages as __initdata so that references to it end up
     being properly calculated rather than being assumed to be in the small
     data section (and thus calculated wrt the GP register).  Not doing this
     causes the linker to emit errors as the offset is too big to fit into the
     load instruction.

 (*) Move pm_power_off into an unconditionally compiled .c file as it's now
     unconditionally accessed.

 (*) Declare frv_change_cmode() in a header file rather than in a .c file, and
     declare it asmlinkage.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/kernel/local.h   |    3 +++
 arch/frv/kernel/pm.c      |    5 -----
 arch/frv/kernel/process.c |    5 +++++
 include/linux/bootmem.h   |    2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/frv/kernel/local.h b/arch/frv/kernel/local.h
index e947176..76606d1 100644
--- a/arch/frv/kernel/local.h
+++ b/arch/frv/kernel/local.h
@@ -51,6 +51,9 @@ #endif
 /* time.c */
 extern void time_divisor_init(void);
 
+/* cmode.S */
+extern asmlinkage void frv_change_cmode(int);
+
 
 #endif /* __ASSEMBLY__ */
 #endif /* _FRV_LOCAL_H */
diff --git a/arch/frv/kernel/pm.c b/arch/frv/kernel/pm.c
index e65a9f1..c1d9fc8 100644
--- a/arch/frv/kernel/pm.c
+++ b/arch/frv/kernel/pm.c
@@ -26,11 +26,6 @@ #include <asm/mb86943a.h>
 
 #include "local.h"
 
-void (*pm_power_off)(void);
-EXPORT_SYMBOL(pm_power_off);
-
-extern void frv_change_cmode(int);
-
 /*
  * Debug macros
  */
diff --git a/arch/frv/kernel/process.c b/arch/frv/kernel/process.c
index eeeb1e2..bec8856 100644
--- a/arch/frv/kernel/process.c
+++ b/arch/frv/kernel/process.c
@@ -10,6 +10,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <linux/config.h>
+#include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -38,6 +40,9 @@ asmlinkage void ret_from_fork(void);
 
 #include <asm/pgalloc.h>
 
+void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
+
 struct task_struct *alloc_task_struct(void)
 {
 	struct task_struct *p = kmalloc(THREAD_SIZE, GFP_KERNEL);
diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index 22866fa..8735d53 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -91,7 +91,7 @@ static inline void *alloc_remap(int nid,
 }
 #endif
 
-extern unsigned long nr_kernel_pages;
+extern unsigned long __initdata nr_kernel_pages;
 extern unsigned long nr_all_pages;
 
 extern void *__init alloc_large_system_hash(const char *tablename,
