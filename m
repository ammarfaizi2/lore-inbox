Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262657AbTCIWy6>; Sun, 9 Mar 2003 17:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262658AbTCIWy6>; Sun, 9 Mar 2003 17:54:58 -0500
Received: from h-64-105-35-31.SNVACAID.covad.net ([64.105.35.31]:54407 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262657AbTCIWy5>; Sun, 9 Mar 2003 17:54:57 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 9 Mar 2003 15:05:12 -0800
Message-Id: <200303092305.PAA02985@adam.yggdrasil.com>
To: gone@us.ibm.com, mbligh@aracnet.com
Subject: 2.5.64bk5: X86_PC + HIGHMEM boot failure
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Under linux-2.5.64bk5, CONFIG_X86_PC sets CONFIG_NUMA,
which sets CONFIG_DISCONTIGMEM.  This causes the version of
set_max_mapnr_init in arch/i386/mm/discontig.c to be compiled
in (instead of the one from arch/i386/mm/init.c):

void __init set_max_mapnr_init(void)
{
#ifdef CONFIG_HIGHMEM
        highmem_start_page = NODE_DATA(0)->node_zones[ZONE_HIGHMEM].zone_mem_ma\p;
        printk ("AJR discontig.c: highmem_start_page set to %p.\n", highmem_sta\rt_page);
        num_physpages = highend_pfn;
#else
        num_physpages = max_low_pfn;
#endif
}


	The discontig.c version sets highmem_start_page to NULL
on my 768MB computer that is compiled with CONFIG_HIGHMEM4G, which
a kernel BUG() as soon as something that needs a lowmem page does
a sanity check.  (In my case, it happens to occur at
arch/i386/mm/pageattr.c line 99 during some kind ACPI initialization,
although I don't think that is particularly imporantant.)

	I am not sure what is the "right" fix for this problem,
because I don't understand if
NODE_DATA(0)->node_zones[ZONE_HIGHMEM].zone_mem_map should ever
be NULL (for example, in my case, when running a highmem kernel
on a computer with no highmem pages).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
