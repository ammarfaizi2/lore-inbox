Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWERWv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWERWv3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 18:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWERWv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 18:51:29 -0400
Received: from xenotime.net ([66.160.160.81]:38635 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751116AbWERWv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 18:51:28 -0400
Date: Thu, 18 May 2006 15:53:57 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] kmap tracking
Message-Id: <20060518155357.04066e9c.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Track kmap/kunmap call history, storing caller function address,
action, and time (jiffies), if CONFIG_DEBUG_KMAP is enabled.
Based on a patch to 2.4.21 by Zach Brown that was used successfully
at Oracle to track down some kmap/kunmap problems.
Built with CONFIG_DEBUG_KMAP =y and =n.

Creates "kmap-history" in debugfs.
Any write to kmap-history clears the history table.

Output format is (all tab-separated):
table_index action_index next_flag caller_function+offset/size refcount jiffies

Example:
99      0       -       do_execve+0x133/0x1bf   2       39340
99      1       -       do_execve+0x133/0x1bf   2       39340
99      2       +       proc_pid_cmdline+0x53/0xeb      2       4294946079
99      3       -       proc_pid_cmdline+0x53/0xeb      2       4294946079
99      4       -       copy_strings_kernel+0x24/0x2b   2       39340
99      5       -       copy_strings_kernel+0x24/0x2b   2       39340
99      6       -       do_execve+0x11d/0x1bf   2       39340
99      7       -       do_execve+0x11d/0x1bf   2       39340

+ = next; next entry for this table_index goes here.

Each history table row tracks up to 8 actions on it.  This is a
circular history table per kmap address row, so the 8 most recent
actions are stored and older actions on each row are lost.

Todo:  add tracking for kmap* variants (atomic, pfn, etc.).

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/Kconfig.debug    |    8 +
 arch/i386/mm/highmem.c     |   19 ----
 include/asm-i386/highmem.h |   49 +++++++++++
 lib/Kconfig.debug          |    2 
 mm/highmem.c               |  187 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 242 insertions(+), 23 deletions(-)

--- linux-2.6.17-rc4.orig/mm/highmem.c
+++ linux-2.6.17-rc4/mm/highmem.c
@@ -27,8 +27,50 @@
 #include <linux/hash.h>
 #include <linux/highmem.h>
 #include <linux/blktrace_api.h>
+#include <linux/jiffies.h>
+#include <linux/kallsyms.h>
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_DEBUG_KMAP
+
+#define NUM_ACTIONS 8
+#define NUM_ACTIONS_MASK (NUM_ACTIONS - 1)
+
+struct kmap_action {
+	unsigned long caller;	/* caller's return address */
+	int what;	/* add, decrement, etc. */
+	int count;	/* reference count */
+	unsigned long jiffies;
+};
+
+enum {
+	KMAP_FIRST = 1,
+	KMAP_ADDREF,
+	KMAP_DECREF,
+	KMAP_LAST,
+};
+
+struct kmap_hist {
+	unsigned int next;
+	struct kmap_action acts[NUM_ACTIONS];
+} kh_running[LAST_PKMAP];
+
+static inline void kmap_record_action(unsigned int nr, int action,
+				int refcount, void *retaddr)
+{
+	struct kmap_hist *kh = &kh_running[nr];
+	struct kmap_action *act = &kh->acts[kh->next];
+
+	act->caller = (unsigned long)retaddr;
+	act->what = action;
+	act->count = refcount;
+	act->jiffies = jiffies;
+	kh->next = (kh->next + 1) & NUM_ACTIONS_MASK;
+}
+#else
+#define kmap_record_action(nr, action, refcount, retaddr) do {} while (0)
+#endif
+
 static mempool_t *page_pool, *isa_page_pool;
 
 static void *mempool_alloc_pages_isa(gfp_t gfp_mask, void *data)
@@ -142,7 +184,11 @@ start:
 	return vaddr;
 }
 
+#ifdef CONFIG_DEBUG_KMAP
+void fastcall *kmap_high(struct page *page, void *retaddr)
+#else
 void fastcall *kmap_high(struct page *page)
