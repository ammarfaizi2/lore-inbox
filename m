Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270864AbTHLRw2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 13:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270931AbTHLRw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 13:52:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:59834 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S270864AbTHLRwW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 13:52:22 -0400
Message-ID: <3F392914.1010704@us.ibm.com>
Date: Tue, 12 Aug 2003 10:51:16 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [patch] Make 16-way x440's boot
Content-Type: multipart/mixed;
 boundary="------------070401010602070105030300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070401010602070105030300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

16 proc x440 boxen aren't booting mainline kernels right now for many 
valid configs.  This patch makes sure NUMA codepaths aren't executed for 
SMP configs.  It also adds some sane error messages to the code, and 
cleans up some #ifdefs.  Please apply.

[mcd@arrakis src]$ diffstat ~/patches/16way-x440_fix.patch
  arch/i386/kernel/setup.c                    |    3 ---
  arch/i386/kernel/summit.c                   |   18 ++++++++++++++----
  include/asm-i386/mach-summit/mach_mpparse.h |    8 ++++++++
  3 files changed, 22 insertions(+), 7 deletions(-)


Cheers!

-Matt

--------------070401010602070105030300
Content-Type: text/plain;
 name="16way-x440_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="16way-x440_fix.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0t3-bk1/arch/i386/kernel/setup.c linux-2.6.0t3-16way-x440/arch/i386/kernel/setup.c
--- linux-2.6.0t3-bk1/arch/i386/kernel/setup.c	Fri Aug  8 21:36:40 2003
+++ linux-2.6.0t3-16way-x440/arch/i386/kernel/setup.c	Tue Aug 12 10:38:52 2003
@@ -989,9 +989,6 @@ void __init setup_arch(char **cmdline_p)
 	if (smp_found_config)
 		get_smp_config();
 #endif
-#ifdef CONFIG_X86_SUMMIT
-	setup_summit();
-#endif
 
 	register_memory(max_low_pfn);
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0t3-bk1/arch/i386/kernel/summit.c linux-2.6.0t3-16way-x440/arch/i386/kernel/summit.c
--- linux-2.6.0t3-bk1/arch/i386/kernel/summit.c	Fri Aug  8 21:36:46 2003
+++ linux-2.6.0t3-16way-x440/arch/i386/kernel/summit.c	Tue Aug 12 10:43:43 2003
@@ -31,6 +31,7 @@
 #include <asm/io.h>
 #include <mach_mpparse.h>
 
+#ifdef CONFIG_NUMA
 static void __init setup_pci_node_map_for_wpeg(int wpeg_num, struct rio_table_hdr *rth, 
 		struct scal_detail **scal_nodes, struct rio_detail **rio_nodes){
 	int twst_num = 0, node = 0, first_bus = 0;
@@ -93,15 +94,21 @@ static void __init setup_pci_node_map_fo
 		mp_bus_id_to_node[bus] = node;
 }
 
-static void __init build_detail_arrays(struct rio_table_hdr *rth,
+static int __init build_detail_arrays(struct rio_table_hdr *rth,
 		struct scal_detail **sd, struct rio_detail **rd){
 	unsigned long ptr;
 	int i, scal_detail_size, rio_detail_size;
 
+	if ((rth->num_scal_dev > MAX_NUMNODES) || 
+	    (rth->num_rio_dev > MAX_NUMNODES * 2)){
+		printk("%s: MAX_NUMNODES too low!  Defined as %d, but system has %d nodes.\n", __FUNCTION__, MAX_NUMNODES, rth->num_scal_dev);
+		return 1;
+	}
+
 	switch (rth->version){
 	default:
 		printk("%s: Bad Rio Grande Table Version: %d\n", __FUNCTION__, rth->version);
-		/* Fall through to default to version 2 spec */
+		return 1;
 	case 2:
 		scal_detail_size = 11;
 		rio_detail_size = 13;
@@ -119,6 +126,8 @@ static void __init build_detail_arrays(s
 	ptr += scal_detail_size * rth->num_scal_dev;
 	for(i = 0; i < rth->num_rio_dev; i++)
 		rd[i] = (struct rio_detail *)(ptr + (rio_detail_size * i));
+
+	return 0;
 }
 
 void __init setup_summit(void)
@@ -152,11 +161,12 @@ void __init setup_summit(void)
 		return;
 	}
 
-	/* Deal with the ugly version 2/3 pointer arithmetic */
-	build_detail_arrays(rio_table_hdr, scal_devs, rio_devs);
+	if (build_detail_arrays(rio_table_hdr, scal_devs, rio_devs))
+		return;
 
 	for(i = 0; i < rio_table_hdr->num_rio_dev; i++)
 		if (is_WPEG(rio_devs[i]->type))
 			/* It's a Winnipeg, it's got PCI Busses */
 			setup_pci_node_map_for_wpeg(i, rio_table_hdr, scal_devs, rio_devs);
 }
+#endif /* CONFIG_NUMA */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0t3-bk1/include/asm-i386/mach-summit/mach_mpparse.h linux-2.6.0t3-16way-x440/include/asm-i386/mach-summit/mach_mpparse.h
--- linux-2.6.0t3-bk1/include/asm-i386/mach-summit/mach_mpparse.h	Fri Aug  8 21:36:02 2003
+++ linux-2.6.0t3-16way-x440/include/asm-i386/mach-summit/mach_mpparse.h	Tue Aug 12 10:38:52 2003
@@ -5,6 +5,12 @@
 
 extern int use_cyclone;
 
+#ifdef CONFIG_NUMA
+extern void setup_summit(void);
+#else /* !CONFIG_NUMA */
+#define setup_summit()	{}
+#endif /* CONFIG_NUMA */
+
 static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char *name, 
 				struct mpc_config_translation *translation)
 {
@@ -24,6 +30,7 @@ static inline int mps_oem_check(struct m
 			 || !strncmp(productid, "EXA", 3)
 			 || !strncmp(productid, "RUTHLESS SMP", 12))){
 		use_cyclone = 1; /*enable cyclone-timer*/
+		setup_summit();
 		return 1;
 	}
 	return 0;
@@ -36,6 +43,7 @@ static inline int acpi_madt_oem_check(ch
 	    (!strncmp(oem_table_id, "SERVIGIL", 8)
 	     || !strncmp(oem_table_id, "EXA", 3))){
 		use_cyclone = 1; /*enable cyclone-timer*/
+		setup_summit();
 		return 1;
 	}
 	return 0;

--------------070401010602070105030300--

