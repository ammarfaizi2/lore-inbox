Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTCOBlB>; Fri, 14 Mar 2003 20:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261294AbTCOBlB>; Fri, 14 Mar 2003 20:41:01 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:8917 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261292AbTCOBku>;
	Fri, 14 Mar 2003 20:40:50 -0500
Message-ID: <3E728528.6070704@us.ibm.com>
Date: Fri, 14 Mar 2003 17:43:04 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [patch] Summit support for pcibus <-> cpumask topology [2/2]
References: <1047676332.5409.374.camel@mulgrave> <3E7284CA.6010907@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------060007000100010400010700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060007000100010400010700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

James Bottomley wrote:
>> This patch adds a new file, arch/i386/kernel/summit.c, for 
>> summit-specific code.  Adds some structures to mach_mpparse.h.  Also 
>> adds a hook in setup_arch() to dig out the PCI info, and stores it in 
>> the mp_bus_id_to_node[] array, where it can be read by the topology 
>> functions.
>
>
> Wouldn't this file be better in arch/i386/mach-summit in keeping with
> all the other subarch stuff?
>
> While you're creating a separate file for summit, could you move the
> summit specific variables (mpparse.c:x86_summit is the only one, I
> think) into it so we can clean all the summit references out of the main
> line?
>
> Thanks,
>
> James

Ok...  Split into two patches now.  Patch 1 moves summit stuff into
subarch.  Just creates the directory and populates it with setup.c,
topology.c, and the Makefile from mach-default.  Also creates a summit.c
which only has the x86_summit variable you referred to.

Patch 2 adds all pcimapping code, but adds it in the subarch dir, not
i386/kernel/.

Cheers!

-Matt

--------------060007000100010400010700
Content-Type: text/plain;
 name="summit_pcimap-2.5.64-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="summit_pcimap-2.5.64-patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-summit_subarch/arch/i386/kernel/setup.c linux-2.5.64-summit_pcimap/arch/i386/kernel/setup.c
--- linux-2.5.64-summit_subarch/arch/i386/kernel/setup.c	Tue Mar  4 19:29:18 2003
+++ linux-2.5.64-summit_pcimap/arch/i386/kernel/setup.c	Fri Mar 14 09:56:21 2003
@@ -918,6 +918,9 @@
 	if (smp_found_config)
 		get_smp_config();
 #endif
+#ifdef CONFIG_X86_SUMMIT
+	setup_summit();
+#endif
 
 	register_memory(max_low_pfn);
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-summit_subarch/arch/i386/mach-summit/summit.c linux-2.5.64-summit_pcimap/arch/i386/mach-summit/summit.c
--- linux-2.5.64-summit_subarch/arch/i386/mach-summit/summit.c	Fri Mar 14 17:32:48 2003
+++ linux-2.5.64-summit_pcimap/arch/i386/mach-summit/summit.c	Fri Mar 14 17:09:02 2003
@@ -26,4 +26,139 @@
  *
  */
 
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <asm/io.h>
+#include <mach_mpparse.h>
+
 int x86_summit = 0;
