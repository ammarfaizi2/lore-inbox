Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbVL2B1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbVL2B1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 20:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVL2B1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 20:27:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24803 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964946AbVL2B1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 20:27:10 -0500
Date: Wed, 28 Dec 2005 20:26:16 -0500
From: Dave Jones <davej@redhat.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Andreas Kleen <ak@suse.de>, Denis Vlasenko <vda@ilport.com.ua>,
       Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Message-ID: <20051229012616.GA3286@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matt Mackall <mpm@selenic.com>, Andreas Kleen <ak@suse.de>,
	Denis Vlasenko <vda@ilport.com.ua>,
	Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net> <43A91C57.20102@cosmosbay.com> <200512281032.15460.vda@ilport.com.ua> <200512281054.26703.vda@ilport.com.ua> <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de> <20051228210124.GB1639@waste.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20051228210124.GB1639@waste.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 28, 2005 at 03:01:25PM -0600, Matt Mackall wrote:

 > Something like this:
 > 
 > http://lwn.net/Articles/124374/

Nice toy. Variant attached that works on 2.6.15rc7
- ->cs_size compile error fixed
- inlines kstrdup and kzalloc.
  Otherwise these functions dominate the profile.

		Dave


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6-debug-account-kmalloc.patch"


/proc/kmalloc allocation tracing


 tiny-mpm/fs/proc/proc_misc.c  |   21 ++++
 tiny-mpm/include/linux/slab.h |   19 ++++
 tiny-mpm/init/Kconfig         |    7 +
 tiny-mpm/mm/Makefile          |    2 
 tiny-mpm/mm/kmallocacct.c     |  182 ++++++++++++++++++++++++++++++++++++++++++
 tiny-mpm/mm/slab.c            |    7 +
 6 files changed, 237 insertions(+), 1 deletion(-)

Index: tiny/init/Kconfig
===================================================================
--- tiny.orig/init/Kconfig	2005-10-10 17:41:44.000000000 -0700
+++ tiny/init/Kconfig	2005-10-10 17:41:46.000000000 -0700
@@ -315,6 +315,13 @@ config BUG
           option for embedded systems with no facilities for reporting errors.
           Just say Y.
 
+config KMALLOC_ACCOUNTING
+	default n
+	bool "Enabled accounting of kmalloc/kfree allocations"
+	help
+	  This option records kmalloc and kfree activity and reports it via
+	  /proc/kmalloc.
+
 config BASE_FULL
 	default y
 	bool "Enable full-sized data structures for core" if EMBEDDED
