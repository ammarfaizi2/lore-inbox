Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132037AbRDEAhx>; Wed, 4 Apr 2001 20:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132042AbRDEAho>; Wed, 4 Apr 2001 20:37:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:9203 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S132037AbRDEAhe>; Wed, 4 Apr 2001 20:37:34 -0400
Message-ID: <3ACBBE09.E4978600@mvista.com>
Date: Wed, 04 Apr 2001 17:36:25 -0700
From: Brian Moyle <bmoyle@mvista.com>
Organization: MontaVista Software, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        bmoyle@mvista.com
Subject: Re: 2.4.2-ac6 hangs on boot w/AMD Elan SC520 dev board
In-Reply-To: <200102280312.TAA13404@bia.mvista.com> <E14Y539-0005XE-00@the-village.bc.nu> <20010301121210.B34@(none)>
Content-Type: multipart/mixed;
 boundary="------------37F25DB919E72E1AF25FAF0D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------37F25DB919E72E1AF25FAF0D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Changes are isolated to sanitize_e820_map().

(patch is against linux-2.4.3-ac3)

This change informs the user when overlaping memory regions have been
found in their e820 map.  If overlaps were found, it displays the 
original mapping and then creates an adjusted map (w/o overlaps).  If 
no overlaps were found, it leaves the original bios-provided map alone.  
Formatting changes were also made so source fits w/in 80 columns.

Hope it helps,

Brian

Pavel Machek wrote:
> > I suspect you need to add some code to take the E820 map and remove any
> > overlaps from it, favouring ROM over RAM if the types disagree (for safety),
> > and filter them before you register them with the bootmem in
> > arch/i386/kernel/setup.c
> 
> ...plus prining ?@#@&#&$ BIOS reports invalid mem map
> seems like good idea, so that bios bugs are fixed.
--------------37F25DB919E72E1AF25FAF0D
Content-Type: text/plain; charset=us-ascii;
 name="e820bios.patch3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e820bios.patch3"

--- linux-2.4.3-ac3/arch/i386/kernel/setup.c	Wed Apr  4 16:30:35 2001
+++ linux/arch/i386/kernel/setup.c	Wed Apr  4 16:34:03 2001
@@ -447,8 +447,8 @@
 /*
  * Sanitize the BIOS e820 map.
  *
- * Some e820 responses include overlapping entries.  The following 
- * replaces the original e820 map with a new one, removing overlaps.
+ * Some e820 responses include overlapping memory regions.  If overlaps are
+ * found, we'll replace the original e820 map with a new one (w/o overlaps).
  *
  */
 static int __init sanitize_e820_map(struct e820entry * biosmap, char * pnr_map)
@@ -464,14 +464,14 @@
 	struct change_member *change_tmp;
 	unsigned long current_type, last_type;
 	unsigned long long last_addr;
+	int overlap_entries, overlaps_found;
 	int chgidx, still_changing;
-	int overlap_entries;
 	int new_bios_entry;
 	int old_nr, new_nr;
 	int i;
 
 	/*
-		Visually we're performing the following (1,2,3,4 = memory types)...
+		Visually, we're performing the following (1,2,3,4 = mem types):
 
 		Sample memory map (w/overlaps):
 		   ____22__________________
@@ -517,7 +517,7 @@
 		if (biosmap[i].addr + biosmap[i].size < biosmap[i].addr)
 			return -1;
 
-	/* create pointers for initial change-point information (for sorting) */
+	/* create pointers for initial change-point info (used for sorting) */
 	for (i=0; i < 2*old_nr; i++)
 		change_point[i] = &change_point_list[i];
 
