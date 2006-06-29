Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751755AbWF2IVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbWF2IVH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 04:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWF2IVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 04:21:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:65041 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751755AbWF2IVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 04:21:04 -0400
X-IronPort-AV: i="4.06,190,1149490800"; 
   d="scan'208"; a="58367822:sNHT632901444"
Subject: Re: [PATCH]microcode update driver rewrite - takes 2
From: Shaohua Li <shaohua.li@intel.com>
To: jbeulich@novell.com, Greg KH <greg@kroah.com>
Cc: arjan <arjan@linux.intel.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Shah, Rajesh" <rajesh.shah@intel.com>,
       Tigran Aivazian <tigran@veritas.com>
In-Reply-To: <1151396103.21189.75.camel@sli10-desk.sh.intel.com>
References: <1151376693.21189.52.camel@sli10-desk.sh.intel.com>
	 <20060627060214.GA27469@kroah.com>
	 <1151396103.21189.75.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 16:18:39 +0800
Message-Id: <1151569119.21189.106.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 16:15 +0800, Shaohua Li wrote:
> On Mon, 2006-06-26 at 23:02 -0700, Greg KH wrote: 
> > On Tue, Jun 27, 2006 at 10:51:33AM +0800, Shaohua Li wrote: 
> > > This is the rewrite of microcode update driver. Changes: 
> > > 1. trim the code 
> > > 2. using request_firmware to pull ucode from userspace, so we
> don't need 
> > > the application 'microcode_ctl' to assist. We name each ucode
> file 
> > > according to CPU's info as intel-ucode/family-model-stepping. In
> this 
> > > way we could split ucode file as small one. This has a lot of
> advantages 
> > > such as selectively update and validate microcode for specific
> models, 
> > > better manage microcode file, easily write tools for
> administerators and 
> > > so on. 
> > > 3. add sysfs support. Currently each CPU has two microcode
> related 
> > > attributes. One is 'version' which shows current ucode version of
> CPU. 
> > > Tools can use the attribute do validation or show CPU ucode
> status. The 
> > > other is 'reload' which allows manually reloading ucode.  
> > > 4. add suspend/resume and CPU hotplug support.  
> >  
> > Why not break this up into 4 patches so we can better review them? 
> >  
> > Remember, one patch per change please :) 
> Ok, I split it to three patches (3 & 4 could be in one patch) 
> >  
> > > With the changes, we should put all intel-ucode/xx-xx-xx microcode
> files 
> > > into the firmware dir (I had a tool to split previous big data
> file into 
> > > small one and later we will release new style data file). The
> init 
> > > script should be changed to just loading the driver without
> unloading 
> > > for hotplug and suspend/resume (for back compatibility I keep old 
> > > interface, so old init script also works). 
> > >  
> > > Previous post is at 
> > >
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114852925121064&w=2 
> > > Changes against previous patch: 
> > > 1. use sys_create_group to add attributes 
> > > 2. add a fake platform_device for reqeust_firmware as Greg
> disliked the 
> > > request_firmware_kobj interface previous patch introduced 
> > > 3. add a new attribute 'pf' to help tools check if CPU has latest
> ucode 
> >  
> > What does "pf" stand for? 
> processor flags. I changed it to processor_flags in next path.
Andrew, this one can be applied in latest -mm. Other two patches can
still apply.
Jan, I saw you added some printk in microcode.c recently. I removed it
as we could export CPU's microcode version in sysfs. If you really
needed it I can added it.

[PATCH 1/3] trim microcode driver to make it clean. Old interface is 
kept.

Signed-off-by: Shaohua Li <shaohua.li@intel.com> 
Acked-by: Tigran Aivazian <tigran@veritas.com>
---
 arch/i386/Kconfig            |    5 
 arch/i386/kernel/microcode.c |  519 +++++++++++++++++++++----------------------
 arch/x86_64/Kconfig          |    5 
 3 files changed, 266 insertions(+), 263 deletions(-)

Index: linux-2.6.17-mm3/arch/i386/Kconfig
===================================================================
--- linux-2.6.17-mm3.orig/arch/i386/Kconfig	2006-06-28 13:43:38.000000000 +0800
+++ linux-2.6.17-mm3/arch/i386/Kconfig	2006-06-28 13:47:45.000000000 +0800
@@ -415,6 +415,11 @@ config MICROCODE
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
Index: linux-2.6.17-mm3/arch/i386/kernel/microcode.c
===================================================================
--- linux-2.6.17-mm3.orig/arch/i386/kernel/microcode.c	2006-06-28 13:43:38.000000000 +0800
+++ linux-2.6.17-mm3/arch/i386/kernel/microcode.c	2006-06-28 14:01:48.000000000 +0800
@@ -2,6 +2,7 @@
  *	Intel CPU Microcode Update Driver for Linux
  *
  *	Copyright (C) 2000-2004 Tigran Aivazian
