Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268247AbTCAEKB>; Fri, 28 Feb 2003 23:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268297AbTCAEKB>; Fri, 28 Feb 2003 23:10:01 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:49103 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S268247AbTCAEJu>; Fri, 28 Feb 2003 23:09:50 -0500
Date: Sat, 01 Mar 2003 17:22:53 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: SWSUSP Discontiguous pagedir patch
In-reply-to: <20030227132024.GB27084@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1046487717.4616.22.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1045784829.3821.10.camel@laptop-linux.cunninghams>
 <20030223223757.GA120@elf.ucw.cz>
 <1046136752.1784.15.camel@laptop-linux.cunninghams>
 <20030227132024.GB27084@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 02:20, Pavel Machek wrote:
> > > b) introduces hard limit on how much pages you can save (4GB).
> > 
> > Well, I might ask how many people you know with 4GB of swap and 4GB of
> > RAM they want to suspend to disk :> Don't forget we still aren't
> > handling himem anyway (at least not last time I checked). As y
> 
> Well, on x86-64 it should be able to suspend 8GB machine just fine --
> being 64bit means you don't have to deal with himem. Plus it would
> only be 2GB limit on x86-64.
> 
[deletia]
> 
> I don't know. I'd let Linus decide. I don't like hard limit on ammount
> of mem, through.

Hi again.

I've thought things through some more. We need to keep in mind that
other patches I intend to submit save the pages that aren't needed for
the suspend process itself separately. Since this includes all the
highmem pages and a reasonable proportion of the normal pages (easily
more than half when we're talking high usage), we don't need to eat
memory and we don't really have a hard limit on the size of the image.
Presumably the same conditions will apply under x86-64.

Thus, I still think we can go with the patch I submitted before. I've
rediffed it against 2.5.63 (less the bits already applied).

Regards,

Nigel

diff -ruN linux-2.5.63/arch/i386/kernel/Makefile linux-2.5.63-01/arch/i386/kernel/Makefile
--- linux-2.5.63/arch/i386/kernel/Makefile	2003-03-01 15:10:16.000000000 +1300
+++ linux-2.5.63-01/arch/i386/kernel/Makefile	2003-03-01 15:14:28.000000000 +1300
@@ -23,7 +23,7 @@
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o suspend_asm.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_MODULES)		+= module.o
diff -ruN linux-2.5.63/arch/i386/kernel/suspend.c linux-2.5.63-01/arch/i386/kernel/suspend.c
--- linux-2.5.63/arch/i386/kernel/suspend.c	2003-02-20 08:25:26.000000000 +1300
+++ linux-2.5.63-01/arch/i386/kernel/suspend.c	2003-02-20 08:27:36.000000000 +1300
@@ -133,3 +133,84 @@
 	}
 
 }