@@ -535,13 +535,15 @@
 	while (still_changing)	{
 		still_changing = 0;
 		for (i=1; i < 2*old_nr; i++)  {
-			/* if <current_addr> > <last_addr>, swap */
-			/* or, if current=<start_addr> & last=<end_addr>, swap */
-			if ((change_point[i]->addr < change_point[i-1]->addr) ||
-				((change_point[i]->addr == change_point[i-1]->addr) &&
-				 (change_point[i]->addr == change_point[i]->pbios->addr) &&
-				 (change_point[i-1]->addr != change_point[i-1]->pbios->addr))
-			   )
+			/* if <current_addr> < <last_addr>, swap */
+			/* or, if curr=<start_addr> & last=<end_addr>, swap */
+			if ((change_point[i]->addr<change_point[i-1]->addr) ||
+				((change_point[i]->addr ==
+					change_point[i-1]->addr) &&
+				 (change_point[i]->addr ==
+					change_point[i]->pbios->addr) &&
+				 (change_point[i-1]->addr !=
+					change_point[i-1]->pbios->addr)))
 			{
 				change_tmp = change_point[i];
 				change_point[i] = change_point[i-1];
@@ -552,47 +554,72 @@
 	}
 
 	/* create a new bios memory map, removing overlaps */
-	overlap_entries=0;	 /* number of entries in the overlap table */
-	new_bios_entry=0;	 /* index for creating new bios map entries */
-	last_type = 0;		 /* start with undefined memory type */
-	last_addr = 0;		 /* start with 0 as last starting address */
-	/* loop through change-points, determining affect on the new bios map */
+	overlaps_found=0;   /* indicates whether or not an overlap was found */
+	overlap_entries=0;  /* number of entries in the overlap table */
+	new_bios_entry=0;   /* index for creating new bios map entries */
+	last_type = 0;	    /* start with undefined memory type */
+	last_addr = 0;	    /* start with 0 as last starting address */
+	/* loop through change-points, determining affect on new bios map */
 	for (chgidx=0; chgidx < 2*old_nr; chgidx++)
 	{
 		/* keep track of all overlapping bios entries */
-		if (change_point[chgidx]->addr == change_point[chgidx]->pbios->addr)
+		if (change_point[chgidx]->addr ==
+			change_point[chgidx]->pbios->addr)
 		{
-			/* add map entry to overlap list (> 1 entry implies an overlap) */
-			overlap_list[overlap_entries++]=change_point[chgidx]->pbios;
+			/* add entry to overlap list (>1 implies overlap) */
+			overlap_list[overlap_entries++]=
+				change_point[chgidx]->pbios;
+			/* check for legitimately overlapped memory regions */
+			if (overlap_entries == 2)
+			{
+				/* note: it's possible to have 2 entries w/out
+				   an overlap ([0]=end_addr, [1]=start_addr) */
+				if ((overlap_list[0]->addr +
+					overlap_list[0]->size) !=
+						(overlap_list[1]->addr))
+				{
+					overlaps_found = 1;
+				}
+			}
+			else if (overlap_entries > 1)
+			{
+				overlaps_found = 1;
+			}
 		}
 		else
 		{
-			/* remove entry from list (order independent, so swap with last) */
+			/* remove entry from list (order independent, so swap
+			   with last) */
 			for (i=0; i<overlap_entries; i++)
 			{
-				if (overlap_list[i] == change_point[chgidx]->pbios)
-					overlap_list[i] = overlap_list[overlap_entries-1];
+				if (overlap_list[i] ==
+					change_point[chgidx]->pbios)
+				{
+					overlap_list[i] =
+						overlap_list[overlap_entries-1];
+				}
 			}
 			overlap_entries--;
 		}
-		/* if there are overlapping entries, decide which "type" to use */
-		/* (larger value takes precedence -- 1=usable, 2,3,4,4+=unusable) */
+		/* if overlapping entries, decide which "type" to use */
+		/* (larger takes precedence -- 1=usable, 2,3,4,4+=unusable) */
 		current_type = 0;
 		for (i=0; i<overlap_entries; i++)
 			if (overlap_list[i]->type > current_type)
 				current_type = overlap_list[i]->type;
-		/* continue building up new bios map based on this information */
+		/* continue building new bios map based on this information */
 		if (current_type != last_type)	{
 			if (last_type != 0)	 {
 				new_bios[new_bios_entry].size =
 					change_point[chgidx]->addr - last_addr;
-				/* move forward only if the new size was non-zero */
+				/* move forward if the new size is non-zero */
 				if (new_bios[new_bios_entry].size != 0)
 					if (++new_bios_entry >= E820MAX)
-						break; 	/* no more space left for new bios entries */
+						break;	/* no more space */
 			}
 			if (current_type != 0)	{
-				new_bios[new_bios_entry].addr = change_point[chgidx]->addr;
+				new_bios[new_bios_entry].addr =
+					change_point[chgidx]->addr;
 				new_bios[new_bios_entry].type = current_type;
 				last_addr=change_point[chgidx]->addr;
 			}
@@ -601,9 +628,36 @@
 	}
 	new_nr = new_bios_entry;   /* retain count for new bios entries */
 
-	/* copy new bios mapping into original location */
-	memcpy(biosmap, new_bios, new_nr*sizeof(struct e820entry));
-	*pnr_map = new_nr;
+	/* if we found overlaps, replace bios map with an adjusted version */
+	if (overlaps_found == 1)
+	{
+		printk(KERN_INFO "Overlaps found in BIOS memory map:\n");
+		for (i = 0; i < old_nr; i++) {
+			printk(" BIOS-e820: %016Lx - %016Lx ", biosmap[i].addr,
+				biosmap[i].addr + biosmap[i].size);
+			switch (biosmap[i].type) {
+				case E820_RAM:
+					printk("(usable)\n");
+					break;
+				case E820_RESERVED:
+					printk("(reserved)\n");
+					break;
+				case E820_ACPI:
+					printk("(ACPI data)\n");
+					break;
+				case E820_NVS:
+					printk("(ACPI NVS)\n");
+					break;
+				default:
+					printk("type %lu\n", biosmap[i].type);
+					break;
+			}
+		}
+		printk(KERN_INFO "Compensating...\n");
+		/* copy new bios mapping into original location */
+		memcpy(biosmap, new_bios, new_nr*sizeof(struct e820entry));
+		*pnr_map = new_nr;
+	}
 
 	return 0;
 }

--------------37F25DB919E72E1AF25FAF0D--

