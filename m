Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVASObP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVASObP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 09:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVASObP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 09:31:15 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:38358 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261732AbVASOaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 09:30:23 -0500
Date: Wed, 19 Jan 2005 20:02:54 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, Andi Kleen <ak@muc.de>, ananth@in.ibm.com,
       maneesh@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kprobes x86_64 memory allocation changes
Message-ID: <20050119143254.GA3531@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This patch moves the memory allocation required by kprobes outside spin lock
as suggested by Andi Kleen. Please let me know your comments.

Thanks
Prasanna

	Minor changes to the kprobes code to provide memory allocation
for x86_64 architecture outside kprobes spin lock.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>

---



---

 linux-2.6.11-rc1-prasanna/arch/i386/kernel/kprobes.c    |    6 +++++-
 linux-2.6.11-rc1-prasanna/arch/ppc64/kernel/kprobes.c   |   10 ++++++++--
 linux-2.6.11-rc1-prasanna/arch/sparc64/kernel/kprobes.c |    6 +++++-
 linux-2.6.11-rc1-prasanna/arch/x86_64/kernel/kprobes.c  |   16 +++++++++++++---
 linux-2.6.11-rc1-prasanna/include/linux/kprobes.h       |    1 +
 linux-2.6.11-rc1-prasanna/kernel/kprobes.c              |   13 ++++++++-----
 6 files changed, 40 insertions(+), 12 deletions(-)

diff -puN arch/i386/kernel/kprobes.c~kprobes-x86_64-changes arch/i386/kernel/kprobes.c
--- linux-2.6.11-rc1/arch/i386/kernel/kprobes.c~kprobes-x86_64-changes	2005-01-19 19:46:23.000000000 +0530
+++ linux-2.6.11-rc1-prasanna/arch/i386/kernel/kprobes.c	2005-01-19 19:46:23.000000000 +0530
@@ -61,10 +61,14 @@ static inline int is_IF_modifier(kprobe_
 
 int arch_prepare_kprobe(struct kprobe *p)
 {
-	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
 	return 0;
 }
 
+void arch_copy_kprobe(struct kprobe *p)
+{
+	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
+}
+
 void arch_remove_kprobe(struct kprobe *p)
 {
 }
diff -puN arch/sparc64/kernel/kprobes.c~kprobes-x86_64-changes arch/sparc64/kernel/kprobes.c
--- linux-2.6.11-rc1/arch/sparc64/kernel/kprobes.c~kprobes-x86_64-changes	2005-01-19 19:46:23.000000000 +0530
+++ linux-2.6.11-rc1-prasanna/arch/sparc64/kernel/kprobes.c	2005-01-19 19:46:23.000000000 +0530
@@ -40,9 +40,13 @@
 
 int arch_prepare_kprobe(struct kprobe *p)
 {
+	return 0;
+}
+
+void arch_copy_kprobe(struct kprobe *p)
+{
 	p->ainsn.insn[0] = *p->addr;
 	p->ainsn.insn[1] = BREAKPOINT_INSTRUCTION_2;
-	return 0;
 }
 
 void arch_remove_kprobe(struct kprobe *p)
diff -puN arch/x86_64/kernel/kprobes.c~kprobes-x86_64-changes arch/x86_64/kernel/kprobes.c
--- linux-2.6.11-rc1/arch/x86_64/kernel/kprobes.c~kprobes-x86_64-changes	2005-01-19 19:46:23.000000000 +0530
+++ linux-2.6.11-rc1-prasanna/arch/x86_64/kernel/kprobes.c	2005-01-19 19:46:23.000000000 +0530
@@ -39,6 +39,8 @@
 #include <asm/pgtable.h>
 #include <asm/kdebug.h>
 
+static DECLARE_MUTEX(kprobe_mutex);
+
 /* kprobe_status settings */
 #define KPROBE_HIT_ACTIVE	0x00000001
 #define KPROBE_HIT_SS		0x00000002
@@ -75,17 +77,25 @@ static inline int is_IF_modifier(kprobe_
 int arch_prepare_kprobe(struct kprobe *p)
 {
 	/* insn: must be on special executable page on x86_64. */
+	up(&kprobe_mutex);
 	p->ainsn.insn = get_insn_slot();
+	down(&kprobe_mutex);
 	if (!p->ainsn.insn) {
 		return -ENOMEM;
 	}
-	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE);
 	return 0;
 }
 
+void arch_copy_kprobe(struct kprobe *p)
+{
+	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE);
+}
+
 void arch_remove_kprobe(struct kprobe *p)
 {
+	up(&kprobe_mutex);
 	free_insn_slot(p->ainsn.insn);
+	down(&kprobe_mutex);
 }
 
 static inline void disarm_kprobe(struct kprobe *p, struct pt_regs *regs)
