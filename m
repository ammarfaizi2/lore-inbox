Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWEIU6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWEIU6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWEIU5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:57:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13533 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750771AbWEIU5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:57:13 -0400
From: dzickus <dzickus@redhat.com>
Message-Id: <20060509205956.815279000@drseuss.boston.redhat.com>
References: <20060509205035.446349000@drseuss.boston.redhat.com>
User-Agent: quilt/0.45-1
Date: Tue, 09 May 2006 16:50:38 -0400
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, oprofile-list@lists.sourceforge.net, dzickus@redhat.com
Subject: [patch 3/8] Utilize performance counter reservation framework in oprofile
Content-Disposition: inline; filename=nmi-x86-oprofile-reservation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Incorporates the new performance counter reservation system in oprofile.
Also cleans up a lot of the initialization code.  The code original zero'd
out every register associated with performance counters regardless if those
registers were used or not.  This causes issues with the nmi watchdog. 

Signed-off-by:  Don Zickus <dzickus@redhat.com


Index: linux-don/arch/i386/oprofile/nmi_int.c
===================================================================
--- linux-don.orig/arch/i386/oprofile/nmi_int.c
+++ linux-don/arch/i386/oprofile/nmi_int.c
@@ -97,15 +97,19 @@ static void nmi_cpu_save_registers(struc
 	unsigned int i;
 
 	for (i = 0; i < nr_ctrs; ++i) {
-		rdmsr(counters[i].addr,
-			counters[i].saved.low,
-			counters[i].saved.high);
+		if (counters[i].addr){
+			rdmsr(counters[i].addr,
+				counters[i].saved.low,
+				counters[i].saved.high);
+		}
 	}
  
 	for (i = 0; i < nr_ctrls; ++i) {
-		rdmsr(controls[i].addr,
-			controls[i].saved.low,
-			controls[i].saved.high);
+		if (controls[i].addr){
+			rdmsr(controls[i].addr,
+				controls[i].saved.low,
+				controls[i].saved.high);
+		}
 	}
 }
 
@@ -204,15 +208,19 @@ static void nmi_restore_registers(struct
 	unsigned int i;
 
 	for (i = 0; i < nr_ctrls; ++i) {
-		wrmsr(controls[i].addr,
-			controls[i].saved.low,
-			controls[i].saved.high);
+		if (controls[i].addr){
+			wrmsr(controls[i].addr,
+				controls[i].saved.low,
+				controls[i].saved.high);
+		}
 	}
  
 	for (i = 0; i < nr_ctrs; ++i) {
-		wrmsr(counters[i].addr,
-			counters[i].saved.low,
-			counters[i].saved.high);
+		if (counters[i].addr){
+			wrmsr(counters[i].addr,
+				counters[i].saved.low,
+				counters[i].saved.high);
+		}
 	}
 }
  
@@ -233,6 +241,7 @@ static void nmi_cpu_shutdown(void * dumm
 	apic_write(APIC_LVTPC, saved_lvtpc[cpu]);
 	apic_write(APIC_LVTERR, v);
 	nmi_restore_registers(msrs);
+	model->shutdown(msrs);
 }
 
  
