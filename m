Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWIHPdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWIHPdL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 11:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWIHPdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 11:33:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18883 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750766AbWIHPdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 11:33:09 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/3] FRV: Mark __do_IRQ() deprecated
Date: Fri, 08 Sep 2006 16:32:42 +0100
To: torvalds@osdl.org, akpm@osdl.org, mingo@elte.hu, benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060908153242.21015.66379.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060908153236.21015.56106.stgit@warthog.cambridge.redhat.com>
References: <20060908153236.21015.56106.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Mark __do_IRQ() as being deprecated (as Ben Herrenschmidt says it is).

Rename the real __do_IRQ() to __do_IRQ_deprecated() and wrap this in an inline
function called __do_IRQ() that is deprecated to prevent generic_handle_irq()
from giving deprecation warnings on every file.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/irq.h |   11 +++++++++--
 kernel/irq/handle.c |    6 ++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 48d3cb3..83bf988 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -319,9 +319,16 @@ handle_irq_name(void fastcall (*handle)(
 /*
  * Monolithic do_IRQ implementation.
  * (is an explicit fastcall, because i386 4KSTACKS calls it from assembly)
+ * - This is obsolete; generic_handle_irq() should be used instead.
  */
 #ifndef CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ
-extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
+extern fastcall unsigned int __do_IRQ_deprecated(unsigned int irq, struct pt_regs *regs);
+
+static inline __deprecated fastcall
+unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs)
+{
+	return __do_IRQ_deprecated(irq, regs);
+}
 #endif
 
 /*
@@ -340,7 +347,7 @@ #else
 	if (likely(desc->handle_irq))
 		desc->handle_irq(irq, desc, regs);
 	else
-		__do_IRQ(irq, regs);
+		__do_IRQ_deprecated(irq, regs);
 #endif
 }
 
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 2e9e800..f3b1615 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -151,7 +151,7 @@ irqreturn_t handle_IRQ_event(unsigned in
 
 #ifndef CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ
 /**
- * __do_IRQ - original all in one highlevel IRQ handler
+ * __do_IRQ_deprecated - original all in one highlevel IRQ handler
  * @irq:	the interrupt number
  * @regs:	pointer to a register structure
  *
@@ -161,8 +161,10 @@ #ifndef CONFIG_GENERIC_HARDIRQS_NO__DO_I
  *
  * This is the original x86 implementation which is used for every
  * interrupt type.
+ *
+ * This is obsolete; generic_handle_irq() should be used instead.
  */
-fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs)
+fastcall unsigned int __do_IRQ_deprecated(unsigned int irq, struct pt_regs *regs)
 {
 	struct irq_desc *desc = irq_desc + irq;
 	struct irqaction *action;
