Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWANTzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWANTzk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 14:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWANTzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 14:55:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2057 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750846AbWANTzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 14:55:15 -0500
Date: Sat, 14 Jan 2006 20:55:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: prasanna@in.ibm.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com,
       davem@davemloft.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/kprobes.c: fix a warning #ifndef ARCH_SUPPORTS_KRETPROBES
Message-ID: <20060114195515.GR29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warning #ifndef ARCH_SUPPORTS_KRETPROBES:

<--  snip  -->

...
  CC      kernel/kprobes.o
kernel/kprobes.c:353: warning: 'pre_handler_kretprobe' defined but not used
...

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm4-sparc64/kernel/kprobes.c.old	2006-01-14 20:17:59.000000000 +0100
+++ linux-2.6.15-mm4-sparc64/kernel/kprobes.c	2006-01-14 20:19:03.000000000 +0100
@@ -344,23 +344,6 @@
 	spin_unlock_irqrestore(&kretprobe_lock, flags);
 }
 
-/*
- * This kprobe pre_handler is registered with every kretprobe. When probe
- * hits it will set up the return probe.
- */
-static int __kprobes pre_handler_kretprobe(struct kprobe *p,
-					   struct pt_regs *regs)
-{
-	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
-	unsigned long flags = 0;
-
-	/*TODO: consider to only swap the RA after the last pre_handler fired */
-	spin_lock_irqsave(&kretprobe_lock, flags);
-	arch_prepare_kretprobe(rp, regs);
-	spin_unlock_irqrestore(&kretprobe_lock, flags);
-	return 0;
-}
-
 static inline void free_rp_inst(struct kretprobe *rp)
 {
 	struct kretprobe_instance *ri;
@@ -578,6 +561,23 @@
 
 #ifdef ARCH_SUPPORTS_KRETPROBES
 
+/*
+ * This kprobe pre_handler is registered with every kretprobe. When probe
+ * hits it will set up the return probe.
+ */
+static int __kprobes pre_handler_kretprobe(struct kprobe *p,
+					   struct pt_regs *regs)
+{
+	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
+	unsigned long flags = 0;
+
+	/*TODO: consider to only swap the RA after the last pre_handler fired */
+	spin_lock_irqsave(&kretprobe_lock, flags);
+	arch_prepare_kretprobe(rp, regs);
+	spin_unlock_irqrestore(&kretprobe_lock, flags);
+	return 0;
+}
+
 int __kprobes register_kretprobe(struct kretprobe *rp)
 {
 	int ret = 0;