+
+/* Local variables for do_magic */
+static int loop __nosavedata = 0;
+static int loop2 __nosavedata = 0;
+
+/*
+ * FIXME: This function should really be written in assembly. Actually
+ * requirement is that it does not touch stack, because %esp will be
+ * wrong during resume before restore_processor_context(). Check
+ * assembly if you modify this.
+ */
+void do_magic(int resume)
+{
+	if (!resume) {
+		do_magic_suspend_1();
+		save_processor_state();	/* We need to capture registers and memory at "same time" */
+		asm (	"movl %esp, saved_context_esp\n\t"
+			"movl %eax, saved_context_eax\n\t"
+			"movl %ebx, saved_context_ebx\n\t"
+			"movl %ecx, saved_context_ecx\n\t"
+			"movl %edx, saved_context_edx\n\t"
+			"movl %ebp, saved_context_ebp\n\t"
+			"movl %esi, saved_context_esi\n\t"
+			"movl %edi, saved_context_edi\n\t"
+			"pushfl ; popl saved_context_eflags\n\t");
+		
+		do_magic_suspend_2();		/* If everything goes okay, this function does not return */
+		return;
+	}
+
+	/* We want to run from swapper_pg_dir, since swapper_pg_dir is stored in constant
+	 * place in memory 
+	 */
+
+        __asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swapper_pg_dir)));
+
+/*
+ * Final function for resuming: after copying the pages to their original
+ * position, it restores the register state.
+ *
+ * What about page tables? Writing data pages may toggle
+ * accessed/dirty bits in our page tables. That should be no problems
+ * with 4MB page tables. That's why we require have_pse.  
+ *
+ * This loops destroys stack from under itself, so it better should
+ * not use any stack space, itself. When this function is entered at
+ * resume time, we move stack to _old_ place.  This is means that this
+ * function must use no stack and no local variables in registers,
+ * until calling restore_processor_context();
+ *
+ * Critical section here: noone should touch saved memory after
+ * do_magic_resume_1; copying works, because nr_copy_pages,
+ * pagedir_nosave, loop and loop2 are nosavedata.
+ */
+	do_magic_resume_1();
+
+	for (loop=0; loop < nr_copy_pages; loop++) {
+		/* You may not call something (like copy_page) here: see above */
+		for (loop2=0; loop2 < PAGE_SIZE; loop2++) {
+			*(((char *)(PAGEDIR_ENTRY(pagedir_nosave,loop)->orig_address))+loop2) =
+				*(((char *)(PAGEDIR_ENTRY(pagedir_nosave,loop)->address))+loop2);
+			__flush_tlb();
+		}
+	}
+
+	asm(	"movl saved_context_esp, %esp\n\t"
+		"movl saved_context_ebp, %ebp\n\t"
+		"movl saved_context_eax, %eax\n\t"
+		"movl saved_context_ebx, %ebx\n\t"
+		"movl saved_context_ecx, %ecx\n\t"
+		"movl saved_context_edx, %edx\n\t"
+		"movl saved_context_esi, %esi\n\t"
+		"movl saved_context_edi, %edi\n\t");
+	restore_processor_state();
+	asm("pushl saved_context_eflags ; popfl\n\t");
+
+/* Ahah, we now run with our old stack, and with registers copied from
+   suspend time */
+
+	do_magic_resume_2();
+}
diff -ruN linux-2.5.63/include/linux/page-flags.h linux-2.5.63-01/include/linux/page-flags.h
--- linux-2.5.63/include/linux/page-flags.h	2003-02-20 07:59:33.000000000 +1300
+++ linux-2.5.63-01/include/linux/page-flags.h	2003-02-20 08:28:31.000000000 +1300
@@ -74,6 +74,7 @@
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
+#define PG_collides		20	/* swsusp - page used in save image */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -256,6 +257,9 @@
 #define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
 #define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)
 
+#define PageCollides(page)	test_bit(PG_collides, &(page)->flags)
+#define SetPageCollides(page)	set_bit(PG_collides, &(page)->flags)
+#define ClearPageCollides(page)	clear_bit(PG_collides, &(page)->flags)
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
  * but it may again do so one day.
diff -ruN linux-2.5.63/include/linux/suspend.h linux-2.5.63-01/include/linux/suspend.h
--- linux-2.5.63/include/linux/suspend.h	2003-01-15 17:00:58.000000000 +1300
+++ linux-2.5.63-01/include/linux/suspend.h	2003-02-20 08:27:36.000000000 +1300
@@ -34,7 +34,7 @@
 	char version[20];
 	int num_cpus;
 	int page_size;
-	suspend_pagedir_t *suspend_pagedir;
+	suspend_pagedir_t **suspend_pagedir;
 	unsigned int num_pbes;
 	struct swap_location {
 		char filename[SWAP_FILENAME_MAXLENGTH];
@@ -42,6 +42,8 @@
 };
 
 #define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
+#define PAGEDIR_CAPACITY(x)     (((x)*PAGE_SIZE/sizeof(struct pbe)))
+#define PAGEDIR_ENTRY(pagedir, i) (pagedir[i/PAGEDIR_CAPACITY(1)] + (i%PAGEDIR_CAPACITY(1)))
    
 /* mm/vmscan.c */
 extern int shrink_mem(void);
