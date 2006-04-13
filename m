Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWDMBJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWDMBJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 21:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWDMBJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 21:09:10 -0400
Received: from fmr20.intel.com ([134.134.136.19]:63629 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932394AbWDMBJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 21:09:09 -0400
Subject: Re: [PATCH 1/3] swsusp add architecture special saveable pages
	support
From: Shaohua Li <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, rjw@sisk.pl, pavel@suse.cz
In-Reply-To: <20060412141642.63debf90.akpm@osdl.org>
References: <1144809499.2865.39.camel@sli10-desk.sh.intel.com>
	 <20060412141642.63debf90.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 09:07:45 +0800
Message-Id: <1144890465.2865.57.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-12 at 14:16 -0700, Andrew Morton wrote:
> Shaohua Li <shaohua.li@intel.com> wrote:
> >
> > +static int save_arch_mem(void)
> > +{
> > +	void *kaddr;
> > +	struct arch_saveable_page *tmp = arch_pages;
> > +
> > +	pr_debug("swsusp: Saving arch specific memory");
> > +	while (tmp) {
> > +		tmp->data = (void *)get_zeroed_page(GFP_ATOMIC);
> 
> There's no need to zero the page here.
Ok.
> 
> > +		if (!tmp->data)
> > +			return -ENOMEM;
> > +		/* arch pages might haven't a 'struct page' */
> > +		kaddr = kmap_atomic_pfn(tmp->pfn, KM_PTE0);
> > +		memcpy(tmp->data, kaddr, PAGE_SIZE);
> > +		kunmap_atomic(kaddr, KM_PTE0);
> 
> Why was KM_PTE0 chosen here?
Any one is ok here, but maybe KM_USER0 is better. Fixed.

1. Add architecture specific pages save/restore support. Next two patches will
use this to save/restore 'ACPI NVS' pages.
2. Allow reserved pages 'nosave'. This could avoid save/restore BIOS reserved
pages.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc1-root/include/linux/suspend.h |    1 
 linux-2.6.17-rc1-root/kernel/power/power.h    |    4 +
 linux-2.6.17-rc1-root/kernel/power/snapshot.c |  100 +++++++++++++++++++++++++-
 linux-2.6.17-rc1-root/kernel/power/swsusp.c   |   18 +---
 4 files changed, 108 insertions(+), 15 deletions(-)

diff -puN kernel/power/snapshot.c~swsusp_save_pages kernel/power/snapshot.c
--- linux-2.6.17-rc1/kernel/power/snapshot.c~swsusp_save_pages	2006-04-10 09:14:35.000000000 +0800
+++ linux-2.6.17-rc1-root/kernel/power/snapshot.c	2006-04-12 07:11:31.000000000 +0800
@@ -39,6 +39,78 @@ static unsigned int nr_copy_pages;
 static unsigned int nr_meta_pages;
 static unsigned long *buffer;
 
+struct arch_saveable_page {
+	unsigned long pfn;
+	void *data;
+	struct arch_saveable_page *next;
+};
+static struct arch_saveable_page *arch_pages;
+
+int swsusp_add_arch_pages(unsigned long start, unsigned long end)
+{
+	struct arch_saveable_page *tmp;
+
+	while (start <= end) {
+		tmp = kzalloc(sizeof(struct arch_saveable_page), GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+		tmp->pfn = start;
+		tmp->next = arch_pages;
+		start++;
+		arch_pages = tmp;
+	}
+	return 0;
+}
+
+static unsigned int count_arch_pages(void)
+{
+	unsigned int count = 0;
+	struct arch_saveable_page *tmp = arch_pages;
+	while (tmp) {
+		count++;
+		tmp = tmp->next;
+	}
+	return count;
+}
+
+static int save_arch_mem(void)
+{
+	void *kaddr;
+	struct arch_saveable_page *tmp = arch_pages;
+
+	pr_debug("swsusp: Saving arch specific memory");
+	while (tmp) {
+		tmp->data = (void *)__get_free_page(GFP_ATOMIC);
+		if (!tmp->data)
+			return -ENOMEM;
+		/* arch pages might haven't a 'struct page' */
+		kaddr = kmap_atomic_pfn(tmp->pfn, KM_USER0);
+		memcpy(tmp->data, kaddr, PAGE_SIZE);
+		kunmap_atomic(kaddr, KM_USER0);
+
+		tmp = tmp->next;
+	}
+	return 0;
+}
+
+static int restore_arch_mem(void)
+{
+	void *kaddr;
+	struct arch_saveable_page *tmp = arch_pages;
+
+	while (tmp) {
+		if (!tmp->data)
+			continue;
+		kaddr = kmap_atomic_pfn(tmp->pfn, KM_USER0);
+		memcpy(kaddr, tmp->data, PAGE_SIZE);
+		kunmap_atomic(kaddr, KM_USER0);
+		free_page((long)tmp->data);
+		tmp->data = NULL;
+		tmp = tmp->next;
+	}
+	return 0;
+}
+
 #ifdef CONFIG_HIGHMEM
 unsigned int count_highmem_pages(void)
 {
@@ -150,8 +222,35 @@ int restore_highmem(void)
 	}
 	return 0;
 }
+#else
+static unsigned int count_highmem_pages(void) {return 0;}
+static int save_highmem(void) {return 0;}
+static int restore_highmem(void) {return 0;}
 #endif
 
+unsigned int count_special_pages(void)
+{
+	return count_arch_pages() + count_highmem_pages();
+}
+
+int save_special_mem(void)
+{
+	int ret;
+	ret = save_arch_mem();
+	if (!ret)
+		ret = save_highmem();
+	return ret;
+}
+
+int restore_special_mem(void)
+{
+	int ret;
+	ret = restore_arch_mem();
+	if (!ret)
+		ret = restore_highmem();
+	return ret;
+}
+
 static int pfn_is_nosave(unsigned long pfn)
 {
 	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
@@ -177,7 +276,6 @@ static int saveable(struct zone *zone, u
 		return 0;
 
 	page = pfn_to_page(pfn);
-	BUG_ON(PageReserved(page) && PageNosave(page));
 	if (PageNosave(page))
 		return 0;
 	if (PageReserved(page) && pfn_is_nosave(pfn))
diff -puN kernel/power/swsusp.c~swsusp_save_pages kernel/power/swsusp.c
--- linux-2.6.17-rc1/kernel/power/swsusp.c~swsusp_save_pages	2006-04-10 09:14:35.000000000 +0800
+++ linux-2.6.17-rc1-root/kernel/power/swsusp.c	2006-04-11 08:02:02.000000000 +0800
@@ -62,16 +62,6 @@ unsigned long image_size = 500 * 1024 * 
 
 int in_suspend __nosavedata = 0;
 
-#ifdef CONFIG_HIGHMEM
-unsigned int count_highmem_pages(void);
-int save_highmem(void);
-int restore_highmem(void);
-#else
-static int save_highmem(void) { return 0; }
-static int restore_highmem(void) { return 0; }
-static unsigned int count_highmem_pages(void) { return 0; }
-#endif
-
 /**
  *	The following functions are used for tracing the allocated
  *	swap pages, so that they can be freed in case of an error.
@@ -186,7 +176,7 @@ int swsusp_shrink_memory(void)
 
 	printk("Shrinking memory...  ");
 	do {
-		size = 2 * count_highmem_pages();
+		size = 2 * count_special_pages();
 		size += size / 50 + count_data_pages();
 		size += (size + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
 			PAGES_FOR_IO;
@@ -228,7 +218,7 @@ int swsusp_suspend(void)
 		goto Enable_irqs;
 	}
 
-	if ((error = save_highmem())) {
+	if ((error = save_special_mem())) {
 		printk(KERN_ERR "swsusp: Not enough free pages for highmem\n");
 		goto Restore_highmem;
 	}
@@ -239,7 +229,7 @@ int swsusp_suspend(void)
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 Restore_highmem:
-	restore_highmem();
+	restore_special_mem();
 	device_power_up();
 Enable_irqs:
 	local_irq_enable();
@@ -265,7 +255,7 @@ int swsusp_resume(void)
 	 */
 	swsusp_free();
 	restore_processor_state();
-	restore_highmem();
+	restore_special_mem();
 	touch_softlockup_watchdog();
 	device_power_up();
 	local_irq_enable();
diff -puN include/linux/suspend.h~swsusp_save_pages include/linux/suspend.h
--- linux-2.6.17-rc1/include/linux/suspend.h~swsusp_save_pages	2006-04-10 09:14:35.000000000 +0800
+++ linux-2.6.17-rc1-root/include/linux/suspend.h	2006-04-10 09:14:35.000000000 +0800
@@ -72,6 +72,7 @@ struct saved_context;
 void __save_processor_state(struct saved_context *ctxt);
 void __restore_processor_state(struct saved_context *ctxt);
 unsigned long get_safe_page(gfp_t gfp_mask);
+int swsusp_add_arch_pages(unsigned long start, unsigned long end);
 
 /*
  * XXX: We try to keep some more pages free so that I/O operations succeed
diff -puN kernel/power/power.h~swsusp_save_pages kernel/power/power.h
--- linux-2.6.17-rc1/kernel/power/power.h~swsusp_save_pages	2006-04-11 08:00:30.000000000 +0800
+++ linux-2.6.17-rc1-root/kernel/power/power.h	2006-04-11 08:02:03.000000000 +0800
@@ -105,6 +105,10 @@ extern struct bitmap_page *alloc_bitmap(
 extern unsigned long alloc_swap_page(int swap, struct bitmap_page *bitmap);
 extern void free_all_swap_pages(int swap, struct bitmap_page *bitmap);
 
+extern unsigned int count_special_pages(void);
+extern int save_special_mem(void);
+extern int restore_special_mem(void);
+
 extern int swsusp_check(void);
 extern int swsusp_shrink_memory(void);
 extern void swsusp_free(void);
_


