Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVCLX3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVCLX3x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 18:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVCLX1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 18:27:17 -0500
Received: from aun.it.uu.se ([130.238.12.36]:25290 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262492AbVCLXXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 18:23:24 -0500
Date: Sun, 13 Mar 2005 00:23:17 +0100 (MET)
Message-Id: <200503122323.j2CNNHx3029012@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-mm3] perfctr API update 7/9: cpu_control access, x86
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Implement perfctr_cpu_control_write()/read() in-kernel API.
  Only handle PERFCTR_DOMAIN_CPU_REGS, as the other domains will be
  handled in generic code.
- Add per-CPU family reg_offset() functions, and have CPU family detection
  set up a pointer to the appropriate function.

This depends on the physical-indexing patch for x86, and on the
common part of the cpu_control access patch.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

/Mikael

 drivers/perfctr/x86.c      |  100 +++++++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/perfctr.h |   11 ++++
 2 files changed, 111 insertions(+)

diff -rupN linux-2.6.11-mm3.perfctr-cpu_control_header/drivers/perfctr/x86.c linux-2.6.11-mm3.perfctr-cpu_control-access/drivers/perfctr/x86.c
--- linux-2.6.11-mm3.perfctr-cpu_control_header/drivers/perfctr/x86.c	2005-03-12 19:58:15.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-cpu_control-access/drivers/perfctr/x86.c	2005-03-12 20:01:39.000000000 +0100
@@ -1077,6 +1077,98 @@ int perfctr_cpu_update_control(struct pe
 	return 0;
 }
 
