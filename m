Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUIITMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUIITMQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266796AbUIITLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:11:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:7076 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266741AbUIITFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:05:18 -0400
Message-ID: <4140A969.9070207@vnet.ibm.com>
Date: Thu, 09 Sep 2004 14:05:13 -0500
From: will schmidt <will_schmidt@vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: paulus@samba.org, anton@samba.org, willschm@us.ibm.com
Subject: [PATCH 1/2] PPC64 lparcfg fixes to logic behind potential and active
 processor values
Content-Type: multipart/mixed;
 boundary="------------040407000601090108050708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040407000601090108050708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

This patch corrects how the lparcfg interface was presenting the number of active and potential processors.   (As reported in LTC bugzilla number 10889)

	- Correct output for partition_potential_processors and system_active_processors.
	- suppress pool related values in scenarios where they do not make sense. (non-shared processor configurations)
	- Display pool_capacity as a percentage, to match the behavior from iSeries code.


Signed-off-by:  Will Schmidt    willschm@us.ibm.com
---

  lparcfg.c |   52 +++++++++++++++++++++++++++++-----------------------
  1 files changed, 29 insertions(+), 23 deletions(-)



--------------040407000601090108050708
Content-Type: text/plain;
 name="lparcfg.bz10889.kernel.org.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lparcfg.bz10889.kernel.org.diff"

--- a/arch/ppc64/kernel/lparcfg.c	2004-08-30 13:55:05.000000000 -0500
+++ b/arch/ppc64/kernel/lparcfg.c	2004-09-08 15:56:21.000000000 -0500
@@ -34,7 +34,7 @@
 #include <asm/rtas.h>
 #include <asm/system.h>
 
-#define MODULE_VERS "1.3"
+#define MODULE_VERS "1.4"
 #define MODULE_NAME "lparcfg"
 
 /* #define LPARCFG_DEBUG */
@@ -292,7 +292,8 @@
 
 static int lparcfg_data(struct seq_file *m, void *v)
 {
-	int system_active_processors;
+	int partition_potential_processors;
+	int partition_active_processors;
 	struct device_node *rootdn;
 	const char *model = "";
 	const char *system_id = "";
@@ -323,11 +324,13 @@
 	lrdrp = (int *)get_property(rtas_node, "ibm,lrdr-capacity", NULL);
 
 	if (lrdrp == NULL) {
-		system_active_processors = systemcfg->processorCount;
+		partition_potential_processors = systemcfg->processorCount;
 	} else {
-		system_active_processors = *(lrdrp + 4);
+		partition_potential_processors = *(lrdrp + 4);
 	}
 
+	partition_active_processors = lparcfg_count_active_processors();
+
 	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR) {
 		unsigned long h_entitled, h_unallocated;
 		unsigned long h_aggregation, h_resource;
@@ -342,8 +345,6 @@
 		seq_printf(m, "R6=0x%lx\n", h_aggregation);
 		seq_printf(m, "R7=0x%lx\n", h_resource);
 
-		h_pic(&pool_idle_time, &pool_procs);
-
 		purr = get_purr();
 
 		/* this call handles the ibm,get-system-parameter contents */
@@ -352,17 +353,28 @@
 		seq_printf(m, "partition_entitled_capacity=%ld\n",
 			      h_entitled);
 
-		seq_printf(m, "pool=%ld\n",
-			      (h_aggregation >> 0*8) & 0xffff);
-
 		seq_printf(m, "group=%ld\n",
 			      (h_aggregation >> 2*8) & 0xffff);
 
 		seq_printf(m, "system_active_processors=%ld\n",
 			      (h_resource >> 0*8) & 0xffff);
 
-		seq_printf(m, "pool_capacity=%ld\n",
-			      (h_resource >> 2*8) & 0xffff);
+		/* pool related entries are apropriate for shared configs */
+		if (paca[0].lppaca.xSharedProc) {
+
+			h_pic(&pool_idle_time, &pool_procs);
+
+			seq_printf(m, "pool=%ld\n",
+				   (h_aggregation >> 0*8) & 0xffff);
+
+			/* report pool_capacity in percentage */
+			seq_printf(m, "pool_capacity=%ld\n",
+				   ((h_resource >> 2*8) & 0xffff)*100);
+
+			seq_printf(m, "pool_idle_time=%ld\n", pool_idle_time);
+
+			seq_printf(m, "pool_num_procs=%ld\n", pool_procs);
+		}
 
 		seq_printf(m, "unallocated_capacity_weight=%ld\n",
 			      (h_resource >> 4*8) & 0xFF);
@@ -376,34 +388,28 @@
 		seq_printf(m, "unallocated_capacity=%ld\n",
 			      h_unallocated);
 
-		seq_printf(m, "pool_idle_time=%ld\n",
-			      pool_idle_time);
-
-		seq_printf(m, "pool_num_procs=%ld\n",
-			      pool_procs);
-
 		seq_printf(m, "purr=%ld\n",
 			      purr);
 
 	} else /* non SPLPAR case */ {
 		seq_printf(m, "system_active_processors=%d\n",
-			      system_active_processors);
+			      partition_potential_processors);
 
 		seq_printf(m, "system_potential_processors=%d\n",
-			      system_active_processors);
+			      partition_potential_processors);
 
 		seq_printf(m, "partition_max_entitled_capacity=%d\n",
-			      100*system_active_processors);
+			      partition_potential_processors * 100);
 
 		seq_printf(m, "partition_entitled_capacity=%d\n",
-			      system_active_processors*100);
+			      partition_active_processors * 100);
 	}
 
 	seq_printf(m, "partition_active_processors=%d\n",
-			(int) lparcfg_count_active_processors());
+			      partition_active_processors);
 
 	seq_printf(m, "partition_potential_processors=%d\n",
-			system_active_processors);
+			      partition_potential_processors);
 
 	seq_printf(m, "shared_processor_mode=%d\n",
 			paca[0].lppaca.xSharedProc);

--------------040407000601090108050708--
