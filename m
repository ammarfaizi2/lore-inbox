Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263452AbVCMJ4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbVCMJ4G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 04:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263483AbVCMJ4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 04:56:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3731 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263452AbVCMJzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 04:55:08 -0500
Date: Sun, 13 Mar 2005 01:54:42 -0800
Message-Id: <200503130954.j2D9sgjB028594@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Cc: Jim Keniston <jkenisto@us.ibm.com>,
       "Prasanna S. Panchamukhi" <PRASANNA@in.ibm.com>
Subject: [PATCH] x86-64 kprobes: handle %RIP-relative addressing mode
Emacs: the only text editor known to get indigestion.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The existing x86-64 kprobes implementation doesn't cope with the
%RIP-relative addressing mode.  Kprobes work by single-stepping a copy of
an instruction overwritten by a breakpoint.  When a probe is inserted on an
instruction that uses the %RIP-relative data addressing mode, the copy run
in a different location gets different data and so the presence of that
probe causes the probed code to read or write the wrong memory location.
Without this problem fixed, it is woefully unsafe to use the current
kprobes code on x86-64 unless you are sure the instruction you instrument
is not one that accesses global data using the %RIP addressing mode.

This patch fixes the problem by recognizing the %RIP-relative addressing
mode in an instruction when it's being copied to insert the kprobe, and
adjusting its displacement so that it finds the right data.  Taking this
approach requires that the copied instruction's %RIP value be within 2GB of
the virtual address of the data, i.e. the text/data areas of the kernel
code and loaded modules.  To satisfy this need the patch also replaces the
use of vmalloc for getting instruction pages with lower-level calls to use
a different part of the address space, the area at the top of the address
space just above where modules are loaded.  I left one page of red zone at
the top, and the 1MB-4KB thus available allows for at most 69632 kprobes.
(If we ever need to overcome that limit, we can change this to add a hook
into the arch/x86_64/kernel/modules.c code and allocate pages inside the
module area loading area instead.)


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/arch/x86_64/kernel/kprobes.c
+++ linux-2.6/arch/x86_64/kernel/kprobes.c
@@ -25,6 +25,8 @@
  *		interface to access function arguments.
  * 2004-Oct	Jim Keniston <kenistoj@us.ibm.com> and Prasanna S Panchamukhi
  *		<prasanna@in.ibm.com> adapted for x86_64
+ * 2005-Mar	Roland McGrath <roland@redhat.com>
+ *		Fixed to handle %rip-relative addressing mode correctly.
  */
 
 #include <linux/config.h>
@@ -86,9 +88,124 @@ int arch_prepare_kprobe(struct kprobe *p
 	return 0;
 }
 
+/*
+ * Determine if the instruction uses the %rip-relative addressing mode.
+ * If it does, return the address of the 32-bit displacement word.
+ * If not, return null.
+ */
+static inline s32 *is_riprel(u8 *insn)
+{
+	static const unsigned char onebyte_has_modrm[256] = {
+		/*       0 1 2 3 4 5 6 7 8 9 a b c d e f        */
+		/*       -------------------------------        */
+		/* 00 */ 1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0, /* 00 */
+		/* 10 */ 1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0, /* 10 */
+		/* 20 */ 1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0, /* 20 */
+		/* 30 */ 1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0, /* 30 */
+		/* 40 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* 40 */
+		/* 50 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* 50 */
+		/* 60 */ 0,0,1,1,0,0,0,0,0,1,0,1,0,0,0,0, /* 60 */
+		/* 70 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* 70 */
+		/* 80 */ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, /* 80 */
+		/* 90 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* 90 */
+		/* a0 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* a0 */
+		/* b0 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* b0 */
+		/* c0 */ 1,1,0,0,1,1,1,1,0,0,0,0,0,0,0,0, /* c0 */
+		/* d0 */ 1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1, /* d0 */
+		/* e0 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* e0 */
+		/* f0 */ 0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1  /* f0 */
+		/*       -------------------------------        */
+		/*       0 1 2 3 4 5 6 7 8 9 a b c d e f        */
+	};
+	static const unsigned char twobyte_has_modrm[256] = {
+		/*       0 1 2 3 4 5 6 7 8 9 a b c d e f        */
+		/*       -------------------------------        */
+		/* 00 */ 1,1,1,1,0,0,0,0,0,0,0,0,0,1,0,1, /* 0f */
+		/* 10 */ 1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0, /* 1f */
+		/* 20 */ 1,1,1,1,1,0,1,0,1,1,1,1,1,1,1,1, /* 2f */
+		/* 30 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* 3f */
+		/* 40 */ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, /* 4f */
+		/* 50 */ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, /* 5f */
+		/* 60 */ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, /* 6f */
+		/* 70 */ 1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,1, /* 7f */
+		/* 80 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* 8f */
+		/* 90 */ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, /* 9f */
+		/* a0 */ 0,0,0,1,1,1,1,1,0,0,0,1,1,1,1,1, /* af */
+		/* b0 */ 1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1, /* bf */
+		/* c0 */ 1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0, /* cf */
+		/* d0 */ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, /* df */
+		/* e0 */ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, /* ef */
+		/* f0 */ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0  /* ff */
+		/*       -------------------------------        */
+		/*       0 1 2 3 4 5 6 7 8 9 a b c d e f        */
+	};
+	int need_modrm;
+
+	/* Skip legacy instruction prefixes.  */
+	while (1) {
+		switch (*insn) {
+		case 0x66:
+		case 0x67:
+		case 0x2e:
+		case 0x3e:
+		case 0x26:
+		case 0x64:
+		case 0x65:
+		case 0x36:
+		case 0xf0:
+		case 0xf3:
+		case 0xf2:
+			++insn;
+			continue;
+		}
+		break;
+	}
+
+	/* Skip REX instruction prefix.  */
+	if ((*insn & 0xf0) == 0x40)
+		++insn;
+
+	if (*insn == 0x0f) {	/* Two-byte opcode.  */
+		need_modrm = twobyte_has_modrm[*++insn];
+	} else {		/* One-byte opcode.  */
+		need_modrm = onebyte_has_modrm[*insn];
+	}
+
+	if (need_modrm) {
+		u8 modrm = *++insn;
+		if ((modrm & 0xc7) == 0x05) { /* %rip+disp32 addressing mode */
+			/* Displacement follows ModRM byte.  */
+			return (s32 *) ++insn;
+		}
+	}
+
+	/* No %rip-relative addressing mode here.  */
+	return NULL;
+}
+
 void arch_copy_kprobe(struct kprobe *p)
 {
+	s32 *ripdisp;
 	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE);
