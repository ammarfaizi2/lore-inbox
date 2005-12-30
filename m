Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbVL3EHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVL3EHT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 23:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbVL3EHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 23:07:19 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:58056 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751014AbVL3EHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 23:07:16 -0500
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull
	on x86_64 machines ?
From: Steven Rostedt <rostedt@goodmis.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Dumazet <dada1@cosmosbay.com>,
       Denis Vlasenko <vda@ilport.com.ua>, Andreas Kleen <ak@suse.de>,
       Matt Mackall <mpm@selenic.com>
In-Reply-To: <20051229012616.GA3286@redhat.com>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net>
	 <43A91C57.20102@cosmosbay.com> <200512281032.15460.vda@ilport.com.ua>
	 <200512281054.26703.vda@ilport.com.ua>
	 <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
	 <20051228210124.GB1639@waste.org>  <20051229012616.GA3286@redhat.com>
Content-Type: multipart/mixed; boundary="=-BV1iAP3GrzVVlhllPG4n"
Date: Thu, 29 Dec 2005 23:06:49 -0500
Message-Id: <1135915609.6039.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BV1iAP3GrzVVlhllPG4n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-12-28 at 20:26 -0500, Dave Jones wrote:
> On Wed, Dec 28, 2005 at 03:01:25PM -0600, Matt Mackall wrote:
> 
>  > Something like this:
>  > 
>  > http://lwn.net/Articles/124374/
> 
> Nice toy. Variant attached that works on 2.6.15rc7
> - ->cs_size compile error fixed
> - inlines kstrdup and kzalloc.
>   Otherwise these functions dominate the profile.

Attached is a variant that was refreshed against 2.6.15-rc7 and fixes
the logical bug that your compile error fix made ;)

It should be cachep->objsize not csizep->cs_size.

-- Steve



--=-BV1iAP3GrzVVlhllPG4n
Content-Disposition: attachment; filename=linux-2.6-debug-account-kmalloc.patch
Content-Type: text/x-patch; name=linux-2.6-debug-account-kmalloc.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit


/proc/kmalloc allocation tracing


 tiny-mpm/fs/proc/proc_misc.c  |   21 ++++
 tiny-mpm/include/linux/slab.h |   19 ++++
 tiny-mpm/init/Kconfig         |    7 +
 tiny-mpm/mm/Makefile          |    2 
 tiny-mpm/mm/kmallocacct.c     |  182 ++++++++++++++++++++++++++++++++++++++++++
 tiny-mpm/mm/slab.c            |    7 +
 6 files changed, 237 insertions(+), 1 deletion(-)

Index: linux-2.6.15-rc7/init/Kconfig
===================================================================
--- linux-2.6.15-rc7.orig/init/Kconfig	2005-12-29 22:54:48.000000000 -0500
+++ linux-2.6.15-rc7/init/Kconfig	2005-12-29 22:55:29.000000000 -0500
@@ -328,6 +328,13 @@
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
Index: linux-2.6.15-rc7/mm/slab.c
===================================================================
--- linux-2.6.15-rc7.orig/mm/slab.c	2005-12-29 22:54:48.000000000 -0500
+++ linux-2.6.15-rc7/mm/slab.c	2005-12-29 22:56:13.000000000 -0500
@@ -2924,6 +2924,7 @@
 void *__kmalloc(size_t size, gfp_t flags)
 {
 	kmem_cache_t *cachep;
+	void *a;
 
 	/* If you want to save a few bytes .text space: replace
 	 * __ with kmem_.
@@ -2933,7 +2934,9 @@
 	cachep = __find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return __cache_alloc(cachep, flags);
+	a = __cache_alloc(cachep, flags);
+	kmalloc_account(a, cachep->objsize, size);
+	return a;
 }
 EXPORT_SYMBOL(__kmalloc);
 
@@ -3006,20 +3009,6 @@
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
@@ -3033,6 +3022,8 @@
 	kmem_cache_t *c;
 	unsigned long flags;
 
+	kfree_account(objp, ksize(objp));
+
 	if (unlikely(!objp))
 		return;
 	local_irq_save(flags);
@@ -3610,25 +3601,3 @@
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
Index: linux-2.6.15-rc7/mm/kmallocacct.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc7/mm/kmallocacct.c	2005-12-29 22:55:29.000000000 -0500
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
Index: linux-2.6.15-rc7/mm/Makefile
===================================================================
--- linux-2.6.15-rc7.orig/mm/Makefile	2005-12-29 22:54:48.000000000 -0500
+++ linux-2.6.15-rc7/mm/Makefile	2005-12-29 22:55:29.000000000 -0500
@@ -12,6 +12,7 @@
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
 			   prio_tree.o $(mmu-y)
 
+obj-$(CONFIG_KMALLOC_ACCOUNTING) += kmallocacct.o
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
Index: linux-2.6.15-rc7/include/linux/slab.h
===================================================================
--- linux-2.6.15-rc7.orig/include/linux/slab.h	2005-12-29 22:54:48.000000000 -0500
+++ linux-2.6.15-rc7/include/linux/slab.h	2005-12-29 22:55:29.000000000 -0500
@@ -53,6 +53,23 @@
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
 
@@ -78,6 +95,7 @@
 
 static inline void *kmalloc(size_t size, gfp_t flags)
 {
+#ifndef CONFIG_KMALLOC_ACCOUNTING
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 #define CACHE(x) \
@@ -96,10 +114,38 @@
 			malloc_sizes[i].cs_dmacachep :
 			malloc_sizes[i].cs_cachep, flags);
 	}
+#endif
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
+
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
 
 /**
  * kcalloc - allocate memory for an array. The memory is set to zero.
Index: linux-2.6.15-rc7/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.15-rc7.orig/fs/proc/proc_misc.c	2005-12-29 22:54:48.000000000 -0500
+++ linux-2.6.15-rc7/fs/proc/proc_misc.c	2005-12-29 22:55:29.000000000 -0500
@@ -337,6 +337,24 @@
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
@@ -601,6 +619,9 @@
 	create_seq_entry("stat", 0, &proc_stat_operations);
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
+#ifdef CONFIG_KMALLOC_ACCOUNTING
+	create_seq_entry("kmalloc",S_IRUGO,&proc_kmalloc_account_operations);
+#endif
 	create_seq_entry("buddyinfo",S_IRUGO, &fragmentation_file_operations);
 	create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
 	create_seq_entry("zoneinfo",S_IRUGO, &proc_zoneinfo_file_operations);
Index: linux-2.6.15-rc7/include/linux/string.h
===================================================================
--- linux-2.6.15-rc7.orig/include/linux/string.h	2005-12-29 22:54:48.000000000 -0500
+++ linux-2.6.15-rc7/include/linux/string.h	2005-12-29 22:55:29.000000000 -0500
@@ -88,8 +88,6 @@
 extern void * memchr(const void *,int,__kernel_size_t);
 #endif
 
-extern char *kstrdup(const char *s, gfp_t gfp);
-
 #ifdef __cplusplus
 }
 #endif

--=-BV1iAP3GrzVVlhllPG4n--

