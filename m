Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbULCRBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbULCRBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbULCRBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:01:18 -0500
Received: from astro.systems.pipex.net ([62.241.163.6]:13734 "EHLO
	astro.systems.pipex.net") by vger.kernel.org with ESMTP
	id S262372AbULCRAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:00:50 -0500
Date: Fri, 3 Dec 2004 17:01:57 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@ezer.homenet
To: linux-kernel@vger.kernel.org
Subject: [patch-2.6.x] fix compile failure if CONFIG_PROC_KCORE not set.
Message-ID: <Pine.LNX.4.61.0412031632310.4221@ezer.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I know that /proc/kcore support cannot be disabled by normal means but 
since it is conditional upon CONFIG_PROC_KCORE in fs/proc/Makefile it 
makes sense to make sure that kernel compiles even if it is disabled 
manually by editing .config and include/linux/autoconf.h or if in the 
future CONFIG_PROC_KCORE becomes a real CONFIG_ variable.

The patch below only fixes i386 arch. Similar changes are needed for ia64, 
ppc64 and x86_64 architectures (trivial to do but I don't like sending 
untested patches). Note that the proc initialization part in 
fs/proc/proc_misc.c was already correctly checking CONFIG_PROC_KCORE so it 
didn't need fixing. Tested that the kernel compiles and boots fine.

Probably CONFIG_PROC_KCORE should be added to a Kconfig to make this more 
useful.

Kind regards
Tigran

--- arch/i386/mm/init.c.0	2004-12-03 16:24:55.000000000 +0000
+++ arch/i386/mm/init.c	2004-12-03 16:25:34.182931952 +0000
@@ -559,7 +559,9 @@
  extern void set_max_mapnr_init(void);
  #endif /* !CONFIG_DISCONTIGMEM */

+#ifdef CONFIG_PROC_KCORE
  static struct kcore_list kcore_mem, kcore_vmalloc; 
+#endif

  void __init mem_init(void)
  {
@@ -610,9 +612,11 @@
  	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
  	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;

+#ifdef CONFIG_PROC_KCORE
  	kclist_add(&kcore_mem, __va(0), max_low_pfn << PAGE_SHIFT);
  	kclist_add(&kcore_vmalloc, (void *)VMALLOC_START,
  		   VMALLOC_END-VMALLOC_START);
+#endif

  	printk(KERN_INFO "Memory: %luk/%luk available (%dk kernel code, %dk reserved, %dk data, %dk init, %ldk highmem)\n",
  		(unsigned long) nr_free_pages() << (PAGE_SHIFT-10),
--- include/linux/proc_fs.h.0	2004-12-03 16:31:28.177116656 +0000
+++ include/linux/proc_fs.h	2004-12-03 16:44:52.383858648 +0000
@@ -68,11 +68,13 @@
  	int deleted;		/* delete flag */
  };

+#ifdef CONFIG_PROC_KCORE
  struct kcore_list {
  	struct kcore_list *next;
  	unsigned long addr;
  	size_t size;
  };
+#endif

  #ifdef CONFIG_PROC_FS

@@ -221,15 +223,7 @@

  #endif /* CONFIG_PROC_FS */

-#if !defined(CONFIG_PROC_FS)
-static inline void kclist_add(struct kcore_list *new, void *addr, size_t size)
-{
-}
-static inline struct kcore_list * kclist_del(void *addr)
-{
-	return NULL;
-}
-#else
+#ifdef CONFIG_PROC_KCORE
  extern void kclist_add(struct kcore_list *, void *, size_t);
  extern struct kcore_list *kclist_del(void *);
  #endif
