Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270643AbTHEWgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 18:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271416AbTHEWgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 18:36:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:25015 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S270643AbTHEWge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 18:36:34 -0400
Message-ID: <3F303138.3040709@us.ibm.com>
Date: Tue, 05 Aug 2003 15:35:36 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: John Stultz <johnstul@us.ibm.com>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: [patch] 16-way x440 doesn't boot
Content-Type: multipart/mixed;
 boundary="------------060107090109070102030006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060107090109070102030006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

We'd been having a problem with our 16-way x440.  The problem was, it 
wouldn't boot. :(  We've narrowed it down to an array bounds problem, 
and here's the patch against 2.6.0-test2 that fixes it.  This also 
cleans up some code that was ugly.

* There was an #ifdef'd call in setup_arch.  It's been moved into 
subarch code.

* There were some ugly for loops that now are more readable.

* The NUMA-specific code is now only compiled in & executed if CONFIG_NUMA.

* The code checks that MAX_NUMNODES has a sane value before proceeding.

Cheers!

-Matt

--------------060107090109070102030006
Content-Type: text/plain;
 name="16way-x440_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="16way-x440_fix.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test2-vanilla/arch/i386/kernel/setup.c linux-2.6.0-test2-16wayfix/arch/i386/kernel/setup.c
--- linux-2.6.0-test2-vanilla/arch/i386/kernel/setup.c	Thu Jul 31 14:40:35 2003
+++ linux-2.6.0-test2-16wayfix/arch/i386/kernel/setup.c	Mon Aug  4 16:31:43 2003
@@ -989,9 +989,6 @@ void __init setup_arch(char **cmdline_p)
 	if (smp_found_config)
 		get_smp_config();
 #endif
-#ifdef CONFIG_X86_SUMMIT
-	setup_summit();
-#endif
 
 	register_memory(max_low_pfn);
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test2-vanilla/arch/i386/kernel/summit.c linux-2.6.0-test2-16wayfix/arch/i386/kernel/summit.c
--- linux-2.6.0-test2-vanilla/arch/i386/kernel/summit.c	Sun Jul 27 10:02:00 2003
+++ linux-2.6.0-test2-16wayfix/arch/i386/kernel/summit.c	Tue Aug  5 09:41:17 2003
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
+		printk("%s ERROR!  MAX_NUMNODES incorrectly defined as %d!!!\n", __FUNCTION__, MAX_NUMNODES);
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
@@ -113,12 +120,13 @@ static void __init build_detail_arrays(s
 	}
 
 	ptr = (unsigned long)rth + 3;
-	for(i = 0; i < rth->num_scal_dev; i++)
-		sd[i] = (struct scal_detail *)(ptr + (scal_detail_size * i));
+	for(i = 0; i < rth->num_scal_dev; i++, ptr += scal_detail_size)
+		sd[i] = (struct scal_detail *)ptr;
+
+	for(i = 0; i < rth->num_rio_dev; i++, ptr += rio_detail_size)
+		rd[i] = (struct rio_detail *)ptr;
 
-	ptr += scal_detail_size * rth->num_scal_dev;
-	for(i = 0; i < rth->num_rio_dev; i++)
-		rd[i] = (struct rio_detail *)(ptr + (rio_detail_size * i));
+	return 0;
 }
 
 void __init setup_summit(void)
@@ -130,8 +138,6 @@ void __init setup_summit(void)
 	unsigned short		offset;
 	int			i;
 
-	memset(mp_bus_id_to_node, -1, sizeof(mp_bus_id_to_node));
-
 	/* The pointer to the EBDA is stored in the word @ phys 0x40E(40:0E) */
 	ptr = *(unsigned short *)phys_to_virt(0x40Eul);
 	ptr = (unsigned long)phys_to_virt(ptr << 4);
@@ -152,11 +158,13 @@ void __init setup_summit(void)
 		return;
 	}
 
-	/* Deal with the ugly version 2/3 pointer arithmetic */
-	build_detail_arrays(rio_table_hdr, scal_devs, rio_devs);
+	/* Parse table.  Non-zero return means bad table. */
+	if (build_detail_arrays(rio_table_hdr, scal_devs, rio_devs))
+		return;
 
 	for(i = 0; i < rio_table_hdr->num_rio_dev; i++)
 		if (is_WPEG(rio_devs[i]->type))
 			/* It's a Winnipeg, it's got PCI Busses */
 			setup_pci_node_map_for_wpeg(i, rio_table_hdr, scal_devs, rio_devs);
 }
+#endif /* CONFIG_NUMA */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test2-vanilla/include/asm-i386/mach-summit/mach_mpparse.h linux-2.6.0-test2-16wayfix/include/asm-i386/mach-summit/mach_mpparse.h
--- linux-2.6.0-test2-vanilla/include/asm-i386/mach-summit/mach_mpparse.h	Sun Jul 27 10:01:16 2003
+++ linux-2.6.0-test2-16wayfix/include/asm-i386/mach-summit/mach_mpparse.h	Tue Aug  5 09:27:51 2003
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

--------------060107090109070102030006--