+#endif
 {
 	unsigned long vaddr;
 
@@ -157,6 +203,8 @@ void fastcall *kmap_high(struct page *pa
 	if (!vaddr)
 		vaddr = map_new_virtual(page);
 	pkmap_count[PKMAP_NR(vaddr)]++;
+	kmap_record_action(PKMAP_NR(vaddr), KMAP_ADDREF,
+			pkmap_count[PKMAP_NR(vaddr)], retaddr);
 	BUG_ON(pkmap_count[PKMAP_NR(vaddr)] < 2);
 	spin_unlock(&kmap_lock);
 	return (void*) vaddr;
@@ -164,7 +212,11 @@ void fastcall *kmap_high(struct page *pa
 
 EXPORT_SYMBOL(kmap_high);
 
+#ifdef CONFIG_DEBUG_KMAP
+void fastcall kunmap_high(struct page *page, void *retaddr)
+#else
 void fastcall kunmap_high(struct page *page)
+#endif
 {
 	unsigned long vaddr;
 	unsigned long nr;
@@ -175,6 +227,13 @@ void fastcall kunmap_high(struct page *p
 	BUG_ON(!vaddr);
 	nr = PKMAP_NR(vaddr);
 
+	if (pkmap_count[nr] == 2)
+		kmap_record_action(PKMAP_NR(vaddr), KMAP_LAST,
+				pkmap_count[nr], retaddr);
+	else
+		kmap_record_action(PKMAP_NR(vaddr), KMAP_DECREF,
+				pkmap_count[nr], retaddr);
+
 	/*
 	 * A count must never go down to zero
 	 * without a TLB flush!
@@ -600,3 +659,131 @@ void __init page_address_init(void)
 }
 
 #endif	/* defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL) */
+
+/* --------------------------------------------------- */
+
+#ifdef CONFIG_DEBUG_KMAP
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+static void *kmap_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct kmap_hist *kha = seq->private;
+
+	if (*pos < 0 || *pos >= LAST_PKMAP)
+		return NULL;
+	return &kha[*pos];
+}
+
+static void *kmap_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	(*pos)++;
+	return kmap_seq_start(seq, pos);
+}
+
+static int kmap_seq_show(struct seq_file *seq, void *v)
+{
+	struct kmap_hist *khbase = seq->private;
+	struct kmap_hist *kh = v;
+	struct kmap_action *act;
+	unsigned int ind;
+	const char *name;
+	char *modname;
+	unsigned long offset, size;
+	char namebuf[KSYM_NAME_LEN + 1];
+	char caller[256];
+
+	spin_lock(&kmap_lock);
+	for (ind = 0; ind < NUM_ACTIONS; ind++) {
+		act = &kh->acts[ind];
+		name = kallsyms_lookup(act->caller, &size, &offset,
+			&modname, namebuf);
+		if (!name)
+			sprintf(caller, "0x%lx", act->caller);
+		else if (modname)
+			sprintf(caller, "%s+%#lx/%#lx [%s]", name, offset,
+				size, modname);
+		else
+			sprintf(caller, "%s+%#lx/%#lx", name, offset, size);
+		seq_printf(seq, "%u\t%u\t%c\t%s\t%d\t%lu\n",
+				kh - &khbase[0], ind,
+				ind == kh->next ? '+' : '-',
+				caller, act->count,
+				act->jiffies);
+	}
+	spin_unlock(&kmap_lock);
+
+	return 0;
+}
+
+static void kmap_seq_stop(struct seq_file *seq, void *v)
+{
+}
+
+static struct seq_operations kmap_seq_ops = {
+	.start  = kmap_seq_start,
+	.next   = kmap_seq_next,
+	.stop   = kmap_seq_stop,
+	.show   = kmap_seq_show,
+};
+
+static int kmap_shared_open(struct inode *inode, struct file *file,
+			  struct kmap_hist *source)
+{
+	int ret;
+
+	ret = seq_open(file, &kmap_seq_ops);
+	if (!ret) {
+		struct seq_file *seq = file->private_data;
+		seq->private = source;
+	}
+	return ret;
+}
+
+/* *any* write here clears the kmap history tables */
+static ssize_t kmap_reset_write(struct file *file, const char __user *buf,
+				size_t count, loff_t *pos)
+{
+	spin_lock(&kmap_lock);
+	memset(kh_running, 0, sizeof(kh_running));
+	spin_unlock(&kmap_lock);
+	return count;
+}
+
+static int kmap_running_fop_open(struct inode *inode, struct file *file)
+{
+	return kmap_shared_open(inode, file, kh_running);
+}
+
+struct file_operations kmap_running_seq_fops = {
+	.open = kmap_running_fop_open,
+	.read = seq_read,
+	.write = kmap_reset_write,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static struct dentry *kmap_history_file;
+
+static __init int kmap_history_init(void)
+{
+	kmap_history_file = debugfs_create_file("kmap-history", 0644, NULL,
+			kh_running, &kmap_running_seq_fops);
+	if (!kmap_history_file)
+		goto out1;
+
+	return 0;
+
+out1:
+	return -ENOMEM;
+}
+
+static void kmap_history_exit(void)
+{
+	debugfs_remove(kmap_history_file);
+}
+
+subsys_initcall(kmap_history_init);
+module_exit(kmap_history_exit);
+#endif /* CONFIG_DEBUG_KMAP */
--- linux-2.6.17-rc4.orig/arch/i386/mm/highmem.c
+++ linux-2.6.17-rc4/arch/i386/mm/highmem.c
@@ -1,23 +1,6 @@
 #include <linux/highmem.h>
 #include <linux/module.h>
 
-void *kmap(struct page *page)
-{
-	might_sleep();
-	if (!PageHighMem(page))
-		return page_address(page);
-	return kmap_high(page);
-}
-
-void kunmap(struct page *page)
-{
-	if (in_interrupt())
-		BUG();
-	if (!PageHighMem(page))
-		return;
-	kunmap_high(page);
-}
-
 /*
  * kmap_atomic/kunmap_atomic is significantly faster than kmap/kunmap because
  * no global lock is needed and because the kmap code must perform a global TLB
@@ -106,8 +89,6 @@ struct page *kmap_atomic_to_page(void *p
 	return pte_page(*pte);
 }
 
-EXPORT_SYMBOL(kmap);
-EXPORT_SYMBOL(kunmap);
 EXPORT_SYMBOL(kmap_atomic);
 EXPORT_SYMBOL(kunmap_atomic);
 EXPORT_SYMBOL(kmap_atomic_to_page);
--- linux-2.6.17-rc4.orig/include/asm-i386/highmem.h
+++ linux-2.6.17-rc4/include/asm-i386/highmem.h
@@ -63,11 +63,54 @@ extern pte_t *pkmap_page_table;
 #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
-extern void * FASTCALL(kmap_high(struct page *page));
+#ifndef CONFIG_DEBUG_KMAP
+extern void *FASTCALL(kmap_high(struct page *page));
 extern void FASTCALL(kunmap_high(struct page *page));
 
-void *kmap(struct page *page);
-void kunmap(struct page *page);
+#define kmap(page)	__kmap(page)
+#define kunmap(page)	__kunmap(page)
+
+static inline void *__kmap(struct page *page)
+{
+	might_sleep();
+	if (!PageHighMem(page))
+		return page_address(page);
+	return kmap_high(page);
+}
+
+static inline void __kunmap(struct page *page)
+{
+	if (in_interrupt())
+		BUG();
+	if (!PageHighMem(page))
+		return;
+	kunmap_high(page);
+}
+#else
+extern void *FASTCALL(kmap_high(struct page *page, void *retaddr));
+extern void FASTCALL(kunmap_high(struct page *page, void *retaddr));
+
+#define kmap(page)	__kmap(page, __builtin_return_address(0))
+#define kunmap(page)	__kunmap(page, __builtin_return_address(0))
+
+static inline void *__kmap(struct page *page, void *retaddr)
+{
+	might_sleep();
+	if (!PageHighMem(page))
+		return page_address(page);
+	return kmap_high(page, retaddr);
+}
+
+static inline void __kunmap(struct page *page, void *retaddr)
+{
+	if (in_interrupt())
+		BUG();
+	if (!PageHighMem(page))
+		return;
+	kunmap_high(page, retaddr);
+}
+#endif
+
 void *kmap_atomic(struct page *page, enum km_type type);
 void kunmap_atomic(void *kvaddr, enum km_type type);
 void *kmap_atomic_pfn(unsigned long pfn, enum km_type type);
--- linux-2.6.17-rc4.orig/arch/i386/Kconfig.debug
+++ linux-2.6.17-rc4/arch/i386/Kconfig.debug
@@ -51,6 +51,14 @@ config DEBUG_PAGEALLOC
 	  This results in a large slowdown, but helps to find certain types
 	  of memory corruptions.
 
+config DEBUG_KMAP
+	bool "Keep history of kmap/kunmap actions"
+	depends on DEBUG_KERNEL && HIGHMEM
+	help
+	  Keep a table of kmap/kunmap actions for developer debugging.
+	  This table is accessible via debugfs, file "kmap-history".
+	  The data in it can be cleared (reset) by any write to it.
+
 config DEBUG_RODATA
 	bool "Write protect kernel read-only data structures"
 	depends on DEBUG_KERNEL
--- linux-2.6.17-rc4.orig/lib/Kconfig.debug
+++ linux-2.6.17-rc4/lib/Kconfig.debug
@@ -134,7 +134,7 @@ config DEBUG_HIGHMEM
 	bool "Highmem debugging"
 	depends on DEBUG_KERNEL && HIGHMEM
 	help
-	  This options enables addition error checking for high memory systems.
+	  Enables additional error checking for high memory systems.
 	  Disable for production systems.
 
 config DEBUG_BUGVERBOSE


---
