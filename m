Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVBTUuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVBTUuX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 15:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVBTUuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 15:50:23 -0500
Received: from waste.org ([216.27.176.166]:17881 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261855AbVBTUrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 15:47:47 -0500
Date: Sun, 20 Feb 2005 12:47:43 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] /proc/kmalloc
Message-ID: <20050220204743.GE3120@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been sitting on this for over a year now, kicking it out in the
hopes that someone finds it useful. kernel.org was down when I was
tidying this up so it's against 2.6.10 which is what I had handy.

/proc/kmalloc allocation tracing

This quick hack adds accounting for kmalloc/kfree callers. This can
aid in tracking down memory leaks and large dynamic memory users. The
stock version use ~280k of memory for hash tables and can track 32k
active allocations.

Here's some sample output from my laptop:

total bytes allocated: 47118848   
slack bytes allocated:  8717262
net bytes allocated:    2825920
number of allocs:        132796
number of frees:         122629
number of callers:          325
lost callers:                 0
lost allocs:                  0
unknown frees:                0

   total    slack      net alloc/free  caller
   24576        0        0     3/3     copy_thread+0x1ad
     192       56      192     1/0     fbcon_startup+0xc9
   32768        0    32768     1/0     fbcon_startup+0x267
   18720     9360       32   585/584   bit_cursor+0x1a1
    8192        0     8192     1/0     sys_ioperm+0x6c
    8192        0     8192     1/0     register_framebuffer+0x10b
     512        0      512     1/0     fb_alloc_cmap+0x42
     512        0      512     1/0     fb_alloc_cmap+0x55
    8192     3192     8192     1/0     framebuffer_alloc+0x36
     512        0      512     1/0     fb_alloc_cmap+0x68
      64        0       64     1/0     fb_add_videomode+0x52
10334976  4521552        0 80742/80742 soft_cursor+0x67
      32        0       32     1/0     mtrr_file_add+0x8c
     128       36      128     1/0     create_driver+0x20
16842752        0   212992  4112/4060  dup_task_struct+0x3d
    1536        0        0    12/12    radeon_do_probe_i2c_edid+0x5f
     672      336      672    21/0     acpi_os_create_semaphore+0x17
      32       32       32     1/0     acpi_os_create_lock+0xd
     448       28        0     7/7     acpi_os_queue_for_execution+0x2a
    2016      252     1184    63/26    __request_region+0x20
     768      480      768    24/0     register_sysctl_table+0x24
      32        8       32     1/0     radeon_agp_alloc+0x6b
     128       52      128     1/0     radeon_agp_init+0x3f
     224       56      224     7/0     radeon_addmap+0x2b
     224      140      224     7/0     radeon_addmap+0x11f
    4096     1792     4096     1/0     radeon_addbufs_agp+0x197
    1024      896     1024    32/0     radeon_addbufs_agp+0x273
    2880      720     1728    15/6     groups_alloc+0x35
      32       28        0     1/1     radeon_ctxbitmap_next+0xfd
    4096        0     4096     1/0     radeon_ctxbitmap_init+0x26
    2048      732     2048     1/0     radeon_dma_setup+0x1a
      32       16       32     1/0     radeon_addctx+0x77
     768        0      768     6/0     __create_workqueue+0x3b
      32       20       32     1/0     radeon_setup+0x97
      32       16       32     1/0     radeon_setup+0xd7
      64       24       64     2/0     inter_module_register+0x1f
     128       32        0     1/1     sock_kmalloc+0x3d
      64       16       64     1/0     radeon_open_helper+0x51
 5347584  2076992  1048576  3520/3264  alloc_skb+0x34
    4160     1392     4160    28/0     param_sysfs_setup+0x4c
  514304   214784        0  1008/1008  pskb_expand_head+0x4c
      32       22       32     1/0     radeon_setunique+0x73
      32       15       32     1/0     radeon_setunique+0xca
     160       24      160     2/0     radeon_realloc+0x21
     576      360      192    18/12    radeon_vm_open+0x32
     192        0      192     1/0     radeon_stub_getminor+0xa4
   19200     5160        0   112/112   acpi_ut_initialize_buffer+0x24
  269344   111231   195008  5588/1890  acpi_ut_callocate+0x37
   24416    17461        0   761/761   acpi_ut_allocate+0x38
     512      248      512     1/0     radeon_do_init_cp+0x2b
     320      266      320    10/0     net_sysctl_strdup+0x2a
      64       40       64     2/0     use_module+0x8c
