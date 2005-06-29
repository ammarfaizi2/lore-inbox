Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVF2Vtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVF2Vtx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 17:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVF2Vtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 17:49:53 -0400
Received: from aun.it.uu.se ([130.238.12.36]:55224 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262474AbVF2Vt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 17:49:29 -0400
Date: Wed, 29 Jun 2005 23:49:18 +0200 (MEST)
Message-Id: <200506292149.j5TLnI8s020912@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-mm2] UP spinlocks gcc-2.9x fix
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The spinlock consolidation patch that was included in 2.6.12-mm2
removed the kernel's fixes for empty structure bugs in gcc-2.95.

This patch re-adds those fixes. It also updates the corresponding
comment to state that the empty structure bug also is present in
early gcc-2.96 versions.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 include/linux/spinlock_types_up.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

diff -rupN linux-2.6.12-mm2/include/linux/spinlock_types_up.h linux-2.6.12-mm2.up-spinlocks-gcc29x-fix/include/linux/spinlock_types_up.h
--- linux-2.6.12-mm2/include/linux/spinlock_types_up.h	2005-06-29 21:54:08.000000000 +0200
+++ linux-2.6.12-mm2.up-spinlocks-gcc29x-fix/include/linux/spinlock_types_up.h	2005-06-29 22:49:34.000000000 +0200
@@ -22,16 +22,30 @@ typedef struct {
 
 #else
 
+/*
+ * All gcc 2.95 versions and early versions of 2.96 have a nasty bug
+ * with empty initializers.
+ */
+#if (__GNUC__ > 2)
 typedef struct { } raw_spinlock_t;
 
 #define __RAW_SPIN_LOCK_UNLOCKED { }
+#else
+typedef struct { int gcc_is_buggy; } raw_spinlock_t;
+#define __RAW_SPIN_LOCK_UNLOCKED (raw_spinlock_t) { 0 }
+#endif
 
 #endif
 
+#if (__GNUC__ > 2)
 typedef struct {
 	/* no debug version on UP */
 } raw_rwlock_t;
 
 #define __RAW_RW_LOCK_UNLOCKED { }
+#else
+typedef struct { int gcc_is_buggy; } raw_rwlock_t;
+#define __RAW_RW_LOCK_UNLOCKED (raw_rwlock_t) { 0 }
+#endif
 
 #endif /* __LINUX_SPINLOCK_TYPES_UP_H */