@@ -283,6 +292,14 @@ static int nmi_create_files(struct super
 		struct dentry * dir;
 		char buf[2];
  
+ 		/* quick little hack to _not_ expose a counter if it is not
+		 * available for use.  This should protect userspace app.
+		 * NOTE:  assumes 1:1 mapping here (that counters are organized
+		 *        sequentially in their struct assignment).
+		 */
+		if (unlikely(!avail_to_resrv_perfctr_nmi_bit(i)))
+			continue;
+
 		snprintf(buf, 2, "%d", i);
 		dir = oprofilefs_mkdir(sb, root, buf);
 		oprofilefs_create_ulong(sb, dir, "enabled", &counter_config[i].enabled); 
Index: linux-don/arch/i386/oprofile/op_model_athlon.c
===================================================================
--- linux-don.orig/arch/i386/oprofile/op_model_athlon.c
+++ linux-don/arch/i386/oprofile/op_model_athlon.c
@@ -21,10 +21,12 @@
 #define NUM_COUNTERS 4
 #define NUM_CONTROLS 4
 
+#define CTR_IS_RESERVED(msrs,c) (msrs->counters[(c)].addr ? 1 : 0)
 #define CTR_READ(l,h,msrs,c) do {rdmsr(msrs->counters[(c)].addr, (l), (h));} while (0)
 #define CTR_WRITE(l,msrs,c) do {wrmsr(msrs->counters[(c)].addr, -(unsigned int)(l), -1);} while (0)
 #define CTR_OVERFLOWED(n) (!((n) & (1U<<31)))
 
+#define CTRL_IS_RESERVED(msrs,c) (msrs->controls[(c)].addr ? 1 : 0)
 #define CTRL_READ(l,h,msrs,c) do {rdmsr(msrs->controls[(c)].addr, (l), (h));} while (0)
 #define CTRL_WRITE(l,h,msrs,c) do {wrmsr(msrs->controls[(c)].addr, (l), (h));} while (0)
 #define CTRL_SET_ACTIVE(n) (n |= (1<<22))
@@ -40,15 +42,21 @@ static unsigned long reset_value[NUM_COU
  
 static void athlon_fill_in_addresses(struct op_msrs * const msrs)
 {
-	msrs->counters[0].addr = MSR_K7_PERFCTR0;
-	msrs->counters[1].addr = MSR_K7_PERFCTR1;
-	msrs->counters[2].addr = MSR_K7_PERFCTR2;
-	msrs->counters[3].addr = MSR_K7_PERFCTR3;
-
-	msrs->controls[0].addr = MSR_K7_EVNTSEL0;
-	msrs->controls[1].addr = MSR_K7_EVNTSEL1;
-	msrs->controls[2].addr = MSR_K7_EVNTSEL2;
-	msrs->controls[3].addr = MSR_K7_EVNTSEL3;
+	int i;
+
+	for (i=0; i < NUM_COUNTERS; i++) {
+		if (reserve_perfctr_nmi(MSR_K7_PERFCTR0 + i))
+			msrs->counters[i].addr = MSR_K7_PERFCTR0 + i;
+		else
+			msrs->counters[i].addr = 0;
+	}
+
+	for (i=0; i < NUM_CONTROLS; i++) {
+		if (reserve_evntsel_nmi(MSR_K7_EVNTSEL0 + i))
+			msrs->controls[i].addr = MSR_K7_EVNTSEL0 + i;
+		else
+			msrs->controls[i].addr = 0;
+	}
 }
 
  
@@ -59,19 +67,23 @@ static void athlon_setup_ctrs(struct op_
  
 	/* clear all counters */
 	for (i = 0 ; i < NUM_CONTROLS; ++i) {
+		if (unlikely(!CTRL_IS_RESERVED(msrs,i)))
+			continue;
 		CTRL_READ(low, high, msrs, i);
 		CTRL_CLEAR(low);
 		CTRL_WRITE(low, high, msrs, i);
 	}
-	
+
 	/* avoid a false detection of ctr overflows in NMI handler */
 	for (i = 0; i < NUM_COUNTERS; ++i) {
+		if (unlikely(!CTR_IS_RESERVED(msrs,i)))
+			continue;
 		CTR_WRITE(1, msrs, i);
 	}
 
 	/* enable active counters */
 	for (i = 0; i < NUM_COUNTERS; ++i) {
-		if (counter_config[i].enabled) {
+		if ((counter_config[i].enabled) && (CTR_IS_RESERVED(msrs,i))) {
 			reset_value[i] = counter_config[i].count;
 
 			CTR_WRITE(counter_config[i].count, msrs, i);
@@ -98,6 +110,8 @@ static int athlon_check_ctrs(struct pt_r
 	int i;
 
 	for (i = 0 ; i < NUM_COUNTERS; ++i) {
+		if (!reset_value[i])
+			continue;
 		CTR_READ(low, high, msrs, i);
 		if (CTR_OVERFLOWED(low)) {
 			oprofile_add_sample(regs, i);
@@ -132,12 +146,27 @@ static void athlon_stop(struct op_msrs c
 	/* Subtle: stop on all counters to avoid race with
 	 * setting our pm callback */
 	for (i = 0 ; i < NUM_COUNTERS ; ++i) {
+		if (!reset_value[i])
+			continue;
 		CTRL_READ(low, high, msrs, i);
 		CTRL_SET_INACTIVE(low);
 		CTRL_WRITE(low, high, msrs, i);
 	}
 }
 
+static void athlon_shutdown(struct op_msrs const * const msrs)
+{
+	int i;
+
+	for (i = 0 ; i < NUM_COUNTERS ; ++i) {
+		if (CTR_IS_RESERVED(msrs,i))
+			release_perfctr_nmi(MSR_K7_PERFCTR0 + i);
+	}
+	for (i = 0 ; i < NUM_CONTROLS ; ++i) {
+		if (CTRL_IS_RESERVED(msrs,i))
+			release_evntsel_nmi(MSR_K7_EVNTSEL0 + i);
+	}
+}
 
 struct op_x86_model_spec const op_athlon_spec = {
 	.num_counters = NUM_COUNTERS,
@@ -146,5 +175,6 @@ struct op_x86_model_spec const op_athlon
 	.setup_ctrs = &athlon_setup_ctrs,
 	.check_ctrs = &athlon_check_ctrs,
 	.start = &athlon_start,
-	.stop = &athlon_stop
+	.stop = &athlon_stop,
+	.shutdown = &athlon_shutdown
 };
Index: linux-don/arch/i386/oprofile/op_model_p4.c
===================================================================
--- linux-don.orig/arch/i386/oprofile/op_model_p4.c
+++ linux-don/arch/i386/oprofile/op_model_p4.c
@@ -32,7 +32,7 @@
 #define NUM_CONTROLS_HT2 (NUM_ESCRS_HT2 + NUM_CCCRS_HT2)
 
 static unsigned int num_counters = NUM_COUNTERS_NON_HT;
-
+static unsigned int num_controls = NUM_CONTROLS_NON_HT;
 
 /* this has to be checked dynamically since the
    hyper-threadedness of a chip is discovered at
@@ -40,8 +40,10 @@ static unsigned int num_counters = NUM_C
 static inline void setup_num_counters(void)
 {
 #ifdef CONFIG_SMP
-	if (smp_num_siblings == 2)
+	if (smp_num_siblings == 2){
 		num_counters = NUM_COUNTERS_HT2;
+		num_controls = NUM_CONTROLS_HT2;
+	}
 #endif
 }
 
@@ -97,15 +99,6 @@ static struct p4_counter_binding p4_coun
 
 #define NUM_UNUSED_CCCRS	NUM_CCCRS_NON_HT - NUM_COUNTERS_NON_HT
 
-/* All cccr we don't use. */
-static int p4_unused_cccr[NUM_UNUSED_CCCRS] = {
-	MSR_P4_BPU_CCCR1,	MSR_P4_BPU_CCCR3,
-	MSR_P4_MS_CCCR1,	MSR_P4_MS_CCCR3,
-	MSR_P4_FLAME_CCCR1,	MSR_P4_FLAME_CCCR3,
-	MSR_P4_IQ_CCCR0,	MSR_P4_IQ_CCCR1,
-	MSR_P4_IQ_CCCR2,	MSR_P4_IQ_CCCR3
-};
-
 /* p4 event codes in libop/op_event.h are indices into this table. */
 
 static struct p4_event_binding p4_events[NUM_EVENTS] = {
@@ -372,6 +365,8 @@ static struct p4_event_binding p4_events
 #define CCCR_OVF_P(cccr) ((cccr) & (1U<<31))
 #define CCCR_CLEAR_OVF(cccr) ((cccr) &= (~(1U<<31)))
 
+#define CTRL_IS_RESERVED(msrs,c) (msrs->controls[(c)].addr ? 1 : 0)
+#define CTR_IS_RESERVED(msrs,c) (msrs->counters[(c)].addr ? 1 : 0)
 #define CTR_READ(l,h,i) do {rdmsr(p4_counters[(i)].counter_address, (l), (h));} while (0)
 #define CTR_WRITE(l,i) do {wrmsr(p4_counters[(i)].counter_address, -(u32)(l), -1);} while (0)
 #define CTR_OVERFLOW_P(ctr) (!((ctr) & 0x80000000))
@@ -401,29 +396,34 @@ static unsigned long reset_value[NUM_COU
 static void p4_fill_in_addresses(struct op_msrs * const msrs)
 {
 	unsigned int i; 
-	unsigned int addr, stag;
+	unsigned int addr, cccraddr, stag;
 
 	setup_num_counters();
 	stag = get_stagger();
 
-	/* the counter registers we pay attention to */
+	/* initialize some registers */
 	for (i = 0; i < num_counters; ++i) {
-		msrs->counters[i].addr = 
-			p4_counters[VIRT_CTR(stag, i)].counter_address;
+		msrs->counters[i].addr = 0;
 	}
-
-	/* FIXME: bad feeling, we don't save the 10 counters we don't use. */
-
-	/* 18 CCCR registers */
-	for (i = 0, addr = MSR_P4_BPU_CCCR0 + stag;
-	     addr <= MSR_P4_IQ_CCCR5; ++i, addr += addr_increment()) {
-		msrs->controls[i].addr = addr;
+	for (i = 0; i < num_controls; ++i) {
+		msrs->controls[i].addr = 0;
 	}
 	
+	/* the counter & cccr registers we pay attention to */
+	for (i = 0; i < num_counters; ++i) {
+		addr = p4_counters[VIRT_CTR(stag, i)].counter_address;
+		cccraddr = p4_counters[VIRT_CTR(stag, i)].cccr_address;
+		if (reserve_perfctr_nmi(addr)){
+			msrs->counters[i].addr = addr;
+			msrs->controls[i].addr = cccraddr;
+		}
+	}
+
 	/* 43 ESCR registers in three or four discontiguous group */
 	for (addr = MSR_P4_BSU_ESCR0 + stag;
 	     addr < MSR_P4_IQ_ESCR0; ++i, addr += addr_increment()) {
-		msrs->controls[i].addr = addr;
+		if (reserve_evntsel_nmi(addr))
+			msrs->controls[i].addr = addr;
 	}
 
 	/* no IQ_ESCR0/1 on some models, we save a seconde time BSU_ESCR0/1
@@ -431,47 +431,57 @@ static void p4_fill_in_addresses(struct 
 	if (boot_cpu_data.x86_model >= 0x3) {
 		for (addr = MSR_P4_BSU_ESCR0 + stag;
 		     addr <= MSR_P4_BSU_ESCR1; ++i, addr += addr_increment()) {
-			msrs->controls[i].addr = addr;
+			if (reserve_evntsel_nmi(addr))
+				msrs->controls[i].addr = addr;
 		}
 	} else {
 		for (addr = MSR_P4_IQ_ESCR0 + stag;
 		     addr <= MSR_P4_IQ_ESCR1; ++i, addr += addr_increment()) {
-			msrs->controls[i].addr = addr;
+			if (reserve_evntsel_nmi(addr))
+				msrs->controls[i].addr = addr;
 		}
 	}
 
 	for (addr = MSR_P4_RAT_ESCR0 + stag;
 	     addr <= MSR_P4_SSU_ESCR0; ++i, addr += addr_increment()) {
-		msrs->controls[i].addr = addr;
+		if (reserve_evntsel_nmi(addr))
+			msrs->controls[i].addr = addr;
 	}
 	
 	for (addr = MSR_P4_MS_ESCR0 + stag;
 	     addr <= MSR_P4_TC_ESCR1; ++i, addr += addr_increment()) { 
-		msrs->controls[i].addr = addr;
+		if (reserve_evntsel_nmi(addr))
+			msrs->controls[i].addr = addr;
 	}
 	
 	for (addr = MSR_P4_IX_ESCR0 + stag;
 	     addr <= MSR_P4_CRU_ESCR3; ++i, addr += addr_increment()) { 
-		msrs->controls[i].addr = addr;
+		if (reserve_evntsel_nmi(addr))
+			msrs->controls[i].addr = addr;
 	}
 
 	/* there are 2 remaining non-contiguously located ESCRs */
 
 	if (num_counters == NUM_COUNTERS_NON_HT) {		
 		/* standard non-HT CPUs handle both remaining ESCRs*/
-		msrs->controls[i++].addr = MSR_P4_CRU_ESCR5;
-		msrs->controls[i++].addr = MSR_P4_CRU_ESCR4;
+		if (reserve_evntsel_nmi(MSR_P4_CRU_ESCR5))
+			msrs->controls[i++].addr = MSR_P4_CRU_ESCR5;
+		if (reserve_evntsel_nmi(MSR_P4_CRU_ESCR4))
+			msrs->controls[i++].addr = MSR_P4_CRU_ESCR4;
 
 	} else if (stag == 0) {
 		/* HT CPUs give the first remainder to the even thread, as
 		   the 32nd control register */
-		msrs->controls[i++].addr = MSR_P4_CRU_ESCR4;
+		if (reserve_evntsel_nmi(MSR_P4_CRU_ESCR4))
+			msrs->controls[i++].addr = MSR_P4_CRU_ESCR4;
 
 	} else {
 		/* and two copies of the second to the odd thread,
 		   for the 22st and 23nd control registers */
-		msrs->controls[i++].addr = MSR_P4_CRU_ESCR5;
-		msrs->controls[i++].addr = MSR_P4_CRU_ESCR5;
+		if (reserve_evntsel_nmi(MSR_P4_CRU_ESCR5)) {
+			msrs->controls[i++].addr = MSR_P4_CRU_ESCR5;
+			msrs->controls[i++].addr = MSR_P4_CRU_ESCR5;
+		}
 	}
 }
 
@@ -544,7 +554,6 @@ static void p4_setup_ctrs(struct op_msrs
 {
 	unsigned int i;
 	unsigned int low, high;
-	unsigned int addr;
 	unsigned int stag;
 
 	stag = get_stagger();
@@ -557,59 +566,24 @@ static void p4_setup_ctrs(struct op_msrs
 
 	/* clear the cccrs we will use */
 	for (i = 0 ; i < num_counters ; i++) {
+		if (unlikely(!CTRL_IS_RESERVED(msrs,i)))
+			continue;
 		rdmsr(p4_counters[VIRT_CTR(stag, i)].cccr_address, low, high);
 		CCCR_CLEAR(low);
 		CCCR_SET_REQUIRED_BITS(low);
 		wrmsr(p4_counters[VIRT_CTR(stag, i)].cccr_address, low, high);
 	}
 
-	/* clear cccrs outside our concern */
-	for (i = stag ; i < NUM_UNUSED_CCCRS ; i += addr_increment()) {
-		rdmsr(p4_unused_cccr[i], low, high);
-		CCCR_CLEAR(low);
-		CCCR_SET_REQUIRED_BITS(low);
-		wrmsr(p4_unused_cccr[i], low, high);
-	}
-
 	/* clear all escrs (including those outside our concern) */
-	for (addr = MSR_P4_BSU_ESCR0 + stag;
-	     addr <  MSR_P4_IQ_ESCR0; addr += addr_increment()) {
-		wrmsr(addr, 0, 0);
-	}
-
-	/* On older models clear also MSR_P4_IQ_ESCR0/1 */
-	if (boot_cpu_data.x86_model < 0x3) {
-		wrmsr(MSR_P4_IQ_ESCR0, 0, 0);
-		wrmsr(MSR_P4_IQ_ESCR1, 0, 0);
-	}
-
-	for (addr = MSR_P4_RAT_ESCR0 + stag;
-	     addr <= MSR_P4_SSU_ESCR0; ++i, addr += addr_increment()) {
-		wrmsr(addr, 0, 0);
-	}
-	
-	for (addr = MSR_P4_MS_ESCR0 + stag;
-	     addr <= MSR_P4_TC_ESCR1; addr += addr_increment()){ 
-		wrmsr(addr, 0, 0);
-	}
-	
-	for (addr = MSR_P4_IX_ESCR0 + stag;
-	     addr <= MSR_P4_CRU_ESCR3; addr += addr_increment()){ 
-		wrmsr(addr, 0, 0);
+	for (i = num_counters; i < num_controls; i++) {
+		if (unlikely(!CTRL_IS_RESERVED(msrs,i)))
+			continue;
+		wrmsr(msrs->controls[i].addr, 0, 0);
 	}
 
-	if (num_counters == NUM_COUNTERS_NON_HT) {		
-		wrmsr(MSR_P4_CRU_ESCR4, 0, 0);
-		wrmsr(MSR_P4_CRU_ESCR5, 0, 0);
-	} else if (stag == 0) {
-		wrmsr(MSR_P4_CRU_ESCR4, 0, 0);
-	} else {
-		wrmsr(MSR_P4_CRU_ESCR5, 0, 0);
-	}		
-	
 	/* setup all counters */
 	for (i = 0 ; i < num_counters ; ++i) {
-		if (counter_config[i].enabled) {
+		if ((counter_config[i].enabled) && (CTRL_IS_RESERVED(msrs,i))) {
 			reset_value[i] = counter_config[i].count;
 			pmc_setup_one_p4_counter(i);
 			CTR_WRITE(counter_config[i].count, VIRT_CTR(stag, i));
@@ -696,12 +670,32 @@ static void p4_stop(struct op_msrs const
 	stag = get_stagger();
 
 	for (i = 0; i < num_counters; ++i) {
+		if (!reset_value[i])
+			continue;
 		CCCR_READ(low, high, VIRT_CTR(stag, i));
 		CCCR_SET_DISABLE(low);
 		CCCR_WRITE(low, high, VIRT_CTR(stag, i));
 	}
 }
 
+static void p4_shutdown(struct op_msrs const * const msrs)
+{
+	int i;
+
+	for (i = 0 ; i < num_counters ; ++i) {
+		if (CTR_IS_RESERVED(msrs,i))
+			release_perfctr_nmi(msrs->counters[i].addr);
+	}
+	/* some of the control registers are specially reserved in
+	 * conjunction with the counter registers (hence the starting offset).
+	 * This saves a few bits.
+	 */
+	for (i = num_counters ; i < num_controls ; ++i) {
+		if (CTRL_IS_RESERVED(msrs,i))
+			release_evntsel_nmi(msrs->controls[i].addr);
+	}
+}
+
 
 #ifdef CONFIG_SMP
 struct op_x86_model_spec const op_p4_ht2_spec = {
@@ -711,7 +705,8 @@ struct op_x86_model_spec const op_p4_ht2
 	.setup_ctrs = &p4_setup_ctrs,
 	.check_ctrs = &p4_check_ctrs,
 	.start = &p4_start,
-	.stop = &p4_stop
+	.stop = &p4_stop,
+	.shutdown = &p4_shutdown
 };
 #endif
 
@@ -722,5 +717,6 @@ struct op_x86_model_spec const op_p4_spe
 	.setup_ctrs = &p4_setup_ctrs,
 	.check_ctrs = &p4_check_ctrs,
 	.start = &p4_start,
-	.stop = &p4_stop
+	.stop = &p4_stop,
+	.shutdown = &p4_shutdown
 };
Index: linux-don/arch/i386/oprofile/op_model_ppro.c
===================================================================
--- linux-don.orig/arch/i386/oprofile/op_model_ppro.c
+++ linux-don/arch/i386/oprofile/op_model_ppro.c
@@ -22,10 +22,12 @@
 #define NUM_COUNTERS 2
 #define NUM_CONTROLS 2
 
+#define CTR_IS_RESERVED(msrs,c) (msrs->counters[(c)].addr ? 1 : 0)
 #define CTR_READ(l,h,msrs,c) do {rdmsr(msrs->counters[(c)].addr, (l), (h));} while (0)
 #define CTR_WRITE(l,msrs,c) do {wrmsr(msrs->counters[(c)].addr, -(u32)(l), -1);} while (0)
 #define CTR_OVERFLOWED(n) (!((n) & (1U<<31)))
 
+#define CTRL_IS_RESERVED(msrs,c) (msrs->controls[(c)].addr ? 1 : 0)
 #define CTRL_READ(l,h,msrs,c) do {rdmsr((msrs->controls[(c)].addr), (l), (h));} while (0)
 #define CTRL_WRITE(l,h,msrs,c) do {wrmsr((msrs->controls[(c)].addr), (l), (h));} while (0)
 #define CTRL_SET_ACTIVE(n) (n |= (1<<22))
@@ -41,11 +43,21 @@ static unsigned long reset_value[NUM_COU
  
 static void ppro_fill_in_addresses(struct op_msrs * const msrs)
 {
-	msrs->counters[0].addr = MSR_P6_PERFCTR0;
-	msrs->counters[1].addr = MSR_P6_PERFCTR1;
+	int i;
+
+	for (i=0; i < NUM_COUNTERS; i++) {
+		if (reserve_perfctr_nmi(MSR_P6_PERFCTR0 + i))
+			msrs->counters[i].addr = MSR_P6_PERFCTR0 + i;
+		else
+			msrs->counters[i].addr = 0;
+	}
 	
-	msrs->controls[0].addr = MSR_P6_EVNTSEL0;
-	msrs->controls[1].addr = MSR_P6_EVNTSEL1;
+	for (i=0; i < NUM_CONTROLS; i++) {
+		if (reserve_evntsel_nmi(MSR_P6_EVNTSEL0 + i))
+			msrs->controls[i].addr = MSR_P6_EVNTSEL0 + i;
+		else
+			msrs->controls[i].addr = 0;
+	}
 }
 
 
@@ -56,6 +68,8 @@ static void ppro_setup_ctrs(struct op_ms
 
 	/* clear all counters */
 	for (i = 0 ; i < NUM_CONTROLS; ++i) {
+		if (unlikely(!CTRL_IS_RESERVED(msrs,i)))
+			continue;
 		CTRL_READ(low, high, msrs, i);
 		CTRL_CLEAR(low);
 		CTRL_WRITE(low, high, msrs, i);
@@ -63,12 +77,14 @@ static void ppro_setup_ctrs(struct op_ms
 	
 	/* avoid a false detection of ctr overflows in NMI handler */
 	for (i = 0; i < NUM_COUNTERS; ++i) {
+		if (unlikely(!CTR_IS_RESERVED(msrs,i)))
+			continue;
 		CTR_WRITE(1, msrs, i);
 	}
 
 	/* enable active counters */
 	for (i = 0; i < NUM_COUNTERS; ++i) {
-		if (counter_config[i].enabled) {
+		if ((counter_config[i].enabled) && (CTR_IS_RESERVED(msrs,i))) {
 			reset_value[i] = counter_config[i].count;
 
 			CTR_WRITE(counter_config[i].count, msrs, i);
@@ -81,6 +97,8 @@ static void ppro_setup_ctrs(struct op_ms
 			CTRL_SET_UM(low, counter_config[i].unit_mask);
 			CTRL_SET_EVENT(low, counter_config[i].event);
 			CTRL_WRITE(low, high, msrs, i);
+		} else {
+			reset_value[i] = 0;
 		}
 	}
 }
@@ -93,6 +111,8 @@ static int ppro_check_ctrs(struct pt_reg
 	int i;
  
 	for (i = 0 ; i < NUM_COUNTERS; ++i) {
+		if (!reset_value[i])
+			continue;
 		CTR_READ(low, high, msrs, i);
 		if (CTR_OVERFLOWED(low)) {
 			oprofile_add_sample(regs, i);
@@ -118,18 +138,38 @@ static int ppro_check_ctrs(struct pt_reg
 static void ppro_start(struct op_msrs const * const msrs)
 {
 	unsigned int low,high;
-	CTRL_READ(low, high, msrs, 0);
-	CTRL_SET_ACTIVE(low);
-	CTRL_WRITE(low, high, msrs, 0);
+
+	if (reset_value[0]) {
+		CTRL_READ(low, high, msrs, 0);
+		CTRL_SET_ACTIVE(low);
+		CTRL_WRITE(low, high, msrs, 0);
+	}
 }
 
 
 static void ppro_stop(struct op_msrs const * const msrs)
 {
 	unsigned int low,high;
-	CTRL_READ(low, high, msrs, 0);
-	CTRL_SET_INACTIVE(low);
-	CTRL_WRITE(low, high, msrs, 0);
+
+	if (reset_value[0]) {
+		CTRL_READ(low, high, msrs, 0);
+		CTRL_SET_INACTIVE(low);
+		CTRL_WRITE(low, high, msrs, 0);
+	}
+}
+
+static void ppro_shutdown(struct op_msrs const * const msrs)
+{
+	int i;
+
+	for (i = 0 ; i < NUM_COUNTERS ; ++i) {
+		if (CTR_IS_RESERVED(msrs,i))
+			release_perfctr_nmi(MSR_P6_PERFCTR0 + i);
+	}
+	for (i = 0 ; i < NUM_CONTROLS ; ++i) {
+		if (CTRL_IS_RESERVED(msrs,i))
+			release_evntsel_nmi(MSR_P6_EVNTSEL0 + i);
+	}
 }
 
 
@@ -140,5 +180,6 @@ struct op_x86_model_spec const op_ppro_s
 	.setup_ctrs = &ppro_setup_ctrs,
 	.check_ctrs = &ppro_check_ctrs,
 	.start = &ppro_start,
-	.stop = &ppro_stop
+	.stop = &ppro_stop,
+	.shutdown = &ppro_shutdown
 };
Index: linux-don/arch/i386/oprofile/op_x86_model.h
===================================================================
--- linux-don.orig/arch/i386/oprofile/op_x86_model.h
+++ linux-don/arch/i386/oprofile/op_x86_model.h
@@ -40,6 +40,7 @@ struct op_x86_model_spec {
 		struct op_msrs const * const msrs);
 	void (*start)(struct op_msrs const * const msrs);
 	void (*stop)(struct op_msrs const * const msrs);
+	void (*shutdown)(struct op_msrs const * const msrs);
 };
 
 extern struct op_x86_model_spec const op_ppro_spec;

--
