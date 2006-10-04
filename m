Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422648AbWJDRnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbWJDRnw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422636AbWJDRmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:42:00 -0400
Received: from www.osadl.org ([213.239.205.134]:13285 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161813AbWJDRhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:37:54 -0400
Message-Id: <20061004172222.667707000@cruncher.tec.linutronix.de>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
Date: Wed, 04 Oct 2006 17:31:37 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 07/22] cleanup: uninline irq_enter() and move it into a
	function
Content-Disposition: inline;
	filename=cleanup-uninline-irq_enter-and-move-it-into-a.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Uninline irq_enter().  [dynticks adds more stuff to it]

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 include/linux/hardirq.h |    7 +------
 kernel/softirq.c        |   10 ++++++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

Index: linux-2.6.18-mm3/include/linux/hardirq.h
===================================================================
--- linux-2.6.18-mm3.orig/include/linux/hardirq.h	2006-10-04 18:13:52.000000000 +0200
+++ linux-2.6.18-mm3/include/linux/hardirq.h	2006-10-04 18:13:55.000000000 +0200
@@ -106,12 +106,7 @@ static inline void account_system_vtime(
  * always balanced, so the interrupted value of ->hardirq_context
  * will always be restored.
  */
-#define irq_enter()					\
-	do {						\
-		account_system_vtime(current);		\
-		add_preempt_count(HARDIRQ_OFFSET);	\
-		trace_hardirq_enter();			\
-	} while (0)
+extern void irq_enter(void);
 
 /*
  * Exit irq context without processing softirqs:
Index: linux-2.6.18-mm3/kernel/softirq.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/softirq.c	2006-10-04 18:13:52.000000000 +0200
+++ linux-2.6.18-mm3/kernel/softirq.c	2006-10-04 18:13:55.000000000 +0200
@@ -273,6 +273,16 @@ EXPORT_SYMBOL(do_softirq);
 
 #endif
 
+/*
+ * Enter an interrupt context.
+ */
+void irq_enter(void)
+{
+	account_system_vtime(current);
+	add_preempt_count(HARDIRQ_OFFSET);
+	trace_hardirq_enter();
+}
+
 #ifdef __ARCH_IRQ_EXIT_IRQS_DISABLED
 # define invoke_softirq()	__do_softirq()
 #else

--

