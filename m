Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVCHLzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVCHLzI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 06:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVCHLyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 06:54:40 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:37560 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262013AbVCHLqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 06:46:19 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][3/3] swsusp: use non-contiguous memory
Date: Tue, 8 Mar 2005 12:47:51 +0100
User-Agent: KMail/1.7.1
Cc: hugang@soulinfo.com, linux-kernel@vger.kernel.org
References: <200503042051.54176.rjw@sisk.pl> <200503071313.07679.rjw@sisk.pl> <20050308103846.GA23640@elf.ucw.cz>
In-Reply-To: <20050308103846.GA23640@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503081247.51797.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 8 of March 2005 11:38, Pavel Machek wrote:
> On Po 07-03-05 13:13:07, Rafael J. Wysocki wrote:
> > On Monday, 7 of March 2005 12:39, Andrew Morton wrote:
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > >
> > > > Yes, the Signed-off-by line was missing from the original patch.  Andrew,
> > > > should I resubmit it?
> > > > 
> > > 
> > > I dropped lots of those swsusp patches due to various bit of breakage. 
> > > Pavel will be redoing all of them sometime, hopefully.
> > 
> > These patches are a "redone version" of the patch that Pavel submitted
> > before and Pavel has acked them already.
> > 
> > I did my best not to break them, but if they are broken, could you please tell
> > me what's wrong with them so that I can fix it?
> 
> Just bad timing, I guess. I sent wrong patches, and andrew reacted by
> simply waiting for me to catch up with right tree (which is okay, it
> was big and not critical).
> 
> Now, akpm sent all (?) swsusp updates to Linus, so it should appear in
> bk tree later today. If you could regenerate the patches (1/3 will no
> longer be needed) and send them to me & l-k. I'll then forward them to
> akpm. [He seems to prefer patches to come from my email address :-)]

OK

Here's the 2/3 one (ie the main resume part).  Do you need the summary?

Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

diff -Nru linux-2.6.11-a/arch/i386/kernel/asm-offsets.c linux-2.6.11-b/arch/i386/kernel/asm-offsets.c
--- linux-2.6.11-a/arch/i386/kernel/asm-offsets.c	2005-03-02 08:38:00.000000000 +0100
+++ linux-2.6.11-b/arch/i386/kernel/asm-offsets.c	2005-03-04 20:14:01.000000000 +0100
@@ -7,6 +7,7 @@
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/personality.h>
+#include <linux/suspend.h>
 #include <asm/ucontext.h>
 #include "sigframe.h"
 #include <asm/fixmap.h>
@@ -56,6 +57,11 @@
 
 	OFFSET(EXEC_DOMAIN_handler, exec_domain, handler);
 	OFFSET(RT_SIGFRAME_sigcontext, rt_sigframe, uc.uc_mcontext);
+	BLANK();
+
+	OFFSET(pbe_address, pbe, address);
+	OFFSET(pbe_orig_address, pbe, orig_address);
+	OFFSET(pbe_next, pbe, next);
 
 	/* Offset from the sysenter stack to tss.esp0 */
 	DEFINE(TSS_sysenter_esp0, offsetof(struct tss_struct, esp0) -
diff -Nru linux-2.6.11-a/arch/i386/power/swsusp.S linux-2.6.11-b/arch/i386/power/swsusp.S
--- linux-2.6.11-a/arch/i386/power/swsusp.S	2005-03-02 08:38:37.000000000 +0100
+++ linux-2.6.11-b/arch/i386/power/swsusp.S	2005-03-04 20:14:01.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/page.h>
+#include <asm/asm_offsets.h>
 
 	.text
 
@@ -28,28 +29,28 @@
 	ret
 
 ENTRY(swsusp_arch_resume)
-	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
-	movl %ecx,%cr3
+	movl	$swsusp_pg_dir-__PAGE_OFFSET, %ecx
+	movl	%ecx, %cr3
 
-	movl	pagedir_nosave, %ebx
-	xorl	%eax, %eax
-	xorl	%edx, %edx
+	movl	pagedir_nosave, %edx
 	.p2align 4,,7
 
 copy_loop:
-	movl	4(%ebx,%edx),%edi
-	movl	(%ebx,%edx),%esi
+	testl	%edx, %edx
+	jz	done
+
+	movl	pbe_address(%edx), %esi
+	movl	pbe_orig_address(%edx), %edi
 
 	movl	$1024, %ecx
 	rep
 	movsl
 
-	incl	%eax
-	addl	$16, %edx
-	cmpl	nr_copy_pages,%eax
-	jb copy_loop
+	movl	pbe_next(%edx), %edx
+	jmp	copy_loop
 	.p2align 4,,7
 
+done:
 	movl saved_context_esp, %esp
 	movl saved_context_ebp, %ebp
 	movl saved_context_ebx, %ebx
diff -Nru linux-2.6.11-a/arch/x86_64/kernel/asm-offsets.c linux-2.6.11-b/arch/x86_64/kernel/asm-offsets.c
--- linux-2.6.11-a/arch/x86_64/kernel/asm-offsets.c	2005-03-02 08:38:10.000000000 +0100
+++ linux-2.6.11-b/arch/x86_64/kernel/asm-offsets.c	2005-03-04 20:14:01.000000000 +0100
@@ -62,8 +62,8 @@
 	       offsetof (struct rt_sigframe32, uc.uc_mcontext));
 	BLANK();
 #endif
