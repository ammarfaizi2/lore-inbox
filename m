Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWIHPdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWIHPdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 11:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWIHPdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 11:33:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22467 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750834AbWIHPdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 11:33:16 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/3] FRV: Permit __do_IRQ() to be dispensed with
Date: Fri, 08 Sep 2006 16:32:40 +0100
To: torvalds@osdl.org, akpm@osdl.org, mingo@elte.hu, benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060908153240.21015.67367.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060908153236.21015.56106.stgit@warthog.cambridge.redhat.com>
References: <20060908153236.21015.56106.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Permit __do_IRQ() to be dispensed with based on a configuration option.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/Kconfig    |    4 ++++
 include/linux/irq.h |    6 ++++++
 kernel/irq/handle.c |    2 ++
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index 130fe8f..69f9846 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -29,6 +29,10 @@ config GENERIC_HARDIRQS
 	bool
 	default y
 
+config GENERIC_HARDIRQS_NO__DO_IRQ
+	bool
+	default y
+
 config GENERIC_TIME
 	bool
 	default y
diff --git a/include/linux/irq.h b/include/linux/irq.h
index fbf6d90..48d3cb3 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -320,7 +320,9 @@ handle_irq_name(void fastcall (*handle)(
  * Monolithic do_IRQ implementation.
  * (is an explicit fastcall, because i386 4KSTACKS calls it from assembly)
  */
+#ifndef CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ
 extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
+#endif
 
 /*
  * Architectures call this to let the generic IRQ layer
@@ -332,10 +334,14 @@ static inline void generic_handle_irq(un
 {
 	struct irq_desc *desc = irq_desc + irq;
 
+#ifdef CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ
+	desc->handle_irq(irq, desc, regs);
+#else
 	if (likely(desc->handle_irq))
 		desc->handle_irq(irq, desc, regs);
 	else
 		__do_IRQ(irq, regs);
+#endif
 }
 
 /* Handling of unhandled and spurious interrupts: */
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index fc4e906..2e9e800 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -149,6 +149,7 @@ irqreturn_t handle_IRQ_event(unsigned in
 	return retval;
 }
 
+#ifndef CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ
 /**
  * __do_IRQ - original all in one highlevel IRQ handler
  * @irq:	the interrupt number
@@ -248,6 +249,7 @@ out:
 
 	return 1;
 }
+#endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 
