Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266134AbUF2XMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266134AbUF2XMZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 19:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266133AbUF2XMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 19:12:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:46489 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266137AbUF2XLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 19:11:43 -0400
Message-ID: <40E1F6FC.3030405@vnet.ibm.com>
Date: Tue, 29 Jun 2004 18:10:52 -0500
From: will schmidt <will_schmidt@vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: anton@samba.org, paulus@samba.org, will_schmidt@vnet.ibm.com
Subject: [PATCH][PPC64] lparcfg seq_file update
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
    This patch includes updates and cleanup for the PPC64 proc/lparcfg 
interface.
	- use seq_file's seq_printf for output
	- remove redundant e2a function. (use viopath.c's instead)
	- change to Kconfig to allow building as a module.
	- export required symbols from LparData.c

Please apply.   (or make constructive comments, as necessary.. :-)  )

Signed-off-by: Will Schmidt <willschm@us.ibm.com>


diff -Naur linux-2.6.7.orig/arch/ppc64/Kconfig 
linux-2.6.7/arch/ppc64/Kconfig
--- linux-2.6.7.orig/arch/ppc64/Kconfig	2004-06-29 15:43:16.000000000 -0500
+++ linux-2.6.7/arch/ppc64/Kconfig	2004-06-29 17:08:30.000000000 -0500
@@ -226,7 +226,7 @@
  	depends on PPC_RTAS

  config LPARCFG
-	bool "LPAR Configuration Data"
+	tristate "LPAR Configuration Data"
  	help
  	Provide system capacity information via human readable
  	<key word>=<value> pairs through a /proc/ppc64/lparcfg interface.
diff -Naur linux-2.6.7.orig/arch/ppc64/kernel/LparData.c 
linux-2.6.7/arch/ppc64/kernel/LparData.c
--- linux-2.6.7.orig/arch/ppc64/kernel/LparData.c	2004-06-29 
15:43:16.000000000 -0500
+++ linux-2.6.7/arch/ppc64/kernel/LparData.c	2004-06-29 
17:02:39.000000000 -0500
@@ -10,6 +10,7 @@
  #include <asm/page.h>
  #include <stddef.h>
  #include <linux/threads.h>
+#include <linux/module.h>
  #include <asm/processor.h>
  #include <asm/ptrace.h>
  #include <asm/naca.h>
@@ -123,12 +124,14 @@
  		(u64)InstructionAccessSLB_Iseries /* 0x480 I-SLB */
  	}
  };
+EXPORT_SYMBOL(itLpNaca);

  /* May be filled in by the hypervisor so cannot end up in the BSS */
  struct ItIplParmsReal xItIplParmsReal 
__attribute__((__section__(".data")));

  /* May be filled in by the hypervisor so cannot end up in the BSS */
  struct ItExtVpdPanel xItExtVpdPanel __attribute__((__section__(".data")));
+EXPORT_SYMBOL(xItExtVpdPanel);

  #define maxPhysicalProcessors 32

diff -Naur linux-2.6.7.orig/arch/ppc64/kernel/lparcfg.c 
linux-2.6.7/arch/ppc64/kernel/lparcfg.c
--- linux-2.6.7.orig/arch/ppc64/kernel/lparcfg.c	2004-06-29 
15:43:16.000000000 -0500
+++ linux-2.6.7/arch/ppc64/kernel/lparcfg.c	2004-06-29 
17:03:22.000000000 -0500
@@ -5,6 +5,7 @@
   *    Copyright (c) 2003 Dave Engebretsen
   * Will Schmidt willschm@us.ibm.com
   *    SPLPAR updates, Copyright (c) 2003 Will Schmidt IBM Corporation.
+ *    seq_file updates, Copyright (c) 2004 Will Schmidt IBM Corporation.
   * Nathan Lynch nathanl@austin.ibm.com
   *    Added lparcfg_write, Copyright (C) 2004 Nathan Lynch IBM 
Corporation.
   *
@@ -23,15 +24,43 @@
  #include <linux/errno.h>
  #include <linux/proc_fs.h>
  #include <linux/init.h>
+#include <linux/seq_file.h>
  #include <asm/uaccess.h>
  #include <asm/iSeries/HvLpConfig.h>
  #include <asm/iSeries/ItLpPaca.h>