Index: tiny/mm/slab.c
===================================================================
--- tiny.orig/mm/slab.c	2005-10-10 17:32:51.000000000 -0700
+++ tiny/mm/slab.c	2005-10-10 17:41:46.000000000 -0700
@@ -2911,6 +2911,8 @@ EXPORT_SYMBOL(kmalloc_node);
 void *__kmalloc(size_t size, unsigned int __nocast flags)
 {
 	kmem_cache_t *cachep;
+	struct cache_sizes *csizep = malloc_sizes;
+	void *a;
 
 	/* If you want to save a few bytes .text space: replace
 	 * __ with kmem_.
@@ -2920,7 +2921,9 @@ void *__kmalloc(size_t size, unsigned in
 	cachep = __find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return __cache_alloc(cachep, flags);
+	a = __cache_alloc(cachep, flags);
+	kmalloc_account(a, csizep->cs_size, size);
+	return a;
 }
 EXPORT_SYMBOL(__kmalloc);
 
@@ -3020,6 +3023,8 @@ void kfree(const void *objp)
 	kmem_cache_t *c;
 	unsigned long flags;
 
+	kfree_account(objp, ksize(objp));
+
 	if (unlikely(!objp))
 		return;
 	local_irq_save(flags);
Index: tiny/mm/kmallocacct.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ tiny/mm/kmallocacct.c	2005-10-10 17:41:46.000000000 -0700
@@ -0,0 +1,182 @@
+#include	<linux/config.h>
+#include	<linux/seq_file.h>
+#include	<linux/kallsyms.h>
+
+struct kma_caller {
+	const void *caller;
+	int total, net, slack, allocs, frees;
+};
+
+struct kma_list {
+	int callerhash;
+	const void *address;
+};
+
+#define MAX_CALLER_TABLE 512
+#define MAX_ALLOC_TRACK 4096
+
+#define kma_hash(address, size) (((u32)address / (u32)size) % size)
+
+static struct kma_list kma_alloc[MAX_ALLOC_TRACK];
+static struct kma_caller kma_caller[MAX_CALLER_TABLE];
+
+static int kma_callers;
+static int kma_lost_callers, kma_lost_allocs, kma_unknown_frees;
+static int kma_total, kma_net, kma_slack, kma_allocs, kma_frees;
+static spinlock_t kma_lock = SPIN_LOCK_UNLOCKED;
+
+void __kmalloc_account(const void *caller, const void *addr, int size, int req)
+{
+	int i, hasha, hashc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&kma_lock, flags);
+	if(req >= 0) /* kmalloc */
+	{
+		/* find callers slot */
+		hashc = kma_hash(caller, MAX_CALLER_TABLE);
+		for (i = 0; i < MAX_CALLER_TABLE; i++) {
+			if (!kma_caller[hashc].caller ||
+			    kma_caller[hashc].caller == caller)
+				break;
+			hashc = (hashc + 1) % MAX_CALLER_TABLE;
+		}
+
+		if (!kma_caller[hashc].caller)
+			kma_callers++;
+
+		if (i < MAX_CALLER_TABLE) {
+			/* update callers stats */
+			kma_caller[hashc].caller = caller;
+			kma_caller[hashc].total += size;
+			kma_caller[hashc].net += size;
+			kma_caller[hashc].slack += size - req;
+			kma_caller[hashc].allocs++;
+
+			/* add malloc to list */
+			hasha = kma_hash(addr, MAX_ALLOC_TRACK);
+			for (i = 0; i < MAX_ALLOC_TRACK; i++) {
+				if (!kma_alloc[hasha].callerhash)
+					break;
+				hasha = (hasha + 1) % MAX_ALLOC_TRACK;
+			}
+
+			if(i < MAX_ALLOC_TRACK) {
+				kma_alloc[hasha].callerhash = hashc;
+				kma_alloc[hasha].address = addr;
+			}
+			else
+				kma_lost_allocs++;
+		}
+		else {
+			kma_lost_callers++;
+			kma_lost_allocs++;
+		}
+
+		kma_total += size;
+		kma_net += size;
+		kma_slack += size - req;
+		kma_allocs++;
+	}
+	else { /* kfree */
+		hasha = kma_hash(addr, MAX_ALLOC_TRACK);
+		for (i = 0; i < MAX_ALLOC_TRACK ; i++) {
+			if (kma_alloc[hasha].address == addr)
+				break;
+			hasha = (hasha + 1) % MAX_ALLOC_TRACK;
+		}
+
+		if (i < MAX_ALLOC_TRACK) {
+			hashc = kma_alloc[hasha].callerhash;
+			kma_alloc[hasha].callerhash = 0;
+			kma_caller[hashc].net -= size;
+			kma_caller[hashc].frees++;
+		}
+		else
+			kma_unknown_frees++;
+
+		kma_net -= size;
+		kma_frees++;
+	}
+	spin_unlock_irqrestore(&kma_lock, flags);
+}
+
+static void *as_start(struct seq_file *m, loff_t *pos)
+{
+	int i;
+	loff_t n = *pos;
+
+	if (!n) {
+		seq_printf(m, "total bytes allocated: %8d\n", kma_total);
+		seq_printf(m, "slack bytes allocated: %8d\n", kma_slack);
+		seq_printf(m, "net bytes allocated:   %8d\n", kma_net);
+		seq_printf(m, "number of allocs:      %8d\n", kma_allocs);
+		seq_printf(m, "number of frees:       %8d\n", kma_frees);
+		seq_printf(m, "number of callers:     %8d\n", kma_callers);
+		seq_printf(m, "lost callers:          %8d\n",
+			   kma_lost_callers);
+		seq_printf(m, "lost allocs:           %8d\n",
+			   kma_lost_allocs);
+		seq_printf(m, "unknown frees:         %8d\n",
+			   kma_unknown_frees);
+		seq_puts(m, "\n   total    slack      net alloc/free  caller\n");
+	}
+
+	for (i = 0; i < MAX_CALLER_TABLE; i++) {
+		if(kma_caller[i].caller)
+			n--;
+		if(n < 0)
+			return (void *)(i+1);
+	}
+
+	return 0;
+}
+
+static void *as_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	int n = (int)p-1, i;
+	++*pos;
+
+	for (i = n + 1; i < MAX_CALLER_TABLE; i++)
+		if(kma_caller[i].caller)
+			return (void *)(i+1);
+
+	return 0;
+}
+
+static void as_stop(struct seq_file *m, void *p)
+{
+}
+
+static int as_show(struct seq_file *m, void *p)
+{
+	int n = (int)p-1;
+	struct kma_caller *c;
+#ifdef CONFIG_KALLSYMS
+	char *modname;
+	const char *name;
+	unsigned long offset = 0, size;
+	char namebuf[128];
+
+	c = &kma_caller[n];
+	name = kallsyms_lookup((int)c->caller, &size, &offset, &modname,
+			       namebuf);
+	seq_printf(m, "%8d %8d %8d %5d/%-5d %s+0x%lx\n",
+		   c->total, c->slack, c->net, c->allocs, c->frees,
+		   name, offset);
+#else
+	c = &kma_caller[n];
+	seq_printf(m, "%8d %8d %8d %5d/%-5d %p\n",
+		   c->total, c->slack, c->net, c->allocs, c->frees, c->caller);
+#endif
+
+	return 0;
+}
+
+struct seq_operations kmalloc_account_op = {
+	.start	= as_start,
+	.next	= as_next,
+	.stop	= as_stop,
+	.show	= as_show,
+};
+
Index: tiny/mm/Makefile
===================================================================
--- tiny.orig/mm/Makefile	2005-10-10 17:30:45.000000000 -0700
+++ tiny/mm/Makefile	2005-10-10 17:41:46.000000000 -0700
@@ -12,6 +12,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
 			   prio_tree.o $(mmu-y)
 
