Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269472AbUJSPzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269472AbUJSPzv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 11:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269474AbUJSPzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 11:55:51 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:61069 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S269472AbUJSPzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 11:55:13 -0400
Date: Tue, 19 Oct 2004 19:54:50 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, debian-alpha@lists.debian.org,
       linux-alpha@vger.kernel.org
Subject: Re: 2.4.27, alpha arch, make bootimage and make bootpfile fails
Message-ID: <20041019195450.A5679@jurassic.park.msu.ru>
References: <20041012173344.GA21846@gamma.logic.tuwien.ac.at> <20041013233247.A11663@jurassic.park.msu.ru> <20041014130035.GA4152@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041014130035.GA4152@gamma.logic.tuwien.ac.at>; from preining@logic.at on Thu, Oct 14, 2004 at 03:00:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 03:00:35PM +0200, Norbert Preining wrote:
> Ok, now I have a boot file but the kernel is not started:
> 
> >>> boot ewa0 -fl ...
> ...
> Halted CPU 0
> 
> halt code = 2
> kernel stack not valid halt

I was able to reproduce that on SX164 with both bootpfile and bootpzfile.
As it turns out, the final kernel destination overlaps the initial stack
region. Please test the appended patch.

Ivan.

--- 2.4/arch/alpha/boot/bootp.c	Fri Oct  5 05:47:08 2001
+++ linux/arch/alpha/boot/bootp.c	Tue Oct 19 19:22:21 2004
@@ -26,6 +26,8 @@ extern unsigned long switch_to_osf_pal(u
 	struct pcb_struct * pcb_va, struct pcb_struct * pcb_pa,
 	unsigned long *vptb);
 
+extern void move_stack(unsigned long new_stack);
+
 struct hwrpb_struct *hwrpb = INIT_HWRPB;
 static struct pcb_struct pcb_va[1];
 
@@ -118,12 +120,10 @@ static inline void
 runkernel(void)
 {
 	__asm__ __volatile__(
-		"bis %1,%1,$30\n\t"
 		"bis %0,%0,$27\n\t"
 		"jmp ($27)"
 		: /* no outputs: it doesn't even return */
-		: "r" (START_ADDR),
-		  "r" (PAGE_SIZE + INIT_STACK));
+		: "r" (START_ADDR));
 }
 
 extern char _end;
@@ -147,9 +147,7 @@ start_kernel(void)
 	 */
 	static long nbytes;
 	static char envval[256] __attribute__((aligned(8)));
-#ifdef INITRD_IMAGE_SIZE
 	static unsigned long initrd_start;
-#endif
 
 	srm_printk("Linux/AXP bootp loader for Linux " UTS_RELEASE "\n");
 	if (INIT_HWRPB->pagesize != 8192) {
@@ -164,12 +162,19 @@ start_kernel(void)
 	}
 	pal_init();
 
-#ifdef INITRD_IMAGE_SIZE
 	/* The initrd must be page-aligned.  See below for the 
 	   cause of the magic number 5.  */
-	initrd_start = ((START_ADDR + 5*KERNEL_SIZE) | (PAGE_SIZE-1)) + 1;
+	initrd_start = ((START_ADDR + 5*KERNEL_SIZE + PAGE_SIZE) |
+			(PAGE_SIZE-1)) + 1;
+#ifdef INITRD_IMAGE_SIZE
 	srm_printk("Initrd positioned at %#lx\n", initrd_start);
 #endif
