Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbUKXOdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbUKXOdM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbUKXOTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:19:16 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:53914 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262705AbUKXOGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 09:06:35 -0500
Subject: Suspend 2 merge: 49/51: Checksumming
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101300589.5805.392.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 00:02:49 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A plugin for verifying the consistency of an image. Working with kdb, it
can look up the locations of variations. There will always be some
variations shown, simply because we're touching memory before we get
here and as we check the image.

diff -ruN 855-checksumming-old/kernel/power/Kconfig 855-checksumming-new/kernel/power/Kconfig
--- 855-checksumming-old/kernel/power/Kconfig	2004-11-11 15:24:19.166594960 +1100
+++ 855-checksumming-new/kernel/power/Kconfig	2004-11-09 12:45:35.000000000 +1100
@@ -206,6 +206,15 @@
 			
 				  For normal usage, this option can be turned off.
 
+			config SOFTWARE_SUSPEND_CHECKSUMS
+				tristate '   Compile checksum module'
+				depends on SOFTWARE_SUSPEND2_CORE
+				---help---
+				  This option enables compilation of a checksumming module, which can
+				  be used to verify the correct operation of suspend.
+			
+				  For normal usage, this option can be turned off.
+
 		endif
 
 	endif
diff -ruN 855-checksumming-old/kernel/power/Makefile 855-checksumming-new/kernel/power/Makefile
--- 855-checksumming-old/kernel/power/Makefile	2004-11-11 15:24:19.166594960 +1100
+++ 855-checksumming-new/kernel/power/Makefile	2004-11-08 14:38:16.000000000 +1100
@@ -21,6 +21,7 @@
 obj-$(CONFIG_SOFTWARE_SUSPEND_GZIP_COMPRESSION)	+= suspend_gzip.o
 obj-$(CONFIG_SOFTWARE_SUSPEND_DEVICE_MAPPER)	+= suspend_dm.o
 obj-$(CONFIG_SOFTWARE_SUSPEND_SWAPWRITER)	+= suspend_block_io.o suspend_swap.o
+obj-$(CONFIG_SOFTWARE_SUSPEND_CHECKSUMS)	+= suspend_checksums.o
 
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o $(swsusp-smp-y) disk.o
 
