Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbTLSUQi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 15:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbTLSUQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 15:16:38 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:12673 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263595AbTLSUQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 15:16:21 -0500
Message-ID: <3FE35B94.4030200@us.ibm.com>
Date: Fri, 19 Dec 2003 12:12:04 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mbligh@aracnet.com, john stultz <johnstul@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>, Greg KH <greg@kroah.com>
Subject: [PATCH] Fix Summit EBDA parsing (2/2)
Content-Type: multipart/mixed;
 boundary="------------000302010204090202090003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000302010204090202090003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The code to parse the EBDA (Extended BIOS Data Area) for Summit boxen is 
broken because it does not handle Lookout boxen (external boxes full of 
additional PCI slots).  This patch cleans up some ugliness in 
arch/i386/kernel/summit.c as well as fixing the code to handle Lookout 
boxen and various other configurations of PCI buses.  Without this, 
Summit PCI bus to node mappings are totally hosed with Lookout boxen 
attatched.  This patch depends upon the GENERICARCH fix I just posted. 
Please apply.

BTW, Greg, this patch is *slightly* different than the one you have in 
your tree due to a small compile error when built on UP.

Cheers!

-Matt

--------------000302010204090202090003
Content-Type: text/plain;
 name="02-ebda_parse_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-ebda_parse_fix.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-01/arch/i386/kernel/summit.c linux-2.6.0-02/arch/i386/kernel/summit.c
--- linux-2.6.0-01/arch/i386/kernel/summit.c	Fri Dec 19 11:36:03 2003
+++ linux-2.6.0-02/arch/i386/kernel/summit.c	Fri Dec 19 11:36:50 2003
@@ -31,83 +31,83 @@
 #include <asm/io.h>
 #include <asm/mach-summit/mach_mpparse.h>
 