+/*
+ * get_reg_offset() maps MSR numbers to offsets into struct perfctr_cpu_control,
+ * suitable for accessing control data of type unsigned int.
+ */
+static int p5_reg_offset(unsigned int msr)
+{
+	if (msr == MSR_P5_CESR)
+		return offsetof(struct perfctr_cpu_control, evntsel[0]);
+	return -1;
+}
+
+static int p6_reg_offset(unsigned int msr)
+{
+	if (msr - MSR_P6_EVNTSEL0 < 2)
+		return offsetof(struct perfctr_cpu_control, evntsel[msr - MSR_P6_EVNTSEL0]);
+	if (msr - MSR_P6_PERFCTR0 < 2)
+		return offsetof(struct perfctr_cpu_control, ireset[msr - MSR_P6_PERFCTR0]);
+	return -1;
+}
+
+static int k7_reg_offset(unsigned int msr)
+{
+	if (msr - MSR_K7_EVNTSEL0 < 4)
+		return offsetof(struct perfctr_cpu_control, evntsel[msr - MSR_K7_EVNTSEL0]);
+	if (msr - MSR_K7_PERFCTR0 < 4)
+		return offsetof(struct perfctr_cpu_control, ireset[msr - MSR_K7_PERFCTR0]);
+	return -1;
+}
+
+static int p4_reg_offset(unsigned int msr)
+{
+	if (msr - MSR_P4_CCCR0 < 18)
+		return offsetof(struct perfctr_cpu_control, evntsel[msr - MSR_P4_CCCR0]);
+	if (msr - MSR_P4_PERFCTR0 < 18)
+		return offsetof(struct perfctr_cpu_control, ireset[msr - MSR_P4_PERFCTR0]);
+	if (msr - MSR_P4_ESCR0 < 0x3E2 - 0x3A0)
+		return offsetof(struct perfctr_cpu_control, p4.escr[msr - MSR_P4_ESCR0]);
+	if (msr == MSR_P4_PEBS_ENABLE)
+		return offsetof(struct perfctr_cpu_control, p4.pebs_enable);
+	if (msr == MSR_P4_PEBS_MATRIX_VERT)
+		return offsetof(struct perfctr_cpu_control, p4.pebs_matrix_vert);
+	return -1;
+}
+
+static int generic_reg_offset(unsigned int msr)
+{
+	return -1;
+}
+
+static int (*get_reg_offset)(unsigned int);
+
+static int access_regs(struct perfctr_cpu_control *control,
+		       void *argp, unsigned int argbytes, int do_write)
+{
+	struct perfctr_cpu_reg *regs;
+	unsigned int i, nr_regs, *where;
+	int offset;
+
+	if (argbytes & (sizeof(struct perfctr_cpu_reg) - 1))
+		return -EINVAL;
+	regs = (struct perfctr_cpu_reg*)argp;
+	nr_regs = argbytes / sizeof(struct perfctr_cpu_reg);
+
+	for(i = 0; i < nr_regs; ++i) {
+		offset = get_reg_offset(regs[i].nr);
+		if (offset < 0)
+			return -EINVAL;
+		where = (unsigned int*)((char*)control + offset);
+		if (do_write)
+			*where = regs[i].value;
+		else
+			regs[i].value = *where;
+	}
+	return argbytes;
+}
+
+int perfctr_cpu_control_write(struct perfctr_cpu_control *control, unsigned int domain,
+			      const void *srcp, unsigned int srcbytes)
+{
+	if (domain != PERFCTR_DOMAIN_CPU_REGS)
+		return -EINVAL;
+	return access_regs(control, (void*)srcp, srcbytes, 1);
+}
+
+int perfctr_cpu_control_read(const struct perfctr_cpu_control *control, unsigned int domain,
+			     void *dstp, unsigned int dstbytes)
+{
+	if (domain != PERFCTR_DOMAIN_CPU_REGS)
+		return -EINVAL;
+	return access_regs((struct perfctr_cpu_control*)control, dstp, dstbytes, 0);
+}
+
 void perfctr_cpu_suspend(struct perfctr_cpu_state *state)
 {
 	unsigned int i, cstatus, nractrs;
@@ -1269,6 +1361,7 @@ static int __init intel_init(void)
 		write_control = p5_write_control;
 		check_control = p5_check_control;
 		clear_counters = p5_clear_counters;
+		get_reg_offset = p5_reg_offset;
 		return 0;
 	case 6:
 		if (current_cpu_data.x86_model == 9 ||
@@ -1290,6 +1383,7 @@ static int __init intel_init(void)
 		write_control = p6_write_control;
 		check_control = p6_check_control;
 		clear_counters = p6_clear_counters;
+		get_reg_offset = p6_reg_offset;
 #ifdef CONFIG_X86_LOCAL_APIC
 		if (cpu_has_apic) {
 			perfctr_info.cpu_features |= PERFCTR_FEATURE_PCINT;
@@ -1318,6 +1412,7 @@ static int __init intel_init(void)
 		write_control = p4_write_control;
 		check_control = p4_check_control;
 		clear_counters = p4_clear_counters;
+		get_reg_offset = p4_reg_offset;
 #ifdef CONFIG_X86_LOCAL_APIC
 		if (cpu_has_apic) {
 			perfctr_info.cpu_features |= PERFCTR_FEATURE_PCINT;
@@ -1350,6 +1445,7 @@ static int __init amd_init(void)
 	write_control = k7_write_control;
 	check_control = k7_check_control;
 	clear_counters = k7_clear_counters;
+	get_reg_offset = k7_reg_offset;
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (cpu_has_apic) {
 		perfctr_info.cpu_features |= PERFCTR_FEATURE_PCINT;
@@ -1373,6 +1469,7 @@ static int __init cyrix_init(void)
 		write_control = p5_write_control;
 		check_control = mii_check_control;
 		clear_counters = p5_clear_counters;
+		get_reg_offset = p5_reg_offset;
 		return 0;
 	}
 	return -ENODEV;
@@ -1407,6 +1504,7 @@ static int __init centaur_init(void)
 		write_control = c6_write_control;
 		check_control = c6_check_control;
 		clear_counters = p5_clear_counters;
+		get_reg_offset = p5_reg_offset;
 		return 0;
 #endif
 	case 6: /* VIA C3 */
@@ -1427,6 +1525,7 @@ static int __init centaur_init(void)
 		write_control = p6_write_control;
 		check_control = vc3_check_control;
 		clear_counters = vc3_clear_counters;
+		get_reg_offset = p6_reg_offset;
 		return 0;
 	}
 	return -ENODEV;
@@ -1444,6 +1543,7 @@ static int __init generic_init(void)
 	write_control = p6_write_control;
 	read_counters = rdpmc_read_counters;
 	clear_counters = generic_clear_counters;
+	get_reg_offset = generic_reg_offset;
 	return 0;
 }
 
diff -rupN linux-2.6.11-mm3.perfctr-cpu_control_header/include/asm-i386/perfctr.h linux-2.6.11-mm3.perfctr-cpu_control-access/include/asm-i386/perfctr.h
--- linux-2.6.11-mm3.perfctr-cpu_control_header/include/asm-i386/perfctr.h	2005-03-12 19:58:15.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-cpu_control-access/include/asm-i386/perfctr.h	2005-03-12 20:01:39.000000000 +0100
@@ -158,6 +158,17 @@ extern void perfctr_cpu_release(const ch
    Returns a negative error code if the control data is invalid. */
 extern int perfctr_cpu_update_control(struct perfctr_cpu_state *state, int is_global);
 
+/* Parse and update control for the given domain. */
+extern int perfctr_cpu_control_write(struct perfctr_cpu_control *control,
+				     unsigned int domain,
+				     const void *srcp, unsigned int srcbytes);
+
+/* Retrieve and format control for the given domain.
+   Returns number of bytes written. */
+extern int perfctr_cpu_control_read(const struct perfctr_cpu_control *control,
+				    unsigned int domain,
+				    void *dstp, unsigned int dstbytes);
+
 /* Read a-mode counters. Subtract from start and accumulate into sums.
    Must be called with preemption disabled. */
 extern void perfctr_cpu_suspend(struct perfctr_cpu_state *state);