@@ -61,7 +63,7 @@
 extern void thaw_processes(void);
 
 extern unsigned int nr_copy_pages __nosavedata;
-extern suspend_pagedir_t *pagedir_nosave __nosavedata;
+extern suspend_pagedir_t **pagedir_nosave __nosavedata;
 
 /* Communication between kernel/suspend.c and arch/i386/suspend.c */
 
diff -ruN linux-2.5.63/kernel/suspend.c linux-2.5.63-01/kernel/suspend.c
--- linux-2.5.63/kernel/suspend.c	2003-02-20 07:59:34.000000000 +1300
+++ linux-2.5.63-01/kernel/suspend.c	2003-02-20 10:42:52.000000000 +1300
@@ -96,7 +96,6 @@
 static int new_loglevel = 7;
 static int orig_loglevel = 0;
 static int orig_fgconsole, orig_kmsg;
-static int pagedir_order_check;
 static int nr_copy_pages_check;
 
 static int resume_status = 0;
@@ -116,9 +115,9 @@
    allocated at time of resume, that travels through memory not to
    collide with anything.
  */
-suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
-static suspend_pagedir_t *pagedir_save;
-static int pagedir_order __nosavedata = 0;
+suspend_pagedir_t **pagedir_nosave __nosavedata = NULL;
+static suspend_pagedir_t **pagedir_save = NULL;
+static int pagedir_size __nosavedata = 0;
 
 struct link {
 	char dummy[PAGE_SIZE - sizeof(swp_entry_t)];
@@ -395,7 +394,7 @@
 {
 	int i;
 	swp_entry_t entry, prev = { 0 };
-	int nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
+	int pagedir_size = SUSPEND_PD_PAGES(nr_copy_pages);
 	union diskpage *cur,  *buffer = (union diskpage *)get_zeroed_page(GFP_ATOMIC);
 	unsigned long address;
 	struct page *page;
@@ -410,16 +409,15 @@
 		if (swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
 			panic("\nPage %d: not enough swapspace on suspend device", i );
 	    
-		address = (pagedir_nosave+i)->address;
+		address = PAGEDIR_ENTRY(pagedir_nosave,i)->address;
 		page = virt_to_page(address);
 		rw_swap_page_sync(WRITE, entry, page);
-		(pagedir_nosave+i)->swap_address = entry;
+		PAGEDIR_ENTRY(pagedir_nosave,i)->swap_address = entry;
 	}
 	printk( "|\n" );
-	printk( "Writing pagedir (%d pages): ", nr_pgdir_pages);
-	for (i=0; i<nr_pgdir_pages; i++) {
-		cur = (union diskpage *)((char *) pagedir_nosave)+i;
-		BUG_ON ((char *) cur != (((char *) pagedir_nosave) + i*PAGE_SIZE));
+	printk( "Writing pagedir (%d pages): ", pagedir_size);
+	for (i=0; i<pagedir_size; i++) {
+		cur = (union diskpage *) pagedir_nosave[i];
 		printk( "." );
 		if (!(entry = get_swap_page()).val) {
 			printk(KERN_CRIT "Not enough swapspace when writing pgdir\n" );
@@ -467,7 +465,7 @@
 }
 
 /* if pagedir_p != NULL it also copies the counted pages */
-static int count_and_copy_data_pages(struct pbe *pagedir_p)
+static int count_and_copy_data_pages(struct pbe **pagedir_p)
 {
 	int chunk_size;
 	int nr_copy_pages = 0;
@@ -507,65 +505,88 @@
 			   critical bios data? */
 		} else	BUG();
 
-		nr_copy_pages++;
 		if (pagedir_p) {
-			pagedir_p->orig_address = ADDRESS(pfn);
-			copy_page((void *) pagedir_p->address, (void *) pagedir_p->orig_address);
-			pagedir_p++;
+			PAGEDIR_ENTRY(pagedir_p, nr_copy_pages)->orig_address = ADDRESS(pfn);
+			copy_page((void *) PAGEDIR_ENTRY(pagedir_p, nr_copy_pages)->address, (void *) PAGEDIR_ENTRY(pagedir_p, nr_copy_pages)->orig_address);
 		}
+		nr_copy_pages++;
 	}
 	return nr_copy_pages;
 }
 
-static void free_suspend_pagedir(unsigned long this_pagedir)
+static void free_suspend_pagedir(struct pbe ** this_pagedir)
 {
-	struct page *page;
-	int pfn;
-	unsigned long this_pagedir_end = this_pagedir +
-		(PAGE_SIZE << pagedir_order);
+	int i;
+	int rangestart = -1, rangeend = -1;
 
-	for(pfn = 0; pfn < num_physpages; pfn++) {
-		page = pfn_to_page(pfn);
-		if (!TestClearPageNosave(page))
-			continue;
+	if (pagedir_size == 0)
+		return;
 
-		if (ADDRESS(pfn) >= this_pagedir && ADDRESS(pfn) < this_pagedir_end)
-			continue; /* old pagedir gets freed in one */
-		
-		free_page(ADDRESS(pfn));
+	for(i = 0; i < nr_copy_pages; i++) {
+		if (PAGEDIR_ENTRY(this_pagedir,i)->address) {
+			if (rangestart > -1) {
+				printk("Pagedir entry %d-%d address2 not set!\n", rangestart, rangeend);
+				rangestart = -1;
+			}
+			ClearPageNosave(virt_to_page(PAGEDIR_ENTRY(this_pagedir,i)->address));
+			free_page(PAGEDIR_ENTRY(this_pagedir,i)->address);
+		} else {
+			if (rangestart == -1)
+				rangestart = i;
+			rangeend = i;
+		}
 	}
-	free_pages(this_pagedir, pagedir_order);
+		
+	if (rangestart > -1)
+		printk("Pagedir entry %d-%d address not set!\n", rangestart, nr_copy_pages - 1);
+
+	for(i = 0; i < pagedir_size; i++)
+		free_page((unsigned long) this_pagedir[i]);
+
+	free_page((unsigned long) this_pagedir);
+	this_pagedir = NULL;
+	nr_copy_pages = 0;
+	pagedir_size = 0;
 }
 
-static suspend_pagedir_t *create_suspend_pagedir(int nr_copy_pages)
+static suspend_pagedir_t **create_suspend_pagedir(int nr_copy_pages)
 {
+	suspend_pagedir_t **pagedir;
+	struct pbe **p;
 	int i;
-	suspend_pagedir_t *pagedir;
-	struct pbe *p;
-	struct page *page;
 
-	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
+	pagedir_size = SUSPEND_PD_PAGES(nr_copy_pages);
 
-	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, pagedir_order);
-	if(!pagedir)
+	p = pagedir = (suspend_pagedir_t **)__get_free_pages(GFP_ATOMIC | __GFP_COLD, 0);
+	if(!p)
 		return NULL;
 
-	page = virt_to_page(pagedir);
-	for(i=0; i < 1<<pagedir_order; i++)
-		SetPageNosave(page++);
-		
+	/* We aren't setting the pagedir itself Nosave because we have to be able
+	 * to free it during resume, after restoring the image. This means nr_copy_pages
+	 * needs to be adjusted */
+	
+	for (i = 0; i < pagedir_size; i++) {
+		p[i] = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, 0);
+		if (!p[i]) {
+			int j;
+			for (j = 0; j < i; j++) {
+				free_page((unsigned long) p[j]);
+			}
+			free_page((unsigned long) p);
+			return NULL;
+		}
+	}
+
 	while(nr_copy_pages--) {
-		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-		if(!p->address) {
-			free_suspend_pagedir((unsigned long) pagedir);
+		PAGEDIR_ENTRY(p, nr_copy_pages)->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+		if(!PAGEDIR_ENTRY(p, nr_copy_pages)->address) {
+			free_suspend_pagedir(p);
 			return NULL;
 		}
-		printk(".");
-		SetPageNosave(virt_to_page(p->address));
-		p->orig_address = 0;
-		p++;
+		SetPageNosave(virt_to_page(PAGEDIR_ENTRY(p, nr_copy_pages)->address));
+		PAGEDIR_ENTRY(p, nr_copy_pages)->orig_address = 0;
 	}
-	return pagedir;
+	return p;
 }
 
 static int prepare_suspend_console(void)
@@ -604,12 +625,13 @@
 
 static int prepare_suspend_processes(void)
 {
+	PRINTK("Syncing...\n");
+	sys_sync();
 	if (freeze_processes()) {
 		printk( KERN_ERR "Suspend failed: Not all processes stopped!\n" );
 		thaw_processes();
 		return 1;
 	}
-	sys_sync();
 	return 0;
 }
 
@@ -684,6 +706,7 @@
 	pagedir_nosave = NULL;
 	printk( "/critical section: Counting pages to copy" );
 	nr_copy_pages = count_and_copy_data_pages(NULL);
+	nr_copy_pages += 1 + SUSPEND_PD_PAGES(nr_copy_pages);
 	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
 	
 	printk(" (pages needed: %d+%d=%d free: %d)\n",nr_copy_pages,PAGES_FOR_IO,nr_needed_pages,nr_free_pages());
@@ -713,7 +736,6 @@
 		return 1;
 	}
 	nr_copy_pages_check = nr_copy_pages;
-	pagedir_order_check = pagedir_order;
 
 	drain_local_pages();	/* During allocating of suspend pagedir, new cold pages may appear. Kill them */
 	if (nr_copy_pages != count_and_copy_data_pages(pagedir_nosave))	/* copy */
@@ -789,12 +811,11 @@
 void do_magic_resume_2(void)
 {
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
-	BUG_ON (pagedir_order_check != pagedir_order);
 
 	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
 
 	PRINTK( "Freeing prev allocated pagedir\n" );
-	free_suspend_pagedir((unsigned long) pagedir_save);
+	free_suspend_pagedir(pagedir_save);
 	spin_unlock_irq(&suspend_pagedir_lock);
 	drivers_resume(RESUME_ALL_PHASES);
 
@@ -831,7 +852,7 @@
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 	mdelay(1000);
 
-	free_pages((unsigned long) pagedir_nosave, pagedir_order);
+	free_suspend_pagedir(pagedir_nosave);
 	spin_unlock_irq(&suspend_pagedir_lock);
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
 	PRINTK(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
@@ -894,37 +915,23 @@
 
 /* More restore stuff */
 
-/* FIXME: Why not memcpy(to, from, 1<<pagedir_order*PAGE_SIZE)? */
-static void copy_pagedir(suspend_pagedir_t *to, suspend_pagedir_t *from)
-{
-	int i;
-	char *topointer=(char *)to, *frompointer=(char *)from;
-
-	for(i=0; i < 1 << pagedir_order; i++) {
-		copy_page(topointer, frompointer);
-		topointer += PAGE_SIZE;
-		frompointer += PAGE_SIZE;
-	}
-}
-
-#define does_collide(addr) does_collide_order(pagedir_nosave, addr, 0)
-
-/*
- * Returns true if given address/order collides with any orig_address 
- */
-static int does_collide_order(suspend_pagedir_t *pagedir, unsigned long addr,
-		int order)
-{
+static void warmup_collision_cache(suspend_pagedir_t **pagedir) {
 	int i;
-	unsigned long addre = addr + (PAGE_SIZE<<order);
 	
-	for(i=0; i < nr_copy_pages; i++)
-		if((pagedir+i)->orig_address >= addr &&
-			(pagedir+i)->orig_address < addre)
-			return 1;
+	PRINTK("Setting up pagedir cache");
+	for (i = 0; i < max_pfn; i++)
+		ClearPageCollides(pfn_to_page(i));
 
-	return 0;
+	for(i=0; i < nr_copy_pages; i++) {
+		SetPageCollides(virt_to_page(PAGEDIR_ENTRY(pagedir, i)->orig_address));
+		if (!(i%800)) {
+			PRINTK(".");
+		}
+	}
+	PRINTK("%d", i);
+	PRINTK("|\n");
 }
+#define does_collide(address) (PageCollides(virt_to_page(address)))
 
 /*
  * We check here that pagedir & pages it points to won't collide with pages
@@ -932,64 +939,106 @@
  */
 static int check_pagedir(void)
 {
-	int i;
+	int i, nrdone = 0;
+	void **eaten_memory = NULL;
+	void **c = eaten_memory, *f, *addr;
 
 	for(i=0; i < nr_copy_pages; i++) {
-		unsigned long addr;
-
-		do {
-			addr = get_zeroed_page(GFP_ATOMIC);
-			if(!addr)
-				return -ENOMEM;
-		} while (does_collide(addr));
-
-		(pagedir_nosave+i)->address = addr;
+		while ((addr = (void *) get_zeroed_page(GFP_ATOMIC))) {
+			memset(addr, 0, PAGE_SIZE);
+			if (!does_collide((unsigned long) addr)) {
+				break;
+			}
+			eaten_memory = addr;
+			*eaten_memory = c;
+			c = eaten_memory;
+		}
+		PAGEDIR_ENTRY(pagedir_nosave,i)->address = (unsigned long) addr;
+		nrdone++;
+	}
+	
+	// Free unwanted memory
+	c = eaten_memory;
+	while(c) {
+		f = c;
+		c = *c;
+		if (f)
+			free_page((unsigned long) f);
 	}
+	eaten_memory = NULL;
+	
 	return 0;
 }
 
 static int relocate_pagedir(void)
 {
+	void **eaten_memory = NULL;
+	void **c = eaten_memory, *m = NULL, *f;
+	int oom = 0, i, numeaten = 0;
+	int pagedir_size = SUSPEND_PD_PAGES(nr_copy_pages);
+
 	/*
 	 * We have to avoid recursion (not to overflow kernel stack),
 	 * and that's why code looks pretty cryptic 
 	 */
-	suspend_pagedir_t *new_pagedir, *old_pagedir = pagedir_nosave;
-	void **eaten_memory = NULL;
-	void **c = eaten_memory, *m, *f;
-
-	printk("Relocating pagedir");
 
-	if(!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
-		printk("not neccessary\n");
-		return 0;
-	}
+	PRINTK("Relocating conflicting parts of pagedir.\n");
 
-	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order))) {
-		memset(m, 0, PAGE_SIZE);
-		if (!does_collide_order(old_pagedir, (unsigned long)m, pagedir_order))
-			break;
-		eaten_memory = m;
-		printk( "." ); 
-		*eaten_memory = c;
-		c = eaten_memory;
-	}
+	for (i = -1; i < pagedir_size; i++) {
+		int this_collides = 0;
 
-	if (!m)
-		return -ENOMEM;
-
-	pagedir_nosave = new_pagedir = m;
-	copy_pagedir(new_pagedir, old_pagedir);
+		if (i == -1)
+			this_collides = does_collide((unsigned long) pagedir_nosave);
+		else
+			this_collides = does_collide((unsigned long) pagedir_nosave[i]);
+		
+		if (this_collides) {
+			while ((m = (void *) __get_free_pages(GFP_ATOMIC, 0))) {
+				memset(m, 0, PAGE_SIZE);
+				if (!does_collide((unsigned long)m)) {
+					if (i == -1) {
+						copy_page(m, pagedir_nosave);
+						free_page((unsigned long) pagedir_nosave);
+						pagedir_nosave = m;
+					}
+					else {
+						copy_page(m, (void *) pagedir_nosave[i]);
+						free_page((unsigned long) pagedir_nosave[i]);
+						pagedir_nosave[i] = m;
+					}
+					break;
+				}
+				numeaten++;
+				eaten_memory = m;
+				PRINTK("Eaten: %d. Still to try:%d\r", numeaten, nr_free_pages()); 
+				*eaten_memory = c;
+				c = eaten_memory;
+			}
+			if (!m) {
+				printk("\nRan out of memory trying to relocate pagedir (tried %d pages).\n", numeaten);
+				oom = 1;
+				break;
+			}
+		}
 
+	}
+		
+	PRINTK("\nFreeing rejected memory locations...");
 	c = eaten_memory;
 	while(c) {
-		printk(":");
-		f = *c;
+		f = c;
 		c = *c;
 		if (f)
-			free_pages((unsigned long)f, pagedir_order);
+			free_pages((unsigned long) f, 0);
 	}
-	printk("|\n");
+	eaten_memory = NULL;
+	
+	PRINTK("\n");
+	
+	if (oom) 
+		return -ENOMEM;
+	else
+		return 0;
 	return 0;
 }
 
@@ -1062,7 +1111,7 @@
 static int __read_suspend_image(struct block_device *bdev, union diskpage *cur, int noresume)
 {
 	swp_entry_t next;
-	int i, nr_pgdir_pages;
+	int i, pagedir_size;
 
 #define PREPARENEXT \
 	{	next = cur->link.next; \
@@ -1110,24 +1159,39 @@
 
 	pagedir_save = cur->sh.suspend_pagedir;
 	nr_copy_pages = cur->sh.num_pbes;
-	nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
-	pagedir_order = get_bitmask_order(nr_pgdir_pages);
+	pagedir_size = SUSPEND_PD_PAGES(nr_copy_pages);
 
-	pagedir_nosave = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, pagedir_order);
+	pagedir_nosave = (suspend_pagedir_t **)__get_free_pages(GFP_ATOMIC, 0);
 	if (!pagedir_nosave)
 		return -ENOMEM;
 
+	{
+		int i;
+		for (i = 0; i < pagedir_size; i++) {
+			pagedir_nosave[i] = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, 0);
+			if (!pagedir_nosave[i]) {
+				int j;
+				for (j = 0; j < i; j++)
+					free_page((unsigned long) pagedir_nosave[j]);
+				free_page((unsigned long) pagedir_nosave);
+				spin_unlock_irq(&suspend_pagedir_lock);
+				return -ENOMEM;
+			}
+		}
+	}
 	PRINTK( "%sReading pagedir, ", name_resume );
 
 	/* We get pages in reverse order of saving! */
-	for (i=nr_pgdir_pages-1; i>=0; i--) {
+	for (i=pagedir_size-1; i>=0; i--) {
 		BUG_ON (!next.val);
-		cur = (union diskpage *)((char *) pagedir_nosave)+i;
+		cur = (union diskpage *) pagedir_nosave[i];
 		if (bdev_read_page(bdev, next.val, cur)) return -EIO;
 		PREPARENEXT;
 	}
 	BUG_ON (next.val);
 
+ 	warmup_collision_cache(pagedir_nosave);
+ 
 	if (relocate_pagedir())
 		return -ENOMEM;
 	if (check_pagedir())
@@ -1135,12 +1199,12 @@
 
 	printk( "Reading image data (%d pages): ", nr_copy_pages );
 	for(i=0; i < nr_copy_pages; i++) {
-		swp_entry_t swap_address = (pagedir_nosave+i)->swap_address;
+		swp_entry_t swap_address = PAGEDIR_ENTRY(pagedir_nosave,i)->swap_address;
 		if (!(i%100))
 			printk( "." );
 		/* You do not need to check for overlaps...
 		   ... check_pagedir already did this work */
-		if (bdev_read_page(bdev, swp_offset(swap_address) * PAGE_SIZE, (char *)((pagedir_nosave+i)->address)))
+		if (bdev_read_page(bdev, swp_offset(swap_address) * PAGE_SIZE, (char *)(PAGEDIR_ENTRY(pagedir_nosave,i)->address)))
 			return -EIO;
 	}
 	printk( "|\n" );



