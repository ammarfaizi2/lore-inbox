Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270247AbUJTCka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270247AbUJTCka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 22:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270312AbUJTCeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 22:34:09 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:61891 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S270268AbUJTCcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 22:32:02 -0400
Date: Tue, 19 Oct 2004 19:31:56 -0700
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] add hook to generic irq code (free_irq)
Message-ID: <20041020023156.GA8597@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed because some architectures (well, presently only UML)
needs to be notified as things are freed.

Signed-off-by: cw@f00f.org


I can't say I'm 100% happy about this, either the name or a somewhat
ugly hook that is called with a spinlock held but for lack of any
better suggestions...

Comments?

 include/asm-i386/hardirq.h   |    3 +++
 include/asm-ppc/hardirq.h    |    3 +++
 include/asm-ppc64/hardirq.h  |    3 +++
 include/asm-x86_64/hardirq.h |    4 ++++
 kernel/irq/manage.c          |    1 +
 5 files changed, 14 insertions(+)


diff -Nru a/include/asm-i386/hardirq.h b/include/asm-i386/hardirq.h
--- a/include/asm-i386/hardirq.h	2004-10-19 17:47:40 -07:00
+++ b/include/asm-i386/hardirq.h	2004-10-19 17:47:40 -07:00
@@ -16,4 +16,7 @@
 
 void ack_bad_irq(unsigned int irq);
 
+/* NOP */
+#define platform_free_irq_notify(i, d)
+
 #endif /* __ASM_HARDIRQ_H */
diff -Nru a/include/asm-ppc/hardirq.h b/include/asm-ppc/hardirq.h
--- a/include/asm-ppc/hardirq.h	2004-10-19 17:47:40 -07:00
+++ b/include/asm-ppc/hardirq.h	2004-10-19 17:47:40 -07:00
@@ -27,5 +27,8 @@
 	BUG();
 }
 
+/* NOP */
+#define platform_free_irq_notify(i, d)
+
 #endif /* __ASM_HARDIRQ_H */
 #endif /* __KERNEL__ */
diff -Nru a/include/asm-ppc64/hardirq.h b/include/asm-ppc64/hardirq.h
--- a/include/asm-ppc64/hardirq.h	2004-10-19 17:47:40 -07:00
+++ b/include/asm-ppc64/hardirq.h	2004-10-19 17:47:40 -07:00
@@ -25,4 +25,7 @@
 	BUG();
 }
 
+/* NOP */
+#define platform_free_irq_notify(i, d)
+
 #endif /* __ASM_HARDIRQ_H */
diff -Nru a/include/asm-x86_64/hardirq.h b/include/asm-x86_64/hardirq.h
--- a/include/asm-x86_64/hardirq.h	2004-10-19 17:47:40 -07:00
+++ b/include/asm-x86_64/hardirq.h	2004-10-19 17:47:40 -07:00
@@ -36,4 +36,8 @@
 #endif
 #endif
 }
+
+/* NOP */
+#define platform_irq_free_notify(i, d)
+
 #endif /* __ASM_HARDIRQ_H */
diff -Nru a/kernel/irq/manage.c b/kernel/irq/manage.c
--- a/kernel/irq/manage.c	2004-10-19 17:47:40 -07:00
+++ b/kernel/irq/manage.c	2004-10-19 17:47:40 -07:00
@@ -260,6 +260,7 @@
 				else
 					desc->handler->disable(irq);
 			}
+			platform_free_irq_notify(irq, dev_id);
 			spin_unlock_irqrestore(&desc->lock,flags);
 			unregister_handler_proc(irq, action);
 
