Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVBGLI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVBGLI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 06:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVBGLI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 06:08:29 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:10369 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261396AbVBGLIE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 06:08:04 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] swsusp: do not use higher order allocations on resume [update 2]
Date: Mon, 7 Feb 2005 12:08:49 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@linuxmail.org>,
       Hu Gang <hugang@soulinfo.com>
References: <200501310019.39526.rjw@sisk.pl>
In-Reply-To: <200501310019.39526.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502071208.50001.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 31 of January 2005 00:19, Rafael J. Wysocki wrote:
> Hi,
> 
> The following patch is (yet) an(other) attempt to eliminate the need for using higher
> order memory allocations on resume.  It accomplishes this by replacing the array
> of page backup entries with a list, so it is only necessary to allocate individual
> memory pages.  This approach makes it possible to avoid relocating many memory
> pages on resume (as a result, much less memory is used) and to simplify
> the assembly code that restores the image.

I have updated the resume patch to apply to the 2.6.11-rc3-mm1 kernel that
contains the suspend part and the x86_64-Speed-up-suspend patch.  The patch
is only for x86-64 and i386.

[Note: without this patch the resume process fails on my box ("out of memory")
during every 7th - 8th suspend/resume cycle, on the average.]

I'm going to maintain this patch so that it's available for the next -mm
kernels (it will be available under http://www.sisk.pl/kernel/patches/).

The (updated) patch follows.

Greets,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

diff -Nru linux-2.6.11-rc3-mm1-orig/arch/i386/power/swsusp.S linux-2.6.11-rc3-mm1/arch/i386/power/swsusp.S
--- linux-2.6.11-rc3-mm1-orig/arch/i386/power/swsusp.S	2004-12-24 22:34:31.000000000 +0100
+++ linux-2.6.11-rc3-mm1/arch/i386/power/swsusp.S	2005-02-05 20:57:03.000000000 +0100
@@ -28,28 +28,28 @@
 	ret
 
 ENTRY(swsusp_arch_resume)
-	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
-	movl %ecx,%cr3
+	movl	$swsusp_pg_dir-__PAGE_OFFSET,%ecx
+	movl	%ecx,%cr3
 
-	movl	pagedir_nosave, %ebx
-	xorl	%eax, %eax
-	xorl	%edx, %edx
+	movl	pagedir_nosave, %edx
+	testl	%edx, %edx
+	jz	done
 	.p2align 4,,7
 
 copy_loop:
-	movl	4(%ebx,%edx),%edi
-	movl	(%ebx,%edx),%esi
+	movl	(%edx), %esi
+	movl	4(%edx), %edi
 
 	movl	$1024, %ecx
 	rep
 	movsl
 
-	incl	%eax
-	addl	$16, %edx
-	cmpl	nr_copy_pages,%eax
-	jb copy_loop
+	movl	12(%edx), %edx
+	testl	%edx, %edx
+	jnz	copy_loop
 	.p2align 4,,7
 
+done:
 	movl saved_context_esp, %esp
 	movl saved_context_ebp, %ebp
 	movl saved_context_ebx, %ebx
diff -Nru linux-2.6.11-rc3-mm1-orig/arch/x86_64/kernel/asm-offsets.c linux-2.6.11-rc3-mm1/arch/x86_64/kernel/asm-offsets.c
--- linux-2.6.11-rc3-mm1-orig/arch/x86_64/kernel/asm-offsets.c	2005-02-05 20:49:04.000000000 +0100
+++ linux-2.6.11-rc3-mm1/arch/x86_64/kernel/asm-offsets.c	2005-02-05 20:57:03.000000000 +0100
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
diff -Nru linux-2.6.11-rc3-mm1-orig/arch/x86_64/kernel/suspend_asm.S linux-2.6.11-rc3-mm1/arch/x86_64/kernel/suspend_asm.S
--- linux-2.6.11-rc3-mm1-orig/arch/x86_64/kernel/suspend_asm.S	2005-02-05 20:49:04.000000000 +0100
+++ linux-2.6.11-rc3-mm1/arch/x86_64/kernel/suspend_asm.S	2005-02-05 20:57:03.000000000 +0100
@@ -54,15 +54,8 @@
 	movq	%rax, %cr4;  # turn PGE back on
 
 	movq	pagedir_nosave(%rip), %rdx
-	/* compute the limit */
-	movl	nr_copy_pages(%rip), %eax
-	testl	%eax, %eax
+	testq	%rdx, %rdx
 	jz	done
-	movq	%rdx,%r8
-	movl	$SIZEOF_PBE,%r9d
-	mul		%r9  # with rax, clobbers rdx
-	movq 	%r8, %rdx
-	addq	%r8, %rax
 loop:
 	/* get addresses from the pbe and copy the page */
 	movq	pbe_address(%rdx), %rsi
@@ -72,9 +65,9 @@
 	movsq
 
 	/* progress to the next pbe */
-	addq	$SIZEOF_PBE, %rdx
-	cmpq	%rax, %rdx
-	jb	loop
+	movq	pbe_next(%rdx), %rdx
+	testq	%rdx, %rdx
+	jnz	loop
 done:
 	movl	$24, %eax
 	movl	%eax, %ds
diff -Nru linux-2.6.11-rc3-mm1-orig/kernel/power/swsusp.c linux-2.6.11-rc3-mm1/kernel/power/swsusp.c
--- linux-2.6.11-rc3-mm1-orig/kernel/power/swsusp.c	2005-02-05 20:49:33.000000000 +0100
+++ linux-2.6.11-rc3-mm1/kernel/power/swsusp.c	2005-02-05 20:57:03.000000000 +0100
@@ -919,44 +919,96 @@
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
-{
-	int i;
+static void **eaten_memory = NULL;
 
-	for(i=0; i < nr_copy_pages; i++) {
-		unsigned long addr;
+static unsigned long __init get_usable_page(unsigned gfp_mask) {
+	unsigned long m;
+	void **c = eaten_memory;
+
+	m = get_zeroed_page(gfp_mask);
+	while (does_collide_order(m, 0)) {
+		eaten_memory = (void *)m;
+		*eaten_memory = c;
+		c = eaten_memory;
+		m = get_zeroed_page(gfp_mask);
+		if (!m)
+			break;
+	}
+	return m;
+}
 
-		do {
-			addr = get_zeroed_page(GFP_ATOMIC);
-			if(!addr)
-				return -ENOMEM;
-		} while (does_collide_order(addr, 0));
+static void __init free_eaten_memory(void) {
+	unsigned long m;
+	void **c;
+	int i = 0;
 
-		(pagedir_nosave+i)->address = addr;
+	c = eaten_memory;
+	while (c) {
+		m = (unsigned long)c;
+		c = *c;
+		free_page(m);
+		i++;
 	}
-	return 0;
+	eaten_memory = NULL;
+	pr_debug("swsusp: %d unused pages freed\n", i);
 }
 
-static int __init swsusp_pagedir_relocate(void)
+/**
+ *	check_pagedir - We ensure here that pages that the PBEs point to
+ *	won't collide with pages where we're going to restore from the loaded
+ *	pages later
+ */
+
+static int __init check_pagedir(struct pbe *pblist)
 {
-	/*
-	 * We have to avoid recursion (not to overflow kernel stack),
-	 * and that's why code looks pretty cryptic 
+	struct pbe *p;
+
+	/* This is necessary, so that we can free allocated pages
+	 * in case of failure
 	 */
-	suspend_pagedir_t *old_pagedir = pagedir_nosave;
-	void **eaten_memory = NULL;
-	void **c = eaten_memory, *m, *f;
-	int ret = 0;
+	for_each_pbe(p, pblist)
+		p->address = 0UL;
+
+	for_each_pbe(p, pblist) {
+		p->address = get_usable_page(GFP_ATOMIC);
+		if(!p->address)
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
 
-	printk("Relocating pagedir ");
+	if (!pblist) /* a sanity check */
+		return NULL;
+
+	pr_debug("swsusp: Relocating pagedir (%lu pages to check)\n",
+			swsusp_info.pagedir_pages);
 
 	/* Set page flags */
 
@@ -966,45 +1018,52 @@
 					zone->zone_start_pfn));
 	}
 
-	/* Clear orig address */
+	/* Clear orig addresses */
 
-	for(i = 0, p = pagedir_nosave; i < nr_copy_pages; i++, p++) {
+	for_each_pbe(p, pblist)
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
+	for_each_pb_page(pbpage, pblist) {
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
+			free_page((unsigned long)pbpage);
+			pbpage = (struct pbe *)m;
+
+			/* We have to link the PBEs again */
+
+			for (p = pbpage ; p < pbpage + PB_PAGE_SKIP ; p++)
+				if (p->next) /* needed to save the end */
+					p->next = p + 1;
+
+			rel++;
+		}
+		tail = pbpage + PB_PAGE_SKIP;
+	}
+
+	if (error) {
+		printk("\nswsusp: Out of memory\n\n");
+		free_pagedir(pblist);
+		free_eaten_memory();
+		pblist = NULL;
 	}
+	else
+		printk("swsusp: Relocated %d pages\n", rel);
 
-	c = eaten_memory;
-	while (c) {
-		printk(":");
-		f = c;
-		c = *c;
-		free_pages((unsigned long)f, pagedir_order);
-	}
-	if (ret)
-		return ret;
-	printk("|\n");
-	return check_pagedir();
+	return pblist;
 }
 
 /**
@@ -1149,76 +1208,150 @@
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
+	for_each_pbe(p, pblist) {
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
+ *	read_pagedir - Read page backup list pages from swap, allocate
+ *	memory for them and set up the list
+ *
+ *	The list of PBEs that is created by this function may be freed
+ *	using free_pagedir()
+ */
+
+static struct pbe * __init read_pagedir(void)
 {
-	unsigned long addr;
-	int i, n = swsusp_info.pagedir_pages;
-	int error = 0;
+	unsigned nr_pages = swsusp_info.image_pages;
+	unsigned num, i = 0;
+	struct pbe *pblist, *pbe, *p;
+	unsigned long offset;
+	int error;
 
-	addr = __get_free_pages(GFP_ATOMIC, pagedir_order);
-	if (!addr)
-		return -ENOMEM;
-	pagedir_nosave = (struct pbe *)addr;
+	if (!nr_pages)
+		return NULL;
+
+	printk("swsusp: Reading pagedir (%lu pages)\n",
+			swsusp_info.pagedir_pages);
 
-	pr_debug("swsusp: Reading pagedir (%d Pages)\n",n);
+	pblist = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+	if (!pblist)
+		return NULL;
+
+	error = -EFAULT;
+	offset = swp_offset(swsusp_info.pagedir[i++]);
+	if (offset)
+		error = bio_read_page(offset, (void *)pblist);
+
+	if (error) {
+		free_page((unsigned long)pblist);
+		pblist = NULL;
+	}
+
+	for (pbe = pblist, num = PBES_PER_PAGE ; pbe && num < nr_pages ;
+        		pbe = pbe->next, num += PBES_PER_PAGE) {
+		p = pbe;
+		pbe += PB_PAGE_SKIP;
+		do
+			p->next = p + 1;
+		while (p++ < pbe);
+		pbe->next = NULL;
+		error = -EFAULT;
+		p = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+		if (p)
+			offset = swp_offset(swsusp_info.pagedir[i++]);
 
-	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE) {
-		unsigned long offset = swp_offset(swsusp_info.pagedir[i]);
 		if (offset)
-			error = bio_read_page(offset, (void *)addr);
+			error = bio_read_page(offset, (void *)p);
+
+		if (error) {
+			if (p)
+				free_page((unsigned long)p);
+		}
 		else
-			error = -EFAULT;
+			pbe->next = p;
 	}
-	if (error)
-		free_pages((unsigned long)pagedir_nosave, pagedir_order);
-	return error;
+	if (pbe) {
+		for (num -= PBES_PER_PAGE - 1, p = pbe ; num < nr_pages ; p++, num++)
+			p->next = p + 1;
+
+		p->next = NULL;
+		pr_debug("swsusp: Read %d pages, allocated %d PBEs\n", i, num);
+		error = (i != swsusp_info.pagedir_pages); /* a sanity check */
+	}
+	if (error) { /* if pbe is zero, error must be non-zero */
+		free_pagedir(pblist);
+		pblist =  NULL;
+		pr_debug("swsusp: Reading pagedir failed\n");
+	}
+	return pblist;
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
-		return error;
-	if ((error = data_read()))
-		free_pages((unsigned long)pagedir_nosave, pagedir_order);
+
+	if(!(p = read_pagedir()))
+		return -EFAULT;
+
+	if(!(pagedir_nosave = swsusp_pagedir_relocate(p)))
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
+		for_each_pbe(p, pagedir_nosave)
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
