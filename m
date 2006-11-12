Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932924AbWKLOzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932924AbWKLOzt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 09:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932923AbWKLOzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 09:55:49 -0500
Received: from il.qumranet.com ([62.219.232.206]:49041 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S932921AbWKLOzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 09:55:48 -0500
Subject: [PATCH] KVM: Segment access cleanup
From: Avi Kivity <avi@qumranet.com>
Date: Sun, 12 Nov 2006 14:55:44 -0000
To: kvm-devel@lists.sourceforge.net
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-Id: <20061112145545.2497FA0001@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using pasting macros, put the vmx segment field indices into
an array and use the array to access the fields indirectly. Cleaner code
as well as ~200 bytes saved.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -195,10 +195,10 @@ struct kvm_vcpu {
 	unsigned char mmio_data[8];
 	gpa_t mmio_phys_addr;
 
-	struct{
+	struct {
 		int active;
 		u8 save_iopl;
-		struct {
+		struct kvm_save_segment {
 			u16 selector;
 			unsigned long base;
 			u32 limit;
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -62,6 +62,41 @@ static struct kvm_stats_debugfs_item {
 
 static struct dentry *debugfs_dir;
 
+enum {
+	VCPU_SREG_CS,
+	VCPU_SREG_DS,
+	VCPU_SREG_ES,
+	VCPU_SREG_FS,
+	VCPU_SREG_GS,
+	VCPU_SREG_SS,
+	VCPU_SREG_TR,
+	VCPU_SREG_LDTR,
+};
+
+#define VMX_SEGMENT_FIELD(seg)					\
+	[VCPU_SREG_##seg] {                                     \
+		GUEST_##seg##_SELECTOR,				\
+		GUEST_##seg##_BASE,			   	\
+		GUEST_##seg##_LIMIT,			   	\
+		GUEST_##seg##_AR_BYTES,			   	\
+	}
+
+static struct kvm_vmx_segment_field {
+	unsigned selector;
+	unsigned base;
+	unsigned limit;
+	unsigned ar_bytes;
+} kvm_vmx_segment_fields[] = {
+	VMX_SEGMENT_FIELD(CS),
+	VMX_SEGMENT_FIELD(DS),
+	VMX_SEGMENT_FIELD(ES),
+	VMX_SEGMENT_FIELD(FS),
+	VMX_SEGMENT_FIELD(GS),
+	VMX_SEGMENT_FIELD(SS),
+	VMX_SEGMENT_FIELD(TR),
+	VMX_SEGMENT_FIELD(LDTR),
+};
+
 static const u32 vmx_msr_index[] = {
 #ifdef __x86_64__
 	MSR_SYSCALL_MASK, MSR_LSTAR, MSR_CSTAR, MSR_KERNEL_GS_BASE,
@@ -689,6 +724,22 @@ static void update_exception_bitmap(stru
 		vmcs_write32(EXCEPTION_BITMAP, 1 << PF_VECTOR);
 }
 
+static void fix_pmode_dataseg(int seg, struct kvm_save_segment *save)
+{
+	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
+
+	if (vmcs_readl(sf->base) == save->base) {
+		vmcs_write16(sf->selector, save->selector);
+		vmcs_writel(sf->base, save->base);
+		vmcs_write32(sf->limit, save->limit);
+		vmcs_write32(sf->ar_bytes, save->ar);
+	} else {
+		u32 dpl = (vmcs_read16(sf->selector) & SELECTOR_RPL_MASK)
+			<< AR_DPL_SHIFT;
+		vmcs_write32(sf->ar_bytes, 0x93 | dpl);
+	}
+}
+
 static void enter_pmode(struct kvm_vcpu *vcpu)
 {
 	unsigned long flags;
@@ -709,24 +760,10 @@ static void enter_pmode(struct kvm_vcpu 
 
 	update_exception_bitmap(vcpu);
 
-	#define FIX_PMODE_DATASEG(seg, save) {				\
-		if (vmcs_readl(GUEST_##seg##_BASE) == save.base) { \
-			vmcs_write16(GUEST_##seg##_SELECTOR, save.selector); \
-			vmcs_writel(GUEST_##seg##_BASE, save.base); \
-			vmcs_write32(GUEST_##seg##_LIMIT, save.limit); \
-			vmcs_write32(GUEST_##seg##_AR_BYTES, save.ar); \
-		} else { \
-			u32 dpl = (vmcs_read16(GUEST_##seg##_SELECTOR) & \
-				   SELECTOR_RPL_MASK) << AR_DPL_SHIFT; \
-			vmcs_write32(GUEST_##seg##_AR_BYTES, 0x93 | dpl); \
-		} \
-	}
-
-	FIX_PMODE_DATASEG(ES, vcpu->rmode.es);
-	FIX_PMODE_DATASEG(DS, vcpu->rmode.ds);
-	FIX_PMODE_DATASEG(GS, vcpu->rmode.gs);
-	FIX_PMODE_DATASEG(FS, vcpu->rmode.fs);
-
+	fix_pmode_dataseg(VCPU_SREG_ES, &vcpu->rmode.es);
+	fix_pmode_dataseg(VCPU_SREG_DS, &vcpu->rmode.ds);
+	fix_pmode_dataseg(VCPU_SREG_GS, &vcpu->rmode.gs);
+	fix_pmode_dataseg(VCPU_SREG_FS, &vcpu->rmode.fs);
 
 	vmcs_write16(GUEST_SS_SELECTOR, 0);
 	vmcs_write32(GUEST_SS_AR_BYTES, 0x93);
@@ -742,6 +779,19 @@ static int rmode_tss_base(struct kvm* kv
 	return base_gfn << PAGE_SHIFT;
 }
 
+static void fix_rmode_seg(int seg, struct kvm_save_segment *save)
+{
+	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
+
+	save->selector = vmcs_read16(sf->selector);
+	save->base = vmcs_readl(sf->base);
+	save->limit = vmcs_read32(sf->limit);
+	save->ar = vmcs_read32(sf->ar_bytes);
+	vmcs_write16(sf->selector, vmcs_readl(sf->base) >> 4);
+	vmcs_write32(sf->limit, 0xffff);
+	vmcs_write32(sf->ar_bytes, 0xf3);
+}
+
 static void enter_rmode(struct kvm_vcpu *vcpu)
 {
 	unsigned long flags;
@@ -766,17 +816,6 @@ static void enter_rmode(struct kvm_vcpu 
 	vmcs_writel(GUEST_CR4, vmcs_readl(GUEST_CR4) | CR4_VME_MASK);
 	update_exception_bitmap(vcpu);
 
-	#define FIX_RMODE_SEG(seg, save) { \
-		save.selector = vmcs_read16(GUEST_##seg##_SELECTOR); \
-		save.base = vmcs_readl(GUEST_##seg##_BASE); \
-		save.limit = vmcs_read32(GUEST_##seg##_LIMIT); \
-		save.ar = vmcs_read32(GUEST_##seg##_AR_BYTES); \
-		vmcs_write16(GUEST_##seg##_SELECTOR, 			   \
-					vmcs_readl(GUEST_##seg##_BASE) >> 4); \
-		vmcs_write32(GUEST_##seg##_LIMIT, 0xffff);		   \
-		vmcs_write32(GUEST_##seg##_AR_BYTES, 0xf3);		   \
-	}
-
 	vmcs_write16(GUEST_SS_SELECTOR, vmcs_readl(GUEST_SS_BASE) >> 4);
 	vmcs_write32(GUEST_SS_LIMIT, 0xffff);
 	vmcs_write32(GUEST_SS_AR_BYTES, 0xf3);
@@ -784,10 +823,10 @@ static void enter_rmode(struct kvm_vcpu 
 	vmcs_write32(GUEST_CS_AR_BYTES, 0xf3);
 	vmcs_write16(GUEST_CS_SELECTOR, vmcs_readl(GUEST_CS_BASE) >> 4);
 
-	FIX_RMODE_SEG(ES, vcpu->rmode.es);
-	FIX_RMODE_SEG(DS, vcpu->rmode.ds);
-	FIX_RMODE_SEG(GS, vcpu->rmode.gs);
-	FIX_RMODE_SEG(FS, vcpu->rmode.fs);
+	fix_rmode_seg(VCPU_SREG_ES, &vcpu->rmode.es);
+	fix_rmode_seg(VCPU_SREG_DS, &vcpu->rmode.ds);
+	fix_rmode_seg(VCPU_SREG_GS, &vcpu->rmode.gs);
+	fix_rmode_seg(VCPU_SREG_FS, &vcpu->rmode.fs);
 }
 
 static int init_rmode_tss(struct kvm* kvm)
@@ -1116,6 +1155,16 @@ static void vmcs_write32_fixedbits(u32 m
 	vmcs_write32(vmcs_field, val);
 }
 
+static void seg_setup(int seg)
+{
+	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
+
+	vmcs_write16(sf->selector, 0);
+	vmcs_writel(sf->base, 0);
+	vmcs_write32(sf->limit, 0xffff);
+	vmcs_write32(sf->ar_bytes, 0x93);
+}
+
 /*
  * Sets up the vmcs for emulated real mode.
  */
@@ -1146,13 +1195,6 @@ static int kvm_vcpu_setup(struct kvm_vcp
 
 	fx_init(vcpu);
 
-#define SEG_SETUP(seg) do {					\
-		vmcs_write16(GUEST_##seg##_SELECTOR, 0);	\
-		vmcs_writel(GUEST_##seg##_BASE, 0);		\
-		vmcs_write32(GUEST_##seg##_LIMIT, 0xffff);	\
-		vmcs_write32(GUEST_##seg##_AR_BYTES, 0x93); 	\
-	} while (0)
-
 	/*
 	 * GUEST_CS_BASE should really be 0xffff0000, but VT vm86 mode
 	 * insists on having GUEST_CS_BASE == GUEST_CS_SELECTOR << 4.  Sigh.
@@ -1162,11 +1204,11 @@ static int kvm_vcpu_setup(struct kvm_vcp
 	vmcs_write32(GUEST_CS_LIMIT, 0xffff);
 	vmcs_write32(GUEST_CS_AR_BYTES, 0x9b);
 
-	SEG_SETUP(DS);
-	SEG_SETUP(ES);
-	SEG_SETUP(FS);
-	SEG_SETUP(GS);
-	SEG_SETUP(SS);
+	seg_setup(VCPU_SREG_DS);
+	seg_setup(VCPU_SREG_ES);
+	seg_setup(VCPU_SREG_FS);
+	seg_setup(VCPU_SREG_GS);
+	seg_setup(VCPU_SREG_SS);
 
 	vmcs_write16(GUEST_TR_SELECTOR, 0);
 	vmcs_writel(GUEST_TR_BASE, 0);
@@ -2900,6 +2942,28 @@ static int kvm_dev_ioctl_set_regs(struct
 	return 0;
 }
 
+static void get_segment(struct kvm_segment *var, int seg)
+{
+	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
+	u32 ar;
+
+	var->base = vmcs_readl(sf->base);
+	var->limit = vmcs_read32(sf->limit);
+	var->selector = vmcs_read16(sf->selector);
+	ar = vmcs_read32(sf->ar_bytes);
+	if (ar & AR_UNUSABLE_MASK)
+		ar = 0;
+	var->type = ar & 15;
+	var->s = (ar >> 4) & 1;
+	var->dpl = (ar >> 5) & 3;
+	var->present = (ar >> 7) & 1;
+	var->avl = (ar >> 12) & 1;
+	var->l = (ar >> 13) & 1;
+	var->db = (ar >> 14) & 1;
+	var->g = (ar >> 15) & 1;
+	var->unusable = (ar >> 16) & 1;
+}
+
 static int kvm_dev_ioctl_get_sregs(struct kvm *kvm, struct kvm_sregs *sregs)
 {
 	struct kvm_vcpu *vcpu;
@@ -2910,36 +2974,15 @@ static int kvm_dev_ioctl_get_sregs(struc
 	if (!vcpu)
 		return -ENOENT;
 
-#define get_segment(var, seg) \
-	do { \
-		u32 ar; \
-		\
-		sregs->var.base = vmcs_readl(GUEST_##seg##_BASE); \
-		sregs->var.limit = vmcs_read32(GUEST_##seg##_LIMIT); \
-		sregs->var.selector = vmcs_read16(GUEST_##seg##_SELECTOR); \
-		ar = vmcs_read32(GUEST_##seg##_AR_BYTES); \
-		if (ar & AR_UNUSABLE_MASK) ar = 0; \
-		sregs->var.type = ar & 15; \
-		sregs->var.s = (ar >> 4) & 1; \
-		sregs->var.dpl = (ar >> 5) & 3; \
-		sregs->var.present = (ar >> 7) & 1; \
-		sregs->var.avl = (ar >> 12) & 1; \
-		sregs->var.l = (ar >> 13) & 1; \
-		sregs->var.db = (ar >> 14) & 1; \
-		sregs->var.g = (ar >> 15) & 1; \
-		sregs->var.unusable = (ar >> 16) & 1; \
-	} while (0);
-
-	get_segment(cs, CS);
-	get_segment(ds, DS);
-	get_segment(es, ES);
-	get_segment(fs, FS);
-	get_segment(gs, GS);
-	get_segment(ss, SS);
-
-	get_segment(tr, TR);
-	get_segment(ldt, LDTR);
-#undef get_segment
+	get_segment(&sregs->cs, VCPU_SREG_CS);
+	get_segment(&sregs->ds, VCPU_SREG_DS);
+	get_segment(&sregs->es, VCPU_SREG_ES);
+	get_segment(&sregs->fs, VCPU_SREG_FS);
+	get_segment(&sregs->gs, VCPU_SREG_GS);
+	get_segment(&sregs->ss, VCPU_SREG_SS);
+
+	get_segment(&sregs->tr, VCPU_SREG_TR);
+	get_segment(&sregs->ldt, VCPU_SREG_LDTR);
 
 #define get_dtable(var, table) \
 	sregs->var.limit = vmcs_read32(GUEST_##table##_LIMIT), \
@@ -2964,6 +3007,29 @@ static int kvm_dev_ioctl_get_sregs(struc
 	return 0;
 }
 
+static void set_segment(struct kvm_segment *var, int seg)
+{
+	struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
+	u32 ar;
+
+	vmcs_writel(sf->base, var->base);
+	vmcs_write32(sf->limit, var->limit);
+	vmcs_write16(sf->selector, var->selector);
+	if (var->unusable)
+		ar = 1 << 16;
+	else {
+		ar = var->type & 15;
+		ar |= (var->s & 1) << 4;
+		ar |= (var->dpl & 3) << 5;
+		ar |= (var->present & 1) << 7;
+		ar |= (var->avl & 1) << 12;
+		ar |= (var->l & 1) << 13;
+		ar |= (var->db & 1) << 14;
+		ar |= (var->g & 1) << 15;
+	}
+	vmcs_write32(sf->ar_bytes, ar);
+}
+
 static int kvm_dev_ioctl_set_sregs(struct kvm *kvm, struct kvm_sregs *sregs)
 {
 	struct kvm_vcpu *vcpu;
@@ -2975,39 +3041,15 @@ static int kvm_dev_ioctl_set_sregs(struc
 	if (!vcpu)
 		return -ENOENT;
 
-#define set_segment(var, seg) \
-	do { \
-		u32 ar; \
-		\
-		vmcs_writel(GUEST_##seg##_BASE, sregs->var.base);  \
-		vmcs_write32(GUEST_##seg##_LIMIT, sregs->var.limit); \
-		vmcs_write16(GUEST_##seg##_SELECTOR, sregs->var.selector); \
-		if (sregs->var.unusable) { \
-			ar = (1 << 16); \
-		} else { \
-			ar = (sregs->var.type & 15); \
-			ar |= (sregs->var.s & 1) << 4; \
-			ar |= (sregs->var.dpl & 3) << 5; \
-			ar |= (sregs->var.present & 1) << 7; \
-			ar |= (sregs->var.avl & 1) << 12; \
-			ar |= (sregs->var.l & 1) << 13; \
-			ar |= (sregs->var.db & 1) << 14; \
-			ar |= (sregs->var.g & 1) << 15; \
-		} \
-		vmcs_write32(GUEST_##seg##_AR_BYTES, ar); \
-	} while (0);
-
-	set_segment(cs, CS);
-	set_segment(ds, DS);
-	set_segment(es, ES);
-	set_segment(fs, FS);
-	set_segment(gs, GS);
-	set_segment(ss, SS);
-
-	set_segment(tr, TR);
+	set_segment(&sregs->cs, VCPU_SREG_CS);
+	set_segment(&sregs->ds, VCPU_SREG_DS);
+	set_segment(&sregs->es, VCPU_SREG_ES);
+	set_segment(&sregs->fs, VCPU_SREG_FS);
+	set_segment(&sregs->gs, VCPU_SREG_GS);
+	set_segment(&sregs->ss, VCPU_SREG_SS);
 
-	set_segment(ldt, LDTR);
-#undef set_segment
+	set_segment(&sregs->tr, VCPU_SREG_TR);
+	set_segment(&sregs->ldt, VCPU_SREG_LDTR);
 
 #define set_dtable(var, table) \
 	vmcs_write32(GUEST_##table##_LIMIT, sregs->var.limit), \
