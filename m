Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758150AbWK0Mnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758150AbWK0Mnl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758151AbWK0Mnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:43:41 -0500
Received: from il.qumranet.com ([62.219.232.206]:43488 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758150AbWK0Mnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:43:40 -0500
Subject: [PATCH 33/38] KVM: Make is_long_mode() an arch operation
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:43:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127124338.D052925015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -275,6 +275,7 @@ struct kvm_arch_ops {
 			    struct kvm_segment *var, int seg);
 	void (*set_segment)(struct kvm_vcpu *vcpu,
 			    struct kvm_segment *var, int seg);
+	int (*is_long_mode)(struct kvm_vcpu *vcpu);
 	void (*get_cs_db_l_bits)(struct kvm_vcpu *vcpu, int *db, int *l);
 	void (*set_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
 	void (*set_cr0_no_modeswitch)(struct kvm_vcpu *vcpu,
@@ -411,11 +412,6 @@ static inline void vmcs_write32(unsigned
 	vmcs_writel(field, value);
 }
 
-static inline int is_long_mode(void)
-{
-	return vmcs_read32(VM_ENTRY_CONTROLS) & VM_ENTRY_CONTROLS_IA32E_MASK;
-}
-
 static inline int is_pae(struct kvm_vcpu *vcpu)
 {
 	return vcpu->cr4 & CR4_PAE_MASK;
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -441,7 +441,7 @@ void set_cr4(struct kvm_vcpu *vcpu, unsi
 		return;
 	}
 
-	if (is_long_mode()) {
+	if (kvm_arch_ops->is_long_mode(vcpu)) {
 		if (!(cr4 & CR4_PAE_MASK)) {
 			printk(KERN_DEBUG "set_cr4: #GP, clearing PAE while "
 			       "in long mode\n");
@@ -468,7 +468,7 @@ EXPORT_SYMBOL_GPL(set_cr4);
 
 void set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
-	if (is_long_mode()) {
+	if (kvm_arch_ops->is_long_mode(vcpu)) {
 		if ( cr3 & CR3_L_MODE_RESEVED_BITS) {
 			printk(KERN_DEBUG "set_cr3: #GP, reserved bits\n");
 			inject_gp(vcpu);
Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -589,7 +589,7 @@ static int init_kvm_mmu(struct kvm_vcpu 
 
 	if (!is_paging(vcpu))
 		return nonpaging_init_context(vcpu);
-	else if (is_long_mode())
+	else if (kvm_arch_ops->is_long_mode(vcpu))
 		return paging64_init_context(vcpu);
 	else if (is_pae(vcpu))
 		return paging32E_init_context(vcpu);
Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -70,7 +70,7 @@ static void FNAME(init_walker)(struct gu
 	hpa = safe_gpa_to_hpa(vcpu, vcpu->cr3 & PT64_BASE_ADDR_MASK);
 	walker->table = kmap_atomic(pfn_to_page(hpa >> PAGE_SHIFT), KM_USER0);
 
-	ASSERT((!is_long_mode() && is_pae(vcpu)) ||
+	ASSERT((!kvm_arch_ops->is_long_mode(vcpu) && is_pae(vcpu)) ||
 	       (vcpu->cr3 & ~(PAGE_MASK | CR3_FLAGS_MASK)) == 0);
 
 	walker->table = (pt_element_t *)( (unsigned long)walker->table |
@@ -135,7 +135,7 @@ static pt_element_t *FNAME(fetch_guest)(
 		     (walker->table[index] & PT_PAGE_SIZE_MASK) &&
 		     (PTTYPE == 64 || is_pse(vcpu))))
 			return &walker->table[index];
-		if (walker->level != 3 || is_long_mode())
+		if (walker->level != 3 || kvm_arch_ops->is_long_mode(vcpu))
 			walker->inherited_ar &= walker->table[index];
 		paddr = safe_gpa_to_hpa(vcpu, walker->table[index] & PT_BASE_ADDR_MASK);
 		kunmap_atomic(walker->table, KM_USER0);
@@ -204,7 +204,7 @@ static u64 *FNAME(fetch)(struct kvm_vcpu
 		shadow_addr = kvm_mmu_alloc_page(vcpu, shadow_ent);
 		if (!VALID_PAGE(shadow_addr))
 			return ERR_PTR(-ENOMEM);
-		if (!is_long_mode() && level == 3)
+		if (!kvm_arch_ops->is_long_mode(vcpu) && level == 3)
 			*shadow_ent = shadow_addr |
 				(*guest_ent & (PT_PRESENT_MASK | PT_PWT_MASK | PT_PCD_MASK));
 		else {
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -811,6 +811,11 @@ static void vmx_set_segment(struct kvm_v
 	vmcs_write32(sf->ar_bytes, ar);
 }
 
+static int vmx_is_long_mode(struct kvm_vcpu *vcpu)
+{
+	return vmcs_read32(VM_ENTRY_CONTROLS) & VM_ENTRY_CONTROLS_IA32E_MASK;
+}
+
 static void vmx_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l)
 {
 	u32 ar = vmcs_read32(GUEST_CS_AR_BYTES);
@@ -1884,6 +1889,7 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.get_segment_base = vmx_get_segment_base,
 	.get_segment = vmx_get_segment,
 	.set_segment = vmx_set_segment,
+	.is_long_mode = vmx_is_long_mode,
 	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
 	.set_cr0 = vmx_set_cr0,
 	.set_cr0_no_modeswitch = vmx_set_cr0_no_modeswitch,