+#include <asm/iSeries/LparData.h>
  #include <asm/hvcall.h>
  #include <asm/cputable.h>

-#define MODULE_VERS "1.0"
+#ifdef CONFIG_PPC_VPURR
+#include "vpurr.h"
+#endif
+
+#define MODULE_VERS "1.3"
  #define MODULE_NAME "lparcfg"

+/* #define LPARCFG_DEBUG */
+
+/* find a better place for this function... */
+void log_plpar_hcall_return(unsigned long rc,char * tag)
+{
+	if (rc==0) /* success, return */
+		return;
+/* check for null tag ? */
+	if (rc == H_Hardware)
+		printk(KERN_INFO "plpar-hcall (%s) failed with hardware fault\n",tag);
+	else if (rc == H_Function)
+		printk(KERN_INFO "plpar-hcall (%s) failed; function not allowed\n",tag);
+	else if (rc == H_Authority)
+		printk(KERN_INFO "plpar-hcall (%s) failed; not authorized to this 
function\n",tag);
+	else if (rc == H_Parameter)
+		printk(KERN_INFO "plpar-hcall (%s) failed; Bad parameter(s)\n",tag);
+	else
+		printk(KERN_INFO "plpar-hcall (%s) failed with unexpected 
rc(0x%lx)\n",tag,rc);
+
+}
+
+
  static struct proc_dir_entry *proc_ppc64_lparcfg;
  #define LPARCFG_BUFF_SIZE 4096

@@ -39,103 +68,20 @@

  #define lparcfg_write NULL

-static unsigned char e2a(unsigned char x)
-{
-        switch (x) {
-        case 0xF0:
-                return '0';
-        case 0xF1:
-                return '1';
-        case 0xF2:
-                return '2';
-        case 0xF3:
-                return '3';
-        case 0xF4:
-                return '4';
-        case 0xF5:
-                return '5';
-        case 0xF6:
-                return '6';
-        case 0xF7:
-                return '7';
-        case 0xF8:
-                return '8';
-        case 0xF9:
-                return '9';
-        case 0xC1:
-                return 'A';
-        case 0xC2:
-                return 'B';
-        case 0xC3:
-                return 'C';
-        case 0xC4:
-                return 'D';
-        case 0xC5:
-                return 'E';
-        case 0xC6:
-                return 'F';
-        case 0xC7:
-                return 'G';
-        case 0xC8:
-                return 'H';
-        case 0xC9:
-                return 'I';
-        case 0xD1:
-                return 'J';
-        case 0xD2:
-                return 'K';
-        case 0xD3:
-                return 'L';
-        case 0xD4:
-                return 'M';
-        case 0xD5:
-                return 'N';
-        case 0xD6:
-                return 'O';
-        case 0xD7:
-                return 'P';
-        case 0xD8:
-                return 'Q';
-        case 0xD9:
-                return 'R';
-        case 0xE2:
-                return 'S';
-        case 0xE3:
-                return 'T';
-        case 0xE4:
-                return 'U';
-        case 0xE5:
-                return 'V';
-        case 0xE6:
-                return 'W';
-        case 0xE7:
-                return 'X';
-        case 0xE8:
-                return 'Y';
-        case 0xE9:
-                return 'Z';
-        }
-        return ' ';
-}
+extern unsigned char e2a(unsigned char);

  /*
   * Methods used to fetch LPAR data when running on an iSeries platform.
   */
-static int lparcfg_data(unsigned char *buf, unsigned long size)
+static int lparcfg_data(struct seq_file *m,void *v)
  {
-	unsigned long n = 0, pool_id, lp_index;
+	unsigned long pool_id, lp_index;
  	int shared, entitled_capacity, max_entitled_capacity;
  	int processors, max_processors;
  	struct paca_struct *lpaca = get_paca();

-	if((buf == NULL) || (size > LPARCFG_BUFF_SIZE)) {
-		return -EFAULT;
-	}
-	memset(buf, 0, size);
-
  	shared = (int)(lpaca->xLpPacaPtr->xSharedProc);
-	n += scnprintf(buf, LPARCFG_BUFF_SIZE - n,
-		      "serial_number=%c%c%c%c%c%c%c\n",
+	seq_printf(m, "serial_number=%c%c%c%c%c%c%c\n",
  		      e2a(xItExtVpdPanel.mfgID[2]),
  		      e2a(xItExtVpdPanel.mfgID[3]),
  		      e2a(xItExtVpdPanel.systemSerial[1]),
@@ -144,32 +90,26 @@
  		      e2a(xItExtVpdPanel.systemSerial[4]),
  		      e2a(xItExtVpdPanel.systemSerial[5]));

-	n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-		      "system_type=%c%c%c%c\n",
+	seq_printf(m, "system_type=%c%c%c%c\n",
  		      e2a(xItExtVpdPanel.machineType[0]),
  		      e2a(xItExtVpdPanel.machineType[1]),
  		      e2a(xItExtVpdPanel.machineType[2]),
  		      e2a(xItExtVpdPanel.machineType[3]));

  	lp_index = HvLpConfig_getLpIndex();
-	n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-		      "partition_id=%d\n", (int)lp_index);
+	seq_printf(m, "partition_id=%d\n", (int)lp_index);

-	n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-		      "system_active_processors=%d\n",
+	seq_printf(m, "system_active_processors=%d\n",
  		      (int)HvLpConfig_getSystemPhysicalProcessors());

-	n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-		      "system_potential_processors=%d\n",
+	seq_printf(m, "system_potential_processors=%d\n",
  		      (int)HvLpConfig_getSystemPhysicalProcessors());

  	processors = (int)HvLpConfig_getPhysicalProcessors();
-	n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-		      "partition_active_processors=%d\n", processors);
+	seq_printf(m, "partition_active_processors=%d\n", processors);

  	max_processors = (int)HvLpConfig_getMaxPhysicalProcessors();
-	n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-		      "partition_potential_processors=%d\n", max_processors);
+	seq_printf(m, "partition_potential_processors=%d\n", max_processors);

  	if(shared) {
  		entitled_capacity = HvLpConfig_getSharedProcUnits();
@@ -178,23 +118,18 @@
  		entitled_capacity = processors * 100;
  		max_entitled_capacity = max_processors * 100;
  	}
-	n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-		      "partition_entitled_capacity=%d\n", entitled_capacity);
+	seq_printf(m, "partition_entitled_capacity=%d\n", entitled_capacity);

