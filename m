Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbUCXX54 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 18:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbUCXX54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 18:57:56 -0500
Received: from gprs214-165.eurotel.cz ([160.218.214.165]:644 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262292AbUCXX50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:57:26 -0500
Date: Thu, 25 Mar 2004 00:57:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: seife@suse.de
Subject: swsusp with highmem, testing wanted
Message-ID: <20040324235702.GA497@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

If you have machine with >=1GB of RAM, do you think you could test
this patch? [I'd like to hear about successes, too; perhaps send it
privately].

							Pavel

--- clean.2.5/kernel/power/swsusp.c	2004-03-11 18:11:26.000000000 +0100
+++ linux-himem-swsusp/kernel/power/swsusp.c	2004-03-25 00:53:56.000000000 +0100
@@ -61,6 +61,7 @@
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
 #include <linux/console.h>
+#include <linux/highmem.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -362,7 +363,69 @@
 	return 0;
 }
 
+struct highmem_page {
+	char *data;
+	struct page *page;
+	struct highmem_page *next;
+};
+
+struct highmem_page *highmem_copy = NULL;
+
 /* if pagedir_p != NULL it also copies the counted pages */
+static int save_highmem(void)
+{
+	int pfn;
+	struct page *page;
+	int chunk_size;
+
+	for (pfn = 0; pfn < max_pfn; pfn++) {
+		struct highmem_page *save;
+		void *kaddr;
+
+		page = pfn_to_page(pfn);
+
+		if (!PageHighMem(page))
+			continue;
+		if (PageReserved(page)) {
+			printk("highmem reserved page?!\n");
+			BUG();
+		}
+		if ((chunk_size=is_head_of_free_region(page))!=0) {
+			pfn += chunk_size - 1;
+			continue;
+		}
+		save = kmalloc(sizeof(struct highmem_page), GFP_ATOMIC);
+		if (!save)
+			panic("Not enough memory");
+		save->next = highmem_copy;
+		save->page = page;
+		save->data = get_zeroed_page(GFP_ATOMIC);
+		if (!save->data)
+			panic("Not enough memory");
+		kaddr = kmap_atomic(page, KM_USER0);
+		memcpy(save->data, kaddr, PAGE_SIZE);
+		kunmap_atomic(kaddr, KM_USER0);
+		highmem_copy = save;
+	}
+	return 0;
+}
+
+static int restore_highmem(void)
+{
+	while (highmem_copy) {
+		struct highmem_page *save = highmem_copy;
+		void *kaddr;
+		highmem_copy = save->next;
+		
+		kaddr = kmap_atomic(save->page, KM_USER0);
+		memcpy(kaddr, save->data, PAGE_SIZE);
+		kunmap_atomic(kaddr, KM_USER0);
+		free_page(save->data);
+		kfree(save);
+	}
+	return 0;
+}
+
 static int count_and_copy_data_pages(struct pbe *pagedir_p)
 {
 	int chunk_size;
@@ -378,7 +441,7 @@
 	for (pfn = 0; pfn < max_pfn; pfn++) {
 		page = pfn_to_page(pfn);
 		if (PageHighMem(page))
-			panic("Swsusp not supported on highmem boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again ;-).");
+			continue;
 
 		if (!PageReserved(page)) {
 			if (PageNosave(page))
@@ -413,6 +476,7 @@
 	return nr_copy_pages;
 }
 
+
 static void free_suspend_pagedir(unsigned long this_pagedir)
 {
 	struct page *page;
@@ -492,10 +556,12 @@
 	struct sysinfo i;
 	unsigned int nr_needed_pages = 0;
 
-	drain_local_pages();
-
 	pagedir_nosave = NULL;
-	printk( "/critical section: Counting pages to copy" );
+	printk( "/critical section: Handling highmem" );
+	save_highmem();
+
+	printk(", counting pages to copy" );
+	drain_local_pages();
 	nr_copy_pages = count_and_copy_data_pages(NULL);
 	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
 	
@@ -603,6 +669,11 @@
 
 	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
+
+	printk( "Restoring highmem\n" );
+	restore_highmem();
+	printk("done, devices\n");
+
 	device_power_up();
 	spin_unlock_irq(&suspend_pagedir_lock);
 	device_resume();

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
