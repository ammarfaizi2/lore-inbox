Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423460AbWJZMbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423460AbWJZMbq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423459AbWJZMbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:31:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:10662 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1423460AbWJZMbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:31:44 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,361,1157353200"; 
   d="scan'208"; a="150975581:sNHT25708522"
Message-ID: <4540AAAD.8010401@intel.com>
Date: Thu, 26 Oct 2006 20:31:41 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] i386 create e820.c about e820 map sanitize and copy function
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves bios e820 map sanitize and copy function from
setup.c to e820.c

Signed-off-by: bibo,mao <bibo.mao@intel.com>


 e820.c  |  252 +++++++++++++++++++++++
 setup.c |  251 ----------------------
 2 files changed, 252 insertions(+), 251 deletions(-)
----------------------------------------------------------

diff -Nrup -X 2.6.19-rc2-mm2.org/Documentation/dontdiff 2.6.19-rc2-mm2.org/arch/i386/kernel/e820.c 2.6.19-rc2-mm2/arch/i386/kernel/e820.c
--- 2.6.19-rc2-mm2.org/arch/i386/kernel/e820.c	2006-10-25 16:07:14.000000000 +0800
+++ 2.6.19-rc2-mm2/arch/i386/kernel/e820.c	2006-10-25 15:51:24.000000000 +0800
@@ -19,6 +19,14 @@ EXPORT_SYMBOL(efi_enabled);
 #endif
 
 struct e820map e820;
+struct change_member {
+	struct e820entry *pbios; /* pointer to original bios entry */
+	unsigned long long addr; /* address for this change point */
+};
+static struct change_member change_point_list[2*E820MAX] __initdata;
+static struct change_member *change_point[2*E820MAX] __initdata;
+static struct e820entry *overlap_list[E820MAX] __initdata;
+static struct e820entry new_bios[E820MAX] __initdata;
 struct resource data_resource = {
 	.name	= "Kernel data",
 	.start	= 0,
@@ -287,3 +295,247 @@ static int __init request_standard_resou
 }
 
 subsys_initcall(request_standard_resources);
