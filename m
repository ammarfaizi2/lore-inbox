Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVCOI75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVCOI75 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 03:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVCOI75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 03:59:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49813 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262344AbVCOI7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 03:59:44 -0500
Date: Tue, 15 Mar 2005 00:59:37 -0800
Message-Id: <200503150859.j2F8xbka025647@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 kprobes: handle %RIP-relative addressing mode
In-Reply-To: Andi Kleen's message of  Sunday, 13 March 2005 17:37:46 +0100 <m18y4ry011.fsf@muc.de>
X-Shopping-List: (1) Intrinsic winters
   (2) Geriatric balls
   (3) Romantic commendation dandelions
   (4) Loquacious itinerant winds
   (5) Pregnant inquisitions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you turn these two arrays into a bitmap please? 

Ok.

> This shouldn't be opencoded here. Instead make a utility function
> like vmalloc_range() that takes a start and end address and
> make the module allocation use it too.
> 
> Also you should fix up asm-x86_64/page.h and Documentation/x86_64/mm.txt
> with the new fixed allocation.
[...]
> I think Andrea has just changed that and the patch went into
> mainline. Be careful with merging.

Since __get_vm_area has been changed to make it harder to avoid the guard
page, I decided just to punt and use module_alloc instead.  This works
either with or without the -mm patches that clean it up to use __vmalloc_area.
There is enough address space in the module area that I'm not going to
worry about each page kprobes uses wasting a second page of address space.

Here is a new version of the patch that addresses your comments.


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
@@ -34,7 +36,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/preempt.h>
-#include <linux/vmalloc.h>
+#include <linux/moduleloader.h>
 
 #include <asm/pgtable.h>
 #include <asm/kdebug.h>
@@ -86,9 +88,132 @@ int arch_prepare_kprobe(struct kprobe *p
 	return 0;
 }
 
+/*
+ * Determine if the instruction uses the %rip-relative addressing mode.
+ * If it does, return the address of the 32-bit displacement word.
+ * If not, return null.
+ */
+static inline s32 *is_riprel(u8 *insn)
+{
+#define W(row,b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,ba,bb,bc,bd,be,bf)		      \
+	(((b0##UL << 0x0)|(b1##UL << 0x1)|(b2##UL << 0x2)|(b3##UL << 0x3) |   \
+	  (b4##UL << 0x4)|(b5##UL << 0x5)|(b6##UL << 0x6)|(b7##UL << 0x7) |   \
+	  (b8##UL << 0x8)|(b9##UL << 0x9)|(ba##UL << 0xa)|(bb##UL << 0xb) |   \
+	  (bc##UL << 0xc)|(bd##UL << 0xd)|(be##UL << 0xe)|(bf##UL << 0xf))    \
+	 << (row % 64))
+	static const u64 onebyte_has_modrm[256 / 64] = {
+		/*      0 1 2 3 4 5 6 7 8 9 a b c d e f         */
+		/*      -------------------------------         */
+		W(0x00, 1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0)| /* 00 */
+		W(0x10, 1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0)| /* 10 */
+		W(0x20, 1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0)| /* 20 */
+		W(0x30, 1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0), /* 30 */
+		W(0x40, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)| /* 40 */
+		W(0x50, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)| /* 50 */
+		W(0x60, 0,0,1,1,0,0,0,0,0,1,0,1,0,0,0,0)| /* 60 */
+		W(0x70, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0), /* 70 */
+		W(0x80, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)| /* 80 */
+		W(0x90, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)| /* 90 */
+		W(0xa0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)| /* a0 */
+		W(0xb0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0), /* b0 */
+		W(0xc0, 1,1,0,0,1,1,1,1,0,0,0,0,0,0,0,0)| /* c0 */
+		W(0xd0, 1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1)| /* d0 */
+		W(0xe0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)| /* e0 */
+		W(0xf0, 0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1)  /* f0 */
+		/*      -------------------------------         */
+		/*      0 1 2 3 4 5 6 7 8 9 a b c d e f         */
+	};
+	static const u64 twobyte_has_modrm[256 / 64] = {
+		/*      0 1 2 3 4 5 6 7 8 9 a b c d e f         */
+		/*      -------------------------------         */
+		W(0x00, 1,1,1,1,0,0,0,0,0,0,0,0,0,1,0,1)| /* 0f */
+		W(0x10, 1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0)| /* 1f */
+		W(0x20, 1,1,1,1,1,0,1,0,1,1,1,1,1,1,1,1)| /* 2f */
+		W(0x30, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0), /* 3f */
+		W(0x40, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)| /* 4f */
+		W(0x50, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)| /* 5f */
+		W(0x60, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)| /* 6f */
+		W(0x70, 1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,1), /* 7f */
+		W(0x80, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)| /* 8f */
+		W(0x90, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)| /* 9f */
+		W(0xa0, 0,0,0,1,1,1,1,1,0,0,0,1,1,1,1,1)| /* af */
+		W(0xb0, 1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1), /* bf */
+		W(0xc0, 1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0)| /* cf */
+		W(0xd0, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)| /* df */
+		W(0xe0, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)| /* ef */
+		W(0xf0, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0)  /* ff */
+		/*      -------------------------------         */
+		/*      0 1 2 3 4 5 6 7 8 9 a b c d e f         */
+	};
+#undef	W
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
+		++insn;
+		need_modrm = test_bit(*insn, twobyte_has_modrm);
+	} else {		/* One-byte opcode.  */
+		need_modrm = test_bit(*insn, onebyte_has_modrm);
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
@@ -439,8 +564,15 @@ static kprobe_opcode_t *get_insn_slot(vo
 	if (!kip) {
 		return NULL;
 	}
-	kip->insns = (kprobe_opcode_t*) __vmalloc(PAGE_SIZE,
-		GFP_KERNEL|__GFP_HIGHMEM, __pgprot(__PAGE_KERNEL_EXEC));
+
+	/*
+	 * For the %rip-relative displacement fixups to be doable, we
+	 * need our instruction copy to be within +/- 2GB of any data it
+	 * might access via %rip.  That is, within 2GB of where the
+	 * kernel image and loaded module images reside.  So we allocate
+	 * a page in the module loading area.
+	 */
+	kip->insns = module_alloc(PAGE_SIZE);
 	if (!kip->insns) {
 		kfree(kip);
 		return NULL;
@@ -481,7 +614,7 @@ static void free_insn_slot(kprobe_opcode
 					hlist_add_head(&kip->hlist,
 						&kprobe_insn_pages);
 				} else {
-					vfree(kip->insns);
+					module_free(NULL, kip->insns);
 					kfree(kip);
 				}
 			}
