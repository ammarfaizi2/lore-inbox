Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbUDATPT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 14:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUDATPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 14:15:19 -0500
Received: from fujitsu2.fujitsu.com ([192.240.0.2]:5536 "EHLO
	fujitsu2.fujitsu.com") by vger.kernel.org with ESMTP
	id S263084AbUDATPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 14:15:09 -0500
Date: Thu, 01 Apr 2004 11:14:52 -0800
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: mbligh@aracnet.com
Subject: [Patch] physnode_map definition should be signed
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Message-Id: <20040401095436.DFDD.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin-san.

In your modification of pfn_valid() for IA32 at 2.6.4 stock kernel,
it doesn't return 0 even if the node is offline.

True problem is physnode_map's definition.
Physnode_map[]'s default (offline) value is -1,
but it is defined as UNSIGNED 8. 
So, pfn_to_nid() return 255. 

I think this should be defined as signed like this patch.
Maximum node number of IA32 is 16, so this is enough yet.

I found this problem on multi-node emulation for memory-hotplug test.
When I started X on this emulation, system panicked at remap_pte_range()
by this problem.
I think that system will be down when a program will call mmap()
for hardware area.

Could you check this? 
Or, Do you already know this problem?

Thanks.

-----------------------------------------------------------------
 mem_node_hotplug-goto/arch/i386/mm/discontig.c  |    2 +-
 mem_node_hotplug-goto/include/asm-i386/mmzone.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN include/asm-i386/mmzone.h~phys_nodemap_modify include/asm-i386/mmzone.h
--- mem_node_hotplug/include/asm-i386/mmzone.h~phys_nodemap_modify	Wed Mar 31 12:34:33 2004
+++ mem_node_hotplug-goto/include/asm-i386/mmzone.h	Wed Mar 31 12:35:07 2004
@@ -37,7 +37,7 @@ extern struct pglist_data *node_data[];
 #define MAX_ELEMENTS 256
 #define PAGES_PER_ELEMENT (MAX_NR_PAGES/MAX_ELEMENTS)
 
-extern u8 physnode_map[];
+extern s8 physnode_map[];
 
 static inline int pfn_to_nid(unsigned long pfn)
 {
diff -puN arch/i386/mm/discontig.c~phys_nodemap_modify arch/i386/mm/discontig.c
--- mem_node_hotplug/arch/i386/mm/discontig.c~phys_nodemap_modify	Wed Mar 31 12:34:43 2004
+++ mem_node_hotplug-goto/arch/i386/mm/discontig.c	Wed Mar 31 12:36:25 2004
@@ -56,7 +56,7 @@ bootmem_data_t node0_bdata;
  *     physnode_map[4-7] = 1;
  *     physnode_map[8- ] = -1;
  */
-u8 physnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
+s8 physnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
 
 unsigned long node_start_pfn[MAX_NUMNODES];
 unsigned long node_end_pfn[MAX_NUMNODES];


-- 
Yasunori Goto <ygoto at us.fujitsu.com>


