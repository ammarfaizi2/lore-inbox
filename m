Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbWGJMrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWGJMrQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 08:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWGJMrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 08:47:15 -0400
Received: from outbound-res.frontbridge.com ([63.161.60.49]:47558 "EHLO
	outbound1-res-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1161007AbWGJMrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 08:47:13 -0400
X-BigFish: V
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Subject: RE: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
From: "Joachim Deguara" <joachim.deguara@amd.com>
To: "Langsdorf, Mark" <mark.langsdorf@amd.com>
cc: ak@suse.de, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       cpufreq@lists.linux.org.uk
In-Reply-To: <84EA05E2CA77634C82730353CBE3A84303218E99@SAUSEXMB1.amd.com>
References: <84EA05E2CA77634C82730353CBE3A84303218E99@SAUSEXMB1.amd.com>
Date: Mon, 10 Jul 2006 14:45:55 +0200
Message-ID: <1152535555.4897.16.camel@lapdog.site>
MIME-Version: 1.0
X-Mailer: Evolution 2.6.0
X-OriginalArrivalTime: 10 Jul 2006 12:46:22.0694 (UTC)
 FILETIME=[D9380860:01C6A41E]
X-WSS-ID: 68AC93A92UK849211-01-01
Content-Type: multipart/mixed;
 boundary="=-bPp9qvWDkclka1MSEgdL"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bPp9qvWDkclka1MSEgdL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-07-07 at 12:36 -0500, Langsdorf, Mark wrote: 
> > Your patch seems to be ^M damaged.
> 
> I'll smack my mailer around again.  Sorry about that.

revised patch attached (also corrected tscsync qualifier and initial
state of req_state).

> > I'm still dubious if the result is really correct if the 
> > hardware wasn't designed to guarantee synchronous TSC operation.
> > 
> > Can you do the following test please? 
> 
> We'll try to have the results back by Monday evening.

may have to wait till Tuesday for my results.

-joachim

--=-bPp9qvWDkclka1MSEgdL
Content-Disposition: attachment;
 filename=2.6.18-rc1-pntscsync.patch
Content-Type: text/x-patch;
 charset=utf-8;
 name=2.6.18-rc1-pntscsync.patch
Content-Transfer-Encoding: 7bit

--- arch/i386/kernel/cpu/cpufreq/powernow-k8.c.orig	2006-07-10 13:25:47.000000000 +0200
+++ arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2006-07-10 14:15:37.000000000 +0200
@@ -46,13 +46,15 @@
 
 #define PFX "powernow-k8: "
 #define BFX PFX "BIOS error: "
-#define VERSION "version 2.00.00"
+#define VERSION "version 2.10.00"
 #include "powernow-k8.h"
 
 /* serialize freq changes  */
 static DEFINE_MUTEX(fidvid_mutex);
 
 static struct powernow_k8_data *powernow_data[NR_CPUS];
+static int *req_state = NULL;
+static int tscsync = 0;
 
 static int cpu_family = CPU_OPTERON;
 
@@ -205,6 +207,17 @@ static int write_new_fid(struct powernow
 	dprintk("writing fid 0x%x, lo 0x%x, hi 0x%x\n",
 		fid, lo, data->plllock * PLL_LOCK_CONVERSION);
 
+	if (tscsync) {
+		int i;
+		cpumask_t oldmask = current->cpus_allowed;
+		for_each_online_cpu(i) {
+			set_cpus_allowed(current, cpumask_of_cpu(i));
+			schedule();
+			wrmsr(MSR_FIDVID_CTL, lo & ~MSR_C_LO_INIT_FID_VID, data->plllock * PLL_LOCK_CONVERSION);
+		}
+		set_cpus_allowed(current, oldmask);
+		schedule();
+	}
 	do {
 		wrmsr(MSR_FIDVID_CTL, lo, data->plllock * PLL_LOCK_CONVERSION);
 		if (i++ > 100) {
@@ -247,6 +260,17 @@ static int write_new_vid(struct powernow
 	dprintk("writing vid 0x%x, lo 0x%x, hi 0x%x\n",
 		vid, lo, STOP_GRANT_5NS);
 
+	if (tscsync) {
+		int i;
+		cpumask_t oldmask = current->cpus_allowed;
+		for_each_online_cpu(i) {
+			set_cpus_allowed(current, cpumask_of_cpu(i));
+			schedule();
+			wrmsr(MSR_FIDVID_CTL, lo & ~MSR_C_LO_INIT_FID_VID, STOP_GRANT_5NS);
+		}
+		set_cpus_allowed(current, oldmask);
+		schedule();
+	}
 	do {
 		wrmsr(MSR_FIDVID_CTL, lo, STOP_GRANT_5NS);
 		if (i++ > 100) {
@@ -386,7 +410,8 @@ static int core_frequency_transition(str
 	}
 
 	if (data->currfid == reqfid) {
-		printk(KERN_ERR PFX "ph2 null fid transition 0x%x\n", data->currfid);
+		if (!tscsync)
+			printk(KERN_ERR PFX "ph2 null fid transition 0x%x\n", data->currfid);
 		return 0;
 	}
 
@@ -960,9 +985,21 @@ static int transition_frequency_fidvid(s
 	u32 vid = 0;
 	int res, i;
 	struct cpufreq_freqs freqs;
+	cpumask_t changing_cores;
 
 	dprintk("cpu %d transition to index %u\n", smp_processor_id(), index);
 
+	/* if all processors are transitioning in step, find the highest
+	 * current state and go to that
+         */
+
+	if (tscsync && req_state) {
+		req_state[smp_processor_id()] = index;
+		for_each_online_cpu(i) 
+			if (req_state[i] < index)
+				index = req_state[i];
+	}
+
 	/* fid/vid correctness check for k8 */
 	/* fid are the lower 8 bits of the index we stored into
 	 * the cpufreq frequency table in find_psb_table, vid
@@ -983,6 +1020,8 @@ static int transition_frequency_fidvid(s
 	}
 
 	if ((fid < HI_FID_TABLE_BOTTOM) && (data->currfid < HI_FID_TABLE_BOTTOM)) {
+		if (tscsync && (data->currfid == fid))
+			return 0;
 		printk(KERN_ERR PFX
 		       "ignoring illegal change in lo freq table-%x to 0x%x\n",
 		       data->currfid, fid);
@@ -994,7 +1033,11 @@ static int transition_frequency_fidvid(s
 	freqs.old = find_khz_freq_from_fid(data->currfid);
 	freqs.new = find_khz_freq_from_fid(fid);
 
-	for_each_cpu_mask(i, *(data->available_cores)) {
+	if (tscsync)
+		changing_cores = cpu_online_map;
+	else
+		changing_cores = *(data->available_cores);
+	for_each_cpu_mask(i, changing_cores) {
 		freqs.cpu = i;
 		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 	}
@@ -1002,10 +1045,16 @@ static int transition_frequency_fidvid(s
 	res = transition_fid_vid(data, fid, vid);
 	freqs.new = find_khz_freq_from_fid(data->currfid);
 
-	for_each_cpu_mask(i, *(data->available_cores)) {
+	for_each_cpu_mask(i, changing_cores) {
 		freqs.cpu = i;
 		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 	}
+	if (tscsync) 
+		for_each_online_cpu(i)
+			if (powernow_data[i]) {
+				powernow_data[i]->currfid = data->currfid;
+				powernow_data[i]->currvid = data->currvid;
+			}
 	return res;
 }
 
@@ -1054,7 +1103,7 @@ static int powernowk8_target(struct cpuf
 	u32 checkfid;
 	u32 checkvid;
 	unsigned int newstate;
-	int ret = -EIO;
+	int ret = 0;//-EIO;
 
 	if (!data)
 		return -EINVAL;
@@ -1089,7 +1138,7 @@ static int powernowk8_target(struct cpuf
 		dprintk("targ: curr fid 0x%x, vid 0x%x\n",
 		data->currfid, data->currvid);
 
-		if ((checkvid != data->currvid) || (checkfid != data->currfid)) {
+		if (!tscsync && ((checkvid != data->currvid) || (checkfid != data->currfid))) {
 			printk(KERN_INFO PFX
 				"error - out of sync, fix 0x%x 0x%x, vid 0x%x 0x%x\n",
 				checkfid, data->currfid, checkvid, data->currvid);
@@ -1100,7 +1149,6 @@ static int powernowk8_target(struct cpuf
 		goto err_out;
 
 	mutex_lock(&fidvid_mutex);
-
 	powernow_k8_acpi_pst_values(data, newstate);
 
 	if (cpu_family == CPU_HW_PSTATE)
@@ -1137,6 +1185,32 @@ static int powernowk8_verify(struct cpuf
 	return cpufreq_frequency_table_verify(pol, data->powernow_table);
 }
 
+/* On an MP system that is transitioning all cores in sync, adjust the
+ * vids for each frequency to the highest.  Otherwise, systems made up
+ * of different steppings may fail.
+ */
+static void sync_tables(int curcpu)
+{
+	int j;
+	for (j = 0; j < powernow_data[curcpu]->numps; j++) {
+		int i;
+		int maxvid = 0;
+		for_each_online_cpu(i) {
+			int testvid;
+			if (!powernow_data[i] || !powernow_data[i]->powernow_table)
+				continue;
+			testvid = powernow_data[i]->powernow_table[j].index & 0xff00;
+			if (testvid > maxvid)
+				maxvid = testvid;
+		}	
+		for_each_online_cpu(i) {
+			if (!powernow_data[i] || ! powernow_data[i]->powernow_table)
+				continue;
+			powernow_data[i]->powernow_table[j].index &= 0xff;
+			powernow_data[i]->powernow_table[j].index |= maxvid;
+		}
+	}
+}
 /* per CPU init entry point to the driver */
 static int __cpuinit powernowk8_cpu_init(struct cpufreq_policy *pol)
 {
@@ -1241,6 +1315,8 @@ static int __cpuinit powernowk8_cpu_init
 
 	powernow_data[pol->cpu] = data;
 
+	if (tscsync && (cpu_family == CPU_OPTERON))
+		sync_tables(pol->cpu);
 	return 0;
 
 err_out:
@@ -1323,6 +1399,16 @@ static int __cpuinit powernowk8_init(voi
 	}
 
 	if (supported_cpus == num_online_cpus()) {
+		if (tscsync) {
+			req_state = kalloc(sizeof(int)*NR_CPUS, GFP_KERNEL);
+			if (!req_state) {
+				printk(KERN_ERR PFX "Unable to allocate memory!\n");
+				return -ENOMEM;
+			}
+			//necessary for dual-cores (99=just a large number)
+			for(i=0; i < NR_CPUS; i++)
+			    req_state[i] = 99;
+		}
 		printk(KERN_INFO PFX "Found %d %s "
 			"processors (" VERSION ")\n", supported_cpus,
 			boot_cpu_data.x86_model_id);
@@ -1337,6 +1423,9 @@ static void __exit powernowk8_exit(void)
 {
 	dprintk("exit\n");
 
+	if (tscsync)
+		kfree(req_state);
+
 	cpufreq_unregister_driver(&cpufreq_amd64_driver);
 }
 
@@ -1346,3 +1435,6 @@ MODULE_LICENSE("GPL");
 
 late_initcall(powernowk8_init);
 module_exit(powernowk8_exit);
+
+module_param(tscsync, int, 0);
+MODULE_PARM_DESC(tscsync, "enable tsc by synchronizing powernow-k8 changes");

--=-bPp9qvWDkclka1MSEgdL--