+obj-$(CONFIG_KMALLOC_ACCOUNTING) += kmallocacct.o
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
Index: tiny/include/linux/slab.h
===================================================================
--- tiny.orig/include/linux/slab.h	2005-10-10 17:32:41.000000000 -0700
+++ tiny/include/linux/slab.h	2005-10-10 17:41:46.000000000 -0700
@@ -53,6 +53,23 @@ typedef struct kmem_cache_s kmem_cache_t
 #define SLAB_CTOR_ATOMIC	0x002UL		/* tell constructor it can't sleep */
 #define	SLAB_CTOR_VERIFY	0x004UL		/* tell constructor it's a verify call */
 
+#ifdef CONFIG_KMALLOC_ACCOUNTING
+void __kmalloc_account(const void *, const void *, int, int);
+
+static void inline kmalloc_account(const void *addr, int size, int req)
+{
+	__kmalloc_account(__builtin_return_address(0), addr, size, req);
+}
+
+static void inline kfree_account(const void *addr, int size)
+{
+	__kmalloc_account(__builtin_return_address(0), addr, size, -1);
+}
+#else
+#define kmalloc_account(a, b, c)
+#define kfree_account(a, b)
+#endif
+
 /* prototypes */
 extern void __init kmem_cache_init(void);
 
@@ -78,6 +95,7 @@ extern void *__kmalloc(size_t, unsigned 
 
 static inline void *kmalloc(size_t size, unsigned int __nocast flags)
 {
+#ifndef CONFIG_KMALLOC_ACCOUNTING
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 #define CACHE(x) \
@@ -96,6 +114,7 @@ found:
 			malloc_sizes[i].cs_dmacachep :
 			malloc_sizes[i].cs_cachep, flags);
 	}
+#endif
 	return __kmalloc(size, flags);
 }
 
Index: tiny/fs/proc/proc_misc.c
===================================================================
--- tiny.orig/fs/proc/proc_misc.c	2005-10-10 17:30:45.000000000 -0700
+++ tiny/fs/proc/proc_misc.c	2005-10-10 17:41:46.000000000 -0700
@@ -337,6 +337,24 @@ static struct file_operations proc_slabi
 	.release	= seq_release,
 };
 
