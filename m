Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130269AbRCBBdT>; Thu, 1 Mar 2001 20:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130272AbRCBBdK>; Thu, 1 Mar 2001 20:33:10 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:60657 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S130269AbRCBBdD>; Thu, 1 Mar 2001 20:33:03 -0500
Message-ID: <3A9EF83E.A7911FE8@mvista.com>
Date: Thu, 01 Mar 2001 17:32:46 -0800
From: Brian Moyle <bmoyle@mvista.com>
Organization: MontaVista Software, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, bmoyle@mvista.com
Subject: Re: 2.4.2-ac6 hangs on boot w/AMD Elan SC520 dev board
In-Reply-To: <E14Y539-0005XE-00@the-village.bc.nu> <3A9E0ED8.76416001@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------F291048CCCD55D0209F54B0E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F291048CCCD55D0209F54B0E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I spent some time testing the previous patch today.  I found a couple of corner cases that weren't handled correctly in the first version.

I've attached a new version (against 2.4.2-ac7) that should fix those problems.

Brian
bmoyle@mvista.com
--------------F291048CCCD55D0209F54B0E
Content-Type: text/plain; charset=us-ascii;
 name="e820bios.patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e820bios.patch2"

--- linux-2.4.2-ac7/arch/i386/kernel/setup.c	Thu Mar  1 15:39:08 2001
+++ linux/arch/i386/kernel/setup.c	Thu Mar  1 15:59:06 2001
@@ -58,6 +58,9 @@
  *  Massive cleanup of CPU detection and bug handling;
  *  Transmeta CPU detection,
  *  H. Peter Anvin <hpa@zytor.com>, November 2000
+ *
+ *  Added E820 sanitization routine (removes overlapping memory regions);
+ *  Brian Moyle <bmoyle@mvista.com>, February 2001
  */
 
 /*
@@ -438,6 +441,170 @@
 }
 
 /*
+ * Sanitize the BIOS e820 map.
+ *
+ * Some e820 responses include overlapping entries.  The following 
+ * replaces the original e820 map with a new one, removing overlaps.
+ *
+ */
+static int __init sanitize_e820_map(struct e820entry * biosmap, char * pnr_map)
+{
+	struct change_member {
+		struct e820entry *pbios; /* pointer to original bios entry */
+		unsigned long long addr; /* address for this change point */
+	};
+	struct change_member change_point_list[2*E820MAX];
+	struct change_member *change_point[2*E820MAX];
+	struct e820entry *overlap_list[E820MAX];
+	struct e820entry new_bios[E820MAX];
+	struct change_member *change_tmp;
+	unsigned long current_type, last_type;
+	unsigned long long last_addr;
+	int chgidx, still_changing;
+	int overlap_entries;
+	int new_bios_entry;
+	int old_nr, new_nr;
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
+
+	/* if there's only one memory region, don't bother */
+	if (*pnr_map < 2)
+		return -1;
+
+	old_nr = *pnr_map;
+
+	/* bail out if we find any unreasonable addresses in bios map */
+	for (i=0; i<old_nr; i++)
+		if (biosmap[i].addr + biosmap[i].size < biosmap[i].addr)
+			return -1;
+
+	/* create pointers for initial change-point information (for sorting) */
+	for (i=0; i < 2*old_nr; i++)
+		change_point[i] = &change_point_list[i];
+
+	/* record all known change-points (starting and ending addresses) */
+	chgidx = 0;
+	for (i=0; i < old_nr; i++)	{
+		change_point[chgidx]->addr = biosmap[i].addr;
+		change_point[chgidx++]->pbios = &biosmap[i];
+		change_point[chgidx]->addr = biosmap[i].addr + biosmap[i].size;
+		change_point[chgidx++]->pbios = &biosmap[i];
+	}
+
+	/* sort change-point list by memory addresses (low -> high) */
+	still_changing = 1;
+	while (still_changing)	{
+		still_changing = 0;
+		for (i=1; i < 2*old_nr; i++)  {
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
+	for (chgidx=0; chgidx < 2*old_nr; chgidx++)
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
+	return 0;
+}
+
+/*
  * Copy the BIOS e820 map into a safe place.
  *
  * Sanity-check it while we're at it..
@@ -504,6 +671,7 @@
 	 * Otherwise fake a memory map; one section from 0k->640k,
 	 * the next section from 1mb->appropriate_mem_k
 	 */
+	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
 	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
 		unsigned long mem_size;
 

--------------F291048CCCD55D0209F54B0E--