...



Index: km/init/Kconfig
===================================================================
--- km.orig/init/Kconfig	2004-12-24 13:35:24.000000000 -0800
+++ km/init/Kconfig	2005-02-20 10:51:49.000000000 -0800
@@ -287,6 +287,13 @@ config KALLSYMS_EXTRA_PASS
 	   reported.  KALLSYMS_EXTRA_PASS is only a temporary workaround while
 	   you wait for kallsyms to be fixed.
 
+config KMALLOC_ACCOUNTING
+	default n
+	bool "Enabled accounting of kmalloc/kfree allocations" if EMBEDDED
+	help
+	  This option records kmalloc and kfree activity and reports it via
+	  /proc/kmalloc.
+
 config FUTEX
 	bool "Enable futex support" if EMBEDDED
 	default y
Index: km/mm/slab.c
===================================================================
--- km.orig/mm/slab.c	2004-12-24 13:35:59.000000000 -0800
+++ km/mm/slab.c	2005-02-20 10:50:15.000000000 -0800
@@ -2427,6 +2427,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_node);
 void * __kmalloc (size_t size, int flags)
 {
 	struct cache_sizes *csizep = malloc_sizes;
+	void *a;
 
 	for (; csizep->cs_size; csizep++) {
 		if (size > csizep->cs_size)
@@ -2438,8 +2439,10 @@ void * __kmalloc (size_t size, int flags
 		 */
 		BUG_ON(csizep->cs_cachep == NULL);
 #endif
-		return __cache_alloc(flags & GFP_DMA ?
+		a = __cache_alloc(flags & GFP_DMA ?
 			 csizep->cs_dmacachep : csizep->cs_cachep, flags);
+		kmalloc_account(a, csizep->cs_size, size);
+		return a;
 	}
 	return NULL;
 }
@@ -2543,6 +2546,8 @@ void kfree (const void *objp)
 	kmem_cache_t *c;
 	unsigned long flags;
 
+	kfree_account(objp, ksize(objp));
+
 	if (!objp)
 		return;
 	local_irq_save(flags);
Index: km/mm/kmallocacct.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ km/mm/kmallocacct.c	2005-02-20 12:25:59.000000000 -0800
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
+#define MAX_CALLER_TABLE 1024
+#define MAX_ALLOC_TRACK 32768
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
Index: km/mm/Makefile
===================================================================
--- km.orig/mm/Makefile	2004-12-24 13:35:00.000000000 -0800
+++ km/mm/Makefile	2005-02-20 10:50:15.000000000 -0800
@@ -12,6 +12,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
 			   $(mmu-y)
 
+obj-$(CONFIG_KMALLOC_ACCOUNTING) += kmallocacct.o
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
Index: km/include/linux/slab.h
===================================================================
--- km.orig/include/linux/slab.h	2004-12-24 13:35:40.000000000 -0800
+++ km/include/linux/slab.h	2005-02-20 10:50:15.000000000 -0800
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
 
@@ -84,6 +101,7 @@ extern void *__kmalloc(size_t, int);
 
 static inline void *kmalloc(size_t size, int flags)
 {
+#ifndef CONFIG_KMALLOC_ACCOUNTING
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 #define CACHE(x) \
@@ -102,6 +120,7 @@ found:
 			malloc_sizes[i].cs_dmacachep :
 			malloc_sizes[i].cs_cachep, flags);
 	}
+#endif
 	return __kmalloc(size, flags);
 }
 
Index: km/fs/proc/proc_misc.c
===================================================================
--- km.orig/fs/proc/proc_misc.c	2004-12-24 13:34:00.000000000 -0800
+++ km/fs/proc/proc_misc.c	2005-02-20 10:50:15.000000000 -0800
@@ -358,6 +358,24 @@ static struct file_operations proc_slabi
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
 int show_stat(struct seq_file *p, void *v)
 {
 	int i;
@@ -617,6 +635,9 @@ void __init proc_misc_init(void)
 	create_seq_entry("stat", 0, &proc_stat_operations);
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
+#ifdef CONFIG_KMALLOC_ACCOUNTING
+	create_seq_entry("kmalloc",S_IRUGO,&proc_kmalloc_account_operations);
+#endif
 	create_seq_entry("buddyinfo",S_IRUGO, &fragmentation_file_operations);
 	create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
 	create_seq_entry("diskstats", 0, &proc_diskstats_operations);



-- 
Mathematics is the supreme nostalgia of our time.