+#ifdef CONFIG_KMALLOC_ACCOUNTING
+
+extern struct seq_operations kmalloc_account_op;
+
+static int kmalloc_account_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &kmalloc_account_op);
+}
+
+static struct file_operations proc_kmalloc_account_operations = {
+	.open		= kmalloc_account_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+#endif
+
 static int show_stat(struct seq_file *p, void *v)
 {
 	int i;
@@ -601,6 +619,9 @@ void __init proc_misc_init(void)
 	create_seq_entry("stat", 0, &proc_stat_operations);
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
+#ifdef CONFIG_KMALLOC_ACCOUNTING
+	create_seq_entry("kmalloc",S_IRUGO,&proc_kmalloc_account_operations);
+#endif
 	create_seq_entry("buddyinfo",S_IRUGO, &fragmentation_file_operations);
 	create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
 	create_seq_entry("zoneinfo",S_IRUGO, &proc_zoneinfo_file_operations);

--- linux-2.6.14/mm/slab.c~	2005-12-28 16:37:04.000000000 -0500
+++ linux-2.6.14/mm/slab.c	2005-12-28 16:37:14.000000000 -0500
@@ -3045,20 +3045,6 @@ void kmem_cache_free(kmem_cache_t *cache
 EXPORT_SYMBOL(kmem_cache_free);
 
 /**
- * kzalloc - allocate memory. The memory is set to zero.
- * @size: how many bytes of memory are required.
- * @flags: the type of memory to allocate.
- */
-void *kzalloc(size_t size, gfp_t flags)
-{
-	void *ret = kmalloc(size, flags);
-	if (ret)
-		memset(ret, 0, size);
-	return ret;
-}
-EXPORT_SYMBOL(kzalloc);
-
-/**
  * kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
  *
--- linux-2.6.14/include/linux/slab.h~	2005-12-28 16:37:19.000000000 -0500
+++ linux-2.6.14/include/linux/slab.h	2005-12-28 16:38:51.000000000 -0500
@@ -118,7 +118,13 @@ found:
 	return __kmalloc(size, flags);
 }
 
-extern void *kzalloc(size_t, gfp_t);
+static inline void *kzalloc(size_t size, gfp_t flags)
+{
+	void *ret = kmalloc(size, flags);
+	if (ret)
+		memset(ret, 0, size);
+	return ret;
+}
 
 /**
  * kcalloc - allocate memory for an array. The memory is set to zero.

--- linux-2.6.14/include/linux/slab.h~	2005-12-28 19:04:06.000000000 -0500
+++ linux-2.6.14/include/linux/slab.h	2005-12-28 19:04:47.000000000 -0500
@@ -126,6 +126,27 @@ static inline void *kzalloc(size_t size,
 	return ret;
 }
 
+/*
+ * kstrdup - allocate space for and copy an existing string
+ *
+ * @s: the string to duplicate
+ * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ */
+static inline char *kstrdup(const char *s, gfp_t gfp)
+{
+	size_t len;
+	char *buf;
+
+	if (!s)
+		return NULL;
+
+	len = strlen(s) + 1;
+	buf = kmalloc(len, gfp);
+	if (buf)
+		memcpy(buf, s, len);
+	return buf;
+}
+
 /**
  * kcalloc - allocate memory for an array. The memory is set to zero.
  * @n: number of elements.
--- linux-2.6.14/mm/slab.c~	2005-12-28 19:04:54.000000000 -0500
+++ linux-2.6.14/mm/slab.c	2005-12-28 19:04:59.000000000 -0500
@@ -3669,25 +3669,3 @@ unsigned int ksize(const void *objp)
 	return obj_reallen(page_get_cache(virt_to_page(objp)));
 }
 
-
-/*
- * kstrdup - allocate space for and copy an existing string
- *
- * @s: the string to duplicate
- * @gfp: the GFP mask used in the kmalloc() call when allocating memory
- */
-char *kstrdup(const char *s, gfp_t gfp)
-{
-	size_t len;
-	char *buf;
-
-	if (!s)
-		return NULL;
-
-	len = strlen(s) + 1;
-	buf = kmalloc(len, gfp);
-	if (buf)
-		memcpy(buf, s, len);
-	return buf;
-}
-EXPORT_SYMBOL(kstrdup);

--- linux-2.6.14/include/linux/string.h~	2005-12-28 19:12:06.000000000 -0500
+++ linux-2.6.14/include/linux/string.h	2005-12-28 19:12:19.000000000 -0500
@@ -88,8 +88,6 @@ extern int memcmp(const void *,const voi
 extern void * memchr(const void *,int,__kernel_size_t);
 #endif
 
-extern char *kstrdup(const char *s, gfp_t gfp);
-
 #ifdef __cplusplus
 }
 #endif

--AhhlLboLdkugWU4S--
