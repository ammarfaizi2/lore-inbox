Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbTJNXj5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 19:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbTJNXj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 19:39:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:60831 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261802AbTJNXjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 19:39:52 -0400
Date: Tue, 14 Oct 2003 16:40:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-Id: <20031014164004.5f698467.akpm@osdl.org>
In-Reply-To: <20031014124457.GB610@krispykreme>
References: <20031014105514.GH765@holomorphy.com>
	<20031014045614.22ea9c4b.akpm@osdl.org>
	<20031014121753.GA610@krispykreme>
	<20031014053154.469255e5.akpm@osdl.org>
	<20031014124457.GB610@krispykreme>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
> 
> > How big?
> 
> Taking a complete guess, 16MB on a 16GB machine wouldnt be missed.
> 
> > I guess it should be scaled by ZONE_DMA+ZONE_NORMAL, skipping ZONE_HIGHMEM.
> 
> Works for me.
> 

OK, I'm testing the below.


 25-akpm/include/linux/mm.h     |    2 ++
 25-akpm/include/linux/mmzone.h |    2 +-
 25-akpm/init/main.c            |    2 +-
 25-akpm/mm/oom_kill.c          |   14 --------------
 25-akpm/mm/page_alloc.c        |   40 +++++++++++++++++++++++++++++++++++++++-
 25-akpm/mm/swap.c              |   20 ++++++++++++++++++++
 6 files changed, 63 insertions(+), 17 deletions(-)

diff -puN mm/page_alloc.c~scale-min_free_kbytes mm/page_alloc.c
--- 25/mm/page_alloc.c~scale-min_free_kbytes	Tue Oct 14 16:25:08 2003
+++ 25-akpm/mm/page_alloc.c	Tue Oct 14 16:32:24 2003
@@ -1589,7 +1589,7 @@ void __init page_alloc_init(void)
  *	that the pages_{min,low,high} values for each zone are set correctly 
  *	with respect to min_free_kbytes.
  */
-void setup_per_zone_pages_min(void)
+static void setup_per_zone_pages_min(void)
 {
 	unsigned long pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);
 	unsigned long lowmem_pages = 0;
@@ -1633,6 +1633,44 @@ void setup_per_zone_pages_min(void)
 }
 
 /*
+ * Initialise min_free_kbytes.
+ *
+ * For small machines we want it small (128k min).  For large machines
+ * we want it large (16MB max).  But it is not linear, because network
+ * bandwidth does not increase linearly with machine size.  We use
+ *
+ *	min_free_kbytes = lowmem_kbytes / sqrt(lowmem_kbytes)
+ *
+ * which yields
+ *
+ *     8MB:		128k
+ *    16MB:		170k
+ *    32MB:		256k
+ *    64MB:		341k
+ *   128MB:		512k
+ *   256MB:		682k
+ *   512MB:		1024k
+ *  1024MB:		1365k
+ *  2048MB:		2048k
+ *  4096MB:		2739k
+ *  8192MB:		4096k
+ * 16348MB:		5461k
+ */
+void __init init_per_zone_pages_min(void)
+{
+	unsigned long lowmem_kbytes;
+
+	lowmem_kbytes = nr_free_buffer_pages() * (PAGE_SIZE >> 10);
+
+	min_free_kbytes = lowmem_kbytes / int_sqrt(lowmem_kbytes);
+	if (min_free_kbytes < 128)
+		min_free_kbytes = 128;
+	if (min_free_kbytes > 16384)
+		min_free_kbytes = 16384;
+	setup_per_zone_pages_min();
+}
+
+/*
  * min_free_kbytes_sysctl_handler - just a wrapper around proc_dointvec() so 
  *	that we can call setup_per_zone_pages_min() whenever min_free_kbytes 
  *	changes.
diff -puN init/main.c~scale-min_free_kbytes init/main.c
--- 25/init/main.c~scale-min_free_kbytes	Tue Oct 14 16:25:08 2003
+++ 25-akpm/init/main.c	Tue Oct 14 16:38:58 2003
@@ -396,7 +396,7 @@ asmlinkage void __init start_kernel(void
 	lock_kernel();
 	printk(linux_banner);
 	setup_arch(&command_line);
-	setup_per_zone_pages_min();
+	init_per_zone_pages_min();
 	setup_per_cpu_areas();
 
 	/*
diff -puN include/linux/mmzone.h~scale-min_free_kbytes include/linux/mmzone.h
--- 25/include/linux/mmzone.h~scale-min_free_kbytes	Tue Oct 14 16:25:08 2003
+++ 25-akpm/include/linux/mmzone.h	Tue Oct 14 16:25:08 2003
@@ -284,7 +284,7 @@ struct ctl_table;
 struct file;
 int min_free_kbytes_sysctl_handler(struct ctl_table *, int, struct file *, 
 					  void *, size_t *);
-extern void setup_per_zone_pages_min(void);
+extern void init_per_zone_pages_min(void);
 
 
 #ifdef CONFIG_NUMA
diff -puN mm/oom_kill.c~scale-min_free_kbytes mm/oom_kill.c
--- 25/mm/oom_kill.c~scale-min_free_kbytes	Tue Oct 14 16:25:08 2003
+++ 25-akpm/mm/oom_kill.c	Tue Oct 14 16:25:08 2003
@@ -24,20 +24,6 @@
 /* #define DEBUG */
 
 /**
- * int_sqrt - oom_kill.c internal function, rough approximation to sqrt
- * @x: integer of which to calculate the sqrt
- * 
- * A very rough approximation to the sqrt() function.
- */
-static unsigned int int_sqrt(unsigned int x)
-{
-	unsigned int out = x;
-	while (x & ~(unsigned int)1) x >>=2, out >>=1;
-	if (x) out -= out >> 2;
-	return (out ? out : 1);
-}	
-
-/**
  * oom_badness - calculate a numeric value for how bad this task has been
  * @p: task struct of which task we should calculate
  *
diff -puN mm/swap.c~scale-min_free_kbytes mm/swap.c
--- 25/mm/swap.c~scale-min_free_kbytes	Tue Oct 14 16:25:08 2003
+++ 25-akpm/mm/swap.c	Tue Oct 14 16:32:36 2003
@@ -380,6 +380,26 @@ void vm_acct_memory(long pages)
 EXPORT_SYMBOL(vm_acct_memory);
 #endif
 
+/**
+ * int_sqrt - rough approximation to sqrt
+ * @x: integer of which to calculate the sqrt
+ *
+ * A very rough approximation to the sqrt() function.
+ */
+unsigned long int_sqrt(unsigned long x)
+{
+	unsigned long out = x;
+
+	while (x & ~(unsigned long)1) {
+		x >>= 2;
+		out >>= 1;
+	}
+
+	if (x)
+		out -= out >> 2;
+
+	return (out ? out : 1);
+}
 
 /*
  * Perform any setup for the swap system
diff -puN include/linux/mm.h~scale-min_free_kbytes include/linux/mm.h
--- 25/include/linux/mm.h~scale-min_free_kbytes	Tue Oct 14 16:25:08 2003
+++ 25-akpm/include/linux/mm.h	Tue Oct 14 16:25:57 2003
@@ -615,6 +615,8 @@ extern struct page * follow_page(struct 
 extern int remap_page_range(struct vm_area_struct *vma, unsigned long from,
 		unsigned long to, unsigned long size, pgprot_t prot);
 
+unsigned long int_sqrt(unsigned long x);
+
 #ifndef CONFIG_DEBUG_PAGEALLOC
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable)

_

