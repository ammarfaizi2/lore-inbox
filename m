Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWEYDwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWEYDwo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 23:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWEYDwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 23:52:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:9095 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964864AbWEYDw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 23:52:26 -0400
X-IronPort-AV: i="4.05,170,1146466800"; 
   d="scan'208"; a="41049709:sNHT248272122"
Subject: [PATCH 2/2] microcode update driver rewrite
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Tigran Aivazian <tigran@veritas.com>, Rajesh Shah <rajesh.shah@intel.com>,
       "Van De Ven, Adriaan" <adriaan.van.de.ven@intel.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 25 May 2006 11:50:49 +0800
Message-Id: <1148529049.32046.103.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the rewrite of microcode update driver. Changes:
1. trim the code
2. using request_firmware to pull ucode from userspace, so we don't need
the application 'microcode_ctl' to assist. We name each ucode file
according to CPU's info as intel-ucode/family-model-stepping. In this
way we could split ucode file as small one. This has a lot of advantages
such as selectively update and validate microcode for specific models,
better manage microcode file, easily write tools for administerators and
so on.
3. add sysfs support. Currently each CPU has two microcode related
attributes. One is 'version' which shows current ucode version of CPU.
Tools can use the attribute do validation or show CPU ucode status. The
other is 'reload' which allows manually reloading ucode. 
4. add suspend/resume and CPU hotplug support. 

With the changes, we should put all intel-ucode/xx-xx-xx microcode files
into the firmware dir (I had a tool to split previous big data file into
small one and later we will release new style data file). The init
script should be changed to just loading the driver without unloading
for hotplug and suspend/resume (for back compatibility I keep old
interface, so old init script also works).

Downside. We are using request_firmware. If the driver is build-in and
initramfs hasn't udev support, the driver will wait for request_firmware
to finish for a long time. But I suppose this is very rare, as microcode
driver usually is a module.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc4-root/arch/i386/Kconfig            |    5 
 linux-2.6.17-rc4-root/arch/i386/kernel/microcode.c |  762 ++++++++++++++-------
 linux-2.6.17-rc4-root/arch/x86_64/Kconfig          |    5 
 3 files changed, 542 insertions(+), 230 deletions(-)

diff -puN arch/i386/kernel/microcode.c~ucode_rewrite arch/i386/kernel/microcode.c
--- linux-2.6.17-rc4/arch/i386/kernel/microcode.c~ucode_rewrite	2006-05-22 08:42:50.000000000 +0800
+++ linux-2.6.17-rc4-root/arch/i386/kernel/microcode.c	2006-05-24 09:09:09.000000000 +0800
@@ -2,6 +2,7 @@
  *	Intel CPU Microcode Update Driver for Linux
  *
  *	Copyright (C) 2000-2004 Tigran Aivazian
+ *		      2006	Shaohua Li <shaohua.li@intel.com>
  *
  *	This driver allows to upgrade microcode on Intel processors
  *	belonging to IA-32 family - PentiumPro, Pentium II, 
@@ -82,6 +83,8 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/cpu.h>
+#include <linux/firmware.h>
 
 #include <asm/msr.h>
 #include <asm/uaccess.h>