-	DEFINE(SIZEOF_PBE, sizeof(struct pbe));
 	DEFINE(pbe_address, offsetof(struct pbe, address));
 	DEFINE(pbe_orig_address, offsetof(struct pbe, orig_address));
+	DEFINE(pbe_next, offsetof(struct pbe, next));
 	return 0;
 }
diff -Nru linux-2.6.11-a/arch/x86_64/kernel/suspend_asm.S linux-2.6.11-b/arch/x86_64/kernel/suspend_asm.S
--- linux-2.6.11-a/arch/x86_64/kernel/suspend_asm.S	2005-03-02 08:38:26.000000000 +0100
+++ linux-2.6.11-b/arch/x86_64/kernel/suspend_asm.S	2005-03-04 20:14:01.000000000 +0100
@@ -54,16 +54,10 @@
 	movq	%rax, %cr4;  # turn PGE back on
 
 	movq	pagedir_nosave(%rip), %rdx
-	/* compute the limit */
-	movl	nr_copy_pages(%rip), %eax
-	testl	%eax, %eax
-	jz	done
-	movq	%rdx,%r8
-	movl	$SIZEOF_PBE,%r9d
-	mul		%r9  # with rax, clobbers rdx
-	movq 	%r8, %rdx
-	addq	%r8, %rax
 loop:
+	testq	%rdx, %rdx
+	jz	done
+
 	/* get addresses from the pbe and copy the page */
 	movq	pbe_address(%rdx), %rsi
 	movq	pbe_orig_address(%rdx), %rdi
@@ -72,9 +66,8 @@
 	movsq
 
 	/* progress to the next pbe */
-	addq	$SIZEOF_PBE, %rdx
-	cmpq	%rax, %rdx
-	jb	loop
+	movq	pbe_next(%rdx), %rdx
+	jmp	loop
 done:
 	movl	$24, %eax
 	movl	%eax, %ds
