Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbUCOSDN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbUCOSDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:03:13 -0500
Received: from imap.gmx.net ([213.165.64.20]:61854 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262650AbUCOSCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:02:52 -0500
X-Authenticated: #18147109
From: Gerald Schaefer <gerald.schaefer@gmx.net>
Reply-To: gerald.schaefer@gmx.net
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: update for altered page_state structure
Date: Mon, 15 Mar 2004 19:02:45 +0100
User-Agent: KMail/1.6.1
Cc: olh@suse.de, arnd@arndb.de, akpm@osdl.org, schwidefsky@de.ibm.com
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403151902.45925.gerald.schaefer@gmx.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 March 2004 11:46, Arnd wrote:

> Sorry, this does not look like the right fix. The structure is
> effectively ABI, because it is accessed as binary data by the
> VM hypervisor. If changes to it can't be avoided, the structure
> version needs to be changed as well and all documentation and
> VM applications using it must be updated.
> 
> In this specific case, it should be simple enough to just leave
> the pgalloc field in place and write the sum of the real kernel
> values (high+normal+dma) to it.
> 
> Gerald, can you please look into this?

This patch fixes the problems introduced by Olaf's patch, please apply.
I have added some comments to the data gathering modules to avoid
future confusion and summarized the pgalloc counts as described above.

===== arch/s390/appldata/appldata_mem.c 1.2 vs edited =====
--- 1.2/arch/s390/appldata/appldata_mem.c	Sun Mar 14 20:17:11 2004
+++ edited/arch/s390/appldata/appldata_mem.c	Mon Mar 15 15:35:23 2004
@@ -27,6 +27,15 @@
 
 /*
  * Memory data
+ *
+ * This is accessed as binary data by z/VM. If changes to it can't be avoided,
+ * the structure version (product ID, see appldata_base.c) needs to be changed
+ * as well and all documentation and z/VM applications using it must be
+ * updated.
+ * 
+ * The record layout is documented in the Linux for zSeries Device Drivers
+ * book:
+ * http://oss.software.ibm.com/developerworks/opensource/linux390/index.shtml
  */
 struct appldata_mem_data {
 	u64 timestamp;
@@ -54,9 +63,7 @@
 	u64 freeswap;		/* free swap space */
 
 // New in 2.6 -->
-	u64 pgalloc_high;	/* page allocations */
-	u64 pgalloc_normal;
-	u64 pgalloc_dma;
+	u64 pgalloc;		/* page allocations */
 	u64 pgfault;		/* page faults (major+minor) */
 	u64 pgmajfault;		/* page faults (major only) */
 // <-- New in 2.6
@@ -71,9 +78,7 @@
 	P_DEBUG("pgpgout    = %8lu KB\n", mem_data->pgpgout);
 	P_DEBUG("pswpin     = %8lu Pages\n", mem_data->pswpin);
 	P_DEBUG("pswpout    = %8lu Pages\n", mem_data->pswpout);
-	P_DEBUG("pgalloc_high   = %8lu \n", mem_data->pgalloc_high);
-	P_DEBUG("pgalloc_normal = %8lu \n", mem_data->pgalloc_normal);
-	P_DEBUG("pgalloc_dma    = %8lu \n", mem_data->pgalloc_dma);
+	P_DEBUG("pgalloc    = %8lu \n", mem_data->pgalloc);
 	P_DEBUG("pgfault    = %8lu \n", mem_data->pgfault);
 	P_DEBUG("pgmajfault = %8lu \n", mem_data->pgmajfault);
 	P_DEBUG("sharedram  = %8lu KB\n", mem_data->sharedram);
@@ -109,14 +114,10 @@
 	mem_data->pgpgout    = ps.pgpgout >> 1;
 	mem_data->pswpin     = ps.pswpin;
 	mem_data->pswpout    = ps.pswpout;
-	mem_data->pgalloc_high   = ps.pgalloc_high;
-	mem_data->pgalloc_normal = ps.pgalloc_normal;
-	mem_data->pgalloc_dma    = ps.pgalloc_dma;
+	mem_data->pgalloc    = ps.pgalloc_high + ps.pgalloc_normal +
+			       ps.pgalloc_dma;
 	mem_data->pgfault    = ps.pgfault;
 	mem_data->pgmajfault = ps.pgmajfault;
-
-P_DEBUG("pgalloc_high = %lu, pgalloc_normal = %lu, pgalloc_dma = %lu, pgfree = %lu\n",
-	ps.pgalloc_high, ps.pgalloc_normal, ps.pgalloc_dma, ps.pgfree);
 
 	si_meminfo(&val);
 	mem_data->sharedram = val.sharedram;
===== arch/s390/appldata/appldata_net_sum.c 1.1 vs edited =====
--- 1.1/arch/s390/appldata/appldata_net_sum.c	Thu Feb 26 12:21:55 2004
+++ edited/arch/s390/appldata/appldata_net_sum.c	Mon Mar 15 15:35:59 2004
@@ -26,6 +26,14 @@
 
 /*
  * Network data
+ *
+ * This is accessed as binary data by z/VM. If changes to it can't be avoided,
+ * the structure version (product ID, see appldata_base.c) needs to be changed
+ * as well and all documentation and z/VM applications using it must be updated.
+ * 
+ * The record layout is documented in the Linux for zSeries Device Drivers
+ * book:
+ * http://oss.software.ibm.com/developerworks/opensource/linux390/index.shtml
  */
 struct appldata_net_sum_data {
 	u64 timestamp;
===== arch/s390/appldata/appldata_os.c 1.1 vs edited =====
--- 1.1/arch/s390/appldata/appldata_os.c	Thu Feb 26 12:21:55 2004
+++ edited/arch/s390/appldata/appldata_os.c	Mon Mar 15 15:35:04 2004
@@ -28,6 +28,15 @@
 
 /*
  * OS data
+ *
+ * This is accessed as binary data by z/VM. If changes to it can't be avoided,
+ * the structure version (product ID, see appldata_base.c) needs to be changed
+ * as well and all documentation and z/VM applications using it must be
+ * updated.
+ * 
+ * The record layout is documented in the Linux for zSeries Device Drivers
+ * book:
+ * http://oss.software.ibm.com/developerworks/opensource/linux390/index.shtml
  */
 struct appldata_os_per_cpu {
 	u32 per_cpu_user;	/* timer ticks spent in user mode   */
===== include/linux/page-flags.h 1.45 vs edited =====
--- 1.45/include/linux/page-flags.h	Sun Mar 14 20:17:11 2004
+++ edited/include/linux/page-flags.h	Mon Mar 15 13:10:26 2004
@@ -80,9 +80,6 @@
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
- *
- * NOTE: if this structure is changed then mm/page_alloc.c and
- * arch/s390/appldata/appldata_mem.c must be updated accordingly
  */
 struct page_state {
 	unsigned long nr_dirty;		/* Dirty writeable pages */