@@ -117,53 +120,41 @@ static DEFINE_SPINLOCK(microcode_update_
 /* no concurrent ->write()s are allowed on /dev/cpu/microcode */
 static DEFINE_MUTEX(microcode_mutex);
 
-static void __user *user_buffer;	/* user area microcode data buffer */
-static unsigned int user_buffer_size;	/* it's size */
-
-typedef enum mc_error_code {
-	MC_SUCCESS 	= 0,
-	MC_NOTFOUND 	= 1,
-	MC_MARKED 	= 2,
-	MC_ALLOCATED 	= 3,
-} mc_error_code_t;
-
 static struct ucode_cpu_info {
+	int valid;
 	unsigned int sig;
 	unsigned int pf;
 	unsigned int rev;
-	unsigned int cksum;
-	mc_error_code_t err;
 	microcode_t *mc;
+	struct kobject kobj;
 } ucode_cpu_info[NR_CPUS];
-				
-static int microcode_open (struct inode *unused1, struct file *unused2)
-{
-	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
-}
 
-static void collect_cpu_info (void *unused)
+static void collect_cpu_info(int cpu_num)
 {
-	int cpu_num = smp_processor_id();
 	struct cpuinfo_x86 *c = cpu_data + cpu_num;
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu_num;
 	unsigned int val[2];
 
-	uci->sig = uci->pf = uci->rev = uci->cksum = 0;
-	uci->err = MC_NOTFOUND; 
+	/* We should bind the task to the CPU */
+	BUG_ON(raw_smp_processor_id() != cpu_num);
+	uci->pf = uci->rev = 0;
 	uci->mc = NULL;
+	uci->valid = 1;
 
 	if (c->x86_vendor != X86_VENDOR_INTEL || c->x86 < 6 ||
 	    	cpu_has(c, X86_FEATURE_IA64)) {
-		printk(KERN_ERR "microcode: CPU%d not a capable Intel processor\n", cpu_num);
+		printk(KERN_ERR "microcode: CPU%d not a capable Intel "
+			"processor\n", cpu_num);
+		uci->valid = 0;
 		return;
-	} else {
-		uci->sig = cpuid_eax(0x00000001);
+	}
 
-		if ((c->x86_model >= 5) || (c->x86 > 6)) {
-			/* get processor flags from MSR 0x17 */
-			rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
-			uci->pf = 1 << ((val[1] >> 18) & 7);
-		}
+	uci->sig = cpuid_eax(0x00000001);
+
+	if ((c->x86_model >= 5) || (c->x86 > 6)) {
+		/* get processor flags from MSR 0x17 */
+		rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
+		uci->pf = 1 << ((val[1] >> 18) & 7);
 	}
 
 	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
@@ -175,201 +166,161 @@ static void collect_cpu_info (void *unus
 			uci->sig, uci->pf, uci->rev);
 }
 
-static inline void mark_microcode_update (int cpu_num, microcode_header_t *mc_header, int sig, int pf, int cksum)
+static inline int microcode_update_match(int cpu_num,
+	microcode_header_t *mc_header, int sig, int pf)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu_num;
 
-	pr_debug("Microcode Found.\n");
-	pr_debug("   Header Revision 0x%x\n", mc_header->hdrver);
-	pr_debug("   Loader Revision 0x%x\n", mc_header->ldrver);
-	pr_debug("   Revision 0x%x \n", mc_header->rev);
-	pr_debug("   Date %x/%x/%x\n",
-		((mc_header->date >> 24 ) & 0xff),
-		((mc_header->date >> 16 ) & 0xff),
-		(mc_header->date & 0xFFFF));
-	pr_debug("   Signature 0x%x\n", sig);
-	pr_debug("   Type 0x%x Family 0x%x Model 0x%x Stepping 0x%x\n",
-		((sig >> 12) & 0x3),
-		((sig >> 8) & 0xf),
-		((sig >> 4) & 0xf),
-		((sig & 0xf)));
-	pr_debug("   Processor Flags 0x%x\n", pf);
-	pr_debug("   Checksum 0x%x\n", cksum);
-
-	if (mc_header->rev < uci->rev) {
-		printk(KERN_ERR "microcode: CPU%d not 'upgrading' to earlier revision"
-		       " 0x%x (current=0x%x)\n", cpu_num, mc_header->rev, uci->rev);
-		goto out;
-	} else if (mc_header->rev == uci->rev) {
-		/* notify the caller of success on this cpu */
-		uci->err = MC_SUCCESS;
-		goto out;
-	}
-
-	pr_debug("microcode: CPU%d found a matching microcode update with "
-		" revision 0x%x (current=0x%x)\n", cpu_num, mc_header->rev, uci->rev);
-	uci->cksum = cksum;
-	uci->pf = pf; /* keep the original mc pf for cksum calculation */
-	uci->err = MC_MARKED; /* found the match */
-out:
-	return;
+	if (!sigmatch(sig, uci->sig, pf, uci->pf)
+		|| mc_header->rev <= uci->rev)
+		return 0;
+	return 1;
 }
 