+
+void __init add_memory_region(unsigned long long start,
+			      unsigned long long size, int type)
+{
+	int x;
+
+	if (!efi_enabled) {
+       		x = e820.nr_map;
+
+		if (x == E820MAX) {
+		    printk(KERN_ERR "Ooops! Too many entries in the memory map!\n");
+		    return;
+		}
+
+		e820.map[x].addr = start;
+		e820.map[x].size = size;
+		e820.map[x].type = type;
+		e820.nr_map++;
+	}
+} /* add_memory_region */
+
+/*
+ * Sanitize the BIOS e820 map.
+ *
+ * Some e820 responses include overlapping entries.  The following 
+ * replaces the original e820 map with a new one, removing overlaps.
+ *
+ */
+int __init sanitize_e820_map(struct e820entry * biosmap, char * pnr_map)
+{
+	struct change_member *change_tmp;
+	unsigned long current_type, last_type;
+	unsigned long long last_addr;
+	int chgidx, still_changing;
+	int overlap_entries;
+	int new_bios_entry;
+	int old_nr, new_nr, chg_nr;
+	int i;
+
+	/*
+		Visually we're performing the following (1,2,3,4 = memory types)...
+
+		Sample memory map (w/overlaps):
+		   ____22__________________
+		   ______________________4_
+		   ____1111________________
+		   _44_____________________
+		   11111111________________
+		   ____________________33__
+		   ___________44___________
+		   __________33333_________
+		   ______________22________
+		   ___________________2222_
+		   _________111111111______
+		   _____________________11_
+		   _________________4______
+
+		Sanitized equivalent (no overlap):
+		   1_______________________
+		   _44_____________________
+		   ___1____________________
+		   ____22__________________
+		   ______11________________
+		   _________1______________
+		   __________3_____________
+		   ___________44___________
+		   _____________33_________
+		   _______________2________
+		   ________________1_______
+		   _________________4______
+		   ___________________2____
+		   ____________________33__
+		   ______________________4_
+	*/
+	printk("sanitize start\n");
+	/* if there's only one memory region, don't bother */
+	if (*pnr_map < 2) {
+		printk("sanitize bail 0\n");
+		return -1;
+	}
+
+	old_nr = *pnr_map;
+
+	/* bail out if we find any unreasonable addresses in bios map */
+	for (i=0; i<old_nr; i++)
+		if (biosmap[i].addr + biosmap[i].size < biosmap[i].addr) {
+			printk("sanitize bail 1\n");
+			return -1;
+		}
+
+	/* create pointers for initial change-point information (for sorting) */
+	for (i=0; i < 2*old_nr; i++)
+		change_point[i] = &change_point_list[i];
+
+	/* record all known change-points (starting and ending addresses),
+	   omitting those that are for empty memory regions */
+	chgidx = 0;
+	for (i=0; i < old_nr; i++)	{
+		if (biosmap[i].size != 0) {
+			change_point[chgidx]->addr = biosmap[i].addr;
+			change_point[chgidx++]->pbios = &biosmap[i];
+			change_point[chgidx]->addr = biosmap[i].addr + biosmap[i].size;
+			change_point[chgidx++]->pbios = &biosmap[i];
+		}
+	}
+	chg_nr = chgidx;    	/* true number of change-points */
+
+	/* sort change-point list by memory addresses (low -> high) */
+	still_changing = 1;
+	while (still_changing)	{
+		still_changing = 0;
+		for (i=1; i < chg_nr; i++)  {
+			/* if <current_addr> > <last_addr>, swap */
+			/* or, if current=<start_addr> & last=<end_addr>, swap */
+			if ((change_point[i]->addr < change_point[i-1]->addr) ||
+				((change_point[i]->addr == change_point[i-1]->addr) &&
+				 (change_point[i]->addr == change_point[i]->pbios->addr) &&
+				 (change_point[i-1]->addr != change_point[i-1]->pbios->addr))
+			   )
+			{
+				change_tmp = change_point[i];
+				change_point[i] = change_point[i-1];
+				change_point[i-1] = change_tmp;
+				still_changing=1;
+			}
+		}
+	}
+
+	/* create a new bios memory map, removing overlaps */
+	overlap_entries=0;	 /* number of entries in the overlap table */
+	new_bios_entry=0;	 /* index for creating new bios map entries */
+	last_type = 0;		 /* start with undefined memory type */
+	last_addr = 0;		 /* start with 0 as last starting address */
+	/* loop through change-points, determining affect on the new bios map */
+	for (chgidx=0; chgidx < chg_nr; chgidx++)
+	{
+		/* keep track of all overlapping bios entries */
+		if (change_point[chgidx]->addr == change_point[chgidx]->pbios->addr)
+		{
+			/* add map entry to overlap list (> 1 entry implies an overlap) */
+			overlap_list[overlap_entries++]=change_point[chgidx]->pbios;
+		}
+		else
+		{
+			/* remove entry from list (order independent, so swap with last) */
+			for (i=0; i<overlap_entries; i++)
+			{
+				if (overlap_list[i] == change_point[chgidx]->pbios)
+					overlap_list[i] = overlap_list[overlap_entries-1];
+			}
+			overlap_entries--;
+		}
+		/* if there are overlapping entries, decide which "type" to use */
+		/* (larger value takes precedence -- 1=usable, 2,3,4,4+=unusable) */
+		current_type = 0;
+		for (i=0; i<overlap_entries; i++)
+			if (overlap_list[i]->type > current_type)
+				current_type = overlap_list[i]->type;
+		/* continue building up new bios map based on this information */
+		if (current_type != last_type)	{
+			if (last_type != 0)	 {
+				new_bios[new_bios_entry].size =
+					change_point[chgidx]->addr - last_addr;
+				/* move forward only if the new size was non-zero */
+				if (new_bios[new_bios_entry].size != 0)
+					if (++new_bios_entry >= E820MAX)
+						break; 	/* no more space left for new bios entries */
+			}
+			if (current_type != 0)	{
+				new_bios[new_bios_entry].addr = change_point[chgidx]->addr;
+				new_bios[new_bios_entry].type = current_type;
+				last_addr=change_point[chgidx]->addr;
+			}
+			last_type = current_type;
+		}
+	}
+	new_nr = new_bios_entry;   /* retain count for new bios entries */
+
+	/* copy new bios mapping into original location */
+	memcpy(biosmap, new_bios, new_nr*sizeof(struct e820entry));
+	*pnr_map = new_nr;
+
+	printk("sanitize end\n");
+	return 0;
+}
+
+/*
+ * Copy the BIOS e820 map into a safe place.
+ *
+ * Sanity-check it while we're at it..
+ *
+ * If we're lucky and live on a modern system, the setup code
+ * will have given us a memory map that we can use to properly
+ * set up memory.  If we aren't, we'll fake a memory map.
+ *
+ * We check to see that the memory map contains at least 2 elements
+ * before we'll use it, because the detection code in setup.S may
+ * not be perfect and most every PC known to man has two memory
+ * regions: one from 0 to 640k, and one from 1mb up.  (The IBM
+ * thinkpad 560x, for example, does not cooperate with the memory
+ * detection code.)
+ */
+int __init copy_e820_map(struct e820entry * biosmap, int nr_map)
+{
+	/* Only one memory region (or negative)? Ignore it */
+	if (nr_map < 2)
+		return -1;
+
+	do {
+		unsigned long long start = biosmap->addr;
+		unsigned long long size = biosmap->size;
+		unsigned long long end = start + size;
+		unsigned long type = biosmap->type;
+		printk("copy_e820_map() start: %016Lx size: %016Lx end: %016Lx type: %ld\n", start, size, end, type);
+
+		/* Overflow in 64 bits? Ignore the memory map. */
+		if (start > end)
+			return -1;
+
+		/*
+		 * Some BIOSes claim RAM in the 640k - 1M region.
+		 * Not right. Fix it up.
+		 */
+		if (type == E820_RAM) {
+			printk("copy_e820_map() type is E820_RAM\n");
+			if (start < 0x100000ULL && end > 0xA0000ULL) {
+				printk("copy_e820_map() lies in range...\n");
+				if (start < 0xA0000ULL) {
+					printk("copy_e820_map() start < 0xA0000ULL\n");
+					add_memory_region(start, 0xA0000ULL-start, type);
+				}
+				if (end <= 0x100000ULL) {
+					printk("copy_e820_map() end <= 0x100000ULL\n");
+					continue;
+				}
+				start = 0x100000ULL;
+				size = end - start;
+			}
+		}
+		add_memory_region(start, size, type);
+	} while (biosmap++,--nr_map);
+	return 0;
+}
+
diff -Nrup -X 2.6.19-rc2-mm2.org/Documentation/dontdiff 2.6.19-rc2-mm2.org/arch/i386/kernel/setup.c 2.6.19-rc2-mm2/arch/i386/kernel/setup.c
--- 2.6.19-rc2-mm2.org/arch/i386/kernel/setup.c	2006-10-25 16:07:14.000000000 +0800
+++ 2.6.19-rc2-mm2/arch/i386/kernel/setup.c	2006-10-25 15:51:44.000000000 +0800
@@ -195,26 +195,6 @@ static void __init limit_regions(unsigne
 	print_memory_map("limit_regions endfunc");
 }
 
