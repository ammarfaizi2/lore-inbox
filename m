Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVL2TtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVL2TtU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 14:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbVL2TtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 14:49:20 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:5539 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750916AbVL2TtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 14:49:19 -0500
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull
	on x86_64 machines ?
From: Steven Rostedt <rostedt@goodmis.org>
To: Andreas Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Eric Dumazet <dada1@cosmosbay.com>,
       Denis Vlasenko <vda@ilport.com.ua>, Matt Mackall <mpm@selenic.com>,
       Dave Jones <davej@redhat.com>
In-Reply-To: <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net>
	 <43A91C57.20102@cosmosbay.com> <200512281032.15460.vda@ilport.com.ua>
	 <200512281054.26703.vda@ilport.com.ua>
	 <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 14:48:41 -0500
Message-Id: <1135885721.6039.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-28 at 18:57 +0100, Andreas Kleen wrote:
[...]
> 
> This whole discussion is pointless anyways because most kmallocs are
> constant
> sized and with a constant sized kmalloc the slab is selected at compile
> time.
> 
> What would be more interesting would be to redo the complete kmalloc
> slab list.
> 
> I remember the original slab paper from Bonwick actually mentioned that
> power of
> two slabs are the worst choice for a malloc - but for some reason Linux
> chose them
> anyways. That would require a lot of measurements in different workloads
> on the
> actual kmalloc sizes and then select a good list, but could ultimately
> safe
> a lot of memory (ok not that much anymore because the memory intensive
> allocations should all have their own caches, but at least some)
> 
> Most likely the best list is different for 32bit and 64bit too.
> 
> Note that just looking at slabinfo is not enough for this - you need the
> original
> sizes as passed to kmalloc, not the rounded values reported there.
> Should be probably not too hard to hack a simple monitoring script up
> for that
> in systemtap to generate the data.
> 

OK then, after reading this I figured there must be a way to dynamically
allocate slab sizes based on the kmalloc constants.  So I spent last
night and some of this morning coming up with the below patch.

Right now it only works with i386, but I'm sure it can be hacked to work
with all archs.  At compile time it creates a table of sizes for all
kmallocs (outside of slab.c and arch/i386/mm/init.c) that uses a
constant declaration.

This table is then initialized in arch/i386/mm/init.c to use a cache
that is either already created (like the mem_sizes array) or it creates
a new cache of that size (L1 cached aligned), and then updates the
pointers to use that cache.

Here's what was created on my test box:

cat /proc/slabinfo
[...]
dynamic_dma-1536       0      0   1536    5    2 : tunables   24   12    0 : slabdata      0      0      0
dynamic-1536           1      5   1536    5    2 : tunables   24   12    0 : slabdata      1      1      0
dynamic_dma-1280       0      0   1280    3    1 : tunables   24   12    0 : slabdata      0      0      0
dynamic-1280           6      6   1280    3    1 : tunables   24   12    0 : slabdata      2      2      0
dynamic_dma-2176       0      0   2176    3    2 : tunables   24   12    0 : slabdata      0      0      0
dynamic-2176           0      0   2176    3    2 : tunables   24   12    0 : slabdata      0      0      0
dynamic_dma-1152       0      0   1152    7    2 : tunables   24   12    0 : slabdata      0      0      0
dynamic-1152           0      0   1152    7    2 : tunables   24   12    0 : slabdata      0      0      0
dynamic_dma-1408       0      0   1408    5    2 : tunables   24   12    0 : slabdata      0      0      0
dynamic-1408           0      0   1408    5    2 : tunables   24   12    0 : slabdata      0      0      0
dynamic_dma-640        0      0    640    6    1 : tunables   54   27    0 : slabdata      0      0      0
dynamic-640            0      0    640    6    1 : tunables   54   27    0 : slabdata      0      0      0
dynamic_dma-768        0      0    768    5    1 : tunables   54   27    0 : slabdata      0      0      0
dynamic-768            0      0    768    5    1 : tunables   54   27    0 : slabdata      0      0      0
dynamic_dma-3200       0      0   3200    2    2 : tunables   24   12    0 : slabdata      0      0      0
dynamic-3200           8      8   3200    2    2 : tunables   24   12    0 : slabdata      4      4      0
dynamic_dma-896        0      0    896    4    1 : tunables   54   27    0 : slabdata      0      0      0
dynamic-896            9     12    896    4    1 : tunables   54   27    0 : slabdata      3      3      0
dynamic_dma-384        0      0    384   10    1 : tunables   54   27    0 : slabdata      0      0      0
dynamic-384           40     40    384   10    1 : tunables   54   27    0 : slabdata      4      4      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             40     40   8192    1    2 : tunables    8    4    0 : slabdata     40     40      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096             34     34   4096    1    1 : tunables   24   12    0 : slabdata     34     34      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048            266    266   2048    2    1 : tunables   24   12    0 : slabdata    133    133      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024             24     24   1024    4    1 : tunables   54   27    0 : slabdata      6      6      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512              90    112    512    8    1 : tunables   54   27    0 : slabdata     14     14      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             735    735    256   15    1 : tunables  120   60    0 : slabdata     49     49      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            2750   2760    128   30    1 : tunables  120   60    0 : slabdata     92     92      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60    0 : slabdata      0      0      0
size-64              418    472     64   59    1 : tunables  120   60    0 : slabdata      8      8      0
size-32             1175   1243     32  113    1 : tunables  120   60    0 : slabdata     11     11      0
[...]