+
+	/*
+	 * Move the stack to a safe place to ensure it won't be
+	 * overwritten by kernel image.
+	 */
+	move_stack(initrd_start - PAGE_SIZE);
 
 	nbytes = callback_getenv(ENV_BOOTED_OSFLAGS, envval, sizeof(envval));
 	if (nbytes < 0 || nbytes >= sizeof(envval)) {
--- 2.4/arch/alpha/boot/bootpz.c	Tue Oct 19 19:27:49 2004
+++ linux/arch/alpha/boot/bootpz.c	Tue Oct 19 19:12:16 2004
@@ -32,9 +32,6 @@
 #undef DEBUG_CHECK_RANGE
 #define DEBUG_ADDRESSES
 
-#define DEBUG_SP(x) \
-    {register long sp asm("30"); srm_printk("%s (sp=%lx)\n", x, sp);}
-
 extern unsigned long switch_to_osf_pal(unsigned long nr,
 	struct pcb_struct * pcb_va, struct pcb_struct * pcb_pa,
 	unsigned long *vptb);
@@ -42,6 +39,8 @@ extern unsigned long switch_to_osf_pal(u
 extern int decompress_kernel(void* destination, void *source,
 			     size_t ksize, size_t kzsize);
 
+extern void move_stack(unsigned long new_stack);
+
 struct hwrpb_struct *hwrpb = INIT_HWRPB;
 static struct pcb_struct pcb_va[1];
 
@@ -154,12 +153,10 @@ static inline void
 runkernel(void)
 {
 	__asm__ __volatile__(
-		"bis %1,%1,$30\n\t"
 		"bis %0,%0,$27\n\t"
 		"jmp ($27)"
 		: /* no outputs: it doesn't even return */
-		: "r" (START_ADDR),
-		  "r" (PAGE_SIZE + INIT_STACK));
+		: "r" (START_ADDR));
 }
 
 /* Must record the SP (it is virtual) on entry, so we can make sure
@@ -244,7 +241,9 @@ extern char _end;
    for "bootmem" anyway.
 */
 #define K_COPY_IMAGE_START	NEXT_PAGE(K_KERNEL_IMAGE_END)
-#define K_INITRD_START		NEXT_PAGE(K_COPY_IMAGE_START + KERNEL_SIZE)
+/* Reserve one page below INITRD for the new stack. */
+#define K_INITRD_START \
+    NEXT_PAGE(K_COPY_IMAGE_START + KERNEL_SIZE + PAGE_SIZE)
 #define K_COPY_IMAGE_END \
     (K_INITRD_START + REAL_INITRD_SIZE + MALLOC_AREA_SIZE)
 #define K_COPY_IMAGE_SIZE \
@@ -410,8 +409,7 @@ start_kernel(void)
 		   initrd_image_start,
 		   INITRD_IMAGE_SIZE);
 #endif
-	memcpy((void *)initrd_image_start,
-	       (void *)V_INITRD_START,
+	memcpy((void *)initrd_image_start, (void *)V_INITRD_START,
 	       INITRD_IMAGE_SIZE);
 
 #endif /* INITRD_IMAGE_SIZE */
@@ -427,9 +425,14 @@ start_kernel(void)
 			   K_KERNEL_IMAGE_START,
 			   (unsigned)KERNEL_SIZE);
 #endif
+		/*
+		 * Move the stack to a safe place to ensure it won't be
+		 * overwritten by kernel image.
+		 */
+		move_stack(initrd_image_start - PAGE_SIZE);
+
 		memcpy((void *)K_KERNEL_IMAGE_START,
-		       (void *)uncompressed_image_start,
-		       KERNEL_SIZE);
+		       (void *)uncompressed_image_start, KERNEL_SIZE);
 	}
 	
 	/* Clear the zero page, then move the argument list in. */
--- 2.4/arch/alpha/boot/bootloader.lds	Tue Jul  3 01:40:14 2001
+++ linux/arch/alpha/boot/bootloader.lds	Tue Oct 19 15:56:21 2004
@@ -1,5 +1,6 @@
 OUTPUT_FORMAT("elf64-alpha")
 ENTRY(__start)
+printk = srm_printk;
 SECTIONS
 {
   . = 0x20000000;
--- 2.4/arch/alpha/boot/head.S	Mon Oct 12 22:40:12 1998
+++ linux/arch/alpha/boot/head.S	Tue Oct 19 18:51:47 2004
@@ -100,3 +100,24 @@ halt:
 	.prologue 0
 	call_pal PAL_halt
 	.end halt
+
+/* $16 - new stack page */
+	.align 3
+	.globl	move_stack
+	.ent	move_stack
+move_stack:
+	.prologue 0
+	lda	$0, 0x1fff($31)
+	and	$0, $30, $1			/* Stack offset */
+	or	$1, $16, $16			/* New stack pointer */
+	mov	$30, $1
+	mov	$16, $2
+1:	ldq	$3, 0($1)			/* Move the stack */
+	addq	$1, 8, $1
+	stq	$3, 0($2)
+	and	$0, $1, $4
+	addq	$2, 8, $2
+	bne	$4, 1b
+	mov	$16, $30
+	ret	($26)
+	.end move_stack