diff -Nru linux-2.6.11-a/kernel/power/swsusp.c linux-2.6.11-b/kernel/power/swsusp.c
--- linux-2.6.11-a/kernel/power/swsusp.c	2005-03-04 20:05:49.000000000 +0100
+++ linux-2.6.11-b/kernel/power/swsusp.c	2005-03-04 20:14:01.000000000 +0100
@@ -621,6 +621,46 @@
 }
 
 /**
+ *	fill_pb_page - Create a list of PBEs on a given memory page
+ */
+
+static inline void fill_pb_page(struct pbe *pbpage)
+{
+	struct pbe *p;
+
+	p = pbpage;
+	pbpage += PB_PAGE_SKIP;
+	do
+		p->next = p + 1;
+	while (++p < pbpage);
+}
+
+/**
+ *	create_pbe_list - Create a list of PBEs on top of a given chain
+ *	of memory pages allocated with alloc_pagedir()
+ */
+ 
+static void create_pbe_list(struct pbe *pblist, unsigned nr_pages)
+{
+	struct pbe *pbpage, *p;
+	unsigned num = PBES_PER_PAGE;
+
+	for_each_pb_page (pbpage, pblist) {
+		if (num >= nr_pages)
+			break;
+
+		fill_pb_page(pbpage);
+		num += PBES_PER_PAGE;
+	}
+	if (pbpage) {
+		for (num -= PBES_PER_PAGE - 1, p = pbpage; num < nr_pages; p++, num++)
+			p->next = p + 1;
+		p->next = NULL;
+	}
+	pr_debug("create_pbe_list(): initialized %d PBEs\n", num);
+}
+
+/**
  *	alloc_pagedir - Allocate the page directory.
  *
  *	First, determine exactly how many pages we need and
@@ -636,7 +676,7 @@
 static struct pbe * alloc_pagedir(unsigned nr_pages)
 {
 	unsigned num;
-	struct pbe *pblist, *pbe, *p;
+	struct pbe *pblist, *pbe;
 
 	if (!nr_pages)
 		return NULL;
@@ -645,21 +685,13 @@
 	pblist = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
 	for (pbe = pblist, num = PBES_PER_PAGE; pbe && num < nr_pages;
         		pbe = pbe->next, num += PBES_PER_PAGE) {
-		p = pbe;
 		pbe += PB_PAGE_SKIP;
-		do
-			p->next = p + 1;
-		while (p++ < pbe);
 		pbe->next = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
 	}
-	if (pbe) {
-		for (num -= PBES_PER_PAGE - 1, p = pbe; num < nr_pages; p++, num++)
-			p->next = p + 1;
-	} else { /* get_zeroed_page() failed */
+	if (!pbe) { /* get_zeroed_page() failed */
 		free_pagedir(pblist);
 		pblist = NULL;
         }
-	pr_debug("alloc_pagedir(): allocated %d PBEs\n", num);
 	return pblist;
 }
 
@@ -766,6 +798,7 @@
 		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
 		return -ENOMEM;
 	}
+	create_pbe_list(pagedir_save, nr_copy_pages);
 	pagedir_nosave = pagedir_save;
 	if ((error = alloc_image_pages())) {
 		printk(KERN_ERR "suspend: Allocating image pages failed.\n");
@@ -917,44 +950,104 @@
 	return 0;
 }
 
-/*
- * We check here that pagedir & pages it points to won't collide with pages
- * where we're going to restore from the loaded pages later
+/**
+ *	On resume, for storing the PBE list and the image,
+ *	we can only use memory pages that do not conflict with the pages
+ *	which had been used before suspend.
+ *
+ *	We don't know which pages are usable until we allocate them.
+ *
+ *	Allocated but unusable (ie eaten) memory pages are linked together
+ *	to create a list, so that we can free them easily
+ *
+ *	We could have used a type other than (void *)
+ *	for this purpose, but ...
  */