-	n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-		      "partition_max_entitled_capacity=%d\n",
+	seq_printf(m, "partition_max_entitled_capacity=%d\n",
  		      max_entitled_capacity);

  	if(shared) {
  		pool_id = HvLpConfig_getSharedPoolIndex();
-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n, "pool=%d\n",
-			      (int)pool_id);
-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-			      "pool_capacity=%d\n", 
(int)(HvLpConfig_getNumProcsInSharedPool(pool_id)*100));
+		seq_printf(m, "pool=%d\n", (int)pool_id);
+		seq_printf(m, "pool_capacity=%d\n", 
(int)(HvLpConfig_getNumProcsInSharedPool(pool_id)*100));
  	}

-	n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-		      "shared_processor_mode=%d\n", shared);
+	seq_printf(m, "shared_processor_mode=%d\n", shared);

  	return 0;
  }
@@ -217,7 +152,7 @@
   *          XXXX - reserved (0)
   *              XXXX - Group Number
   *                  XXXX - Pool Number.
- *  R7 (PPOONNMMLLKKJJII)
+ *  R7 (IIJJKKLLMMNNOOPP).
   *      XX - reserved. (0)
   *        XX - bit 0-6 reserved (0).   bit 7 is Capped indicator.
   *          XX - variable processor Capacity Weight
@@ -225,168 +160,259 @@
   *              XXXX - Active processors in Physical Processor Pool.
   *                  XXXX  - Processors active on platform.
   */
