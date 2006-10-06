Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWJFKQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWJFKQI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 06:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWJFKQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 06:16:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48771 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932307AbWJFKQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 06:16:04 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] um: irq changes break build
Date: Fri, 06 Oct 2006 11:15:36 +0100
To: penberg@cs.helsinki.fi, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, jdike@addtoit.com,
       blaisorblade@yahoo.it
Message-Id: <20061006101535.7403.26244.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

Fixup broken UML build due to 7d12e780e003f93433d49ce78cfedf4b4c52adc5 "IRQ:
Maintain regs pointer globally rather than passing to IRQ handlers".

Added code to save/restore regs pointer.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Paolo "Blaisorblade" Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/um/kernel/irq.c      |   10 ++++++----
 include/asm-um/irq_regs.h |    1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index eee97bb..41b2e53 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -355,10 +355,12 @@ #endif
  */
 unsigned int do_IRQ(int irq, union uml_pt_regs *regs)
 {
-       irq_enter();
-       __do_IRQ(irq, (struct pt_regs *)regs);
-       irq_exit();
-       return 1;
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	irq_enter();
+	__do_IRQ(irq, (struct pt_regs *)regs);
+	irq_exit();
+	set_irq_regs(old_regs);
+	return 1;
 }
 
 int um_request_irq(unsigned int irq, int fd, int type,
diff --git a/include/asm-um/irq_regs.h b/include/asm-um/irq_regs.h
new file mode 100644
index 0000000..3dd9c0b
--- /dev/null
+++ b/include/asm-um/irq_regs.h
@@ -0,0 +1 @@
+#include <asm-generic/irq_regs.h>