Not sure if this is worth looking further into, but it might actually be
a way to use less memory.  For example, the above 384 size with 40
objects cost only 4 4k pages, where as these same objects would be 40
512 objects (in size-512) costing 5 4k pages.  Plus the 384 probably has
ON_SLAB management where as the 512 does not.

Comments?

-- Steve

Index: linux-2.6.15-rc7/arch/i386/Kconfig
===================================================================
--- linux-2.6.15-rc7.orig/arch/i386/Kconfig	2005-12-29 09:09:29.000000000 -0500
+++ linux-2.6.15-rc7/arch/i386/Kconfig	2005-12-29 09:09:53.000000000 -0500
@@ -173,6 +173,14 @@
 	depends on HPET_TIMER && RTC=y
 	default y
 
+config DYNAMIC_SLABS
+	bool "Dynamically create slabs for constant kmalloc"
+	default y
+	help
+	  This enables the creation of SLABS using information created at
+	  compile time.  Then on boot up, the slabs are created to fit
+	  more with what was asked for.
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
Index: linux-2.6.15-rc7/arch/i386/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.15-rc7.orig/arch/i386/kernel/vmlinux.lds.S	2005-12-29 09:09:29.000000000 -0500
+++ linux-2.6.15-rc7/arch/i386/kernel/vmlinux.lds.S	2005-12-29 09:09:53.000000000 -0500
@@ -68,6 +68,13 @@
 	*(.data.init_task)
   }
 
+#ifdef CONFIG_DYNAMIC_SLABS
+  . = ALIGN(16);		/* dynamic slab table */
+  __start____slab_addresses = .;
+  __slab_addresses : AT(ADDR(__slab_addresses) - LOAD_OFFSET) { *(__slab_addresses) }
+  __stop____slab_addresses = .;
+#endif
+
   /* will be freed after init */
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
@@ -107,6 +114,14 @@
   .altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
 	*(.altinstr_replacement)
   }
+#ifdef CONFIG_DYNAMIC_SLABS
+  . = ALIGN(16);		/* dynamic slab table */
+  __start____slab_preprocess = .;
+  __slab_preprocess : AT(ADDR(__slab_preprocess) - LOAD_OFFSET) { *(__slab_preprocess) }
+  __slab_process_ret : AT(ADDR(__slab_process_ret) - LOAD_OFFSET) { *(__slab_process_ret) }
+  __stop____slab_preprocess = .;
+#endif
+
   /* .exit.text is discard at runtime, not link time, to deal with references
      from .altinstructions and .eh_frame */
   .exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) { *(.exit.text) }
@@ -119,7 +134,7 @@
   __per_cpu_start = .;
   .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) { *(.data.percpu) }
   __per_cpu_end = .;
-  . = ALIGN(4096);
+ . = ALIGN(4096);
   __init_end = .;
   /* freed after init ends here */
 	
Index: linux-2.6.15-rc7/arch/i386/mm/init.c
===================================================================
--- linux-2.6.15-rc7.orig/arch/i386/mm/init.c	2005-12-29 09:09:29.000000000 -0500
+++ linux-2.6.15-rc7/arch/i386/mm/init.c	2005-12-29 14:31:08.000000000 -0500
@@ -6,6 +6,7 @@
  *  Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
  */
 
+#define DYNAMIC_SLABS_BOOTSTRAP
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/signal.h>
@@ -748,3 +749,187 @@
 	}
 }
 #endif