-unsigned int h_get_ppp(unsigned long *entitled,unsigned long 
*unallocated,unsigned long *aggregation,unsigned long *resource)
+static unsigned int h_get_ppp(unsigned long *entitled,unsigned long 
*unallocated,unsigned long *aggregation,unsigned long *resource)
  {
  	unsigned long rc;
  	rc = 
plpar_hcall_4out(H_GET_PPP,0,0,0,0,entitled,unallocated,aggregation,resource);
-	return 0;
+
+	log_plpar_hcall_return(rc,"H_GET_PPP");
+
+	return rc;
+}
+
+static void h_pic(unsigned long *pool_idle_time,unsigned long *num_procs)
+{
+	unsigned long rc;
+	unsigned long dummy;
+	rc = plpar_hcall(H_PIC,0,0,0,0,pool_idle_time,num_procs,&dummy);
+
+	log_plpar_hcall_return(rc,"H_PIC");
+}
+
+static unsigned long get_purr(void);
+/* get sum of purr across all processors.  if PPC_VPURR is not enabled, 
return zero. */
+/* this utilizes the existing functionality from vpurr.c */
+static unsigned long get_purr()
+{
+	unsigned long sum_purr=0;
+#ifdef CONFIG_PPC_VPURR	
+	int cpu;
+	struct cpu_util_store * cus;
+
+	for_each_online_cpu(cpu){
+		cus =   &per_cpu (cpu_util_sampler, cpu);
+		sum_purr += cus->current_purr;
+#ifdef PURR_DEBUG
+	printk(KERN_INFO "get_purr for cpu (%x) has value (%lx) 
\n",cpu,cus->current_purr);
+#endif
+                }
+#endif
+	return sum_purr;
  }

-/*
- * get_splpar_potential_characteristics().
- * Retrieve the potential_processors and max_entitled_capacity values
- * through the get-system-parameter rtas call.
- */
  #define SPLPAR_CHARACTERISTICS_TOKEN 20
  #define SPLPAR_MAXLENGTH 1026*(sizeof(char))
-unsigned int get_splpar_potential_characteristics(void)
+
+/*
+ * parse_system_parameter_string()
+ * Retrieve the potential_processors, max_entitled_capacity and friends
+ * through the get-system-parameter rtas call.  Replace keyword strings as
+ * necessary.
+ */
+static void parse_system_parameter_string(struct seq_file *m)
  {
-	/* return 0 for now.  Underlying rtas functionality is not yet 
complete. 12/01/2003*/
-	return 0;
-#if 0
  	long call_status;
  	unsigned long ret[2];

-	char * buffer = kmalloc(SPLPAR_MAXLENGTH, GFP_KERNEL);
-
-	printk("token for ibm,get-system-parameter 
(0x%x)\n",rtas_token("ibm,get-system-parameter"));
+	char * local_buffer = kmalloc(SPLPAR_MAXLENGTH, GFP_KERNEL);
+	if (!local_buffer) {
+		printk(KERN_ERR "%s %s kmalloc failure at line %d 
\n",__FILE__,__FUNCTION__,__LINE__);
+		return;
+	}

+	spin_lock(&rtas_data_buf_lock);
+	memset(rtas_data_buf, 0, SPLPAR_MAXLENGTH);
  	call_status = rtas_call(rtas_token("ibm,get-system-parameter"), 3, 1,
  				NULL,
  				SPLPAR_CHARACTERISTICS_TOKEN,
-				&buffer,
+				__pa(rtas_data_buf),
  				SPLPAR_MAXLENGTH,
  				(void *)&ret);
+	memcpy(local_buffer,rtas_data_buf, SPLPAR_MAXLENGTH);
+	spin_unlock(&rtas_data_buf_lock);

  	if (call_status!=0) {
-		printk("Error calling get-system-parameter (0x%lx)\n",call_status);
-		kfree(buffer);
-		return -1;
+		printk(KERN_INFO "%s %s Error calling get-system-parameter 
(0x%lx)\n",__FILE__,__FUNCTION__,call_status);
  	} else {
-		printk("get-system-parameter (%s)\n",buffer);
-		kfree(buffer);
-		/* TODO: Add code here to parse out value for 
system_potential_processors and partition_max_entitled_capacity */
-		return 1;
+		int splpar_strlen;
+		int idx,w_idx;
+		char * workbuffer = kmalloc(SPLPAR_MAXLENGTH, GFP_KERNEL);
+		if (!workbuffer) {
+			printk(KERN_ERR "%s %s kmalloc failure at line %d 
\n",__FILE__,__FUNCTION__,__LINE__);
+			return;
+		}
+
+#ifdef LPARCFG_DEBUG
+		printk(KERN_INFO "success calling get-system-parameter \n");
+#endif
+		splpar_strlen=local_buffer[0]*16+local_buffer[1];
+		local_buffer+=2; /* step over strlen value */
+
+		memset(workbuffer, 0, SPLPAR_MAXLENGTH);
+		w_idx=0; idx=0;
+		while ((*local_buffer) && (idx<splpar_strlen)) {
+			workbuffer[w_idx++]=local_buffer[idx++];
+			if ((local_buffer[idx]==',')||(local_buffer[idx]=='\0')) {
+				workbuffer[w_idx]='\0';
+				if (w_idx) /* avoid the empty string */
+				{
+					seq_printf(m, "%s\n",workbuffer);
+				}
+				memset(workbuffer, 0, SPLPAR_MAXLENGTH);
+				idx++; /* skip the comma */
+				w_idx=0;
+			} else if (local_buffer[idx]=='=') {
+				/* code here to replace workbuffer contents
+				 with different keyword strings */
+				if (0==strcmp(workbuffer,"MaxEntCap")) {
+					strcpy(workbuffer,"partition_max_entitled_capacity\0");
+					w_idx=strlen(workbuffer);
+				}
+				if (0==strcmp(workbuffer,"MaxPlatProcs")) {
+					strcpy(workbuffer,"system_potential_processors\0");
+					w_idx=strlen(workbuffer);
+				}
+			}
+		}
+		kfree(workbuffer);
+		local_buffer-=2; /* back up over strlen value */
  	}
+	kfree(local_buffer);
+	return;
+}
+
+static int lparcfg_count_active_processors(void);
+
+static int lparcfg_count_active_processors()
+{
+	struct device_node *cpus_dn = NULL;
+	int count=0;
+	for (cpus_dn = of_find_node_by_type(NULL, "cpu");
+		cpus_dn;
+		cpus_dn = of_find_node_by_type(cpus_dn, "cpu")) {
+#ifdef LPARCFG_DEBUG
+		printk(KERN_ERR "cpus_dn %p \n",cpus_dn);
  #endif
+		count++;
+		}
+	of_node_put(cpus_dn);
+	return count;
  }

-static int lparcfg_data(unsigned char *buf, unsigned long size)
+static int lparcfg_data(struct seq_file *m, void *v)
  {
-	unsigned long n = 0;
-	int shared, max_entitled_capacity;
-	int processors, system_active_processors, system_potential_processors;
-	struct device_node *root;
+	int system_active_processors;
+	struct device_node *rootdn;
  	const char *model = "";
  	const char *system_id = "";
  	unsigned int *lp_index_ptr, lp_index = 0;
  	struct device_node *rtas_node;
-	int *ip;
-	unsigned long h_entitled,h_unallocated,h_aggregation,h_resource;
+	int *lrdrp;

-	if((buf == NULL) || (size > LPARCFG_BUFF_SIZE)) {
-		return -EFAULT;
+	rootdn = find_path_device("/");
+	if (rootdn) {
+		model = get_property(rootdn, "model", NULL);
+		system_id = get_property(rootdn, "system-id", NULL);
+		lp_index_ptr = (unsigned int *)get_property(rootdn, 
"ibm,partition-no", NULL);
+		if (lp_index_ptr) lp_index = *lp_index_ptr;
  	}
-	memset(buf, 0, size);

-	root = find_path_device("/");
-	if (root) {
-		model = get_property(root, "model", NULL);
-		system_id = get_property(root, "system-id", NULL);
-		lp_index_ptr = (unsigned int *)get_property(root, "ibm,partition-no", 
NULL);
-		if(lp_index_ptr) lp_index = *lp_index_ptr;
-	}

-	n  = scnprintf(buf, LPARCFG_BUFF_SIZE - n,
-		      "serial_number=%s\n", system_id);
+	seq_printf(m,"%s %s \n",MODULE_NAME,MODULE_VERS);

-	n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-		      "system_type=%s\n", model);
+	seq_printf(m,"serial_number=%s\n", system_id);

-	n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-		      "partition_id=%d\n", (int)lp_index);
+	seq_printf(m,"system_type=%s\n", model);
+
+	seq_printf(m,"partition_id=%d\n", (int)lp_index);

  	rtas_node = find_path_device("/rtas");
-	ip = (int *)get_property(rtas_node, "ibm,lrdr-capacity", NULL);
-	if (ip == NULL) {
+	lrdrp = (int *)get_property(rtas_node, "ibm,lrdr-capacity", NULL);
+
+	if (lrdrp == NULL) {
  		system_active_processors = systemcfg->processorCount;
  	} else {
-		system_active_processors = *(ip + 4);
-	}
+		system_active_processors = *(lrdrp + 4);
+	}

  	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR) {
+		unsigned long h_entitled,h_unallocated,h_aggregation,h_resource;
+		unsigned long pool_idle_time,pool_procs;
+		unsigned long purr;
+
  		h_get_ppp(&h_entitled,&h_unallocated,&h_aggregation,&h_resource);
-#ifdef DEBUG
-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-			      "R4=0x%lx\n", h_entitled);
-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-			      "R5=0x%lx\n", h_unallocated);
-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-			      "R6=0x%lx\n", h_aggregation);
-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-			      "R7=0x%lx\n", h_resource);
-#endif /* DEBUG */
-	}

