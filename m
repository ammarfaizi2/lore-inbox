Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWI3ALG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWI3ALG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWI3AKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:10:07 -0400
Received: from www.osadl.org ([213.239.205.134]:9108 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422687AbWI3AED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:03 -0400
Message-Id: <20060929234439.611901000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:26 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 07/23] cleanup: uninline irq_enter() and move it into a
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
 kernel/softirq.c        |    7 +++++++
 2 files changed, 8 insertions(+), 6 deletions(-)

Index: linux-2.6.18-mm2/include/linux/hardirq.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/hardirq.h	2006-09-30 01:41:13.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/hardirq.h	2006-09-30 01:41:16.000000000 +0200
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
--- linux-2.6.18-mm2.orig/kernel/softirq.c	2006-09-30 01:41:13.000000000 +0200
+++ linux-2.6.18-mm2/kernel/softirq.c	2006-09-30 01:41:16.000000000 +0200
@@ -279,6 +279,13 @@ EXPORT_SYMBOL(do_softirq);
 # define invoke_softirq()	do_softirq()
 #endif
 
+extern void irq_enter(void)
+{
+	account_system_vtime(current);
+	add_preempt_count(HARDIRQ_OFFSET);
+	trace_hardirq_enter();
+}
+
 /*
  * Exit an interrupt context. Process softirqs if needed and possible:
  */

--

