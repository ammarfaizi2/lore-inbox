Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVCLX3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVCLX3r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 18:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVCLX1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 18:27:53 -0500
Received: from aun.it.uu.se ([130.238.12.36]:34250 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262500AbVCLXYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 18:24:10 -0500
Date: Sun, 13 Mar 2005 00:24:04 +0100 (MET)
Message-Id: <200503122324.j2CNO4Y5029037@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-mm3] perfctr API update 8/9: cpu_control access, ppc32
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Implement perfctr_cpu_control_write()/read() in-kernel API.
  Only handle PERFCTR_DOMAIN_CPU_REGS, as the other domains will be
  handled in generic code.
- Implement get_reg_offset() via a static table. The ppc32 SPR numbers
  we use don't form a nice dense range, alas.

This depends on the physical-indexing patch for ppc32, and on the
common part of the cpu_control access patch.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

/Mikael

 drivers/perfctr/ppc.c     |   70 ++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-ppc/perfctr.h |   11 +++++++
 2 files changed, 81 insertions(+)

diff -rupN linux-2.6.11-mm3.perfctr-cpu_control_header/drivers/perfctr/ppc.c linux-2.6.11-mm3.perfctr-cpu_control-access/drivers/perfctr/ppc.c
--- linux-2.6.11-mm3.perfctr-cpu_control_header/drivers/perfctr/ppc.c	2005-03-12 19:58:15.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-cpu_control-access/drivers/perfctr/ppc.c	2005-03-12 20:01:39.000000000 +0100
@@ -636,6 +636,76 @@ int perfctr_cpu_update_control(struct pe
 	return 0;
 }
 
+/*
+ * get_reg_offset() maps SPR numbers to offsets into struct perfctr_cpu_control,
+ * suitable for accessing control data of type unsigned int.
+ */
+static const struct {
+	unsigned int spr;
+	unsigned int offset;
+} reg_offsets[] = {
+	{ SPRN_MMCR0, offsetof(struct perfctr_cpu_control, mmcr0) },
+	{ SPRN_MMCR1, offsetof(struct perfctr_cpu_control, mmcr1) },
+	{ SPRN_MMCR2, offsetof(struct perfctr_cpu_control, mmcr2) },
+	{ SPRN_PMC1,  offsetof(struct perfctr_cpu_control, ireset[1-1]) },
+	{ SPRN_PMC2,  offsetof(struct perfctr_cpu_control, ireset[2-1]) },
+	{ SPRN_PMC3,  offsetof(struct perfctr_cpu_control, ireset[3-1]) },
+	{ SPRN_PMC4,  offsetof(struct perfctr_cpu_control, ireset[4-1]) },
+	{ SPRN_PMC5,  offsetof(struct perfctr_cpu_control, ireset[5-1]) },
+	{ SPRN_PMC6,  offsetof(struct perfctr_cpu_control, ireset[6-1]) },
+};
+
+static int get_reg_offset(unsigned int spr)
+{
+	unsigned int i;
+
+	for(i = 0; i < ARRAY_SIZE(reg_offsets); ++i)
+		if (spr == reg_offsets[i].spr)
+			return reg_offsets[i].offset;
+	return -1;
+}
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
diff -rupN linux-2.6.11-mm3.perfctr-cpu_control_header/include/asm-ppc/perfctr.h linux-2.6.11-mm3.perfctr-cpu_control-access/include/asm-ppc/perfctr.h
--- linux-2.6.11-mm3.perfctr-cpu_control_header/include/asm-ppc/perfctr.h	2005-03-12 19:58:15.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-cpu_control-access/include/asm-ppc/perfctr.h	2005-03-12 20:01:39.000000000 +0100
@@ -133,6 +133,17 @@ extern void perfctr_cpu_release(const ch
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
