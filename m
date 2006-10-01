Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWJAXNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWJAXNh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 19:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWJAXN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 19:13:27 -0400
Received: from www.osadl.org ([213.239.205.134]:435 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932478AbWJAXGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 19:06:47 -0400
Message-Id: <20061001225723.835253000@cruncher.tec.linutronix.de>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
Date: Sun, 01 Oct 2006 23:00:53 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 07/21] cleanup: uninline irq_enter() and move it into a
	function
Content-Disposition: inline; filename=unmacro-irq-enter.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

uninline irq_enter(). [dynticks adds more stuff to it]

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
--
 include/linux/hardirq.h |    7 +------
 kernel/softirq.c        |   10 ++++++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

Index: linux-2.6.18-mm2/include/linux/hardirq.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/hardirq.h	2006-10-02 00:55:48.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/hardirq.h	2006-10-02 00:55:51.000000000 +0200
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
Index: linux-2.6.18-mm2/kernel/softirq.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/softirq.c	2006-10-02 00:55:48.000000000 +0200
+++ linux-2.6.18-mm2/kernel/softirq.c	2006-10-02 00:55:51.000000000 +0200
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