-	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR) {
-		system_potential_processors =  get_splpar_potential_characteristics();
-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-			      "system_active_processors=%ld\n",
+		seq_printf(m, "R4=0x%lx\n", h_entitled);
+		seq_printf(m, "R5=0x%lx\n", h_unallocated);
+		seq_printf(m, "R6=0x%lx\n", h_aggregation);
+		seq_printf(m, "R7=0x%lx\n", h_resource);
+
+		h_pic(&pool_idle_time,&pool_procs);
+
+		purr = get_purr();
+
+		/* this call handles the ibm,get-system-parameter contents */
+		parse_system_parameter_string(m);
+
+		seq_printf(m, "partition_entitled_capacity=%ld\n",
+			      h_entitled);
+
+		seq_printf(m, "pool=%ld\n",
+			      (h_aggregation >> 0*8) & 0xffff);
+
+		seq_printf(m, "group=%ld\n",
+			      (h_aggregation >> 2*8) & 0xffff);
+
+		seq_printf(m, "system_active_processors=%ld\n",
+			      (h_resource >> 0*8) & 0xffff);
+
+		seq_printf(m, "pool_capacity=%ld\n",
  			      (h_resource >> 2*8) & 0xffff);
-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-			      "system_potential_processors=%d\n",
-			      system_potential_processors);
-	} else {
-		system_potential_processors = system_active_processors;
-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-			      "system_active_processors=%d\n",
-			      system_active_processors);
-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-			      "system_potential_processors=%d\n",
-			      system_potential_processors);
-	}

