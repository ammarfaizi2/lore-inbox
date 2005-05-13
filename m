Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbVEMSHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbVEMSHj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVEMSHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:07:39 -0400
Received: from mailfe09.swipnet.se ([212.247.155.1]:34712 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262464AbVEMSGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:06:24 -0400
X-T2-Posting-ID: k1c2aGMK8Lj9Cnpb+Eju4eOhqUzXuhsckJNC9B9P7R8=
Date: Fri, 13 May 2005 20:12:19 +0200
From: Frederik Deweerdt <dev.deweerdt@laposte.net>
To: Andrew Morton <akpm@osdl.org>, maneesh@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] kprobes: arch_supports_kretprobes cleanup
Message-ID: <20050513181219.GD26933@gilgamesh.home.res>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, maneesh@in.ibm.com,
	linux-kernel@vger.kernel.org
References: <20050512033100.017958f6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512033100.017958f6.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I felt that the arch_supports_kprobes use was a bit weird.
The constant is not capitalized and is used as a variable for a
C test.
I also added comments (CONFIG_KPROBES) to an #else and an #endif
This patch is against 2.6.12-rc4-mm1, i386 compile tested.

Regards,
Frederik Deweerdt

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@laposte.net>


--

diff -uprN --exclude-from=diff.ignore linux-2.6.12-rc4-mm1/include/asm-i386/kprobes.h linux-2.6.12-rc4-mm1-def/include/asm-i386/kprobes.h
--- linux-2.6.12-rc4-mm1/include/asm-i386/kprobes.h	2005-05-12 16:48:00.000000000 +0200
+++ linux-2.6.12-rc4-mm1-def/include/asm-i386/kprobes.h	2005-05-13 00:05:00.000000000 +0200
@@ -39,7 +39,7 @@ typedef u8 kprobe_opcode_t;
 	: (((unsigned long)current_thread_info()) + THREAD_SIZE - (ADDR)))
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
-#define arch_supports_kretprobes 1
+#define ARCH_SUPPORTS_KRETPROBES
 
 void kretprobe_trampoline(void);
 
diff -uprN --exclude-from=diff.ignore linux-2.6.12-rc4-mm1/include/linux/kprobes.h linux-2.6.12-rc4-mm1-def/include/linux/kprobes.h
--- linux-2.6.12-rc4-mm1/include/linux/kprobes.h	2005-05-12 16:48:00.000000000 +0200
+++ linux-2.6.12-rc4-mm1-def/include/linux/kprobes.h	2005-05-13 10:21:07.000000000 +0200
@@ -93,15 +93,14 @@ struct jprobe {
 	kprobe_opcode_t *entry;	/* probe handling code to jump to */
 };
 
-#ifdef arch_supports_kretprobes
+#ifdef ARCH_SUPPORTS_KRETPROBES
 extern int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs);
 extern void trampoline_post_handler(struct kprobe *p, struct pt_regs *regs,
 							unsigned long flags);
 extern struct task_struct *arch_get_kprobe_task(void *ptr);
 extern void arch_prepare_kretprobe(struct kretprobe *rp, struct pt_regs *regs);
 extern void arch_kprobe_flush_task(struct task_struct *tk, spinlock_t *kp_lock);
-#else
-#define arch_supports_kretprobes		0
+#else /* ARCH_SUPPORTS_KRETPROBES */
 static inline void kretprobe_trampoline(void)
 {
 }
@@ -123,7 +122,7 @@ static inline void arch_kprobe_flush_tas
 {
 }
 #define arch_get_kprobe_task(ptr) ((struct task_struct *)NULL)
-#endif
+#endif /* ARCH_SUPPORTS_KRETPROBES */
 /*
  * Function-return probe -
  * Note:
@@ -189,7 +188,7 @@ struct kretprobe_instance *get_rp_inst_t
 void add_rp_inst(struct kretprobe_instance *ri);
 void kprobe_flush_task(struct task_struct *tk);
 void recycle_rp_inst(struct kretprobe_instance *ri);
-#else
+#else /* CONFIG_KPROBES */
 static inline int kprobe_running(void)
 {
 	return 0;
@@ -221,5 +220,5 @@ static inline void unregister_kretprobe(
 static inline void kprobe_flush_task(struct task_struct *tk)
 {
 }
-#endif
+#endif				/* CONFIG_KPROBES */
 #endif				/* _LINUX_KPROBES_H */
diff -uprN --exclude-from=diff.ignore linux-2.6.12-rc4-mm1/kernel/kprobes.c linux-2.6.12-rc4-mm1-def/kernel/kprobes.c
--- linux-2.6.12-rc4-mm1/kernel/kprobes.c	2005-05-12 16:48:00.000000000 +0200
+++ linux-2.6.12-rc4-mm1-def/kernel/kprobes.c	2005-05-12 23:27:04.000000000 +0200
@@ -390,15 +390,14 @@ void unregister_jprobe(struct jprobe *jp
 	unregister_kprobe(&jp->kp);
 }
 
+#ifdef ARCH_SUPPORTS_KRETPROBES
+
 int register_kretprobe(struct kretprobe *rp)
 {
 	int ret = 0;
 	struct kretprobe_instance *inst;
 	int i;
 
-	if (!arch_supports_kretprobes)
-		return -ENOSYS;
-
 	rp->kp.pre_handler = pre_handler_kretprobe;
 
 	/* Pre-allocate memory for max kretprobe instances */
@@ -428,6 +427,15 @@ int register_kretprobe(struct kretprobe 
 	return ret;
 }
 
+#else /* ARCH_SUPPORTS_KRETPROBES */
+
+int register_kretprobe(struct kretprobe *rp)
+{
+	return -ENOSYS;
+}
+
+#endif /* ARCH_SUPPORTS_KRETPROBES */
+
 void unregister_kretprobe(struct kretprobe *rp)
 {
 	unsigned long flags;