+ *		      2006	Shaohua Li <shaohua.li@intel.com>
  *
  *	This driver allows to upgrade microcode on Intel processors
  *	belonging to IA-32 family - PentiumPro, Pentium II, 
@@ -91,9 +92,6 @@ MODULE_DESCRIPTION("Intel CPU (IA-32) Mi
 MODULE_AUTHOR("Tigran Aivazian <tigran@veritas.com>");
 MODULE_LICENSE("GPL");
 
-static int verbose;
-module_param(verbose, int, 0644);
-
 #define MICROCODE_VERSION 	"1.14a"
 
 #define DEFAULT_UCODE_DATASIZE 	(2000) 	  /* 2000 bytes */
@@ -120,55 +118,40 @@ static DEFINE_SPINLOCK(microcode_update_
 /* no concurrent ->write()s are allowed on /dev/cpu/microcode */
 static DEFINE_MUTEX(microcode_mutex);
 
-static void __user *user_buffer;	/* user area microcode data buffer */
-static unsigned int user_buffer_size;	/* it's size */
-
-typedef enum mc_error_code {
-	MC_SUCCESS 	= 0,
-	MC_IGNORED 	= 1,
-	MC_NOTFOUND 	= 2,
-	MC_MARKED 	= 3,
-	MC_ALLOCATED 	= 4,
-} mc_error_code_t;
-
 static struct ucode_cpu_info {
+	int valid;
 	unsigned int sig;
-	unsigned int pf, orig_pf;
+	unsigned int pf;
 	unsigned int rev;
-	unsigned int cksum;
-	mc_error_code_t err;
 	microcode_t *mc;
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
-		uci->orig_pf = uci->pf;
+	uci->sig = cpuid_eax(0x00000001);
+
+	if ((c->x86_model >= 5) || (c->x86 > 6)) {
+		/* get processor flags from MSR 0x17 */
+		rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
+		uci->pf = 1 << ((val[1] >> 18) & 7);
 	}
 
 	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
@@ -180,218 +163,161 @@ static void collect_cpu_info (void *unus
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
-		if (uci->err == MC_NOTFOUND) {
-			uci->err = MC_IGNORED;
-			uci->cksum = mc_header->rev;
-		} else if (uci->err == MC_IGNORED && uci->cksum < mc_header->rev)
-			uci->cksum = mc_header->rev;
-	} else if (mc_header->rev == uci->rev) {
-		if (uci->err < MC_MARKED) {
-			/* notify the caller of success on this cpu */
-			uci->err = MC_SUCCESS;
-		}
-	} else if (uci->err != MC_ALLOCATED || mc_header->rev > uci->mc->hdr.rev) {
-		pr_debug("microcode: CPU%d found a matching microcode update with "
-			" revision 0x%x (current=0x%x)\n", cpu_num, mc_header->rev, uci->rev);
-		uci->cksum = cksum;
-		uci->pf = pf; /* keep the original mc pf for cksum calculation */
-		uci->err = MC_MARKED; /* found the match */
-		for_each_online_cpu(cpu_num) {
-			if (ucode_cpu_info + cpu_num != uci
-			    && ucode_cpu_info[cpu_num].mc == uci->mc) {
-				uci->mc = NULL;
-				break;
-			}
-		}
-		if (uci->mc != NULL) {
-			vfree(uci->mc);
-			uci->mc = NULL;
-		}
-	}
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
-
-		total_size = get_totalsize(&mc_header);
-		if ((cursor + total_size > user_buffer_size) || (total_size < DEFAULT_UCODE_TOTALSIZE)) {
-			printk(KERN_ERR "microcode: error! Bad data in microcode data file\n");
-			error = -EINVAL;
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
+			"Bad data size in microcode data file\n");
+		return -EINVAL;
+	}
 
-		data_size = get_datasize(&mc_header);
-		if ((data_size + MC_HEADER_SIZE > total_size) || (data_size < DEFAULT_UCODE_DATASIZE)) {
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
+				"Small exttable size in microcode data file\n");
+			return -EINVAL;
+		}
+		ext_header = mc + MC_HEADER_SIZE + data_size;
+		if (ext_table_size != exttable_size(ext_header)) {
+			printk(KERN_ERR "microcode: error! "
+				"Bad exttable size in microcode data file\n");
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
-
-			if (sigmatch(mc_header.sig, uci->sig, mc_header.pf, uci->orig_pf))
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
-
-					if (sigmatch(ext_sig.sig, uci->sig, ext_sig.pf, uci->orig_pf)) {
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
-		if (verbose) {
-			if (uci->err == MC_SUCCESS)
-				printk(KERN_INFO "microcode: CPU%d already at revision 0x%x\n",
-					cpu_num, uci->rev);
-			else
-				printk(KERN_INFO "microcode: No new microcode data for CPU%d\n", cpu_num);
-		}
+	/* We should bind the task to the CPU */
+	BUG_ON(cpu_num != cpu);
+
+	if (uci->mc == NULL)
 		return;
-	}
 
 	/* serialize access to the physical write to MSR 0x79 */
 	spin_lock_irqsave(&microcode_update_lock, flags);          
@@ -408,54 +334,98 @@ static void do_update_one (void * unused
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
-	}
-
-	if ((error = find_matching_ucodes())) {
-		printk(KERN_ERR "microcode: Error in the microcode data\n");
-		goto out_free;
-	}
-
-	if (on_each_cpu(do_update_one, NULL, 1, 1) != 0) {
-		printk(KERN_ERR "microcode: Error! Could not run on all processors\n");
-		error = -EIO;
-	}
-
-out_free:
-	for_each_online_cpu(i) {
-		if (ucode_cpu_info[i].mc) {
-			int j;
-			void *tmp = ucode_cpu_info[i].mc;
-			vfree(tmp);
-			for_each_online_cpu(j) {
-				if (ucode_cpu_info[j].mc == tmp)
-					ucode_cpu_info[j].mc = NULL;
-			}
+	/* No more data */
+	if (offset >= user_buffer_size)
+		return 0;
+	if (copy_from_user(&mc_header, user_buffer + offset, MC_HEADER_SIZE)) {
+		printk(KERN_ERR "microcode: error! Can not read user data\n");
+		return -EFAULT;
+	}
+	total_size = get_totalsize(&mc_header);
+	if ((offset + total_size > user_buffer_size)
+		|| (total_size < DEFAULT_UCODE_TOTALSIZE)) {
+		printk(KERN_ERR "microcode: error! Bad total size in microcode "
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
+	}
+	return offset + total_size;
+}
+
+static int do_microcode_update (void)
+{
+	long cursor = 0;
+	int error = 0;
+	void * new_mc;
+	int cpu;
+	cpumask_t old;
+
+	old = current->cpus_allowed;
+
+	while ((cursor = get_next_ucode(&new_mc, cursor)) > 0) {
+		error = microcode_sanity_check(new_mc);
+		if (error)
+			goto out;
+		/*
+		 * It's possible the data file has multiple matching ucode,
+		 * lets keep searching till the latest version
+		 */
+		for_each_online_cpu(cpu) {
+			struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+
+			if (!uci->valid)
+				continue;
+			set_cpus_allowed(current, cpumask_of_cpu(cpu));
+			error = get_maching_microcode(new_mc, cpu);
+			if (error < 0)
+				goto out;
+			if (error == 1)
+				apply_microcode(cpu);
 		}
-		if (ucode_cpu_info[i].err == MC_IGNORED && verbose)
-			printk(KERN_WARNING "microcode: CPU%d not 'upgrading' to earlier revision"
-			       " 0x%x (current=0x%x)\n", i, ucode_cpu_info[i].cksum, ucode_cpu_info[i].rev);
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
@@ -470,6 +440,7 @@ static ssize_t microcode_write (struct f
 		return -EINVAL;
 	}
 
+	lock_cpu_hotplug();
 	mutex_lock(&microcode_mutex);
 
 	user_buffer = (void __user *) buf;
@@ -480,6 +451,7 @@ static ssize_t microcode_write (struct f
 		ret = (ssize_t)len;
 
 	mutex_unlock(&microcode_mutex);
+	unlock_cpu_hotplug();
 
 	return ret;
 }
@@ -497,7 +469,7 @@ static struct miscdevice microcode_dev =
 	.fops		= &microcode_fops,
 };
 
-static int __init microcode_init (void)
+static int __init microcode_dev_init (void)
 {
 	int error;
 
@@ -509,6 +481,28 @@ static int __init microcode_init (void)
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
+static int __init microcode_init (void)
+{
+	int error;
+
+	error = microcode_dev_init();
+	if (error)
+		return error;
+
 	printk(KERN_INFO 
 		"IA-32 Microcode Update Driver: v" MICROCODE_VERSION " <tigran@veritas.com>\n");
 	return 0;
@@ -516,9 +510,8 @@ static int __init microcode_init (void)
 
 static void __exit microcode_exit (void)
 {
-	misc_deregister(&microcode_dev);
+	microcode_dev_exit();
 }
 
 module_init(microcode_init)
 module_exit(microcode_exit)
-MODULE_ALIAS_MISCDEV(MICROCODE_MINOR);
Index: linux-2.6.17-mm3/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.17-mm3.orig/arch/x86_64/Kconfig	2006-06-28 13:43:38.000000000 +0800
+++ linux-2.6.17-mm3/arch/x86_64/Kconfig	2006-06-28 13:47:45.000000000 +0800
@@ -174,6 +174,11 @@ config MICROCODE
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