-	processors = systemcfg->processorCount;
-	n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-		      "partition_active_processors=%d\n", processors);
-	n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-		      "partition_potential_processors=%d\n",
-		      system_active_processors);
+		seq_printf(m, "unallocated_capacity_weight=%ld\n",
+			      (h_resource >> 4*8) & 0xFF);

-	/* max_entitled_capacity will come out of 
get_splpar_potential_characteristics() when that function is complete */
-	max_entitled_capacity = system_active_processors * 100;
-	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR) {
-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-			      "partition_entitled_capacity=%ld\n", h_entitled);
-	} else {
-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-			      "partition_entitled_capacity=%d\n", system_active_processors*100);
-	}
+		seq_printf(m, "capacity_weight=%ld\n",
+			      (h_resource >> 5*8) & 0xFF);

-	n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-		      "partition_max_entitled_capacity=%d\n",
-		      max_entitled_capacity);
+		seq_printf(m, "capped=%ld\n",
+			      (h_resource >> 6*8) & 0x01);

-	shared = 0;
-	n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-		      "shared_processor_mode=%d\n", shared);
+		seq_printf(m, "unallocated_capacity=%ld\n",
+			      h_unallocated);

-	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR) {
-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-			      "pool=%ld\n", (h_aggregation >> 0*8)&0xffff);
+		seq_printf(m, "pool_idle_time=%ld\n",
+			      pool_idle_time);
+
+		seq_printf(m, "pool_num_procs=%ld\n",
+			      pool_procs);