-static int find_matching_ucodes (void) 
+static int microcode_sanity_check(void *mc)
 {
-	int cursor = 0;
-	int error = 0;
-
-	while (cursor + MC_HEADER_SIZE < user_buffer_size) {
-		microcode_header_t mc_header;
-		void *newmc = NULL;
-		int i, sum, cpu_num, allocated_flag, total_size, data_size, ext_table_size;
-
-		if (copy_from_user(&mc_header, user_buffer + cursor, MC_HEADER_SIZE)) {
-			printk(KERN_ERR "microcode: error! Can not read user data\n");
-			error = -EFAULT;
-			goto out;
-		}
+	microcode_header_t *mc_header = mc;
+	struct extended_sigtable *ext_header = NULL;
+	struct extended_signature *ext_sig;
+	unsigned long total_size, data_size, ext_table_size;
+	int sum, orig_sum, ext_sigcount = 0, i;
+
+	total_size = get_totalsize(mc_header);
+	data_size = get_datasize(mc_header);
+	if ((data_size + MC_HEADER_SIZE > total_size)
+		|| (data_size < DEFAULT_UCODE_DATASIZE)) {
+		printk(KERN_ERR "microcode: error! "
+			"Bad data in microcode data file\n");
+		return -EINVAL;
+	}
 
-		total_size = get_totalsize(&mc_header);
-		if ((cursor + total_size > user_buffer_size) || (total_size < DEFAULT_UCODE_TOTALSIZE)) {
-			printk(KERN_ERR "microcode: error! Bad data in microcode data file\n");
-			error = -EINVAL;
-			goto out;
+	if (mc_header->ldrver != 1 || mc_header->hdrver != 1) {
+		printk(KERN_ERR "microcode: error! "
+			"Unknown microcode update format\n");
+		return -EINVAL;
+	}
+	ext_table_size = total_size - (MC_HEADER_SIZE + data_size);
+	if (ext_table_size) {
+		if ((ext_table_size < EXT_HEADER_SIZE)
+		 || ((ext_table_size - EXT_HEADER_SIZE) % EXT_SIGNATURE_SIZE)) {
+			printk(KERN_ERR "microcode: error! "
+				"Bad data in microcode data file\n");
+			return -EINVAL;
 		}
-
-		data_size = get_datasize(&mc_header);
-		if ((data_size + MC_HEADER_SIZE > total_size) || (data_size < DEFAULT_UCODE_DATASIZE)) {
-			printk(KERN_ERR "microcode: error! Bad data in microcode data file\n");
-			error = -EINVAL;
-			goto out;
+		ext_header = mc + MC_HEADER_SIZE + data_size;
+		if (ext_table_size != exttable_size(ext_header)) {
+			printk(KERN_ERR "microcode: error! "
+				"Bad data in microcode data file\n");
+			return -EFAULT;
 		}
+		ext_sigcount = ext_header->count;
+	}
 
-		if (mc_header.ldrver != 1 || mc_header.hdrver != 1) {
-			printk(KERN_ERR "microcode: error! Unknown microcode update format\n");
-			error = -EINVAL;
-			goto out;
+	/* check extended table checksum */
+	if (ext_table_size) {
+		int ext_table_sum = 0;
+		int * ext_tablep = (int *)ext_header;
+
+		i = ext_table_size / DWSIZE;
+		while (i--)
+			ext_table_sum += ext_tablep[i];
+		if (ext_table_sum) {
+			printk(KERN_WARNING "microcode: aborting, "
+				"bad extended signature table checksum\n");
+			return -EINVAL;
 		}
+	}
 
-		for_each_online_cpu(cpu_num) {
-			struct ucode_cpu_info *uci = ucode_cpu_info + cpu_num;
-			if (uci->err != MC_NOTFOUND) /* already found a match or not an online cpu*/
-				continue;
-
-			if (sigmatch(mc_header.sig, uci->sig, mc_header.pf, uci->pf))
-				mark_microcode_update(cpu_num, &mc_header, mc_header.sig, mc_header.pf, mc_header.cksum);
+	/* calculate the checksum */
+	orig_sum = 0;
+	i = (MC_HEADER_SIZE + data_size) / DWSIZE;
+	while (i--)
+		orig_sum += ((int *)mc)[i];
+	if (orig_sum) {
+		printk(KERN_ERR "microcode: aborting, bad checksum\n");
+		return -EINVAL;
+	}
+	if (!ext_table_size)
+		return 0;
+	/* check extended signature checksum */
+	for (i = 0; i < ext_sigcount; i++) {
+		ext_sig = (struct extended_signature *)((void *)ext_header
+			+ EXT_HEADER_SIZE + EXT_SIGNATURE_SIZE * i);
+		sum = orig_sum
+			- (mc_header->sig + mc_header->pf + mc_header->cksum)
+			+ (ext_sig->sig + ext_sig->pf + ext_sig->cksum);
+		if (sum) {
+			printk(KERN_ERR "microcode: aborting, bad checksum\n");
+			return -EINVAL;
 		}
+	}
+	return 0;
+}
 
-		ext_table_size = total_size - (MC_HEADER_SIZE + data_size);
-		if (ext_table_size) {
-			struct extended_sigtable ext_header;
-			struct extended_signature ext_sig;
-			int ext_sigcount;
-
-			if ((ext_table_size < EXT_HEADER_SIZE) 
-					|| ((ext_table_size - EXT_HEADER_SIZE) % EXT_SIGNATURE_SIZE)) {
-				printk(KERN_ERR "microcode: error! Bad data in microcode data file\n");
-				error = -EINVAL;
-				goto out;
-			}
-			if (copy_from_user(&ext_header, user_buffer + cursor 
-					+ MC_HEADER_SIZE + data_size, EXT_HEADER_SIZE)) {
-				printk(KERN_ERR "microcode: error! Can not read user data\n");
-				error = -EFAULT;
-				goto out;
-			}
-			if (ext_table_size != exttable_size(&ext_header)) {
-				printk(KERN_ERR "microcode: error! Bad data in microcode data file\n");
-				error = -EFAULT;
-				goto out;
-			}
+/*
+ * return 0 - no update found
+ * return 1 - found update
+ * return < 0 - error
+ */
+static int get_maching_microcode(void *mc, int cpu)
+{
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+	microcode_header_t *mc_header = mc;
+	struct extended_sigtable *ext_header;
+	unsigned long total_size = get_totalsize(mc_header);
+	int ext_sigcount, i;
+	struct extended_signature *ext_sig;
+	void *new_mc;
+
+	if (microcode_update_match(cpu, mc_header,
+			mc_header->sig, mc_header->pf))
+		goto find;
+
+	if (total_size <= get_datasize(mc_header) + MC_HEADER_SIZE)
+		return 0;
+
+	ext_header = (struct extended_sigtable *)(mc +
+			get_datasize(mc_header) + MC_HEADER_SIZE);
+	ext_sigcount = ext_header->count;
+	ext_sig = (struct extended_signature *)((void *)ext_header
+			+ EXT_HEADER_SIZE);
+	for (i = 0; i < ext_sigcount; i++) {
+		if (microcode_update_match(cpu, mc_header,
+				ext_sig->sig, ext_sig->pf))
+			goto find;
+		ext_sig++;
+	}
+	return 0;
+find:
+	pr_debug("microcode: CPU %d found a matching microcode update with"
+		" version 0x%x (current=0x%x)\n", cpu, mc_header->rev,uci->rev);
+	new_mc = vmalloc(total_size);
+	if (!new_mc) {
+		printk(KERN_ERR "microcode: error! Can not allocate memory\n");
+		return -ENOMEM;
+	}
 
-			ext_sigcount = ext_header.count;
-			
-			for (i = 0; i < ext_sigcount; i++) {
-				if (copy_from_user(&ext_sig, user_buffer + cursor + MC_HEADER_SIZE + data_size + EXT_HEADER_SIZE 
-						+ EXT_SIGNATURE_SIZE * i, EXT_SIGNATURE_SIZE)) {
-					printk(KERN_ERR "microcode: error! Can not read user data\n");
-					error = -EFAULT;
-					goto out;
-				}
-				for_each_online_cpu(cpu_num) {
-					struct ucode_cpu_info *uci = ucode_cpu_info + cpu_num;
-					if (uci->err != MC_NOTFOUND) /* already found a match or not an online cpu*/
-						continue;
-					if (sigmatch(ext_sig.sig, uci->sig, ext_sig.pf, uci->pf)) {
-						mark_microcode_update(cpu_num, &mc_header, ext_sig.sig, ext_sig.pf, ext_sig.cksum);
-					}
-				}
-			}
-		}
-		/* now check if any cpu has matched */
-		allocated_flag = 0;
-		sum = 0;
-		for_each_online_cpu(cpu_num) {
-			if (ucode_cpu_info[cpu_num].err == MC_MARKED) { 
-				struct ucode_cpu_info *uci = ucode_cpu_info + cpu_num;
-				if (!allocated_flag) {
-					allocated_flag = 1;
-					newmc = vmalloc(total_size);
-					if (!newmc) {
-						printk(KERN_ERR "microcode: error! Can not allocate memory\n");
-						error = -ENOMEM;
-						goto out;
-					}
-					if (copy_from_user(newmc + MC_HEADER_SIZE, 
-								user_buffer + cursor + MC_HEADER_SIZE, 
-								total_size - MC_HEADER_SIZE)) {
-						printk(KERN_ERR "microcode: error! Can not read user data\n");
-						vfree(newmc);
-						error = -EFAULT;
-						goto out;
-					}
-					memcpy(newmc, &mc_header, MC_HEADER_SIZE);
-					/* check extended table checksum */
-					if (ext_table_size) {
-						int ext_table_sum = 0;
-						int * ext_tablep = (((void *) newmc) + MC_HEADER_SIZE + data_size);
-						i = ext_table_size / DWSIZE;
-						while (i--) ext_table_sum += ext_tablep[i];
-						if (ext_table_sum) {
-							printk(KERN_WARNING "microcode: aborting, bad extended signature table checksum\n");
-							vfree(newmc);
-							error = -EINVAL;
-							goto out;
-						}
-					}
-
-					/* calculate the checksum */
-					i = (MC_HEADER_SIZE + data_size) / DWSIZE;
-					while (i--) sum += ((int *)newmc)[i];
-					sum -= (mc_header.sig + mc_header.pf + mc_header.cksum);
-				}
-				ucode_cpu_info[cpu_num].mc = newmc;
-				ucode_cpu_info[cpu_num].err = MC_ALLOCATED; /* mc updated */
-				if (sum + uci->sig + uci->pf + uci->cksum != 0) {
-					printk(KERN_ERR "microcode: CPU%d aborting, bad checksum\n", cpu_num);
-					error = -EINVAL;
-					goto out;
-				}
-			}
-		}
-		cursor += total_size; /* goto the next update patch */
-	} /* end of while */
-out:
-	return error;
+	/* free previous update file */
+	if (uci->mc)
+		vfree(uci->mc);
+
+	memcpy(new_mc, mc, total_size);
+	uci->mc = new_mc;
+	return 1;
 }
 
-static void do_update_one (void * unused)
+static void apply_microcode(int cpu)
 {
 	unsigned long flags;
 	unsigned int val[2];
-	int cpu_num = smp_processor_id();
+	int cpu_num = raw_smp_processor_id();
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu_num;
 
-	if (uci->mc == NULL) {
+	/* We should bind the task to the CPU */
+	BUG_ON(cpu_num != cpu);
+
+	if (uci->mc == NULL)
 		return;
-	}
 
 	/* serialize access to the physical write to MSR 0x79 */
 	spin_lock_irqsave(&microcode_update_lock, flags);          
@@ -386,51 +337,104 @@ static void do_update_one (void * unused
 	/* get the current revision from MSR 0x8B */
 	rdmsr(MSR_IA32_UCODE_REV, val[0], val[1]);
 
-	/* notify the caller of success on this cpu */
-	uci->err = MC_SUCCESS;
 	spin_unlock_irqrestore(&microcode_update_lock, flags);
-	printk(KERN_INFO "microcode: CPU%d updated from revision "
+	if (val[1] != uci->mc->hdr.rev) {
+		printk(KERN_ERR "microcode: CPU%d updated from revision "
+			"0x%x to 0x%x failed\n", cpu_num, uci->rev, val[1]);
+		return;
+	}
+	pr_debug("microcode: CPU%d updated from revision "
 	       "0x%x to 0x%x, date = %08x \n", 
 	       cpu_num, uci->rev, val[1], uci->mc->hdr.date);
-	return;
+	uci->rev = val[1];
 }
 
-static int do_microcode_update (void)
+#ifdef CONFIG_MICROCODE_OLD_INTERFACE
+static void __user *user_buffer;	/* user area microcode data buffer */
+static unsigned int user_buffer_size;	/* it's size */
+
+static long get_next_ucode(void **mc, long offset)
 {
-	int i, error;
+	microcode_header_t mc_header;
+	unsigned long total_size;
 
-	if (on_each_cpu(collect_cpu_info, NULL, 1, 1) != 0) {
-		printk(KERN_ERR "microcode: Error! Could not run on all processors\n");
-		error = -EIO;
-		goto out;
+	/* No more data */
+	if (offset >= user_buffer_size)
+		return 0;
+	if (copy_from_user(&mc_header, user_buffer + offset, MC_HEADER_SIZE)) {
+		printk(KERN_ERR "microcode: error! Can not read user data\n");
+		return -EFAULT;
 	}
-
-	if ((error = find_matching_ucodes())) {
-		printk(KERN_ERR "microcode: Error in the microcode data\n");
-		goto out_free;
+	total_size = get_totalsize(&mc_header);
+	if ((offset + total_size > user_buffer_size)
+		|| (total_size < DEFAULT_UCODE_TOTALSIZE)) {
+		printk(KERN_ERR "microcode: error! Bad data in microcode "
+				"data file\n");
+		return -EINVAL;
+	}
+	*mc = vmalloc(total_size);
+	if (!*mc)
+		return -ENOMEM;
+	if (copy_from_user(*mc, user_buffer + offset, total_size)) {
+		printk(KERN_ERR "microcode: error! Can not read user data\n");
+		vfree(*mc);
+		return -EFAULT;
 	}
+	return offset + total_size;
+}
 
-	if (on_each_cpu(do_update_one, NULL, 1, 1) != 0) {
-		printk(KERN_ERR "microcode: Error! Could not run on all processors\n");
-		error = -EIO;
+static int do_microcode_update (void)
+{
+	long cursor = 0;
+	int error = 0;
+	void * new_mc;
+	int cpu;
+	cpumask_t old, applied;
+
+	cpus_clear(applied);
+	for_each_online_cpu(cpu) {
+		struct ucode_cpu_info *uci;
+
+		uci = ucode_cpu_info + cpu;
+		if (!uci->valid)
+			cpu_set(cpu, applied);
 	}
+	old = current->cpus_allowed;
 
-out_free:
-	for_each_online_cpu(i) {
-		if (ucode_cpu_info[i].mc) {
-			int j;
-			void *tmp = ucode_cpu_info[i].mc;
-			vfree(tmp);
-			for_each_online_cpu(j) {
-				if (ucode_cpu_info[j].mc == tmp)
-					ucode_cpu_info[j].mc = NULL;
+	while ((cursor = get_next_ucode(&new_mc, cursor)) > 0) {
+		error = microcode_sanity_check(new_mc);
+		if (error)
+			goto out;
+		for_each_online_cpu(cpu) {
+			if (cpu_isset(cpu, applied))
+				continue;
+			error = get_maching_microcode(new_mc, cpu);
+			if (error < 0)
+				goto out;
+			if (error == 1) {
+				set_cpus_allowed(current, cpumask_of_cpu(cpu));
+				apply_microcode(cpu);
+				cpu_set(cpu, applied);
 			}
 		}
+		if (cpus_equal(applied, cpu_online_map))
+			break;
+		vfree(new_mc);
 	}
 out:
+	if (cursor > 0)
+		vfree(new_mc);
+	if (cursor < 0)
+		error = cursor;
+	set_cpus_allowed(current, old);
 	return error;
 }
 
+static int microcode_open (struct inode *unused1, struct file *unused2)
+{
+	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
+}
+
 static ssize_t microcode_write (struct file *file, const char __user *buf, size_t len, loff_t *ppos)
 {
 	ssize_t ret;
@@ -445,6 +449,7 @@ static ssize_t microcode_write (struct f
 		return -EINVAL;
 	}
 
+	lock_cpu_hotplug();
 	mutex_lock(&microcode_mutex);
 
 	user_buffer = (void __user *) buf;
@@ -455,6 +460,7 @@ static ssize_t microcode_write (struct f
 		ret = (ssize_t)len;
 
 	mutex_unlock(&microcode_mutex);
+	unlock_cpu_hotplug();
 
 	return ret;
 }
@@ -472,7 +478,7 @@ static struct miscdevice microcode_dev =
 	.fops		= &microcode_fops,
 };
 
-static int __init microcode_init (void)
+static int __init microcode_dev_init (void)
 {
 	int error;
 
@@ -484,6 +490,297 @@ static int __init microcode_init (void)
 		return error;
 	}
 
+	return 0;
+}
+
+static void __exit microcode_dev_exit (void)
+{
+	misc_deregister(&microcode_dev);
+}
+
+MODULE_ALIAS_MISCDEV(MICROCODE_MINOR);
+#else
+#define microcode_dev_init() 0
+#define microcode_dev_exit() do { } while(0)
+#endif
+
+static long get_next_ucode_from_buffer(void **mc, void *buf,
+	unsigned long size, long offset)
+{
+	microcode_header_t *mc_header;
+	unsigned long total_size;
+
+	/* No more data */
+	if (offset >= size)
+		return 0;
+	mc_header = (microcode_header_t *)(buf + offset);
+	total_size = get_totalsize(mc_header);
+
+	if ((offset + total_size > size)
+		|| (total_size < DEFAULT_UCODE_TOTALSIZE)) {
+		printk(KERN_ERR "microcode: error! Bad data in microcode data file\n");
+		return -EINVAL;
+	}
+
+	*mc = vmalloc(total_size);
+	if (!*mc) {
+		printk(KERN_ERR "microcode: error! Can not allocate memory\n");
+		return -ENOMEM;
+	}
+	memcpy(*mc, buf + offset, total_size);
+	return offset + total_size;
+}
+
+static int cpu_request_microcode(int cpu)
+{
+	char name[30];
+	struct cpuinfo_x86 *c = cpu_data + cpu;
+	const struct firmware *firmware;
+	void * buf;
+	unsigned long size;
+	long offset = 0;
+	int error;
+	void *mc;
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+
+	/* We should bind the task to the CPU */
+	BUG_ON(cpu != raw_smp_processor_id());
+	sprintf(name,"intel-ucode/%02x-%02x-%02x",
+		c->x86, c->x86_model, c->x86_mask);
+	error = request_firmware_kobj(&firmware, name, &uci->kobj);
+	if (error) {
+		pr_debug("ucode data file %s load failed\n", name);
+		return error;
+	}
+	buf = (void *)firmware->data;
+	size = firmware->size;
+	while ((offset = get_next_ucode_from_buffer(&mc, buf, size, offset))
+			> 0) {
+		error = microcode_sanity_check(mc);
+		if (error)
+			break;
+		error = get_maching_microcode(mc, cpu);
+		if (error < 0)
+			break;
+		if (error == 1) {
+			apply_microcode(cpu);
+			error = 0;
+			break;
+		}
+		vfree(mc);
+	}
+	if (offset > 0)
+		vfree(mc);
+	if (offset < 0)
+		error = offset;
+	release_firmware(firmware);
+
+	return error;
+}
+
+static void microcode_init_cpu(int cpu)
+{
+	cpumask_t old;
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+
+	old = current->cpus_allowed;
+
+	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+	mutex_lock(&microcode_mutex);
+	collect_cpu_info(cpu);
+	if (uci->valid)
+		cpu_request_microcode(cpu);
+	mutex_unlock(&microcode_mutex);
+	set_cpus_allowed(current, old);
+}
+
+static void microcode_fini_cpu(int cpu)
+{
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+
+	mutex_lock(&microcode_mutex);
+	uci->valid = 0;
+	vfree(uci->mc);
+	uci->mc = NULL;
+	mutex_unlock(&microcode_mutex);
+}
+
+static ssize_t reload_store(struct ucode_cpu_info *uci,
+			    const char *buf, size_t sz)
+{
+	char *end;
+	unsigned long val = simple_strtoul(buf, &end, 0);
+	int err = 0;
+	int cpu = uci - ucode_cpu_info;
+
+	if (end == buf)
+		return -EINVAL;
+	if (val == 1) {
+		cpumask_t old;
+
+		old = current->cpus_allowed;
+
+		lock_cpu_hotplug();
+		set_cpus_allowed(current, cpumask_of_cpu(cpu));
+
+		mutex_lock(&microcode_mutex);
+		if (uci->valid)
+			err = cpu_request_microcode(cpu);
+		mutex_unlock(&microcode_mutex);
+		unlock_cpu_hotplug();
+		set_cpus_allowed(current, old);
+	}
+	if (err)
+		return err;
+	return sz;
+}
+
+static ssize_t version_show(struct ucode_cpu_info *uci, char *buf)
+{
+	return sprintf(buf, "0x%x\n", uci->rev);
+}
+
+struct mc_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct ucode_cpu_info *, char *);
+	ssize_t (*store)(struct ucode_cpu_info *, const char *, size_t);
+};
+#define to_uci(k) container_of(k, struct ucode_cpu_info, kobj)
+#define to_attr(a) container_of(a, struct mc_attr, attr)
+
+static struct mc_attr attr_reload = __ATTR(reload, 0200, NULL, reload_store);
+static struct mc_attr attr_version = __ATTR(version, 0400, version_show, NULL);
+static struct attribute * mc_default_attrs[] = {
+	&attr_reload.attr,
+	&attr_version.attr,
+	NULL
+};
+
+static ssize_t mc_sysfs_show(struct kobject *kobj, struct attribute *attr,
+			     char *buf)
+{
+	struct ucode_cpu_info *uci = to_uci(kobj);
+	struct mc_attr *mca = to_attr(attr);
+
+	if (mca->show)
+		return mca->show(uci, buf);
+	return -EIO;
+}
+
+static ssize_t mc_sysfs_store(struct kobject *kobj, struct attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct ucode_cpu_info *uci = to_uci(kobj);
+	struct mc_attr *mca = to_attr(attr);
+
+	if (mca->store)
+		return mca->store(uci, buf, count);
+	return -EIO;
+}
+
+static struct sysfs_ops mc_sysfs_ops = {
+	.show = mc_sysfs_show,
+	.store = mc_sysfs_store,
+};
+
+static struct kobj_type mc_kobj_type = {
+	.sysfs_ops = &mc_sysfs_ops,
+	.default_attrs = mc_default_attrs,
+};
+
+static int mc_sysdev_add(struct sys_device *sys_dev)
+{
+	int err;
+	int cpu = sys_dev->id;
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+
+	if (!cpu_online(cpu))
+		return 0;
+	pr_debug("Microcode:CPU %d added\n", cpu);
+	memset(uci, 0, sizeof(*uci));
+	uci->kobj.parent = &sys_dev->kobj;
+	kobject_set_name(&uci->kobj, "%s", "microcode");
+	uci->kobj.ktype = &mc_kobj_type;
+	err = kobject_register(&uci->kobj);
+	if (err)
+		return err;
+
+	microcode_init_cpu(cpu);
+	return err;
+}
+
+static int mc_sysdev_remove(struct sys_device *sys_dev)
+{
+	int cpu = sys_dev->id;
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+
+	if (!cpu_online(cpu))
+		return 0;
+	pr_debug("Microcode:CPU %d removed\n", cpu);
+	microcode_fini_cpu(cpu);
+	kobject_unregister(&uci->kobj);
+	return 0;
+}
+
+static int mc_sysdev_resume(struct sys_device *dev)
+{
+	int cpu = dev->id;
+
+	if (!cpu_online(cpu))
+		return 0;
+	pr_debug("Microcode:CPU %d resumed\n", cpu);
+	/* only CPU 0 will apply ucode here */
+	apply_microcode(0);
+	return 0;
+}
+
+static struct sysdev_driver mc_sysdev_driver = {
+	.add = mc_sysdev_add,
+	.remove = mc_sysdev_remove,
+	.resume = mc_sysdev_resume,
+};
+
+static __cpuinit int
+mc_cpu_callback(struct notifier_block *nb, unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+	struct sys_device *sys_dev;
+
+	sys_dev = get_cpu_sysdev(cpu);
+	switch (action) {
+	case CPU_ONLINE:
+	case CPU_DOWN_FAILED:
+		mc_sysdev_add(sys_dev);
+		break;
+	case CPU_DOWN_PREPARE:
+		mc_sysdev_remove(sys_dev);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block mc_cpu_notifier = {
+	.notifier_call = mc_cpu_callback,
+};
+
+static int __init microcode_init (void)
+{
+	int error;
+
+	error = microcode_dev_init();
+	if (error)
+		return error;
+
+	lock_cpu_hotplug();
+	error = sysdev_driver_register(&cpu_sysdev_class, &mc_sysdev_driver);
+	unlock_cpu_hotplug();
+	if (error) {
+		microcode_dev_exit();
+		return error;
+	}
+
+	register_cpu_notifier(&mc_cpu_notifier);
+
 	printk(KERN_INFO 
 		"IA-32 Microcode Update Driver: v" MICROCODE_VERSION " <tigran@veritas.com>\n");
 	return 0;
@@ -491,9 +788,14 @@ static int __init microcode_init (void)
 
 static void __exit microcode_exit (void)
 {
-	misc_deregister(&microcode_dev);
+	microcode_dev_exit();
+
+	unregister_cpu_notifier(&mc_cpu_notifier);
+
+	lock_cpu_hotplug();
+	sysdev_driver_unregister(&cpu_sysdev_class, &mc_sysdev_driver);
+	unlock_cpu_hotplug();
 }
 
 module_init(microcode_init)
 module_exit(microcode_exit)
-MODULE_ALIAS_MISCDEV(MICROCODE_MINOR);
diff -puN arch/i386/Kconfig~ucode_rewrite arch/i386/Kconfig
--- linux-2.6.17-rc4/arch/i386/Kconfig~ucode_rewrite	2006-05-24 08:16:11.000000000 +0800
+++ linux-2.6.17-rc4-root/arch/i386/Kconfig	2006-05-24 08:18:00.000000000 +0800
@@ -389,6 +389,11 @@ config MICROCODE
 	  To compile this driver as a module, choose M here: the
 	  module will be called microcode.
 
+config MICROCODE_OLD_INTERFACE
+	bool
+	depends on MICROCODE
+	default y
+
 config X86_MSR
 	tristate "/dev/cpu/*/msr - Model-specific register support"
 	help
diff -puN arch/x86_64/Kconfig~ucode_rewrite arch/x86_64/Kconfig
--- linux-2.6.17-rc4/arch/x86_64/Kconfig~ucode_rewrite	2006-05-24 08:18:12.000000000 +0800
+++ linux-2.6.17-rc4-root/arch/x86_64/Kconfig	2006-05-24 08:19:14.000000000 +0800
@@ -166,6 +166,11 @@ config MICROCODE
 	  If you use modprobe or kmod you may also want to add the line
 	  'alias char-major-10-184 microcode' to your /etc/modules.conf file.
 
+config MICROCODE_OLD_INTERFACE
+	bool
+	depends on MICROCODE
+	default y
+
 config X86_MSR
 	tristate "/dev/cpu/*/msr - Model-specific register support"
 	help
_
