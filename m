Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWDEXwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWDEXwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 19:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWDEXwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 19:52:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11213 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932098AbWDEXwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 19:52:12 -0400
Message-ID: <4434581E.4080505@redhat.com>
Date: Wed, 05 Apr 2006 19:51:58 -0400
From: Hideo AOKI <haoki@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: A test kernel module of OVERCOMMIT_GUESS
References: <4434570F.9030507@redhat.com>
In-Reply-To: <4434570F.9030507@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------090108040004080906060708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090108040004080906060708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Andrew,

This is a kernel module patch which I developed to test my patches.

The module makes a kind of memory pressure situation. After that, the
module tests if the OVERCOMMIT_GUESS detects overcommit.

The module has "mode" option. If you specify "mode=1", the module
tries to allocate pages in the test phase.

Here is the test result when I did "mode=1" test on my machine.

* 2.6.17-rc1-mm1

   kernel: Test MAY be <failed>.
   kernel: allocation failed: out of vmalloc space - use vmalloc=<size> to increase size.
   kernel: allocation failed: out of vmalloc space - use vmalloc=<size> to increase size.
   kernel: Test SURELY was <FAILED>.


* 2.6.17-rc1-mm1 + my patches

   kernel: Test was <PASSED>.


Unfortunately, this kernel module needs another kernel patch.
I will send it in later e-mail.

Please note that I don't intend to propose to apply the module to
kernel tree.

Best regards,
Hideo Aoki

---
Hideo Aoki, Hitachi Computer Products (America) Inc.

--------------090108040004080906060708
Content-Type: text/x-patch;
 name="mm-test_overcommit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-test_overcommit.patch"

A kernel module to test OVERCOMMIT_GUESS.
 
 lib/Kconfig.debug    |   11 +
 mm/Makefile          |    1 
 mm/test_overcommit.c |  515 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 527 insertions(+)

diff -purN linux-2.6.17-rc1-mm1/lib/Kconfig.debug linux-2.6.17-rc1-mm1-test1/lib/Kconfig.debug
--- linux-2.6.17-rc1-mm1/lib/Kconfig.debug	2006-04-04 10:43:57.000000000 -0400
+++ linux-2.6.17-rc1-mm1-test1/lib/Kconfig.debug	2006-04-04 16:30:31.000000000 -0400
@@ -282,6 +282,17 @@ config RCU_TORTURE_TEST
 	  Say M if you want the RCU torture tests to build as a module.
 	  Say N if you are unsure.
 
+config OVERCOMMIT_GUESS_TEST
+	tristate "An overcommit guess testing module"
+	depends on DEBUG_KERNEL && X86
+	default n
+	help
+	  This option provides a kernel module that can test OVERCOMMIT_GUESS
+	  in __vm_enough_memory(). 
+ 
+	  You should say N or M here. Say M if you want to build the module.
+	  Say N if you are unsure.
+
 config WANT_EXTRA_DEBUG_INFORMATION
 	bool
 	select DEBUG_INFO
diff -purN linux-2.6.17-rc1-mm1/mm/Makefile linux-2.6.17-rc1-mm1-test1/mm/Makefile
--- linux-2.6.17-rc1-mm1/mm/Makefile	2006-04-04 10:43:57.000000000 -0400
+++ linux-2.6.17-rc1-mm1-test1/mm/Makefile	2006-04-04 16:23:09.000000000 -0400
@@ -24,4 +24,5 @@ obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
+obj-$(CONFIG_OVERCOMMIT_GUESS_TEST) += test_overcommit.o
 