+	ripdisp = is_riprel(p->ainsn.insn);
+	if (ripdisp) {
+		/*
+		 * The copied instruction uses the %rip-relative
+		 * addressing mode.  Adjust the displacement for the
+		 * difference between the original location of this
+		 * instruction and the location of the copy that will
+		 * actually be run.  The tricky bit here is making sure
+		 * that the sign extension happens correctly in this
+		 * calculation, since we need a signed 32-bit result to
+		 * be sign-extended to 64 bits when it's added to the
+		 * %rip value and yield the same 64-bit result that the
+		 * sign-extension of the original signed 32-bit
+		 * displacement would have given.
+		 */
+		s64 disp = (u8 *) p->addr + *ripdisp - (u8 *) p->ainsn.insn;
+		BUG_ON((s64) (s32) disp != disp); /* Sanity check.  */
+		*ripdisp = disp;
+	}
 }
 
 void arch_remove_kprobe(struct kprobe *p)
@@ -417,6 +534,8 @@ static kprobe_opcode_t *get_insn_slot(vo
 {
 	struct kprobe_insn_page *kip;
 	struct hlist_node *pos;
+	struct vm_struct *area;
+	struct page **pages;
 
 	hlist_for_each(pos, &kprobe_insn_pages) {
 		kip = hlist_entry(pos, struct kprobe_insn_page, hlist);
@@ -439,12 +558,52 @@ static kprobe_opcode_t *get_insn_slot(vo
 	if (!kip) {
 		return NULL;
 	}
-	kip->insns = (kprobe_opcode_t*) __vmalloc(PAGE_SIZE,
-		GFP_KERNEL|__GFP_HIGHMEM, __pgprot(__PAGE_KERNEL_EXEC));
-	if (!kip->insns) {
+
+	/*
+	 * For the %rip-relative displacement fixups to be doable, we
+	 * need our instruction copy to be within +/- 2GB of any data
+	 * it might access via %rip.  That is, within 2GB of where the
+	 * kernel image and loaded module images reside.  From the base
+	 * of kernel text (see vmlinux.lds.S) up through the top of the
+	 * address space is less than 2GB total.  There is a megabyte
+	 * of space free from MODULE_END up to the top of the address
+	 * space.  We cap it one page short of that just to have some
+	 * unmapped space at the very top for sanity's sake in case of
+	 * *(NULL - constant) accesses in buggy kernel code.
+	 *
+	 * This basically replicates __vmalloc, except that it uses a
+	 * range of addresses starting at MODULE_END.  This also
+	 * allocates a single page of address space with no following
+	 * guard page (__get_vm_area always adds PAGE_SIZE to the size,
+	 * so by passing zero we get the one page).  We set up all the
+	 * data structures here such that a normal vfree call tears
+	 * them all down just right.
+	 */
+	area = __get_vm_area(0, VM_ALLOC, MODULES_END, 0ULL - PAGE_SIZE);
+	if (!area)
+		goto fail_kip;
+	area->nr_pages = 1;
+	area->pages = kmalloc(sizeof(struct page *), GFP_KERNEL);
+	if (!area->pages)
+		goto fail_area;
+	area->pages[0] = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
+	if (!area->pages[0])
+		goto fail_pages;
+	pages = area->pages;
+	if (map_vm_area(area, PAGE_KERNEL_EXEC, &pages)) {
+		__free_page(area->pages[0]);
+	fail_pages:
+		kfree(area->pages);
+	fail_area:
+		remove_vm_area(area->addr);
+		kfree(area);
+	fail_kip:
 		kfree(kip);
 		return NULL;
 	}
+	BUG_ON(pages != area->pages + 1);
+	kip->insns = (kprobe_opcode_t *) area->addr;
+
 	INIT_HLIST_NODE(&kip->hlist);
 	hlist_add_head(&kip->hlist, &kprobe_insn_pages);
 	memset(kip->slot_used, 0, INSNS_PER_PAGE);