-static int __init check_pagedir(void)
+static void **eaten_memory = NULL;
+
+static inline void eat_page(void *page)
 {
-	int i;
+	void **c;
 
-	for(i=0; i < nr_copy_pages; i++) {
-		unsigned long addr;
+	c = eaten_memory;
+	eaten_memory = page;
+	*eaten_memory = c;
+}
 
-		do {
-			addr = get_zeroed_page(GFP_ATOMIC);
-			if(!addr)
-				return -ENOMEM;
-		} while (does_collide_order(addr, 0));
+static unsigned long __init get_usable_page(unsigned gfp_mask)
+{
+	unsigned long m;
 
-		(pagedir_nosave+i)->address = addr;
+	m = get_zeroed_page(gfp_mask);
+	while (does_collide_order(m, 0)) {
+		eat_page((void *)m);
+		m = get_zeroed_page(gfp_mask);
+		if (!m)
+			break;
 	}
-	return 0;
+	return m;
 }
 
-static int __init swsusp_pagedir_relocate(void)
+static void __init free_eaten_memory(void)
 {
-	/*
-	 * We have to avoid recursion (not to overflow kernel stack),
-	 * and that's why code looks pretty cryptic 
+	unsigned long m;
+	void **c;
+	int i = 0;
+
+	c = eaten_memory;
+	while (c) {
+		m = (unsigned long)c;
+		c = *c;
+		free_page(m);
+		i++;
+	}
+	eaten_memory = NULL;
+	pr_debug("swsusp: %d unused pages freed\n", i);
+}
+
+/**
+ *	check_pagedir - We ensure here that pages that the PBEs point to
+ *	won't collide with pages where we're going to restore from the loaded
+ *	pages later
+ */
+
+static int __init check_pagedir(struct pbe *pblist)
+{
+	struct pbe *p;
+
+	/* This is necessary, so that we can free allocated pages
+	 * in case of failure
 	 */
-	suspend_pagedir_t *old_pagedir = pagedir_nosave;
-	void **eaten_memory = NULL;
-	void **c = eaten_memory, *m, *f;
-	int ret = 0;
+	for_each_pbe (p, pblist)
+		p->address = 0UL;
+
+	for_each_pbe (p, pblist) {
+		p->address = get_usable_page(GFP_ATOMIC);
+		if (!p->address)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+/**
+ *	swsusp_pagedir_relocate - It is possible, that some memory pages
+ *	occupied by the list of PBEs collide with pages where we're going to
+ *	restore from the loaded pages later.  We relocate them here.
+ */
+
+static struct pbe * __init swsusp_pagedir_relocate(struct pbe *pblist)
+{
 	struct zone *zone;
-	int i;
-	struct pbe *p;
 	unsigned long zone_pfn;
+	struct pbe *pbpage, *tail, *p;
+	void *m;
+	int rel = 0, error = 0;
+
+	if (!pblist) /* a sanity check */
+		return NULL;
 
-	printk("Relocating pagedir ");
+	pr_debug("swsusp: Relocating pagedir (%lu pages to check)\n",
+			swsusp_info.pagedir_pages);
 
 	/* Set page flags */
 
@@ -964,45 +1057,52 @@
 					zone->zone_start_pfn));
 	}
 
-	/* Clear orig address */
+	/* Clear orig addresses */
 
-	for(i = 0, p = pagedir_nosave; i < nr_copy_pages; i++, p++) {
+	for_each_pbe (p, pblist)
 		ClearPageNosaveFree(virt_to_page(p->orig_address));
-	}
 
-	if (!does_collide_order((unsigned long)old_pagedir, pagedir_order)) {
-		printk("not necessary\n");
-		return check_pagedir();
-	}
+	tail = pblist + PB_PAGE_SKIP;
 
-	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order)) != NULL) {
-		if (!does_collide_order((unsigned long)m, pagedir_order))
-			break;
-		eaten_memory = m;
-		printk( "." ); 
-		*eaten_memory = c;
-		c = eaten_memory;
-	}
+	/* Relocate colliding pages */
 
