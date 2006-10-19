Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946446AbWJSU0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946446AbWJSU0c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946452AbWJSU0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:26:32 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:2205 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1946446AbWJSU0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:26:31 -0400
Date: Thu, 19 Oct 2006 22:26:12 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Avi Kivity <avi@qumranet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] KVM: mmu virtualization
In-Reply-To: <45378377.9080604@qumranet.com>
Message-ID: <Pine.LNX.4.61.0610192220510.8142@yvahk01.tjqt.qr>
References: <4537818D.4060204@qumranet.com> <45378377.9080604@qumranet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+static int is_write_protection(void)
>+{
>+    return guest_cr0() & CR0_WP_MASK;
>+}
>+
>+static int is_cpuid_PSE36(void)
>+{
>+    return 1;
>+}
>+
>+static int is_present_pte(unsigned long pte)
>+{
>+    return pte & PT_PRESENT_MASK;
>+}
>+
>+static int is_writeble_pte(unsigned long pte)
>+{
>+    return pte & PT_WRITABLE_MASK;
>+}
>+
>+static int is_io_pte(unsigned long pte)
>+{
>+    return pte & PT_SHADOW_IO_MARK;
>+}

Unless the above will grow in size by later patches, or is taken address of,
mark them static inline.

>+static void nonpaging_new_cr3(struct kvm_vcpu *vcpu)
>+{
>+}

Remove it unless needed shortly afterwards.

>+static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, gva_t vaddr)
>+{
>+    return vaddr;
>+}

Candidate for inline too.

>+static void nonpaging_inval_page(struct kvm_vcpu *vcpu, gva_t addr)
>+{
>+}

Removal candidate

>+
>+static void paging_new_cr3(struct kvm_vcpu *vcpu)
>+{
>+    kvm_mmu_flush_tlb(vcpu);
>+}
>+
>+static void mark_pagetable_nonglobal(void *shadow_pte)
>+{
>+    page_header(__pa(shadow_pte))->global = 0;
>+}
>
>+static void paging_free(struct kvm_vcpu *vcpu)
>+{
>+    nonpaging_free(vcpu);
>+}

>+int kvm_mmu_reset_context(struct kvm_vcpu *vcpu)
>+{
>+    destroy_kvm_mmu(vcpu);
>+    return init_kvm_mmu(vcpu);
>+}

Inline candidate.

>Index: linux-2.6/drivers/kvm/paging_tmpl.h
>===================================================================
>+    #define PT_DIR_BASE_ADDR_MASK PT32_DIR_BASE_ADDR_MASK
>+    #define PT_INDEX(addr, level) PT32_INDEX(addr, level)
>+    #define SHADOW_PT_INDEX(addr, level) PT64_INDEX(addr, level)
>+    #define PT_LEVEL_MASK(level) PT32_LEVEL_MASK(level)
>+    #define PT_PTE_COPY_MASK PT32_PTE_COPY_MASK
>+    #define PT_NON_PTE_COPY_MASK PT32_NON_PTE_COPY_MASK
>+#else
>+    error
>+#endif

	#error Free Ad Space Here
it is.

>+static u64 *FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
>+                  struct guest_walker *walker)

I am not particularly thrilled about the FNAME() thing but I do not see a
better way ATM. Maybe someone else does.



	-`J'
-- 