@@ -425,12 +435,12 @@ static kprobe_opcode_t *get_insn_slot(vo
 	}
 
 	/* All out of space.  Need to allocate a new page. Use slot 0.*/
-	kip = kmalloc(sizeof(struct kprobe_insn_page), GFP_ATOMIC);
+	kip = kmalloc(sizeof(struct kprobe_insn_page), GFP_KERNEL);
 	if (!kip) {
 		return NULL;
 	}
 	kip->insns = (kprobe_opcode_t*) __vmalloc(PAGE_SIZE,
-		GFP_ATOMIC|__GFP_HIGHMEM, __pgprot(__PAGE_KERNEL_EXEC));
+		GFP_KERNEL|__GFP_HIGHMEM, __pgprot(__PAGE_KERNEL_EXEC));
 	if (!kip->insns) {
 		kfree(kip);
 		return NULL;
diff -puN include/linux/kprobes.h~kprobes-x86_64-changes include/linux/kprobes.h
--- linux-2.6.11-rc1/include/linux/kprobes.h~kprobes-x86_64-changes	2005-01-19 19:46:23.000000000 +0530
+++ linux-2.6.11-rc1-prasanna/include/linux/kprobes.h	2005-01-19 19:46:23.000000000 +0530
@@ -95,6 +95,7 @@ static inline int kprobe_running(void)
 }
 
 extern int arch_prepare_kprobe(struct kprobe *p);
+extern void arch_copy_kprobe(struct kprobe *p);
 extern void arch_remove_kprobe(struct kprobe *p);
 extern void show_registers(struct pt_regs *regs);
 
diff -puN kernel/kprobes.c~kprobes-x86_64-changes kernel/kprobes.c
--- linux-2.6.11-rc1/kernel/kprobes.c~kprobes-x86_64-changes	2005-01-19 19:46:23.000000000 +0530
+++ linux-2.6.11-rc1-prasanna/kernel/kprobes.c	2005-01-19 19:46:23.000000000 +0530
@@ -76,18 +76,19 @@ struct kprobe *get_kprobe(void *addr)
 int register_kprobe(struct kprobe *p)
 {
 	int ret = 0;
-	unsigned long flags;
+	unsigned long flags = 0;
 
+	if ((ret = arch_prepare_kprobe(p)) != 0) {
+		goto out;
+	}
 	spin_lock_irqsave(&kprobe_lock, flags);
 	INIT_HLIST_NODE(&p->hlist);
 	if (get_kprobe(p->addr)) {
 		ret = -EEXIST;
 		goto out;
 	}
+	arch_copy_kprobe(p);
 
-	if ((ret = arch_prepare_kprobe(p)) != 0) {
-		goto out;
-	}
 	hlist_add_head(&p->hlist,
 		       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
 
@@ -97,14 +98,16 @@ int register_kprobe(struct kprobe *p)
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
       out:
 	spin_unlock_irqrestore(&kprobe_lock, flags);
+	if (ret == -EEXIST)
+		arch_remove_kprobe(p);
 	return ret;
 }
 
 void unregister_kprobe(struct kprobe *p)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&kprobe_lock, flags);
 	arch_remove_kprobe(p);
+	spin_lock_irqsave(&kprobe_lock, flags);
 	*p->addr = p->opcode;
 	hlist_del(&p->hlist);
 	flush_icache_range((unsigned long) p->addr,
diff -puN arch/ppc64/kernel/kprobes.c~kprobes-x86_64-changes arch/ppc64/kernel/kprobes.c
--- linux-2.6.11-rc1/arch/ppc64/kernel/kprobes.c~kprobes-x86_64-changes	2005-01-19 19:52:36.000000000 +0530
+++ linux-2.6.11-rc1-prasanna/arch/ppc64/kernel/kprobes.c	2005-01-19 19:52:49.000000000 +0530
@@ -45,13 +45,19 @@ static struct pt_regs jprobe_saved_regs;
 
 int arch_prepare_kprobe(struct kprobe *p)
 {
-	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
-	if (IS_MTMSRD(p->ainsn.insn[0]) || IS_RFID(p->ainsn.insn[0]))
+	kprobe_opcode_t insn = *p->addr;
+
+	if (IS_MTMSRD(insn) || IS_RFID(insn))
 		/* cannot put bp on RFID/MTMSRD */
 		return 1;
 	return 0;
 }
 
+void arch_copy_kprobe(struct kprobe *p)
+{
+	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
+}
+
 void arch_remove_kprobe(struct kprobe *p)
 {
 }

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