-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-			      "pool_capacity=%ld\n", (h_resource >> 3*8) &0xffff);
+		seq_printf(m, "purr=%ld\n",
+			      purr);
+
+	} else /* non SPLPAR case */ {
+		seq_printf(m, "system_active_processors=%d\n",
+			      system_active_processors);

-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-			      "group=%ld\n", (h_aggregation >> 2*8)&0xffff);
+		seq_printf(m, "system_potential_processors=%d\n",
+			      system_active_processors);

-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-			      "capped=%ld\n", (h_resource >> 6*8)&0x40);
+		seq_printf(m, "partition_max_entitled_capacity=%d\n",
+			      100*system_active_processors);

-		n += scnprintf(buf+n, LPARCFG_BUFF_SIZE - n,
-			      "capacity_weight=%d\n", (int)(h_resource>>5*8)&0xFF);
+		seq_printf(m, "partition_entitled_capacity=%d\n",
+			      system_active_processors*100);
  	}
+
+	seq_printf(m, "partition_active_processors=%d\n",
+			(int) lparcfg_count_active_processors());
+
+	seq_printf(m, "partition_potential_processors=%d\n",
+			system_active_processors);
+
+	seq_printf(m, "shared_processor_mode=%d\n",
+			paca[0].xLpPaca.xSharedProc);
+
  	return 0;
  }

@@ -484,58 +510,16 @@

  #endif /* CONFIG_PPC_PSERIES */

-
-static ssize_t lparcfg_read(struct file *file, char *buf,
-			    size_t count, loff_t *ppos)
-{
-	struct proc_dir_entry *dp = PDE(file->f_dentry->d_inode);
-	unsigned long *data = (unsigned long *)dp->data;
-	unsigned long p;
-	ssize_t read;
-	char * pnt;
-
-	if (!data) {
-		printk(KERN_ERR "lparcfg: read failed no data\n");
-		return -EIO;
-	}
-
-	if(ppos) {
-		p = *ppos;
-	} else {
-		return -EFAULT;
-	}
-
-	if (p >= LPARCFG_BUFF_SIZE) return 0;
-
-	lparcfg_data((unsigned char *)data, LPARCFG_BUFF_SIZE);
-	if (count > (strlen((char *)data) - p))
-		count = (strlen((char *)data)) - p;
-	read = 0;
-
-	pnt = (char *)(data) + p;
-	copy_to_user(buf, (void *)pnt, count);
-	read += count;
-	*ppos += read;
-	return read;
-}
-
  static int lparcfg_open(struct inode * inode, struct file * file)
  {
-	struct proc_dir_entry *dp = PDE(file->f_dentry->d_inode);
-	unsigned int *data = (unsigned int *)dp->data;
-
-	if (!data) {
-		printk(KERN_ERR "lparcfg: open failed no data\n");
-		return -EIO;
-	}
-
-	return 0;
+	return single_open(file,lparcfg_data,NULL);
  }

  struct file_operations lparcfg_fops = {
  	owner:		THIS_MODULE,
-	read:		lparcfg_read,
+	read:		seq_read,
  	open:		lparcfg_open,
+	release:	single_release,
  };

  int __init lparcfg_init(void)
diff -Naur linux-2.6.7.orig/arch/ppc64/kernel/viopath.c 
linux-2.6.7/arch/ppc64/kernel/viopath.c
--- linux-2.6.7.orig/arch/ppc64/kernel/viopath.c	2004-06-29 
15:43:16.000000000 -0500
+++ linux-2.6.7/arch/ppc64/kernel/viopath.c	2004-06-29 
17:02:39.000000000 -0500
@@ -108,7 +108,7 @@
  #define VIOPATH_KERN_WARN	KERN_WARNING "viopath: "
  #define VIOPATH_KERN_INFO	KERN_INFO "viopath: "

-static unsigned char e2a(unsigned char x)
+unsigned char e2a(unsigned char x)
  {
  	switch (x) {
  	case 0xF0:
@@ -186,6 +186,7 @@
  	}
  	return ' ';
  }
+EXPORT_SYMBOL(e2a);

  static int proc_viopath_show(struct seq_file *m, void *v)
  {