+
+static void __init setup_pci_node_map_for_wpeg(int wpeg_num, struct rio_table_hdr *rth, 
+		struct scal_detail **scal_nodes, struct rio_detail **rio_nodes){
+	int twst_num = 0, node = 0, first_bus = 0;
+	int i, bus, num_busses;
+
+	for(i = 0; i < rth->num_rio_dev; i++){
+		if (rio_nodes[i]->node_id == rio_nodes[wpeg_num]->owner_id){
+			twst_num = rio_nodes[i]->owner_id;
+			break;
+		}
+	}
+	if (i == rth->num_rio_dev){
+		printk("%s: Couldn't find owner Cyclone for Winnipeg!\n", __FUNCTION__);
+		return;
+	}
+
+	for(i = 0; i < rth->num_scal_dev; i++){
+		if (scal_nodes[i]->node_id == twst_num){
+			node = scal_nodes[i]->node_id;
+			break;
+		}
+	}
+	if (i == rth->num_scal_dev){
+		printk("%s: Couldn't find owner Twister for Cyclone!\n", __FUNCTION__);
+		return;
+	}
+
+	switch (rio_nodes[wpeg_num]->type){
+	case CompatWPEG:
+		/* The Compatability Winnipeg controls the legacy busses
+		   (busses 0 & 1), the 66MHz PCI bus [2 slots] (bus 2), 
+		   and the "extra" busses in case a PCI-PCI bridge card is 
+		   used in either slot (busses 3 & 4): total 5 busses. */
+		num_busses = 5;
+		/* The BIOS numbers the busses starting at 1, and in a 
+		   slightly wierd manner.  You'll have to trust that 
+		   the math used below to determine the number of the 
+		   first bus works. */
+		first_bus = (rio_nodes[wpeg_num]->first_slot - 1) * 2;
+		break;
+	case AltWPEG:
+		/* The Alternate/Secondary Winnipeg controls the 1st 133MHz 
+		   bus [1 slot] & its "extra" bus (busses 0 & 1), the 2nd 
+		   133MHz bus [1 slot] & its "extra" bus (busses 2 & 3), the 
+		   100MHz bus [2 slots] (bus 4), and the "extra" busses for 
+		   the 2 100MHz slots (busses 5 & 6): total 7 busses. */
+		num_busses = 7;
+		first_bus = (rio_nodes[wpeg_num]->first_slot * 2) - 1;
+		break;
+	case LookOutAWPEG:
+	case LookOutBWPEG:
+		printk("%s: LookOut Winnipegs not supported yet!\n", __FUNCTION__);
+		return;
+	default:
+		printk("%s: Unsupported Winnipeg type!\n", __FUNCTION__);
+		return;
+	}
+
+	for(bus = first_bus; bus < first_bus + num_busses; bus++)
+		mp_bus_id_to_node[bus] = node;
+}
+
+static void __init build_detail_arrays(struct rio_table_hdr *rth,
+		struct scal_detail **sd, struct rio_detail **rd){
+	unsigned long ptr;
+	int i, scal_detail_size, rio_detail_size;
+
+	switch (rth->version){
+	default:
+		printk("%s: Bad Rio Grande Table Version: %d\n", __FUNCTION__, rth->version);
+		/* Fall through to default to version 2 spec */
+	case 2:
+		scal_detail_size = 11;
+		rio_detail_size = 13;
+		break;
+	case 3:
+		scal_detail_size = 12;
+		rio_detail_size = 15;
+		break;
+	}
+
+	ptr = (unsigned long)rth + 3;
+	for(i = 0; i < rth->num_scal_dev; i++)
+		sd[i] = (struct scal_detail *)(ptr + (scal_detail_size * i));
+
+	ptr += scal_detail_size * rth->num_scal_dev;
+	for(i = 0; i < rth->num_rio_dev; i++)
+		rd[i] = (struct rio_detail *)(ptr + (rio_detail_size * i));
+}
+
+void __init setup_summit(void)
+{
+	struct rio_table_hdr	*rio_table_hdr = NULL;
+	struct scal_detail	*scal_devs[MAX_NUMNODES];
+	struct rio_detail	*rio_devs[MAX_NUMNODES*2];
+	unsigned long		ptr;
+	unsigned short		offset;
+	int			i;
+
+	memset(mp_bus_id_to_node, -1, sizeof(mp_bus_id_to_node));
+
+	/* The pointer to the EBDA is stored in the word @ phys 0x40E(40:0E) */
+	ptr = *(unsigned short *)phys_to_virt(0x40Eul);
+	ptr = (unsigned long)phys_to_virt(ptr << 4);
+
+	offset = 0x180;
+	while (offset){
+		/* The block id is stored in the 2nd word */
+		if (*((unsigned short *)(ptr + offset + 2)) == 0x4752){
+			/* set the pointer past the offset & block id */
+			rio_table_hdr = (struct rio_table_hdr *)(ptr + offset + 4);
+			break;
+		}
+		/* The next offset is stored in the 1st word.  0 means no more */
+		offset = *((unsigned short *)(ptr + offset));
+	}
+	if (!rio_table_hdr){
+		printk("%s: Unable to locate Rio Grande Table in EBDA - bailing!\n", __FUNCTION__);
+		return;
+	}
+
+	/* Deal with the ugly version 2/3 pointer arithmetic */
+	build_detail_arrays(rio_table_hdr, scal_devs, rio_devs);
+
+	for(i = 0; i < rio_table_hdr->num_rio_dev; i++)
+		if (is_WPEG(rio_devs[i]->type))
+			/* It's a Winnipeg, it's got PCI Busses */
+			setup_pci_node_map_for_wpeg(i, rio_table_hdr, scal_devs, rio_devs);
+}
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-summit_subarch/include/asm-i386/mach-summit/mach_mpparse.h linux-2.5.64-summit_pcimap/include/asm-i386/mach-summit/mach_mpparse.h
--- linux-2.5.64-summit_subarch/include/asm-i386/mach-summit/mach_mpparse.h	Tue Mar  4 19:29:17 2003
+++ linux-2.5.64-summit_pcimap/include/asm-i386/mach-summit/mach_mpparse.h	Fri Mar 14 12:20:38 2003
@@ -1,6 +1,8 @@
 #ifndef __ASM_MACH_MPPARSE_H
 #define __ASM_MACH_MPPARSE_H
 
+#include <mach_apic.h>
+
 extern int use_cyclone;
 
 static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char *name, 
@@ -33,4 +35,71 @@
 		use_cyclone = 1; /*enable cyclone-timer*/
 	}
 }
