Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbTFWNeQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 09:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266036AbTFWNeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 09:34:15 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:28632 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S266034AbTFWNeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 09:34:02 -0400
Date: Mon, 23 Jun 2003 15:48:07 +0200 (MEST)
Message-Id: <200306231348.h5NDm76X007502@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.73] restore UP spinlock workaround for gcc-2.95.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sent to Linus and Andi, forgot to cc: lkml]

This patch reverts Andi's change to include/linux/spinlock.h
which made gcc-2.95 use empty structs and empty initializers for
spinlocks on UP. gcc-2.95.3 requires the workaround. Please apply.

A short boot-rebuild-kernel-reboot cycle with 2.5.73 compiled
with gcc-2.95.3 resulted in five "Unitialized timer!" stack
traces on my P4, the first three during boot+init. Recompiling
with gcc-3.2.2, or with 2.95.3 and Andi's patch reverted,
eliminated these problems.

At least on x86 gcc-2.95.3 compiles faster and generates smaller
object code than 3.x.y for at lot of us, so I'd prefer to restore
the workaround rather than deprecating 2.95.3.

/Mikael

--- linux-2.5.73/include/linux/spinlock.h.~1~	2003-06-23 13:07:39.000000000 +0200
+++ linux-2.5.73/include/linux/spinlock.h	2003-06-23 13:46:09.000000000 +0200
@@ -146,8 +146,13 @@
 /*
  * gcc versions before ~2.95 have a nasty bug with empty initializers.
  */
-typedef struct { } spinlock_t;
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { }
+#if (__GNUC__ > 2)
+  typedef struct { } spinlock_t;
+  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
+#else
+  typedef struct { int gcc_is_buggy; } spinlock_t;
+  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+#endif
 
 /*
  * If CONFIG_SMP is unset, declare the _raw_* definitions as nops
