Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVCVR7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVCVR7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 12:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVCVR6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 12:58:14 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:28348 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261494AbVCVR4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:56:36 -0500
Subject: [patch 02/12] uml: cpu_relax fix
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 22 Mar 2005 17:21:21 +0100
Message-Id: <20050322162121.4295D2125C@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use rep_nop instead of barrier for cpu_relax, following $(SUBARCH)'s doing
that (i.e. i386 and x86_64).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/include/asm-um/processor-generic.h |    2 --
 linux-2.6.11-paolo/include/asm-um/processor-i386.h    |    8 ++++++++
 linux-2.6.11-paolo/include/asm-um/processor-x86_64.h  |    8 ++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff -puN include/asm-um/processor-generic.h~uml-cpu_relax include/asm-um/processor-generic.h
--- linux-2.6.11/include/asm-um/processor-generic.h~uml-cpu_relax	2005-03-22 16:52:25.000000000 +0100
+++ linux-2.6.11-paolo/include/asm-um/processor-generic.h	2005-03-22 16:54:41.000000000 +0100
@@ -16,8 +16,6 @@ struct task_struct;
 
 struct mm_struct;
 
-#define cpu_relax()   barrier()
-
 struct thread_struct {
 	int forking;
 	int nsyscalls;
diff -puN include/asm-um/processor-i386.h~uml-cpu_relax include/asm-um/processor-i386.h
--- linux-2.6.11/include/asm-um/processor-i386.h~uml-cpu_relax	2005-03-22 16:53:43.000000000 +0100
+++ linux-2.6.11-paolo/include/asm-um/processor-i386.h	2005-03-22 16:54:39.000000000 +0100
@@ -19,6 +19,14 @@ struct arch_thread {
 
 #include "asm/arch/user.h"
 
+/* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
+static inline void rep_nop(void)
+{
+	__asm__ __volatile__("rep;nop": : :"memory");
+}
+
+#define cpu_relax()	rep_nop()
+
 /*
  * Default implementation of macro that returns current
  * instruction pointer ("program counter"). Stolen
diff -puN include/asm-um/processor-x86_64.h~uml-cpu_relax include/asm-um/processor-x86_64.h
--- linux-2.6.11/include/asm-um/processor-x86_64.h~uml-cpu_relax	2005-03-22 16:56:30.000000000 +0100
+++ linux-2.6.11-paolo/include/asm-um/processor-x86_64.h	2005-03-22 16:56:32.000000000 +0100
@@ -12,6 +12,14 @@
 struct arch_thread {
 };
 
+/* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
+extern inline void rep_nop(void)
+{
+	__asm__ __volatile__("rep;nop": : :"memory");
+}
+
+#define cpu_relax()   rep_nop()
+
 #define INIT_ARCH_THREAD { }
 
 #define current_text_addr() \
_
