Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129554AbRCAI5t>; Thu, 1 Mar 2001 03:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbRCAI5b>; Thu, 1 Mar 2001 03:57:31 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:62967 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S129561AbRCAI5J>; Thu, 1 Mar 2001 03:57:09 -0500
Message-ID: <3A9E0ED8.76416001@mvista.com>
Date: Thu, 01 Mar 2001 00:56:56 -0800
From: Brian Moyle <bmoyle@mvista.com>
Organization: MontaVista Software, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, bmoyle@mvista.com
Subject: Re: 2.4.2-ac6 hangs on boot w/AMD Elan SC520 dev board
In-Reply-To: <E14Y539-0005XE-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------744006DE8246618B2FCC2F00"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------744006DE8246618B2FCC2F00
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I believe the following patch fixes the problem (it worked on the few machines I tested).

Is this along the lines of what you were thinking?

Brian
bmoyle@mvista.com

Alan Cox wrote:
> Having been over the code the problem is indeed the bios reporting overlapping
> /duplicated ranges. That will cause a crash in mm/bootmem when we try and free
> the range twice.
> 
> I suspect you need to add some code to take the E820 map and remove any
> overlaps from it, favouring ROM over RAM if the types disagree (for safety),
> and filter them before you register them with the bootmem in
> arch/i386/kernel/setup.c
--------------744006DE8246618B2FCC2F00
Content-Type: text/plain; charset=us-ascii;
 name="e820bios.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e820bios.patch"

--- linux-2.4.2-ac6/arch/i386/kernel/setup.c	Thu Mar  1 00:24:26 2001
+++ linux/arch/i386/kernel/setup.c	Thu Mar  1 00:29:34 2001
@@ -58,6 +58,9 @@
  *  Massive cleanup of CPU detection and bug handling;
  *  Transmeta CPU detection,
  *  H. Peter Anvin <hpa@zytor.com>, November 2000
+ *
+ *  Added E820 sanitization routine (removes overlapping memory regions);
+ *  Brian Moyle <bmoyle@mvista.com>, February 2001
  */
 
 /*
@@ -438,6 +441,126 @@
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
+		for (i=1; i < 2*old_nr; i++)
+		{
+			if (change_point[i]->addr < change_point[i-1]->addr)  {
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
+		/* (larger value takes precedence -- 1=usable, 2,3,4,+=unusable) */
+		current_type = 0;
+		for (i=0; i<overlap_entries; i++)
+			if (overlap_list[i]->type > current_type)
+				current_type = overlap_list[i]->type;
+		/* continue building up new bios map based on this information */
+		if (current_type != last_type)	{
+			if (last_type != 0)	 {
+				new_bios[new_bios_entry].size =
+					change_point[chgidx]->addr - last_addr;
+				if (++new_bios_entry >= E820MAX)
+					break;	/* no more space left for new bios entries */
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
@@ -504,6 +627,7 @@
 	 * Otherwise fake a memory map; one section from 0k->640k,
 	 * the next section from 1mb->appropriate_mem_k
 	 */
+	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
 	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
 		unsigned long mem_size;
 
@@ -2267,7 +2391,7 @@
 			p+=sprintf(p, " (%dMhz/%dMhz FSB)\n", c->cpuclock,
 						c->busclock);
 		else if(c->busclock)
-			p+sprintf(p, " (%dMhz FSB)\n", c->busclock);
+			p+=sprintf(p, " (%dMhz FSB)\n", c->busclock);
 		else
 			p+=sprintf(p, "\n");
 			

--------------744006DE8246618B2FCC2F00--