diff -purN linux-2.6.17-rc1-mm1/mm/test_overcommit.c linux-2.6.17-rc1-mm1-test1/mm/test_overcommit.c
--- linux-2.6.17-rc1-mm1/mm/test_overcommit.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.17-rc1-mm1-test1/mm/test_overcommit.c	2006-04-04 16:23:09.000000000 -0400
@@ -0,0 +1,515 @@
+/*
+ * A kernel module for testing OVERCOMMIT_GUESS. ver 0.0.1
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
+ * MA  02110-1301, USA.
+ */
+/*
+ * This kernel module tests the later part of OVERCOMMIT_GUESS algorithm.
+ * To test the algorithm, the module makes a kind of memory pressure situation.
+ * After that, the module tests if the algorithm detects overcommit.
+ *
+ * You can specify by "mode" module option if the module actually tries to
+ * allocate pages in the situation. 
+ *
+ * You have to apply a kernel patch to use the module currently, since the
+ * module needs to refer some internal symbols for testing.
+ *
+ * The module was tested on only i386 SMP machines.
+ */
+#include <linux/module.h>  /* Needed by all modules */
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>  /* Needed for KERN_INFO */
+
+#include <linux/gfp.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/swap.h>
+#include <linux/vmalloc.h>
+
+#include <asm/kmap_types.h>
+#include <asm/system.h>
+#include <linux/blkdev.h>
+#include <linux/string.h>
+
+/*
+ * Get rid of taint message by declaring code as GPL v2.
+ */
+MODULE_LICENSE("GPL v2");
+
+/*
+ * Module documentation
+ */
+MODULE_AUTHOR("Hideo Aoki");
+MODULE_DESCRIPTION("test module of overcommit guess");
+
+/*
+ * Module parameter(s)
+ */
+enum { MODE_DEFALUT = 0, MODE_DOLASTALLOC = 1 };
+static int mode = MODE_DEFALUT;
+
+module_param(mode, int, S_IRUSR);
+MODULE_PARM_DESC(mode, "test mode. If mode is 1, the module executes actual page allocation in concrete test.");
+
+/*
+ * declarations 
+ */
+#define MOD_MM 1                        /* modify kernel */
+#define DEF_PRT_LV KERN_DEBUG           /* default print level in this mod. */
+
+/*
+ * Page managemnt: We manage allocated pages. When module is unloaded,
+ * the module releases them.
+ */
+struct page_mng_t {
+	struct page *listp;     /* list of allocated pages */
+	int zone;               /* which zone manage */
+};
+
+/* We use head of allocated pages for managing page list */ 
+struct mypage_t {
+	struct page *next_page;
+	int order;              /* page order */
+};
+
+
+enum {
+	NORMAL, HIGH
+};
+
+static struct page_mng_t low_pg; /* LOWMEM pages management */  
+static struct page_mng_t high_pg;/* HIGHMEM pages management */
+static unsigned long committed_pages;/* number of pages committed in the mod.*/
+
+void prepare_test_env(void);
+void final_test(int mode);
+int commit_pages(unsigned long target, struct page_mng_t *mng, int gfp,
+		 char *msg);
+int try_to_commit_pages(int order, int gfp, struct page_mng_t *mng, 
+			unsigned long *n_alloced);
+int alloc_last_pages(unsigned long npage);
+
+/* allocated page management */ 
+int page_mng_init(struct page_mng_t *mng, int gfp);
+void page_mng_add(struct page_mng_t *mng, struct page *newp, int order);
+void page_mng_freeall(struct page_mng_t *mng);
+
+/* zone */
+struct zone *get_zone(char *name);
+void print_zone_info(struct zone *zone, char *msg);
+
+
+/*
+ * initialize module and invoke test functions
+ */
+int init_module(void)
+{
+	int ret; 
+
+	printk(DEF_PRT_LV "Test module was loaded. <mode %d>\n", mode);
+
+	if (mode != MODE_DEFALUT && mode != MODE_DOLASTALLOC) {
+		printk(KERN_ERR "invalid mode. <mode %d>\n", mode);
+		return 1;
+	}
+
+	/*
+	 * making a memory pressure situation
+	 */
+	printk(DEF_PRT_LV "init ...");
+	committed_pages = 0;
+	ret = page_mng_init(&low_pg, GFP_KERNEL);
+	if (ret == 1) {
+		printk(KERN_ERR "failed to init lowmem mng\n");
+		return 1;
+	}
+	ret = page_mng_init(&high_pg, GFP_HIGHUSER);
+	if (ret == 1) {
+		printk(KERN_ERR "failed to init highmem mng\n");
+		return 1;
+	}
+	printk(DEF_PRT_LV "done\n");
+
+	prepare_test_env();
+
+	/*
+	 * concrete test
+	 */
+	printk(DEF_PRT_LV "concrete test ...\n");
+	final_test(mode);
+	printk(DEF_PRT_LV "concrete test ...done.\n");
+
+	/*
+	 * A non 0 return means init_module failed; module can't be loaded.
+	 */
+	return 0;
+}
+
+
+/*
+ * destructor of module
+ */
+void cleanup_module(void)
+{
+	printk(DEF_PRT_LV "Unloading module ...\n");
+	page_mng_freeall(&low_pg);
+	page_mng_freeall(&high_pg);
+	vm_unacct_memory(committed_pages);
+}
+
+
+/*
+ * To prepare test environment, this function repeat to allocate pages
+ * in ZONE_HIGHMEM and ZONE_NORMAL until the number of free pages is
+ * pages_high in the zone.
+ */
+void prepare_test_env(void)
+{
+	struct zone *high_zone; /* high mem zone */
+	struct zone *normal_zone; /* normal zone */
+	int i;
+	int ret;
+	unsigned long target;
+
+	high_zone = get_zone("HighMem");
+	if (high_zone == NULL) {
+		printk(KERN_ERR "fail to get higmem zone\n");
+		return ;
+	}
+	for (i = 0; i < 100; i++) {
+		if (high_zone->free_pages <= high_zone->pages_high) {
+			printk(DEF_PRT_LV "already satisfied\n");
+			break;
+		}
+
+		spin_lock_irq(&high_zone->lru_lock);
+		target = high_zone->free_pages - high_zone->pages_high;
+		spin_unlock_irq(&high_zone->lru_lock);
+		print_zone_info(high_zone, "HIGH");
+		ret = commit_pages(target, &high_pg, GFP_HIGHUSER, "HighMem");
+		if (ret < 0) {
+			printk(KERN_ERR "error high %i\n", i);
+			goto error;
+		}
+
+		print_zone_info(high_zone, "HIGH");
+		/* printk(DEF_PRT_LV "%i\n", i); */
+		blk_congestion_wait(WRITE, HZ/2);
+	}
+
+	normal_zone = get_zone("Normal");
+	if (high_zone == NULL) {
+		printk(KERN_ERR "fail to get normal zone\n");
+		return ;
+	}
+	for (i = 0; i < 100; i++) {
+		if (normal_zone->free_pages <= normal_zone->pages_high) {
+			printk(DEF_PRT_LV "already satisfied\n");
+			break;
+		}
+
+		spin_lock_irq(&normal_zone->lru_lock);
+		target = normal_zone->free_pages - normal_zone->pages_high;
+		spin_unlock_irq(&normal_zone->lru_lock);
+		print_zone_info(normal_zone, "NORMAL");
+		ret = commit_pages(target, &low_pg, GFP_KERNEL, "Normal");
+		if (ret < 0) {
+			printk(KERN_ERR "error %i\n", i);
+			goto error;
+		}
+	
+		print_zone_info(normal_zone, "NORMAL");
+		/* printk(DEF_PRT_LV "%i\n", i); */
+		blk_congestion_wait(WRITE, HZ/2);
+	}
+
+error:
+	return;
+}
+
+/*
+ * main test function
+ */
+void final_test(int mode)
+{
+	int ret;
+	unsigned long n;
+	unsigned long nbuffer;
+	unsigned long ncache;
+	unsigned long nmargin;
+#if MOD_MM
+	unsigned long nslabrec;
+	unsigned long nswap;
+#endif
+	struct sysinfo info;
+	
+	
+	for (nmargin = 1; nmargin < 100000; nmargin *= 10) {
+		si_meminfo(&info);
+		nbuffer = info.bufferram;
+		ncache = get_page_cache_size();
+#if MOD_MM
+		nslabrec = atomic_read(&slab_reclaim_pages);
+		nswap = nr_swap_pages;
+		n = ncache + nslabrec + nmargin + nswap;
+		printk(DEF_PRT_LV "<buf %lu><cache %lu><slab reclaim %lu><swap %lu> <+ %lu> <target %lu>\n",
+		       nbuffer, ncache, nslabrec, nswap, nmargin, n);
+#else
+		n = ncache + nmargin;
+		printk(DEF_PRT_LV "<buf %lu> <cache %lu> <+ %lu> <target %lu>\n",
+		       nbuffer, ncache, nmargin, n);
+#endif
+
+		ret = __vm_enough_memory(n, 0);
+		if (ret != 0) {
+			printk(KERN_ERR "Test was <PASSED>.\n"); 
+			break ;
+		} 
+
+		/* unexpected result */ 
+		committed_pages += n;
+		if (mode == MODE_DOLASTALLOC) {
+			printk(KERN_ERR "Test MAY be <failed>.\n");
+			ret = alloc_last_pages(n);
+			if (ret == 0) {
+				printk(KERN_ERR "Test modeule has problem\n");
+			} else {
+				printk(KERN_ERR "Test SURELY was <FAILED>.\n");
+				break ;
+			}
+		} else {
+			printk(KERN_ERR "Test was <FAILED>\n");
+		}
+	}
+}
+
+int commit_pages(unsigned long target, struct page_mng_t *mng, int gfp,
+		 char *msg)
+{
+	int ret;
+	unsigned long total;
+	unsigned long npage;
+
+	if (target == 0 || mng == NULL)
+		goto error;
+
+	/* 
+	 * try to commit anonymous pages 
+	 */
+	total = 0;
+	while (total < target) {
+		ret = try_to_commit_pages(0, gfp, mng, &npage);
+		if (ret == 1) {
+			printk(DEF_PRT_LV "%s test stoped. <target %lu>\n",
+			       msg, target);
+			return 1;
+		} else if (ret == 0) {
+			total += npage;
+			/* printk(KERN_ERR "p"); */
+		} else if (ret == -1) {
+			printk(KERN_ERR "error %s overcommit.\n", msg);
+			goto error;
+		} else {
+			printk(KERN_ERR "error %s test environment.\n", msg);
+			goto error;
+		}
+	}
+	printk(DEF_PRT_LV "%s <target %lu>, ", msg, target);
+
+	return 0;
+
+ error:
+	return -1;
+}
+
+/*
+ * ret:  1; success (detected overcommit) 
+ *       0: success 
+ *      -1: error   (overcommiet was not detected)
+ */
+int try_to_commit_pages(int order, int gfp, struct page_mng_t *mng, 
+			unsigned long *n_alloced)
+{
+	int ret;
+	long n_pages;
+	struct page *p;
+	
+	n_pages = 1L << order;
+	/* printk(KERN_ERR "<order %d>, <pages %ld>\n,", order, n_pages); */
+
+	*n_alloced = 0;
+
+	ret = __vm_enough_memory(n_pages, 0);
+	if (ret != 0) {
+		printk(KERN_ERR "<order %d>, <pages %ld> ", order, n_pages);
+		printk(KERN_ERR "overcommit was detected.\n");
+		return 1;
+	}
+	committed_pages += n_pages;
+
+	p = alloc_pages(gfp, order);
+	if (p ==  NULL) {
+		/* error */
+		printk(KERN_ERR "<order %d>, <pages %ld> ", order, n_pages);
+		printk(KERN_ERR "allocation failed\n");
+		return -1;
+	} else {
+		page_mng_add(mng, p, order);
+		*n_alloced += n_pages;
+		/*
+		 * printk(KERN_ERR "<order %d>, <pages %ld> <alloced %lu> ",
+		 *        order, n_pages, *n_alloced);
+		 * printk(KERN_ERR " succeed\n");
+		 */
+		return 0;
+	}
+}
+
+/*
+ * 0: success, 1: failure  
+ */
+int alloc_last_pages(unsigned long npage)
+{
+	int i;
+	int ret;
+	void *mem;
+	struct mypage2_t {
+		struct mypage2_t *next;
+	} *endp, *listp, *p, *nextp;
+
+	/*
+	 * allocation scenario 1
+	 */
+	mem = vmalloc(npage * PAGE_SIZE);
+	if (mem != NULL) {
+		printk(KERN_ERR "TEST MODULE HAS PROBLEMS.\n");
+		vfree(mem);
+		return 0;
+	}
+
+	/*
+	 * allocation scenario 2
+	 */
+	for (listp = endp = NULL, i = 0; i < npage; i++) {
+		p = (struct mypage2_t *)vmalloc(PAGE_SIZE);
+		if (p == NULL) {
+			ret = 1;
+			goto release;
+		}
+
+		p->next = NULL;
+		if (listp == NULL)
+			listp = p;
+		else
+			endp->next = p;
+		
+		endp = p;
+	}
+	
+	printk(KERN_ERR "TEST MODULE HAS PROBLEMS.\n");
+	ret = 0;
+	
+release: 
+	for ( ; listp != NULL; listp = nextp) {
+		nextp = listp->next;
+		vfree(listp);
+	}
+
+	return ret;
+}
+
+/*
+ * ret: 1: error, 0: success
+ */
+int page_mng_init(struct page_mng_t *mng, int gfp)
+{
+	mng->listp = NULL;
+	if (gfp == GFP_HIGHUSER)
+		mng->zone = HIGH;
+	else if (gfp == GFP_KERNEL || gfp == GFP_USER)
+		mng->zone = NORMAL;
+	else
+		return 1;
+
+	return 0;
+}
+
+void page_mng_add(struct page_mng_t *mng, struct page *newp, int order)
+{
+	struct mypage_t *p;
+
+	if (mng->zone != NORMAL && mng->zone != HIGH) {
+		printk(KERN_ERR "PAGE_MNG: ERROR \n");
+		return ;
+	}
+
+	p = (struct mypage_t *)kmap_atomic(newp, KM_TYPE_NR);
+	p->order = order;
+	p->next_page = mng->listp;
+	mng->listp = newp;
+
+	kunmap_atomic((void *)p, KM_TYPE_NR);
+}
+
+void page_mng_freeall(struct page_mng_t *mng)
+{
+	int order; 
+	struct page *next;
+	struct mypage_t *p;
+
+	for ( ; mng->listp != NULL; mng->listp = next) {
+		p = (struct mypage_t *)kmap_atomic(mng->listp, KM_TYPE_NR);
+		next = p->next_page;
+		order = p->order;
+		kunmap_atomic((void *)p, KM_TYPE_NR);
+		__free_pages(mng->listp, order);
+	}
+}
+
+struct zone *get_zone(char *name)
+{
+	struct zone *zone;
+	for_each_zone(zone) {
+		if (strcmp(zone->name, name) == 0)
+			return zone;
+	}	
+
+	return NULL;
+}
+
+void print_zone_info(struct zone *zone, char *msg)
+{
+	unsigned long free_pages;
+	unsigned long nr_active;
+	unsigned long nr_inactive;
+	unsigned long present_pages;
+
+	spin_lock_irq(&zone->lru_lock);
+	free_pages = zone->free_pages;
+	nr_active = zone->nr_active;
+	nr_inactive = zone->nr_inactive;
+	present_pages = zone->present_pages;
+	spin_unlock_irq(&zone->lru_lock);
+
+	printk(DEF_PRT_LV "\n%s: <active %lu><inactive %lu><free %lu><sum %lu><present %lu>\n",
+	       msg,
+	       nr_active,
+	       nr_inactive,
+	       free_pages,
+	       nr_active + nr_inactive + free_pages,
+	       present_pages);
+}

--------------090108040004080906060708--
