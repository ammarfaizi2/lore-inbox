Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUIKH4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUIKH4u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 03:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267638AbUIKH4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 03:56:50 -0400
Received: from ozlabs.org ([203.10.76.45]:41958 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267602AbUIKH4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 03:56:13 -0400
Date: Sat, 11 Sep 2004 17:53:05 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix spurious warnings uncovered by -Wno-uninitialized removal
Message-ID: <20040911075304.GB32755@krispykreme>
References: <20040911065406.GA32755@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911065406.GA32755@krispykreme>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here are fixes for some false positives.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/iommu.c~falsepositives arch/ppc64/kernel/iommu.c
--- foobar2/arch/ppc64/kernel/iommu.c~falsepositives	2004-09-11 16:11:50.126708344 +1000
+++ foobar2-anton/arch/ppc64/kernel/iommu.c	2004-09-11 16:11:50.248698966 +1000
@@ -229,7 +229,7 @@ int iommu_map_sg(struct device *dev, str
 		struct scatterlist *sglist, int nelems,
 		enum dma_data_direction direction)
 {
-	dma_addr_t dma_next, dma_addr;
+	dma_addr_t dma_next = 0, dma_addr;
 	unsigned long flags;
 	struct scatterlist *s, *outs, *segstart;
 	int outcount;
diff -puN arch/ppc64/kernel/nvram.c~falsepositives arch/ppc64/kernel/nvram.c
--- foobar2/arch/ppc64/kernel/nvram.c~falsepositives	2004-09-11 16:11:50.132707882 +1000
+++ foobar2-anton/arch/ppc64/kernel/nvram.c	2004-09-11 16:11:50.251698736 +1000
@@ -340,7 +340,7 @@ static int nvram_create_os_partition(voi
 	struct list_head * p;
 	struct nvram_partition * part;
 	struct nvram_partition * new_part = NULL;
-	struct nvram_partition * free_part;
+	struct nvram_partition * free_part = NULL;
 	int seq_init[2] = { 0, 0 };
 	loff_t tmp_index;
 	long size = 0;
diff -puN arch/ppc64/kernel/sysfs.c~falsepositives arch/ppc64/kernel/sysfs.c
--- foobar2/arch/ppc64/kernel/sysfs.c~falsepositives	2004-09-11 16:11:50.221701042 +1000
+++ foobar2-anton/arch/ppc64/kernel/sysfs.c	2004-09-11 16:11:50.297695200 +1000
@@ -97,6 +97,13 @@ __setup("smt-snooze-delay=", setup_smt_s
 
 /* PMC stuff */
 
+#ifdef CONFIG_PPC_ISERIES
+void ppc64_enable_pmcs(void)
+{
+	/* XXX Implement for iseries */
+}
+#else
+
 /*
  * Enabling PMCs will slow partition context switch times so we only do
  * it the first time we write to the PMCs.
@@ -104,12 +111,6 @@ __setup("smt-snooze-delay=", setup_smt_s
 
 static DEFINE_PER_CPU(char, pmcs_enabled);
 
-#ifdef CONFIG_PPC_ISERIES
-void ppc64_enable_pmcs(void)
-{
-	/* XXX Implement for iseries */
-}
-#else
 void ppc64_enable_pmcs(void)
 {
 	unsigned long hid0;
diff -puN arch/ppc64/kernel/pSeries_pci.c~falsepositives arch/ppc64/kernel/pSeries_pci.c
--- foobar2/arch/ppc64/kernel/pSeries_pci.c~falsepositives	2004-09-11 16:11:50.144706960 +1000
+++ foobar2-anton/arch/ppc64/kernel/pSeries_pci.c	2004-09-11 16:11:50.255698428 +1000
@@ -497,7 +497,7 @@ unsigned long __init find_and_init_phbs(
 	struct pci_controller *phb;
 	unsigned int root_size_cells = 0;
 	unsigned int index;
-	unsigned int *opprop;
+	unsigned int *opprop = NULL;
 	struct device_node *root = of_find_node_by_path("/");
 
 	if (naca->interrupt_controller == IC_OPEN_PIC) {
diff -puN arch/ppc64/kernel/rtasd.c~falsepositives arch/ppc64/kernel/rtasd.c
--- foobar2/arch/ppc64/kernel/rtasd.c~falsepositives	2004-09-11 16:11:50.158705884 +1000
+++ foobar2-anton/arch/ppc64/kernel/rtasd.c	2004-09-11 16:11:50.265697660 +1000
@@ -106,7 +106,7 @@ static char *rtas_event_type(int type)
 static void printk_log_rtas(char *buf, int len)
 {
 
-	int i,j,n;
+	int i,j,n = 0;
 	int perline = 16;
 	char buffer[64];
 	char * str = "RTAS event";
diff -puN arch/ppc64/kernel/setup.c~falsepositives arch/ppc64/kernel/setup.c
--- foobar2/arch/ppc64/kernel/setup.c~falsepositives	2004-09-11 16:11:50.164705423 +1000
+++ foobar2-anton/arch/ppc64/kernel/setup.c	2004-09-11 16:11:50.267697506 +1000
@@ -598,7 +598,7 @@ static int __init set_preferred_console(
 {
 	struct device_node *prom_stdout;
 	char *name;
-	int offset;
+	int offset = 0;
 
 	/* The user has requested a console so this is already set up. */
 	if (strstr(saved_command_line, "console="))
diff -puN arch/ppc64/kernel/signal.c~falsepositives arch/ppc64/kernel/signal.c
--- foobar2/arch/ppc64/kernel/signal.c~falsepositives	2004-09-11 16:11:50.170704962 +1000
+++ foobar2-anton/arch/ppc64/kernel/signal.c	2004-09-11 16:11:50.269697352 +1000
@@ -178,7 +178,7 @@ static long restore_sigcontext(struct pt
 	elf_vrreg_t __user *v_regs;
 #endif
 	unsigned long err = 0;
-	unsigned long save_r13;
+	unsigned long save_r13 = 0;
 	elf_greg_t *gregs = (elf_greg_t *)regs;
 	int i;
 
diff -puN arch/ppc64/kernel/signal32.c~falsepositives arch/ppc64/kernel/signal32.c
--- foobar2/arch/ppc64/kernel/signal32.c~falsepositives	2004-09-11 16:11:50.176704500 +1000
+++ foobar2-anton/arch/ppc64/kernel/signal32.c	2004-09-11 16:11:50.272697121 +1000
@@ -189,7 +189,7 @@ static long restore_user_regs(struct pt_
 	elf_greg_t64 *gregs = (elf_greg_t64 *)regs;
 	int i;
 	long err = 0;
-	unsigned int save_r2;
+	unsigned int save_r2 = 0;
 #ifdef CONFIG_ALTIVEC
 	unsigned long msr;
 #endif
diff -puN arch/ppc64/oprofile/op_model_rs64.c~falsepositives arch/ppc64/oprofile/op_model_rs64.c
--- foobar2/arch/ppc64/oprofile/op_model_rs64.c~falsepositives	2004-09-11 16:11:50.182704039 +1000
+++ foobar2-anton/arch/ppc64/oprofile/op_model_rs64.c	2004-09-11 16:11:50.273697045 +1000
@@ -21,8 +21,8 @@
 
 static void ctrl_write(unsigned int i, unsigned int val)
 {
-	unsigned int tmp;
-	unsigned long shift, mask;
+	unsigned int tmp = 0;
+	unsigned long shift = 0, mask = 0;
 
 	dbg("ctrl_write %d %x\n", i, val);
 
diff -puN arch/ppc64/xmon/xmon.c~falsepositives arch/ppc64/xmon/xmon.c
--- foobar2/arch/ppc64/xmon/xmon.c~falsepositives	2004-09-11 16:11:50.189703501 +1000
+++ foobar2-anton/arch/ppc64/xmon/xmon.c	2004-09-11 16:11:50.279696583 +1000
@@ -2059,7 +2059,7 @@ ppc_inst_dump(unsigned long adr, long co
 {
 	int nr, dotted;
 	unsigned long first_adr;
-	unsigned long inst, last_inst;
+	unsigned long inst, last_inst = 0;
 	unsigned char val[4];
 
 	dotted = 0;
diff -puN drivers/char/hvsi.c~falsepositives drivers/char/hvsi.c
--- foobar2/drivers/char/hvsi.c~falsepositives	2004-09-11 16:11:50.196702963 +1000
+++ foobar2-anton/drivers/char/hvsi.c	2004-09-11 16:11:50.282696353 +1000
@@ -1004,7 +1004,7 @@ static int hvsi_write(struct tty_struct 
 {
 	struct hvsi_struct *hp = tty->driver_data;
 	const char *source = buf;
-	char *kbuf;
+	char *kbuf = NULL;
 	unsigned long flags;
 	int total = 0;
 	int origcount = count;
diff -puN drivers/macintosh/via-pmu.c~falsepositives drivers/macintosh/via-pmu.c
--- foobar2/drivers/macintosh/via-pmu.c~falsepositives	2004-09-11 16:14:45.116577104 +1000
+++ foobar2-anton/drivers/macintosh/via-pmu.c	2004-09-11 16:14:48.743825573 +1000
@@ -1446,7 +1446,7 @@ static struct adb_request* __pmac
 pmu_sr_intr(struct pt_regs *regs)
 {
 	struct adb_request *req;
-	int bite;
+	int bite = 0;
 
 	if (via[B] & TREQ) {
 		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", via[B]);
