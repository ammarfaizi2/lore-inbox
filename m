Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbWJBQU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWJBQU4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWJBQU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:20:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15542 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965068AbWJBQUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:20:55 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/3] IRQ: Typedef the IRQ flow handler function type
Date: Mon, 02 Oct 2006 17:20:49 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Message-Id: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Typedef the IRQ flow handler function type.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/irq.h |   30 ++++++++++++------------------
 kernel/irq/chip.c   |   12 +++---------
 2 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 48d3cb3..8e1e1d8 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -22,6 +22,12 @@ #include <linux/irqreturn.h>
 #include <asm/irq.h>
 #include <asm/ptrace.h>
 
+struct irq_desc;
+typedef	void fastcall (*irq_flow_handler_t)(unsigned int irq,
+					    struct irq_desc *desc,
+					    struct pt_regs *regs);
+
+
 /*
  * IRQ line status.
  *
@@ -139,9 +145,7 @@ #endif
  * Pad this out to 32 bytes for cache and indexing reasons.
  */
 struct irq_desc {
-	void fastcall		(*handle_irq)(unsigned int irq,
-					      struct irq_desc *desc,
-					      struct pt_regs *regs);
+	irq_flow_handler_t	handle_irq;
 	struct irq_chip		*chip;
 	void			*handler_data;
 	void			*chip_data;
@@ -312,9 +316,7 @@ handle_bad_irq(unsigned int irq, struct 
  * Get a descriptive string for the highlevel handler, for
  * /proc/interrupts output:
  */
-extern const char *
-handle_irq_name(void fastcall (*handle)(unsigned int, struct irq_desc *,
-					struct pt_regs *));
+extern const char *handle_irq_name(irq_flow_handler_t handle);
 
 /*
  * Monolithic do_IRQ implementation.
@@ -366,22 +368,15 @@ extern struct irq_chip dummy_irq_chip;
 
 extern void
 set_irq_chip_and_handler(unsigned int irq, struct irq_chip *chip,
-			 void fastcall (*handle)(unsigned int,
-						 struct irq_desc *,
-						 struct pt_regs *));
+			 irq_flow_handler_t handle);
 extern void
-__set_irq_handler(unsigned int irq,
-		  void fastcall (*handle)(unsigned int, struct irq_desc *,
-					  struct pt_regs *),
-		  int is_chained);
+__set_irq_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained);
 
 /*
  * Set a highlevel flow handler for a given IRQ:
  */
 static inline void
-set_irq_handler(unsigned int irq,
-		void fastcall (*handle)(unsigned int, struct irq_desc *,
-					struct pt_regs *))
+set_irq_handler(unsigned int irq, irq_flow_handler_t handle)
 {
 	__set_irq_handler(irq, handle, 0);
 }
@@ -393,8 +388,7 @@ set_irq_handler(unsigned int irq,
  */
 static inline void
 set_irq_chained_handler(unsigned int irq,
-			void fastcall (*handle)(unsigned int, struct irq_desc *,
-						struct pt_regs *))
+			irq_flow_handler_t handle)
 {
 	__set_irq_handler(irq, handle, 1);
 }
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 736cb0b..ca8a28d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -442,10 +442,7 @@ handle_percpu_irq(unsigned int irq, stru
 #endif /* CONFIG_SMP */
 
 void
-__set_irq_handler(unsigned int irq,
-		  void fastcall (*handle)(unsigned int, irq_desc_t *,
-					  struct pt_regs *),
-		  int is_chained)
+__set_irq_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained)
 {
 	struct irq_desc *desc;
 	unsigned long flags;
@@ -498,9 +495,7 @@ __set_irq_handler(unsigned int irq,
 
 void
 set_irq_chip_and_handler(unsigned int irq, struct irq_chip *chip,
-			 void fastcall (*handle)(unsigned int,
-						 struct irq_desc *,
-						 struct pt_regs *))
+			 irq_flow_handler_t handle)
 {
 	set_irq_chip(irq, chip);
 	__set_irq_handler(irq, handle, 0);
@@ -511,8 +506,7 @@ set_irq_chip_and_handler(unsigned int ir
  * /proc/interrupts output:
  */
 const char *
-handle_irq_name(void fastcall (*handle)(unsigned int, struct irq_desc *,
-					struct pt_regs *))
+handle_irq_name(irq_flow_handler_t handle)
 {
 	if (handle == handle_level_irq)
 		return "level  ";
