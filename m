Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVFHWHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVFHWHr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 18:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVFHWHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 18:07:47 -0400
Received: from [151.97.230.9] ([151.97.230.9]:57731 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261513AbVFHWHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 18:07:38 -0400
Subject: [patch 1/1] uml: make hw_controller_type->release exist only for archs needing it
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       mingo@redhat.com, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Thu, 09 Jun 2005 00:07:51 +0200
Message-Id: <20050608220754.25D501CBCD5@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Chris Wedgwood <cw@f00f.org>
CC: Ingo Molnar <mingo@redhat.com>

As suggested by Chris, we can make the "just added" method ->release
conditional to UML only (better: to archs requesting it, i.e. only UML
currently), so that other archs don't get this unneeded crud, and if UML won't
need it any more we can kill this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/Kconfig     |    5 +++++
 linux-2.6.git-paolo/include/linux/irq.h |    3 +++
 linux-2.6.git-paolo/kernel/irq/manage.c |    4 ++++
 3 files changed, 12 insertions(+)

diff -puN arch/um/Kconfig~uml-gen-irq-conditionalize arch/um/Kconfig
--- linux-2.6.git/arch/um/Kconfig~uml-gen-irq-conditionalize	2005-06-07 02:25:25.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/Kconfig	2005-06-07 02:25:25.000000000 +0200
@@ -35,6 +35,11 @@ config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
 
+# Used in kernel/irq/manage.c and include/linux/irq.h
+config IRQ_RELEASE_METHOD
+	bool
+	default y
+
 menu "UML-specific options"
 
 config MODE_TT
diff -puN kernel/irq/manage.c~uml-gen-irq-conditionalize kernel/irq/manage.c
--- linux-2.6.git/kernel/irq/manage.c~uml-gen-irq-conditionalize	2005-06-07 02:25:25.000000000 +0200
+++ linux-2.6.git-paolo/kernel/irq/manage.c	2005-06-07 02:25:25.000000000 +0200
@@ -6,6 +6,7 @@
  * This file contains driver APIs to the irq subsystem.
  */
 
+#include <linux/config.h>
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/random.h>
@@ -256,8 +257,11 @@ void free_irq(unsigned int irq, void *de
 			/* Found it - now remove it from the list of entries */
 			*pp = action->next;
 
+			/* Currently used only by UML, might disappear one day.*/
+#ifdef CONFIG_IRQ_RELEASE_METHOD
 			if (desc->handler->release)
 				desc->handler->release(irq, dev_id);
+#endif
 
 			if (!desc->action) {
 				desc->status |= IRQ_DISABLED;
diff -puN include/linux/irq.h~uml-gen-irq-conditionalize include/linux/irq.h
--- linux-2.6.git/include/linux/irq.h~uml-gen-irq-conditionalize	2005-06-07 02:25:25.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/irq.h	2005-06-07 02:25:25.000000000 +0200
@@ -47,7 +47,10 @@ struct hw_interrupt_type {
 	void (*ack)(unsigned int irq);
 	void (*end)(unsigned int irq);
 	void (*set_affinity)(unsigned int irq, cpumask_t dest);
+	/* Currently used only by UML, might disappear one day.*/
+#ifdef CONFIG_IRQ_RELEASE_METHOD
 	void (*release)(unsigned int irq, void *dev_id);
+#endif
 };
 
 typedef struct hw_interrupt_type  hw_irq_controller;
_