-static void __init setup_pci_node_map_for_wpeg(int wpeg_num, struct rio_table_hdr *rth, 
-		struct scal_detail **scal_nodes, struct rio_detail **rio_nodes){
-	int twst_num = 0, node = 0, first_bus = 0;
-	int i, bus, num_busses;
-
-	for(i = 0; i < rth->num_rio_dev; i++){
-		if (rio_nodes[i]->node_id == rio_nodes[wpeg_num]->owner_id){
-			twst_num = rio_nodes[i]->owner_id;
+static struct rio_table_hdr *rio_table_hdr __initdata;
+static struct scal_detail   *scal_devs[MAX_NUMNODES] __initdata;
+static struct rio_detail    *rio_devs[MAX_NUMNODES*4] __initdata;
+
+static int __init setup_pci_node_map_for_wpeg(int wpeg_num, int last_bus)
+{
+	int twister = 0, node = 0;
+	int i, bus, num_buses;
+
+	for(i = 0; i < rio_table_hdr->num_rio_dev; i++){
+		if (rio_devs[i]->node_id == rio_devs[wpeg_num]->owner_id){
+			twister = rio_devs[i]->owner_id;
 			break;
 		}
 	}
-	if (i == rth->num_rio_dev){
-		printk("%s: Couldn't find owner Cyclone for Winnipeg!\n", __FUNCTION__);
-		return;
+	if (i == rio_table_hdr->num_rio_dev){
+		printk(KERN_ERR "%s: Couldn't find owner Cyclone for Winnipeg!\n", __FUNCTION__);
+		return last_bus;
 	}
 
-	for(i = 0; i < rth->num_scal_dev; i++){
-		if (scal_nodes[i]->node_id == twst_num){
-			node = scal_nodes[i]->node_id;
+	for(i = 0; i < rio_table_hdr->num_scal_dev; i++){
+		if (scal_devs[i]->node_id == twister){
+			node = scal_devs[i]->node_id;
 			break;
 		}
 	}
-	if (i == rth->num_scal_dev){
-		printk("%s: Couldn't find owner Twister for Cyclone!\n", __FUNCTION__);
-		return;
+	if (i == rio_table_hdr->num_scal_dev){
+		printk(KERN_ERR "%s: Couldn't find owner Twister for Cyclone!\n", __FUNCTION__);
+		return last_bus;
 	}
 
-	switch (rio_nodes[wpeg_num]->type){
+	switch (rio_devs[wpeg_num]->type){
 	case CompatWPEG:
-		/* The Compatability Winnipeg controls the legacy busses
-		   (busses 0 & 1), the 66MHz PCI bus [2 slots] (bus 2), 
-		   and the "extra" busses in case a PCI-PCI bridge card is 
-		   used in either slot (busses 3 & 4): total 5 busses. */
-		num_busses = 5;
-		/* The BIOS numbers the busses starting at 1, and in a 
-		   slightly wierd manner.  You'll have to trust that 
-		   the math used below to determine the number of the 
-		   first bus works. */
-		first_bus = (rio_nodes[wpeg_num]->first_slot - 1) * 2;
+		/* The Compatability Winnipeg controls the 2 legacy buses, 
+		 * the 66MHz PCI bus [2 slots] and the 2 "extra" buses in case 
+		 * a PCI-PCI bridge card is used in either slot: total 5 buses.
+		 */
+		num_buses = 5;
 		break;
 	case AltWPEG:
-		/* The Alternate/Secondary Winnipeg controls the 1st 133MHz 
-		   bus [1 slot] & its "extra" bus (busses 0 & 1), the 2nd 
-		   133MHz bus [1 slot] & its "extra" bus (busses 2 & 3), the 
-		   100MHz bus [2 slots] (bus 4), and the "extra" busses for 
-		   the 2 100MHz slots (busses 5 & 6): total 7 busses. */
-		num_busses = 7;
-		first_bus = (rio_nodes[wpeg_num]->first_slot * 2) - 1;
+		/* The Alternate Winnipeg controls the 2 133MHz buses [1 slot 
+		 * each], their 2 "extra" buses, the 100MHz bus [2 slots] and 
+		 * the "extra" buses for each of those slots: total 7 buses.
+		 */
+		num_buses = 7;
 		break;
 	case LookOutAWPEG:
 	case LookOutBWPEG:
-		printk("%s: LookOut Winnipegs not supported yet!\n", __FUNCTION__);
-		return;
+		/* A Lookout Winnipeg controls 3 100MHz buses [2 slots each] 
+		 * & the "extra" buses for each of those slots: total 9 buses.
+		 */
+		num_buses = 9;
+		break;
 	default:
-		printk("%s: Unsupported Winnipeg type!\n", __FUNCTION__);
-		return;
+		printk(KERN_INFO "%s: Unsupported Winnipeg type!\n", __FUNCTION__);
+		return last_bus;
 	}
 
-	for(bus = first_bus; bus < first_bus + num_busses; bus++)
+	for(bus = last_bus; bus < last_bus + num_buses; bus++)
 		mp_bus_id_to_node[bus] = node;
+	return bus;
 }
 
-static int __init build_detail_arrays(struct rio_table_hdr *rth,
-		struct scal_detail **sd, struct rio_detail **rd){
+static int __init build_detail_arrays(void)
+{
 	unsigned long ptr;
 	int i, scal_detail_size, rio_detail_size;
 
-	if ((rth->num_scal_dev > MAX_NUMNODES) ||
-	    (rth->num_rio_dev > MAX_NUMNODES * 2)){
-		printk("%s: MAX_NUMNODES too low!  Defined as %d, but system has %d nodes.\n", __FUNCTION__, MAX_NUMNODES, rth->num_scal_dev);
-		return 1;
+	if (rio_table_hdr->num_scal_dev > MAX_NUMNODES){
+		printk(KERN_WARNING "%s: MAX_NUMNODES too low!  Defined as %d, but system has %d nodes.\n", __FUNCTION__, MAX_NUMNODES, rio_table_hdr->num_scal_dev);
+		return 0;
 	}
 
-	switch (rth->version){
+	switch (rio_table_hdr->version){
 	default:
-		printk("%s: Bad Rio Grande Table Version: %d\n", __FUNCTION__, rth->version);
-		return 1;
+		printk(KERN_WARNING "%s: Invalid Rio Grande Table Version: %d\n", __FUNCTION__, rio_table_hdr->version);
+		return 0;
 	case 2:
 		scal_detail_size = 11;
 		rio_detail_size = 13;
@@ -118,32 +118,27 @@ static int __init build_detail_arrays(st
 		break;
 	}
 
-	ptr = (unsigned long)rth + 3;
-	for(i = 0; i < rth->num_scal_dev; i++)
-		sd[i] = (struct scal_detail *)(ptr + (scal_detail_size * i));
-
-	ptr += scal_detail_size * rth->num_scal_dev;
-	for(i = 0; i < rth->num_rio_dev; i++)
-		rd[i] = (struct rio_detail *)(ptr + (rio_detail_size * i));
+	ptr = (unsigned long)rio_table_hdr + 3;
+	for(i = 0; i < rio_table_hdr->num_scal_dev; i++, ptr += scal_detail_size)
+		scal_devs[i] = (struct scal_detail *)ptr;
 
-	return 0;
+	for(i = 0; i < rio_table_hdr->num_rio_dev; i++, ptr += rio_detail_size)
+		rio_devs[i] = (struct rio_detail *)ptr;
+
+	return 1;
 }
 
 void __init setup_summit(void)
 {
-	struct rio_table_hdr	*rio_table_hdr = NULL;
-	struct scal_detail	*scal_devs[MAX_NUMNODES];
-	struct rio_detail	*rio_devs[MAX_NUMNODES*2];
 	unsigned long		ptr;
 	unsigned short		offset;
-	int			i;
-
-	memset(mp_bus_id_to_node, -1, sizeof(mp_bus_id_to_node));
+	int			i, next_wpeg, next_bus = 0;
 
 	/* The pointer to the EBDA is stored in the word @ phys 0x40E(40:0E) */
 	ptr = *(unsigned short *)phys_to_virt(0x40Eul);
 	ptr = (unsigned long)phys_to_virt(ptr << 4);
 
+	rio_table_hdr = NULL;
 	offset = 0x180;
 	while (offset){
 		/* The block id is stored in the 2nd word */
@@ -156,15 +151,30 @@ void __init setup_summit(void)
 		offset = *((unsigned short *)(ptr + offset));
 	}
 	if (!rio_table_hdr){
-		printk("%s: Unable to locate Rio Grande Table in EBDA - bailing!\n", __FUNCTION__);
+		printk(KERN_ERR "%s: Unable to locate Rio Grande Table in EBDA - bailing!\n", __FUNCTION__);
 		return;
 	}
 
-	if (build_detail_arrays(rio_table_hdr, scal_devs, rio_devs))
+	if (!build_detail_arrays())
 		return;
 
-	for(i = 0; i < rio_table_hdr->num_rio_dev; i++)
-		if (is_WPEG(rio_devs[i]->type))
-			/* It's a Winnipeg, it's got PCI Busses */
-			setup_pci_node_map_for_wpeg(i, rio_table_hdr, scal_devs, rio_devs);
+	/* The first Winnipeg we're looking for has an index of 0 */
+	next_wpeg = 0;
+	do {
+		for(i = 0; i < rio_table_hdr->num_rio_dev; i++){
+			if (is_WPEG(rio_devs[i]) && rio_devs[i]->WP_index == next_wpeg){
+				/* It's the Winnipeg we're looking for! */
+				next_bus = setup_pci_node_map_for_wpeg(i, next_bus);
+				next_wpeg++;
+				break;
+			}
+		}
+		/*
+		 * If we go through all Rio devices and don't find one with 
+		 * the next index, it means we've found all the Winnipegs, 
+		 * and thus all the PCI buses.
+		 */
+		if (i == rio_table_hdr->num_rio_dev)
+			next_wpeg = 0;
+	} while (next_wpeg != 0);
 }
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-01/include/asm-i386/mach-summit/mach_mpparse.h linux-2.6.0-02/include/asm-i386/mach-summit/mach_mpparse.h
--- linux-2.6.0-01/include/asm-i386/mach-summit/mach_mpparse.h	Fri Dec 19 11:36:03 2003
+++ linux-2.6.0-02/include/asm-i386/mach-summit/mach_mpparse.h	Fri Dec 19 11:36:50 2003
@@ -110,9 +110,9 @@ typedef enum {
 	LookOutBWPEG  = 7,  /* LookOut WPEG                        */
 } node_type;
 
-static inline int is_WPEG(node_type type){
-	return (type == CompatWPEG || type == AltWPEG ||
-		type == LookOutAWPEG || type == LookOutBWPEG);
+static inline int is_WPEG(struct rio_detail *rio){
+	return (rio->type == CompatWPEG || rio->type == AltWPEG ||
+		rio->type == LookOutAWPEG || rio->type == LookOutBWPEG);
 }
 
 #endif /* __ASM_MACH_MPPARSE_H */

--------------000302010204090202090003--