-	if (!m) {
-		printk("out of memory\n");
-		ret = -ENOMEM;
-	} else {
-		pagedir_nosave =
-			memcpy(m, old_pagedir, PAGE_SIZE << pagedir_order);
+	for_each_pb_page (pbpage, pblist) {
+		if (does_collide_order((unsigned long)pbpage, 0)) {
+			m = (void *)get_usable_page(GFP_ATOMIC | __GFP_COLD);
+			if (!m) {
+				error = -ENOMEM;
+				break;
+			}
+			memcpy(m, (void *)pbpage, PAGE_SIZE);
+			if (pbpage == pblist)
+				pblist = (struct pbe *)m;
+			else
+				tail->next = (struct pbe *)m;
+
+			eat_page((void *)pbpage);
+			pbpage = (struct pbe *)m;
+
+			/* We have to link the PBEs again */
+
+			for (p = pbpage; p < pbpage + PB_PAGE_SKIP; p++)
+				if (p->next) /* needed to save the end */
+					p->next = p + 1;
+
+			rel++;
+		}
+		tail = pbpage + PB_PAGE_SKIP;
 	}
 
-	c = eaten_memory;
-	while (c) {
-		printk(":");
-		f = c;
-		c = *c;
-		free_pages((unsigned long)f, pagedir_order);
+	if (error) {
+		printk("\nswsusp: Out of memory\n\n");
+		free_pagedir(pblist);
+		free_eaten_memory();
+		pblist = NULL;
 	}
-	if (ret)
-		return ret;
-	printk("|\n");
-	return check_pagedir();
+	else
+		printk("swsusp: Relocated %d pages\n", rel);
+
+	return pblist;
 }
 
 /**
@@ -1147,76 +1247,117 @@
 }
 
 /**
- *	swsusp_read_data - Read image pages from swap.
+ *	data_read - Read image pages from swap.
  *
  *	You do not need to check for overlaps, check_pagedir()
  *	already did that.
  */
 
-static int __init data_read(void)
+static int __init data_read(struct pbe *pblist)
 {
 	struct pbe * p;
-	int error;
-	int i;
-	int mod = nr_copy_pages / 100;
+	int error = 0;
+	int i = 0;
+	int mod = swsusp_info.image_pages / 100;
 
 	if (!mod)
 		mod = 1;
 
-	if ((error = swsusp_pagedir_relocate()))
-		return error;
+	printk("swsusp: Reading image data (%lu pages):     ",
+			swsusp_info.image_pages);
+
+	for_each_pbe (p, pblist) {
+		if (!(i % mod))
+			printk("\b\b\b\b%3d%%", i / mod);
 
-	printk( "Reading image data (%d pages):     ", nr_copy_pages );
-	for(i = 0, p = pagedir_nosave; i < nr_copy_pages && !error; i++, p++) {
-		if (!(i%mod))
-			printk( "\b\b\b\b%3d%%", i / mod );
 		error = bio_read_page(swp_offset(p->swap_address),
 				  (void *)p->address);
+		if (error)
+			return error;
+
+		i++;
 	}
-	printk(" %d done.\n",i);
+	printk("\b\b\b\bdone\n");
 	return error;
-
 }
 
 extern dev_t __init name_to_dev_t(const char *line);
 
-static int __init read_pagedir(void)
+/**
+ *	read_pagedir - Read page backup list pages from swap
+ */
+
+static int __init read_pagedir(struct pbe *pblist)
 {
-	unsigned long addr;
-	int i, n = swsusp_info.pagedir_pages;
-	int error = 0;
+	struct pbe *pbpage, *p;
+	unsigned i = 0;
+	int error;
 
-	addr = __get_free_pages(GFP_ATOMIC, pagedir_order);
-	if (!addr)
-		return -ENOMEM;
-	pagedir_nosave = (struct pbe *)addr;
+	if (!pblist)
+		return -EFAULT;
+
+	printk("swsusp: Reading pagedir (%lu pages)\n",
+			swsusp_info.pagedir_pages);
 
-	pr_debug("swsusp: Reading pagedir (%d Pages)\n",n);
+	for_each_pb_page (pbpage, pblist) {
+		unsigned long offset = swp_offset(swsusp_info.pagedir[i++]);
 
-	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE) {
-		unsigned long offset = swp_offset(swsusp_info.pagedir[i]);
-		if (offset)
-			error = bio_read_page(offset, (void *)addr);
-		else
-			error = -EFAULT;
+		error = -EFAULT;
+		if (offset) {
+			p = (pbpage + PB_PAGE_SKIP)->next;
+			error = bio_read_page(offset, (void *)pbpage);
+			(pbpage + PB_PAGE_SKIP)->next = p;
+		}
+		if (error)
+			break;
 	}
+
 	if (error)
-		free_pages((unsigned long)pagedir_nosave, pagedir_order);
+		free_page((unsigned long)pblist);
+
+	BUG_ON(i != swsusp_info.pagedir_pages);
+
 	return error;
 }
 
+
 static int __init read_suspend_image(void)
 {
 	int error = 0;
+	struct pbe *p;
 
 	if ((error = check_sig()))
 		return error;
+
 	if ((error = check_header()))
 		return error;
-	if ((error = read_pagedir()))
+
+	if (!(p = alloc_pagedir(nr_copy_pages)))
+		return -ENOMEM;
+
+	if ((error = read_pagedir(p)))
 		return error;
-	if ((error = data_read()))
-		free_pages((unsigned long)pagedir_nosave, pagedir_order);
+
+	create_pbe_list(p, nr_copy_pages);
+
+	if (!(pagedir_nosave = swsusp_pagedir_relocate(p)))
+		return -ENOMEM;
+
+	/* Allocate memory for the image and read the data from swap */
+
+	error = check_pagedir(pagedir_nosave);
+	free_eaten_memory();
+	if (!error)
+		error = data_read(pagedir_nosave);
+
+	if (error) { /* We fail cleanly */
+		for_each_pbe (p, pagedir_nosave)
+			if (p->address) {
+				free_page(p->address);
+				p->address = 0UL;
+			}
+		free_pagedir(pagedir_nosave);
+	}
 	return error;
 }
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