+
+struct rio_table_hdr {
+	unsigned char version;      /* Version number of this data structure           */
+	                            /* Version 3 adds chassis_num & WP_index           */
+	unsigned char num_scal_dev; /* # of Scalability devices (Twisters for Vigil)   */
+	unsigned char num_rio_dev;  /* # of RIO I/O devices (Cyclones and Winnipegs)   */
+} __attribute__((packed));
+
+struct scal_detail {
+	unsigned char node_id;      /* Scalability Node ID                             */
+	unsigned long CBAR;         /* Address of 1MB register space                   */
+	unsigned char port0node;    /* Node ID port connected to: 0xFF=None            */
+	unsigned char port0port;    /* Port num port connected to: 0,1,2, or 0xFF=None */
+	unsigned char port1node;    /* Node ID port connected to: 0xFF = None          */
+	unsigned char port1port;    /* Port num port connected to: 0,1,2, or 0xFF=None */
+	unsigned char port2node;    /* Node ID port connected to: 0xFF = None          */
+	unsigned char port2port;    /* Port num port connected to: 0,1,2, or 0xFF=None */
+	unsigned char chassis_num;  /* 1 based Chassis number (1 = boot node)          */
+} __attribute__((packed));
+
+struct rio_detail {
+	unsigned char node_id;      /* RIO Node ID                                     */
+	unsigned long BBAR;         /* Address of 1MB register space                   */
+	unsigned char type;         /* Type of device                                  */
+	unsigned char owner_id;     /* For WPEG: Node ID of Cyclone that owns this WPEG*/
+	                            /* For CYC:  Node ID of Twister that owns this CYC */
+	unsigned char port0node;    /* Node ID port connected to: 0xFF=None            */
+	unsigned char port0port;    /* Port num port connected to: 0,1,2, or 0xFF=None */
+	unsigned char port1node;    /* Node ID port connected to: 0xFF=None            */
+	unsigned char port1port;    /* Port num port connected to: 0,1,2, or 0xFF=None */
+	unsigned char first_slot;   /* For WPEG: Lowest slot number below this WPEG    */
+	                            /* For CYC:  0                                     */
+	unsigned char status;       /* For WPEG: Bit 0 = 1 : the XAPIC is used         */
+	                            /*                 = 0 : the XAPIC is not used, ie:*/
+	                            /*                     ints fwded to another XAPIC */
+	                            /*           Bits1:7 Reserved                      */
+	                            /* For CYC:  Bits0:7 Reserved                      */
+	unsigned char WP_index;     /* For WPEG: WPEG instance index - lower ones have */
+	                            /*           lower slot numbers/PCI bus numbers    */
+	                            /* For CYC:  No meaning                            */
+	unsigned char chassis_num;  /* 1 based Chassis number                          */
+	                            /* For LookOut WPEGs this field indicates the      */
+	                            /* Expansion Chassis #, enumerated from Boot       */
+	                            /* Node WPEG external port, then Boot Node CYC     */
+	                            /* external port, then Next Vigil chassis WPEG     */
+	                            /* external port, etc.                             */
+	                            /* Shared Lookouts have only 1 chassis number (the */
+	                            /* first one assigned)                             */
+} __attribute__((packed));
+
+
+typedef enum {
+	CompatTwister = 0,  /* Compatibility Twister               */
+	AltTwister    = 1,  /* Alternate Twister of internal 8-way */
+	CompatCyclone = 2,  /* Compatibility Cyclone               */
+	AltCyclone    = 3,  /* Alternate Cyclone of internal 8-way */
+	CompatWPEG    = 4,  /* Compatibility WPEG                  */
+	AltWPEG       = 5,  /* Second Planar WPEG                  */
+	LookOutAWPEG  = 6,  /* LookOut WPEG                        */
+	LookOutBWPEG  = 7,  /* LookOut WPEG                        */
+} node_type;
+
+static inline int is_WPEG(node_type type){
+	return (type == CompatWPEG || type == AltWPEG ||
+		type == LookOutAWPEG || type == LookOutBWPEG);
+}
+
 #endif /* __ASM_MACH_MPPARSE_H */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-summit_subarch/include/asm-i386/mpspec.h linux-2.5.64-summit_pcimap/include/asm-i386/mpspec.h
--- linux-2.5.64-summit_subarch/include/asm-i386/mpspec.h	Tue Mar  4 19:28:53 2003
+++ linux-2.5.64-summit_pcimap/include/asm-i386/mpspec.h	Fri Mar 14 09:58:46 2003
@@ -222,6 +222,10 @@
 extern int pic_mode;
 extern int using_apic_timer;
 
+#ifdef CONFIG_X86_SUMMIT
+extern void setup_summit (void);
+#endif
+
 #ifdef CONFIG_ACPI_BOOT
 extern void mp_register_lapic (u8 id, u8 enabled);
 extern void mp_register_lapic_address (u64 address);

--------------060007000100010400010700--