diff -ruN 855-checksumming-old/kernel/power/suspend_checksums.c 855-checksumming-new/kernel/power/suspend_checksums.c
--- 855-checksumming-old/kernel/power/suspend_checksums.c	1970-01-01 10:00:00.000000000 +1000
+++ 855-checksumming-new/kernel/power/suspend_checksums.c	2004-11-11 07:31:01.000000000 +1100
@@ -0,0 +1,610 @@
+#include <linux/suspend.h>
+#include <linux/highmem.h>
+#ifdef CONFIG_KDB
+#include <linux/kdb.h>
+#include <linux/kdbprivate.h>
+#endif
+#include <linux/module.h>
+
+#include "suspend.h"
+#include "plugins.h"
+#include "pageflags.h"
+#include "proc.h"
+
+#define CHECKSUMS_PER_PAGE ((PAGE_SIZE - sizeof(void *)) / sizeof(unsigned long))
+#define NEXT_CHECKSUM_PAGE(page) *((unsigned long *) (((char *) (page)) + PAGE_SIZE - sizeof(void *)))
+static int checksum_pages;
+static unsigned long * first_checksum_page, *last_checksum_page;
+static int num_reload_pages = 0;
+
+struct reload_data
+{
+	int pageset;
+	int pagenumber;
+	struct page * page_address;
+	char * base_version;
+	char * compared_version;
+	struct reload_data * next;
+};
+
+static struct reload_data * first_reload_data, * last_reload_data;
+
+static unsigned long suspend_page_checksum(struct page * page)
+{
+	unsigned long * virt;
+	int i;
+	unsigned long value = 0;
+
+	virt = (unsigned long *) kmap_atomic(page, KM_USER0);
+	for (i = 0; i < (PAGE_SIZE / sizeof(unsigned long)); i++)
+		value += *(virt + i);
+	kunmap_atomic(virt, KM_USER0);
+	return value;
+}
+
+extern void get_first_pbe(struct pbe2 * pbe, struct pagedir * pagedir);
+extern void get_next_pbe(struct pbe2 * pbe);
+
+static void suspend_calculate_checksums(void)
+{
+	struct pbe2 pbe;
+	int i = 0, page_index = 0, whichpagedir = 1;
+	unsigned long * current_checksum_page = first_checksum_page;
+	
+	if (!first_checksum_page) {
+		prepare_status(1, 0, "Unable to checksum at this point.");
+		return;
+	}
+
+	prepare_status(1, 0, "Calculating checksums... ");
+	//printk("First checksum page is %p.\n", current_checksum_page);
+	
+	get_first_pbe(&pbe, &pagedir1);
+	
+	do {
+		//printk("Page number %d... Orig address %p.", i, pbe.origaddress);
+		*(current_checksum_page + page_index) =
+			suspend_page_checksum(pbe.origaddress);
+		//printk("Checksum calculated as %lx.\n", *(current_checksum_page + page_index));
+		i++;
+		page_index++;
+		if (page_index == CHECKSUMS_PER_PAGE) {
+			page_index = 0;
+			current_checksum_page = (unsigned long *)
+				NEXT_CHECKSUM_PAGE(current_checksum_page);
+			//printk("Moving to new checksum page %p.\n", current_checksum_page);
+		}
+		if (whichpagedir == 1) {
+			if (pagedir1.pageset_size == i) {
+				//if (test_suspend_state(SUSPEND_PAGESET2_NOT_LOADED))
+					goto out;
+				get_first_pbe(&pbe, &pagedir2);
+				whichpagedir = 2;
+				i = 0;
+			}
+		} else {
+			if (pagedir2.pageset_size == i)
+				goto out;
+		}
+		get_next_pbe(&pbe);
+	} while(1);
+	
+out:
+	prepare_status(1, 0, "Checksums done.");
+}
+
+void suspend_check_checksums(void)
+{
+	struct pbe2 pbe;
+	int i = 0, page_index = 0, whichpagedir = 1, num_differences = 0;
+	unsigned long * current_checksum_page = first_checksum_page;
+	unsigned long sum_now;
+	struct reload_data * next_reload_data = first_reload_data;
+
+	if (!first_checksum_page) {
+		prepare_status(1, 0, "Unable to checksum at this point.");
+		return;
+	}
+
+	//prepare_status(1, 0, "Checking checksums... ");
+	
+	get_first_pbe(&pbe, &pagedir1);
+	
+	do {
+		/* Also ignore the page containing our variables */
+		if (PageChecksumIgnore(pbe.origaddress) || (pbe.origaddress == virt_to_page(&i)))
+			goto skip;
+				
+		sum_now = suspend_page_checksum(pbe.origaddress);
+		if (sum_now != *(current_checksum_page + page_index)) {
+			num_differences++;
+			if (next_reload_data) {
+				char * virt;
+				next_reload_data->pageset = whichpagedir;
+				next_reload_data->pagenumber = i;
+				next_reload_data->page_address = pbe.origaddress;
+				virt = kmap_atomic(pbe.origaddress, KM_USER0);
+				memcpy(next_reload_data->compared_version, 
+						virt, PAGE_SIZE);
+				kunmap_atomic(virt, KM_USER0);
+				next_reload_data = next_reload_data->next;
+			}
+		}
+skip:
+		i++;
+		page_index++;
+		if (page_index == CHECKSUMS_PER_PAGE) {
+			page_index = 0;
+			current_checksum_page =	(unsigned long *) 
+				NEXT_CHECKSUM_PAGE(current_checksum_page);
+		}
+		if (whichpagedir == 1) {
+			if (pagedir1.pageset_size == i) {
+				//if (test_suspend_state(SUSPEND_PAGESET2_NOT_LOADED))
+					goto out;
+				get_first_pbe(&pbe, &pagedir2);
+				whichpagedir = 2;
+				i = 0;
+			}
+		} else {
+			if (pagedir2.pageset_size == i)
+				goto out;
+		}
+		get_next_pbe(&pbe);
+	
+	} while(1);
+	
+out:
+	//printk("%d/%d different.\n", num_differences, i);
+	//prepare_status(1, 0, "Differencing done.");
+	return;
+}
+
+/*
+ * free_reload_data.
+ *
+ * Reload data begins on a page boundary.
+ */
+static void suspend_free_reload_data(void)
+{
+	struct reload_data * this_data = first_reload_data;
+	struct reload_data *prev_reload_data = this_data;
+	
+	while (this_data) {
+		if (this_data->compared_version) {
+		  ClearPageNosave(virt_to_page(this_data->compared_version));
+		  free_pages((unsigned long) this_data->compared_version, 0);
+		}
+
+		if (this_data->base_version) {
+			ClearPageNosave(virt_to_page(this_data->base_version));
+			free_pages((unsigned long) this_data->base_version, 0);
+		}
+
+		this_data = this_data->next;
+
+		if (!(((unsigned long) this_data) & ~PAGE_MASK)) {
+			//printk("Linking %p to %p.\n", prev_reload_data, this_data);
+			prev_reload_data->next = this_data;
+			prev_reload_data = this_data;
+		}
+	}
+
+	this_data = first_reload_data;
+	while (this_data) {
+		prev_reload_data = this_data;
+		this_data = this_data->next;
+		//printk("Freeing reload page %p.\n", prev_reload_data);
+		free_pages((unsigned long) prev_reload_data, 0);
+		num_reload_pages--;
+	}
+
+	first_reload_data = last_reload_data = NULL;
+
+}
+
+/* suspend_reread_pages()
+ *
+ * Description:	Reread pages from an image for diagnosing differences.
+ * Arguments:	page_list:	A list containing information on pages
+ *                              to be reloaded, sorted by pageset and
+ *                              page index.
+ * Returns:	Zero on success or -1 on failure.
+ */
+
+static int suspend_reread_pages(struct reload_data * page_list)
+{
+	int result = 0, whichtoread;
+	long i;
+	struct pbe2 pbe;
+	struct list_head *filter;
+	struct suspend_plugin_ops * this_filter, * first_filter = get_next_filter(NULL);
+
+	if (!page_list)
+		return 0;
+
+	PRINTFREEMEM("at start of read pageset");
+
+	for (whichtoread = page_list->pageset; whichtoread <= 2; whichtoread++) {
+		struct pagedir * pagedir;
+
+		switch (whichtoread) {
+			case 1:
+				pagedir = &pagedir1;
+				break;
+			case 2:
+				pagedir = &pagedir2;
+				break;
+			default:
+				goto out;
+		}
+
+		suspend_message(SUSPEND_IO, SUSPEND_LOW, 0,
+			"Reread pages from pagedir %d.\n", whichtoread);
+
+		/* Initialise page transformers */
+		list_for_each(filter, &suspend_filters) {
+			this_filter = list_entry(filter, struct suspend_plugin_ops,
+				ops.filter.filter_list);
+			if (this_filter->disabled)
+				continue;
+			if (this_filter->ops.filter.read_init && 
+				this_filter->ops.filter.read_init(whichtoread)) {
+				abort_suspend("Failed to initialise a filter.");
+				return 1;
+			}
+		}
+
+		/* Initialise writer */
+		if (active_writer->ops.writer.read_init(whichtoread)) {
+			abort_suspend("Failed to initialise the writer."); 
+			result = 1;
+			goto reread_free_buffers;
+		}
+
+		get_first_pbe(&pbe, pagedir);
+
+		/* Read the pages */
+		for (i=0; i< pagedir->pageset_size; i++) {
+			/* Read */
+			result = first_filter->ops.filter.read_chunk(
+					virt_to_page(page_list->base_version),
+					SUSPEND_SYNC);
+
+			if (result) {
+				abort_suspend("Failed to read a chunk of the image.");
+				goto reread_free_buffers;
+			}
+
+			/* Interactivity*/
+			check_shift_keys(0, NULL);
+
+			/* Prepare next */
+			get_next_pbe(&pbe);
+
+			/* Got the one we're after? */
+			if (i == page_list->pagenumber)
+				page_list = page_list->next;
+
+			if (page_list->pageset != whichtoread)
+				break;
+		}
+		
+reread_free_buffers:
+
+		/* Cleanup reads from this pageset. */
+		list_for_each_entry(this_filter, &suspend_filters, ops.filter.filter_list) {
+			if (this_filter->disabled)
+				continue;
+			if (this_filter->ops.filter.read_cleanup &&
+				this_filter->ops.filter.read_cleanup()) {
+				abort_suspend("Failed to cleanup a filter.");
+				result = 1;
+			}
+		}
+
+		if (active_writer->ops.writer.read_cleanup()) {
+			abort_suspend("Failed to cleanup the writer.");
+			result = 1;
+		}
+	}
+out:
+	printk("\n");
+
+	return result;
+}
+static void suspend_free_checksum_pages(void)
+{
+	unsigned long * next_checksum_page;
+
+	while(first_checksum_page) {
+		next_checksum_page =
+		  (unsigned long *) NEXT_CHECKSUM_PAGE(first_checksum_page);
+		free_pages((unsigned long) first_checksum_page, 0);
+		first_checksum_page = next_checksum_page;
+	}
+	last_checksum_page = NULL;
+	checksum_pages = 0;
+	suspend_store_free_mem(SUSPEND_FREE_CHECKSUM_PAGES, 1);
+}
+
+#define PRINTABLE(a) (((a) < 32 || (a) > 122) ? '.' : (a))
+extern int PageRangePage(char * seeking);
+
+static void local_print_location(
+		unsigned char * real,
+		unsigned char * original,
+		unsigned char * resumetime)
+{
+	int i;
+
+	for (i = 0; i < 8; i++)
+		if (*(original + i) != *(resumetime + i))
+			break;
+	if (i == 8)
+		return;
+	
+	suspend_message(SUSPEND_INTEGRITY, SUSPEND_HIGH, 1, "%p", real);
+	if (PageNosave(virt_to_page(real)))
+		suspend_message(SUSPEND_INTEGRITY, SUSPEND_HIGH, 1,
+			" [NoSave]");
+	if (PageRangePage(real))
+		suspend_message(SUSPEND_INTEGRITY, SUSPEND_HIGH, 1,
+			" [RangePage]");
+	if (PageSlab(virt_to_page(real)))
+		suspend_message(SUSPEND_INTEGRITY, SUSPEND_HIGH, 1,
+			" [Slab]");
+	suspend_message(SUSPEND_INTEGRITY, SUSPEND_HIGH, 1, "\n");
+
+#ifdef CONFIG_KDB
+	for (i = 0; i < 8; i++) {
+		static const char *last_sym = NULL;
+		if (*(original + i) != *(resumetime + i)) {
+			kdb_symtab_t symtab;
+
+			kdbnearsym((unsigned long) real + i,
+					&symtab);
+
+			if ((!symtab.sym_name) ||
+					(symtab.sym_name == last_sym))
+				continue;
+
+			last_sym = symtab.sym_name;
+
+			suspend_message(SUSPEND_INTEGRITY, SUSPEND_LOW, 1,
+				"%p = %s\n",
+				symtab.sym_start,
+				symtab.sym_name);
+		}
+	}
+#endif
+
+	for (i = 0; i < 8; i++)
+		suspend_message(SUSPEND_INTEGRITY, SUSPEND_HIGH, 1,
+			"%2x ", *(original + i));
+	suspend_message(SUSPEND_INTEGRITY, SUSPEND_HIGH, 1, "    ");
+	for (i = 0; i < 8; i++)
+		suspend_message(SUSPEND_INTEGRITY, SUSPEND_HIGH, 1,
+			"%c", PRINTABLE(*(original + i)));
+	suspend_message(SUSPEND_INTEGRITY, SUSPEND_HIGH, 1, "    ");
+	
+	for (i = 0; i < 8; i++)
+		suspend_message(SUSPEND_INTEGRITY, SUSPEND_HIGH, 1,
+			"%2x ", *(resumetime + i));
+	suspend_message(SUSPEND_INTEGRITY, SUSPEND_HIGH, 1, "    ");
+	for (i = 0; i < 8; i++)
+		suspend_message(SUSPEND_INTEGRITY, SUSPEND_HIGH, 1,
+			"%c", PRINTABLE(*(resumetime + i)));
+	suspend_message(SUSPEND_INTEGRITY, SUSPEND_HIGH, 1, "\n\n");
+}
+
+static int suspend_allocate_reload_data(int pages)
+{
+	struct reload_data * this_data;
+	unsigned long data_start;
+	int i;
+
+	if (num_reload_pages >= pages)
+		return 0;
+
+	for (i = 1; i <= pages; i++) {
+		data_start = suspend2_get_grabbed_pages(0);
+
+		if (!data_start)
+			return -ENOMEM;
+
+		SetPageChecksumIgnore(virt_to_page(data_start));
+		this_data = (struct reload_data *) data_start; 
+		num_reload_pages++;
+
+		while (data_start == 
+		  ((((unsigned long) (this_data + 1)) - 1) & PAGE_MASK)) {
+			struct page * page;
+			unsigned long virt;
+
+			virt = suspend2_get_grabbed_pages(0);
+			if (!virt) {
+				printk("Couldn't get a page in which to store "
+					"a changed page.\n");
+				return -ENOMEM;
+			}
+			page = virt_to_page(virt);
+
+			this_data->compared_version = (char *) virt;
+			SetPageNosave(page);
+			SetPageChecksumIgnore(page);
+			
+			virt = suspend2_get_grabbed_pages(0);
+			if (!virt) {
+				printk("Couldn't get a page in which to store "
+					"a baseline page.\n");
+				return -ENOMEM;
+			}
+			page = virt_to_page(virt);
+
+			this_data->base_version = (char *) virt;
+			SetPageNosave(page);
+			SetPageChecksumIgnore(page);
+
+			if (last_reload_data)
+				last_reload_data->next = this_data;
+			else
+				first_reload_data = this_data;
+			
+			last_reload_data = this_data;
+
+			this_data++;
+		}
+
+		check_shift_keys(0, NULL);
+	}
+
+	return 0;
+}
+
+static void suspend_print_differences(void)
+{
+	struct reload_data * this_data = first_reload_data;
+	int i;
+
+	suspend_reread_pages(first_reload_data);
+	
+	if (get_rangepages_list())
+		return;
+
+	while (this_data) {
+		if (this_data->pageset && 
+		    this_data->pagenumber) {
+			suspend_message(SUSPEND_INTEGRITY, SUSPEND_MEDIUM, 1,
+				"Pagedir %d. Page %d. Address %p."
+				" Base %p. Copy %p.\n",
+				this_data->pageset,
+				this_data->pagenumber,
+				page_address(this_data->page_address),
+				this_data->base_version,
+				this_data->compared_version);
+			for (i= 0; i < (PAGE_SIZE / 8); i++) {
+				local_print_location(
+					page_address(this_data->page_address) + i * 8,
+					this_data->base_version + i * 8,
+					this_data->compared_version + i * 8);
+				check_shift_keys(0, NULL);
+			}
+			check_shift_keys(1, NULL);
+		} else
+			return;
+		this_data = this_data->next;
+	}
+
+	put_rangepages_list();
+}
+
+int __suspend_allocate_checksum_pages(void)
+{
+	int pages_required =
+		(pageset1_size + pageset2_size) / CHECKSUMS_PER_PAGE;
+	unsigned long this_page;
+
+	while (checksum_pages <= pages_required) {
+		this_page = suspend2_get_grabbed_pages(0);
+		if (!this_page)
+			return -ENOMEM;
+
+		if (!first_checksum_page)
+			first_checksum_page = 
+				(unsigned long *) this_page;
+		else
+			NEXT_CHECKSUM_PAGE(last_checksum_page) = this_page;
+		
+		last_checksum_page = (unsigned long *) this_page;
+		SetPageChecksumIgnore(virt_to_page(this_page));
+		checksum_pages++;
+	}
+	suspend_store_free_mem(SUSPEND_FREE_CHECKSUM_PAGES, 0);
+
+	return suspend_allocate_reload_data(2);
+}
+
+static int suspend_checksum_init(void)
+{
+	if (allocate_local_pageflags(&checksum_map, 0))
+		return 1;
+	PRINTFREEMEM("after allocating checksum map");
+	suspend_store_free_mem(5, 0);
+	return 0;
+}
+
+
+static void suspend_checksum_cleanup(void)
+{
+	suspend_free_reload_data();
+	suspend_free_checksum_pages();
+	
+	free_local_pageflags(&checksum_map);
+	PRINTFREEMEM("after freeing checksum map");
+	suspend_store_free_mem(SUSPEND_FREE_CHECKSUM_MAP, 1);
+}
+
+static struct suspend_plugin_ops checksum_ops = 
+{
+	.name					= "Checksum",
+	.type					= CHECKSUM_PLUGIN,
+	.initialise				= suspend_checksum_init,
+	.cleanup				= suspend_checksum_cleanup,
+	.ops = {
+		.checksum = {
+			.calculate_checksums	= suspend_calculate_checksums,
+			.check_checksums	= suspend_check_checksums,
+			.print_differences	= suspend_print_differences,
+			.allocate_pages		= __suspend_allocate_checksum_pages,
+		}
+	}
+};
+
+static struct suspend_proc_data proc_params[] = {
+	{ .filename			= "disable_checksumming",
+	.permissions			= PROC_RW,
+	.type				= SUSPEND_PROC_DATA_INTEGER,
+	.data = {
+		.integer = {
+			.variable	= &checksum_ops.disabled,
+			.minimum	= 0,
+			.maximum	= 1,
+		}
+	 }
+	},
+};
+
+static __init int checksum_load(void)
+{
+	int i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+	int result;
+
+	if (!(result = suspend_register_plugin(&checksum_ops))) {
+		printk("Software Suspend Checksum Module\n");
+		for (i=0; i< numfiles; i++)
+			suspend_register_procfile(&proc_params[i]);
+	}
+	return result;
+}
+
+#ifdef MODULE
+static __exit void checksum_unload(void)
+{
+	int i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+
+	printk("Software Suspend Checksum module unloading.\n");
+
+	for (i=0; i< numfiles; i++)
+		suspend_unregister_procfile(&proc_params[i]);
+	suspend_unregister_plugin(&checksum_ops);
+}
+
+module_init(checksum_load);
+module_exit(checksum_unload);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nigel Cunningham");
+MODULE_DESCRIPTION("Suspend2 checksum module");
+#else
+late_initcall(checksum_load);
+#endif