-void __init add_memory_region(unsigned long long start,
-			      unsigned long long size, int type)
-{
-	int x;
-
-	if (!efi_enabled) {
-       		x = e820.nr_map;
-
-		if (x == E820MAX) {
-		    printk(KERN_ERR "Ooops! Too many entries in the memory map!\n");
-		    return;
-		}
-
-		e820.map[x].addr = start;
-		e820.map[x].size = size;
-		e820.map[x].type = type;
-		e820.nr_map++;
-	}
-} /* add_memory_region */
-
 #define E820_DEBUG	1
 
 static void __init print_memory_map(char *who)
@@ -243,237 +223,6 @@ static void __init print_memory_map(char
 	}
 }
 
-/*
- * Sanitize the BIOS e820 map.
- *
- * Some e820 responses include overlapping entries.  The following 
- * replaces the original e820 map with a new one, removing overlaps.
- *
- */
-struct change_member {
-	struct e820entry *pbios; /* pointer to original bios entry */
-	unsigned long long addr; /* address for this change point */
-};
-static struct change_member change_point_list[2*E820MAX] __initdata;
-static struct change_member *change_point[2*E820MAX] __initdata;
-static struct e820entry *overlap_list[E820MAX] __initdata;
-static struct e820entry new_bios[E820MAX] __initdata;
-
-int __init sanitize_e820_map(struct e820entry * biosmap, char * pnr_map)
-{
-	struct change_member *change_tmp;
-	unsigned long current_type, last_type;
-	unsigned long long last_addr;
-	int chgidx, still_changing;
-	int overlap_entries;
-	int new_bios_entry;
-	int old_nr, new_nr, chg_nr;
-	int i;
-
-	/*
-		Visually we're performing the following (1,2,3,4 = memory types)...
-
-		Sample memory map (w/overlaps):
-		   ____22__________________
-		   ______________________4_
-		   ____1111________________
-		   _44_____________________
-		   11111111________________
-		   ____________________33__
-		   ___________44___________
-		   __________33333_________
-		   ______________22________
-		   ___________________2222_
-		   _________111111111______
-		   _____________________11_
-		   _________________4______
-
-		Sanitized equivalent (no overlap):
-		   1_______________________
-		   _44_____________________
-		   ___1____________________
-		   ____22__________________
-		   ______11________________
-		   _________1______________
-		   __________3_____________
-		   ___________44___________
-		   _____________33_________
-		   _______________2________
-		   ________________1_______
-		   _________________4______
-		   ___________________2____
-		   ____________________33__
-		   ______________________4_
-	*/
-	printk("sanitize start\n");
-	/* if there's only one memory region, don't bother */
-	if (*pnr_map < 2) {
-		printk("sanitize bail 0\n");
-		return -1;
-	}
-
-	old_nr = *pnr_map;
-
-	/* bail out if we find any unreasonable addresses in bios map */
-	for (i=0; i<old_nr; i++)
-		if (biosmap[i].addr + biosmap[i].size < biosmap[i].addr) {
-			printk("sanitize bail 1\n");
-			return -1;
-		}
-
-	/* create pointers for initial change-point information (for sorting) */
-	for (i=0; i < 2*old_nr; i++)
-		change_point[i] = &change_point_list[i];
-
-	/* record all known change-points (starting and ending addresses),
-	   omitting those that are for empty memory regions */
-	chgidx = 0;
-	for (i=0; i < old_nr; i++)	{
-		if (biosmap[i].size != 0) {
-			change_point[chgidx]->addr = biosmap[i].addr;
-			change_point[chgidx++]->pbios = &biosmap[i];
-			change_point[chgidx]->addr = biosmap[i].addr + biosmap[i].size;
-			change_point[chgidx++]->pbios = &biosmap[i];
-		}
-	}
-	chg_nr = chgidx;    	/* true number of change-points */
-
-	/* sort change-point list by memory addresses (low -> high) */
-	still_changing = 1;
-	while (still_changing)	{
-		still_changing = 0;
-		for (i=1; i < chg_nr; i++)  {
-			/* if <current_addr> > <last_addr>, swap */
-			/* or, if current=<start_addr> & last=<end_addr>, swap */
-			if ((change_point[i]->addr < change_point[i-1]->addr) ||
-				((change_point[i]->addr == change_point[i-1]->addr) &&
-				 (change_point[i]->addr == change_point[i]->pbios->addr) &&
-				 (change_point[i-1]->addr != change_point[i-1]->pbios->addr))
-			   )
-			{
-				change_tmp = change_point[i];
-				change_point[i] = change_point[i-1];
-				change_point[i-1] = change_tmp;
-				still_changing=1;
-			}
-		}
-	}
-
-	/* create a new bios memory map, removing overlaps */
-	overlap_entries=0;	 /* number of entries in the overlap table */
-	new_bios_entry=0;	 /* index for creating new bios map entries */
-	last_type = 0;		 /* start with undefined memory type */
-	last_addr = 0;		 /* start with 0 as last starting address */
-	/* loop through change-points, determining affect on the new bios map */
-	for (chgidx=0; chgidx < chg_nr; chgidx++)
-	{
-		/* keep track of all overlapping bios entries */
-		if (change_point[chgidx]->addr == change_point[chgidx]->pbios->addr)
-		{
-			/* add map entry to overlap list (> 1 entry implies an overlap) */
-			overlap_list[overlap_entries++]=change_point[chgidx]->pbios;
-		}
-		else
-		{
-			/* remove entry from list (order independent, so swap with last) */
-			for (i=0; i<overlap_entries; i++)
-			{
-				if (overlap_list[i] == change_point[chgidx]->pbios)
-					overlap_list[i] = overlap_list[overlap_entries-1];
-			}
-			overlap_entries--;
-		}
-		/* if there are overlapping entries, decide which "type" to use */
-		/* (larger value takes precedence -- 1=usable, 2,3,4,4+=unusable) */
-		current_type = 0;
-		for (i=0; i<overlap_entries; i++)
-			if (overlap_list[i]->type > current_type)
-				current_type = overlap_list[i]->type;
-		/* continue building up new bios map based on this information */
-		if (current_type != last_type)	{
-			if (last_type != 0)	 {
-				new_bios[new_bios_entry].size =
-					change_point[chgidx]->addr - last_addr;
-				/* move forward only if the new size was non-zero */
-				if (new_bios[new_bios_entry].size != 0)
-					if (++new_bios_entry >= E820MAX)
-						break; 	/* no more space left for new bios entries */
-			}
-			if (current_type != 0)	{
-				new_bios[new_bios_entry].addr = change_point[chgidx]->addr;
-				new_bios[new_bios_entry].type = current_type;
-				last_addr=change_point[chgidx]->addr;
-			}
-			last_type = current_type;
-		}
-	}
-	new_nr = new_bios_entry;   /* retain count for new bios entries */
-
-	/* copy new bios mapping into original location */
-	memcpy(biosmap, new_bios, new_nr*sizeof(struct e820entry));
-	*pnr_map = new_nr;
-
-	printk("sanitize end\n");
-	return 0;
-}
-
-/*
- * Copy the BIOS e820 map into a safe place.
- *
- * Sanity-check it while we're at it..
- *
- * If we're lucky and live on a modern system, the setup code
- * will have given us a memory map that we can use to properly
- * set up memory.  If we aren't, we'll fake a memory map.
- *
- * We check to see that the memory map contains at least 2 elements
- * before we'll use it, because the detection code in setup.S may
- * not be perfect and most every PC known to man has two memory
- * regions: one from 0 to 640k, and one from 1mb up.  (The IBM
- * thinkpad 560x, for example, does not cooperate with the memory
- * detection code.)
- */
-int __init copy_e820_map(struct e820entry * biosmap, int nr_map)
-{
-	/* Only one memory region (or negative)? Ignore it */
-	if (nr_map < 2)
-		return -1;
-
-	do {
-		unsigned long long start = biosmap->addr;
-		unsigned long long size = biosmap->size;
-		unsigned long long end = start + size;
-		unsigned long type = biosmap->type;
-		printk("copy_e820_map() start: %016Lx size: %016Lx end: %016Lx type: %ld\n", start, size, end, type);
-
-		/* Overflow in 64 bits? Ignore the memory map. */
-		if (start > end)
-			return -1;
-
-		/*
-		 * Some BIOSes claim RAM in the 640k - 1M region.
-		 * Not right. Fix it up.
-		 */
-		if (type == E820_RAM) {
-			printk("copy_e820_map() type is E820_RAM\n");
-			if (start < 0x100000ULL && end > 0xA0000ULL) {
-				printk("copy_e820_map() lies in range...\n");
-				if (start < 0xA0000ULL) {
-					printk("copy_e820_map() start < 0xA0000ULL\n");
-					add_memory_region(start, 0xA0000ULL-start, type);
-				}
-				if (end <= 0x100000ULL) {
-					printk("copy_e820_map() end <= 0x100000ULL\n");
-					continue;
-				}
-				start = 0x100000ULL;
-				size = end - start;
-			}
-		}
-		add_memory_region(start, size, type);
-	} while (biosmap++,--nr_map);
-	return 0;
-}
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 struct edd edd;