+
+#ifdef CONFIG_DYNAMIC_SLABS
+extern void __start____slab_preprocess(void);
+extern unsigned long __start____slab_addresses;
+extern unsigned long __stop____slab_addresses;
+
+static __initdata LIST_HEAD(slablist);
+
+struct slab_links {
+	struct cache_sizes *c;
+	struct list_head list;
+};
+
+static struct cache_sizes *find_slab_size(int size)
+{
+	struct list_head *curr;
+	struct slab_links *s;
+
+	list_for_each(curr, &slablist) {
+		s = list_entry(curr, struct slab_links, list);
+		if (s->c->cs_size == size)
+			return s->c;
+	}
+	return NULL;
+}
+
+static void free_slablist(void)
+{
+	struct list_head *curr, *next;
+	struct slab_links *s;
+
+	list_for_each_safe(curr, next, &slablist) {
+		s = list_entry(curr, struct slab_links, list);
+		list_del(&s->list);
+		kfree(s);
+	}
+}
+
+#ifndef ARCH_KMALLOC_MINALIGN
+#define ARCH_KMALLOC_MINALIGN L1_CACHE_BYTES
+#endif
+#ifndef ARCH_KMALLOC_FLAGS
+#define ARCH_KMALLOC_FLAGS SLAB_HWCACHE_ALIGN
+#endif
+#define	BYTES_PER_WORD		sizeof(void *)
+
+#ifdef DEBUG_ADDR
+static __init void print_slab_addresses(int hex)
+{
+	unsigned long *slab_addresses = &__start____slab_addresses;
+	unsigned long *end = &__stop____slab_addresses;
+
+
+	for (; slab_addresses < end; slab_addresses++) {
+		if (hex)
+			printk("slab %p = %lx\n",slab_addresses, *slab_addresses);
+		else
+			printk("slab %p = %ld\n",slab_addresses, *slab_addresses);
+	}
+}
+#else
+# define print_slab_addresses(x) do {} while(0)
+#endif
+
+int __init dynamic_slab_init(void)
+{
+	unsigned long *slab_addresses = &__start____slab_addresses;
+	unsigned long *end = &__stop____slab_addresses;
+	struct cache_sizes *c;
+	struct slab_links *s;
+	unsigned long sizes[] = {
+#define CACHE(C) C,
+#include <linux/kmalloc_sizes.h>
+#undef CACHE
+	};
+	int i;
+
+
+	asm (".section __slab_process_ret,\"ax\"\n"
+	     "ret\n"
+	     ".previous\n");
+
+	__start____slab_preprocess();
+
+	printk("Before update!\n");
+	print_slab_addresses(0);
+
+	/*
+	 * DYNAMIC_SLABS_BOOTSTRAP is defined, so we don't need
+	 * to worry about kmalloc hardcoded.
+	 */
+
+	/*
+	 * This is really bad, but I don't want to go monkey up the
+	 * slab.c to get to the cache_chain.  So right now I just
+	 * allocate a pointer list to search for slabs that are
+	 * of the right size, and then free it at the end.
+	 *
+	 * Hey, you find a better way, then fix this ;)
+	 */
+	for (i=0; i < sizeof(sizes)/sizeof(sizes[0]); i++) {
+		s = kmalloc(sizeof(*s), GFP_ATOMIC);
+		if (!s)
+			panic("Can't create link list for slabs\n");
+		s->c = &malloc_sizes[i];
+		list_add_tail(&s->list, &slablist);
+	}
+
+	for (; slab_addresses < end; slab_addresses++) {
+		char *name;
+		char *name_dma;
+		unsigned long size = *slab_addresses;
+		struct cache_sizes **ptr = (struct cache_sizes**)slab_addresses;
+
+		if (!size)
+			continue;
+
+		size = (size + (L1_CACHE_BYTES-1)) & ~(L1_CACHE_BYTES-1);
+		if (size < BYTES_PER_WORD)
+			size = BYTES_PER_WORD;
+		if (size < ARCH_KMALLOC_MINALIGN)
+			size = ARCH_KMALLOC_MINALIGN;
+
+		c = find_slab_size(size);
+		if (c) {
+			*ptr = c;
+			continue;
+		}
+
+		/*
+		 * Create a cache for this specific size.
+		 */
+		name = kmalloc(25, GFP_ATOMIC);
+		if (!name)
+			panic("Can't allocate name for dynamic slab\n");
+
+		snprintf(name, 25, "dynamic-%ld", size);
+		name_dma = kmalloc(25, GFP_ATOMIC);
+		if (!name_dma)
+			panic("Can't allocate name for dynamic slab\n");
+
+		snprintf(name_dma, 25, "dynamic_dma-%ld", size);
+
+		c = kmalloc(sizeof(*c), GFP_ATOMIC);
+
+		if (!c)
+			panic("Can't allocate cache_size descriptor\n");
+
+		c->cs_size = size;
+
+		/*
+		 * For performance, all the general caches are L1 aligned.
+		 * This should be particularly beneficial on SMP boxes, as it
+		 * eliminates "false sharing".
+		 * Note for systems short on memory removing the alignment will
+		 * allow tighter packing of the smaller caches.
+		 */
+		c->cs_cachep = kmem_cache_create(name,
+				c->cs_size, ARCH_KMALLOC_MINALIGN,
+				(ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL, NULL);
+
+		c->cs_dmacachep = kmem_cache_create(name_dma,
+			c->cs_size, ARCH_KMALLOC_MINALIGN,
+			(ARCH_KMALLOC_FLAGS | SLAB_CACHE_DMA | SLAB_PANIC),
+			NULL, NULL);
+
+		s = kmalloc(sizeof(*s), GFP_ATOMIC);
+		if (!s)
+			panic("Can't create link list for slabs\n");
+		s->c = c;
+		list_add_tail(&s->list, &slablist);
+
+		*ptr = c;
+
+	}
+
+	free_slablist();
+
+	printk("\nAfter update!\n");
+	print_slab_addresses(1);
+
+	return 0;
+}
+#endif
Index: linux-2.6.15-rc7/include/asm-i386/dynamic_slab.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc7/include/asm-i386/dynamic_slab.h	2005-12-29 09:09:53.000000000 -0500
@@ -0,0 +1,20 @@
+
+/*
+ * Included in slab.h
+ *
+ * @c    - cache pointer to return base on size
+ * @size - size of cache.
+ */
+__asm__ __volatile__ (
+	"jmp 2f\n"
+	".section __slab_preprocess,\"ax\"\n"
+	"movl %1,1f\n"
+	".previous\n"
+	".section __slab_addresses,\"aw\"\n"
+	".align 4\n"
+	"1:\n"
+	".long 0\n"
+	".previous\n"
+	"2:\n"
+	"movl 1b, %0\n"
+	: "=r"(c) : "i"(size));
Index: linux-2.6.15-rc7/include/linux/slab.h
===================================================================
--- linux-2.6.15-rc7.orig/include/linux/slab.h	2005-12-29 09:09:29.000000000 -0500
+++ linux-2.6.15-rc7/include/linux/slab.h	2005-12-29 09:23:44.000000000 -0500
@@ -80,6 +80,15 @@
 {
 	if (__builtin_constant_p(size)) {
 		int i = 0;
+#if defined(CONFIG_DYNAMIC_SLABS) && !defined(MODULE) && !defined(DYNAMIC_SLABS_BOOTSTRAP)
+		{
+			struct cache_sizes *c;
+# include <asm/dynamic_slab.h>
+		return kmem_cache_alloc((flags & GFP_DMA) ?
+			c->cs_dmacachep :
+			c->cs_cachep, flags);
+		}
+#endif
 #define CACHE(x) \
 		if (size <= x) \
 			goto found; \
Index: linux-2.6.15-rc7/mm/slab.c
===================================================================
--- linux-2.6.15-rc7.orig/mm/slab.c	2005-12-29 09:09:29.000000000 -0500
+++ linux-2.6.15-rc7/mm/slab.c	2005-12-29 14:04:44.000000000 -0500
@@ -86,6 +86,7 @@
  *	All object allocations for a node occur from node specific slab lists.
  */
 
+#define DYNAMIC_SLABS_BOOTSTRAP
 #include	<linux/config.h>
 #include	<linux/slab.h>
 #include	<linux/mm.h>
@@ -1165,6 +1166,19 @@
 	/* Done! */
 	g_cpucache_up = FULL;
 
+#ifdef CONFIG_DYNAMIC_SLABS
+	{
+		extern int dynamic_slab_init(void);
+		/*
+		 * Create the caches that will handle
+		 * kmallocs of constant sizes.
+		 */
+		dynamic_slab_init();
+	}
+#endif
+	/*
+	 */
+
 	/* Register a cpu startup notifier callback
 	 * that initializes ac_data for all new cpus
 	 */





