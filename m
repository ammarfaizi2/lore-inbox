Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264406AbUEDOtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264406AbUEDOtH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 10:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbUEDOsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 10:48:22 -0400
Received: from fmr03.intel.com ([143.183.121.5]:36743 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S264407AbUEDOqp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 10:46:45 -0400
Date: Tue, 4 May 2004 07:46:32 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, davidm@hpl.hp.com, pj@sgi.com, linux-ia64@vger.kernel.org,
       rusty@rustycorp.com.au
Subject: take3: Updated CPU Hotplug patches for IA64 (pj blessed) Patch [5/7]
Message-ID: <20040504074632.E1909@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Name: ia64_palinfo.patch
Author: Ashok Raj (Intel Corporation)
Status: Tested with Hotplug CPU Code

D: Changes proc entries for cpu hotplug to be created via the cpu 
D: hotplug notifier callbacks. Also fixed a bug in the removal code
D: that did not remove proc entries as expected.


---

 linux-2.6.5-lhcs-root/arch/ia64/kernel/palinfo.c |  134 +++++++++++++++++------
 1 files changed, 104 insertions(+), 30 deletions(-)

diff -puN arch/ia64/kernel/palinfo.c~ia64_palinfo arch/ia64/kernel/palinfo.c
--- linux-2.6.5-lhcs/arch/ia64/kernel/palinfo.c~ia64_palinfo	2004-05-03 16:30:57.418048224 -0700
+++ linux-2.6.5-lhcs-root/arch/ia64/kernel/palinfo.c	2004-05-03 16:30:57.420001350 -0700
@@ -8,11 +8,14 @@
  *
  * Copyright (C) 2000-2001, 2003 Hewlett-Packard Co
  *	Stephane Eranian <eranian@hpl.hp.com>
+ * Copyright (C) 2004 Intel Corporation
+ *  Ashok Raj <ashok.raj@intel.com>
  *
  * 05/26/2000	S.Eranian	initial release
  * 08/21/2000	S.Eranian	updated to July 2000 PAL specs
  * 02/05/2001   S.Eranian	fixed module support
  * 10/23/2001	S.Eranian	updated pal_perf_mon_info bug fixes
+ * 03/24/2004	Ashok Raj	updated to work with CPU Hotplug
  */
 #include <linux/config.h>
 #include <linux/types.h>
@@ -22,6 +25,9 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/efi.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
 
 #include <asm/pal.h>
 #include <asm/sal.h>
@@ -768,13 +774,12 @@ static palinfo_entry_t palinfo_entries[]
  * does not do recursion of deletion
  *
  * Notes:
- *	- first +1 accounts for the cpuN entry
- *	- second +1 account for toplevel palinfo
- *
+ *	- +1 accounts for the cpuN directory entry in /proc/pal
  */
-#define NR_PALINFO_PROC_ENTRIES	(NR_CPUS*(NR_PALINFO_ENTRIES+1)+1)
+#define NR_PALINFO_PROC_ENTRIES	(NR_CPUS*(NR_PALINFO_ENTRIES+1))
 
 static struct proc_dir_entry *palinfo_proc_entries[NR_PALINFO_PROC_ENTRIES];
+static struct proc_dir_entry *palinfo_dir;
 
 /*
  * This data structure is used to pass which cpu,function is being requested
@@ -888,47 +893,107 @@ palinfo_read_entry(char *page, char **st
 	return len;
 }
 
-static int __init
-palinfo_init(void)
+static void
+create_palinfo_proc_entries(unsigned int cpu)
 {
 #	define CPUSTR	"cpu%d"
 
 	pal_func_cpu_u_t f;
-	struct proc_dir_entry **pdir = palinfo_proc_entries;
-	struct proc_dir_entry *palinfo_dir, *cpu_dir;
-	int i, j;
+	struct proc_dir_entry **pdir;
+	struct proc_dir_entry *cpu_dir;
+	int j;
 	char cpustr[sizeof(CPUSTR)];
 
-	printk(KERN_INFO "PAL Information Facility v%s\n", PALINFO_VERSION);
-
-	palinfo_dir = proc_mkdir("pal", NULL);
 
 	/*
 	 * we keep track of created entries in a depth-first order for
 	 * cleanup purposes. Each entry is stored into palinfo_proc_entries
 	 */
-	for (i=0; i < NR_CPUS; i++) {
+	sprintf(cpustr,CPUSTR, cpu);
 
-		if (!cpu_online(i)) continue;
+	cpu_dir = proc_mkdir(cpustr, palinfo_dir);
 
-		sprintf(cpustr,CPUSTR, i);
+	f.req_cpu = cpu;
 
-		cpu_dir = proc_mkdir(cpustr, palinfo_dir);
+	/*
+	 * Compute the location to store per cpu entries
+	 * We dont store the top level entry in this list, but
+	 * remove it finally after removing all cpu entries.
+	 */
+	pdir = &palinfo_proc_entries[cpu*(NR_PALINFO_ENTRIES+1)];
+	*pdir++ = cpu_dir;
+	for (j=0; j < NR_PALINFO_ENTRIES; j++) {
+		f.func_id = j;
+		*pdir = create_proc_read_entry(
+				palinfo_entries[j].name, 0, cpu_dir,
+				palinfo_read_entry, (void *)f.value);
+		if (*pdir)
+			(*pdir)->owner = THIS_MODULE;
+		pdir++;
+	}
+}
 
-		f.req_cpu = i;
+static void
+remove_palinfo_proc_entries(unsigned int hcpu)
+{
+	int j;
+	struct proc_dir_entry *cpu_dir, **pdir;
 
-		for (j=0; j < NR_PALINFO_ENTRIES; j++) {
-			f.func_id = j;
-			*pdir = create_proc_read_entry(
-					palinfo_entries[j].name, 0, cpu_dir,
-					palinfo_read_entry, (void *)f.value);
-			if (*pdir)
-				(*pdir)->owner = THIS_MODULE;
-			pdir++;
+	pdir = &palinfo_proc_entries[hcpu*(NR_PALINFO_ENTRIES+1)];
+	cpu_dir = *pdir;
+	*pdir++=NULL;
+	for (j=0; j < (NR_PALINFO_ENTRIES); j++) {
+		if ((*pdir)) {
+			remove_proc_entry ((*pdir)->name, cpu_dir);
+			*pdir ++= NULL;
 		}
-		*pdir++ = cpu_dir;
 	}
-	*pdir = palinfo_dir;
+
+	if (cpu_dir) {
+		remove_proc_entry(cpu_dir->name, palinfo_dir);
+	}
+}
+
+static int __devinit palinfo_cpu_callback(struct notifier_block *nfb,
+								unsigned long action,
+								void *hcpu)
+{
+	unsigned int hotcpu = (unsigned long)hcpu;
+
+	switch (action) {
+	case CPU_ONLINE:
+		create_palinfo_proc_entries(hotcpu);
+		break;
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_DEAD:
+		remove_palinfo_proc_entries(hotcpu);
+		break;
+#endif
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block palinfo_cpu_notifier =
+{
+	.notifier_call = palinfo_cpu_callback,
+	.priority = 0,
+};
+
+static int __init
+palinfo_init(void)
+{
+	int i = 0;
+
+	printk(KERN_INFO "PAL Information Facility v%s\n", PALINFO_VERSION);
+	palinfo_dir = proc_mkdir("pal", NULL);
+
+	/* Create palinfo dirs in /proc for all online cpus */
+	for_each_online_cpu(i) {
+		create_palinfo_proc_entries(i);
+	}
+
+	/* Register for future delivery via notify registration */
+	register_cpu_notifier(&palinfo_cpu_notifier);
 
 	return 0;
 }
@@ -939,10 +1004,19 @@ palinfo_exit(void)
 	int i = 0;
 
 	/* remove all nodes: depth first pass. Could optimize this  */
-	for (i=0; i< NR_PALINFO_PROC_ENTRIES ; i++) {
-		if (palinfo_proc_entries[i])
-			remove_proc_entry (palinfo_proc_entries[i]->name, NULL);
+	for_each_online_cpu(i) {
+		remove_palinfo_proc_entries(i);
 	}
+
+	/*
+	 * Remove the top level entry finally
+	 */
+	remove_proc_entry(palinfo_dir->name, NULL);
+
+	/*
+	 * Unregister from cpu notifier callbacks
+	 */
+	unregister_cpu_notifier(&palinfo_cpu_notifier);
 }
 
 module_init(palinfo_init);

_
