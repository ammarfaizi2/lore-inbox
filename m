Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264625AbUFXNch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264625AbUFXNch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 09:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbUFXNch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 09:32:37 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:57061 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264625AbUFXN32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 09:29:28 -0400
Subject: Re: [Lhms-devel] Re: [Lhns-devel] Merging Nonlinear and Numa style
	memory hotplug
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <ygoto@us.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       Linux-Node-Hotplug <lhns-devel@lists.sourceforge.net>,
       linux-mm <linux-mm@kvack.org>,
       "BRADLEY CHRISTIANSEN [imap]" <bradc1@us.ibm.com>
In-Reply-To: <20040623184303.25D9.YGOTO@us.fujitsu.com>
References: <20040622114733.30A6.YGOTO@us.fujitsu.com>
	 <1088029973.28102.269.camel@nighthawk>
	 <20040623184303.25D9.YGOTO@us.fujitsu.com>
Content-Type: text/plain
Message-Id: <1088083724.3918.390.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 24 Jun 2004 06:28:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more comments on the first patch:

+#ifdef CONFIG_HOTPLUG_MEMORY_OF_NODE
+               if (node_online(nid)) {
+                       allocate_pgdat(nid);
+                       printk ("node %d will remap to vaddr %08lx\n", nid,
+                               (ulong) node_remap_start_vaddr[nid]);
+               }else
+                       NODE_DATA(nid)=NULL;
+#else
                allocate_pgdat(nid);
                printk ("node %d will remap to vaddr %08lx - %08lx\n", nid,
                        (ulong) node_remap_start_vaddr[nid],
                        (ulong) pfn_to_kaddr(highstart_pfn
                            - node_remap_offset[nid] + node_remap_size[nid]));
+#endif

I don't think this chunk is very necessary.  The 'NODE_DATA(nid)=NULL;'
is superfluous because the node_data[] is zeroed at boot:

NUMA:
#define NODE_DATA(nid) (node_data[nid])
non-NUMA:
#define NODE_DATA(nid) (&contig_page_data)

Why not just make it:

+               if (!node_online(nid))
+			continue;

That should at least get rid of the ifdef.

-       bootmap_size = init_bootmem_node(NODE_DATA(0), min_low_pfn, 0, system_max_low_pfn);
+       bootmap_size = init_bootmem_node(NODE_DATA(0), min_low_pfn, 0,
+           (system_max_low_pfn > node_end_pfn[0]) ?
+           node_end_pfn[0] : system_max_low_pfn);

-       register_bootmem_low_pages(system_max_low_pfn);
+       register_bootmem_low_pages((system_max_low_pfn > node_end_pfn[0]) ?
+           node_end_pfn[0] : system_max_low_pfn);

How about using a temp variable here instead of those nasty conditionals?

+
+#ifdef CONFIG_HOTPLUG_MEMORY_OF_NODE
+               if (node_online(nid)){
+                       if (nid)
+                               memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
+                       NODE_DATA(nid)->pgdat_next = pgdat_list;
+                       pgdat_list = NODE_DATA(nid);
+                       NODE_DATA(nid)->enabled = 1;
+               }
+#else
                if (nid)
                        memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
                NODE_DATA(nid)->pgdat_next = pgdat_list;
                pgdat_list = NODE_DATA(nid);
+#endif

I'd just take the ifdef out.  Wouldn't this work instead?

-               if (nid)
-                       memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
-               NODE_DATA(nid)->pgdat_next = pgdat_list;
-               pgdat_list = NODE_DATA(nid);
+               if (node_online(nid)){
+                       if (nid)
+                               memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
+                       NODE_DATA(nid)->pgdat_next = pgdat_list;
+                       pgdat_list = NODE_DATA(nid);
+                       NODE_DATA(nid)->enabled = 1;
+               }

+void set_max_mapnr_init(void)
+{
...
+       struct page *hsp=0;

Should just be 'struct page *hsp = NULL;'

+       for(i = 0; i < numnodes; i++) {
+               if (!NODE_DATA(i))
+                       continue;
+               pgdat = NODE_DATA(i);
+               size = pgdat->node_zones[ZONE_HIGHMEM].present_pages;
+               if (!size)
+                       continue;
+               hsp = pgdat->node_zones[ZONE_HIGHMEM].zone_mem_map;
+               if (hsp)
+                       break;
+       }

Doesn't this just find the lowest-numbered node's highmem?  Are you sure
that no NUMA systems have memory at lower physical addresses on
higher-numbered nodes?  I'm not sure that this is true.

+       if (hsp)
+               highmem_start_page = hsp;
+       else
+               highmem_start_page = (struct page *)-1;

By not just BUG() here?  Do you check for 'highmem_start_page == -1' somewhere?

@@ -478,12 +482,35 @@ void __init mem_init(void)
        totalram_pages += __free_all_bootmem();

        reservedpages = 0;
+
+#ifdef CONFIG_HOTPLUG_MEMORY_OF_NODE
+       for (nid = 0; nid < numnodes; nid++){
+               int start, end;
+
+               if ( !node_online(nid))
+                       continue;
+               if ( node_start_pfn[nid] >= max_low_pfn )
+                       break;
+
+               start = node_start_pfn[nid];
+               end = ( node_end_pfn[nid] < max_low_pfn) ?
+                       node_end_pfn[nid] : max_low_pfn;
+
+               for ( tmp = start; tmp < end; tmp++)
+                       /*
+                        * Only count reserved RAM pages
+                        */
+                       if (page_is_ram(tmp) && PageReserved(pfn_to_page(tmp)))
+                               reservedpages++;
+       }
+#else

Again, I don't see what this loop is used for.  You appear to be trying
to detect which nodes have lowmem.  Is there currently any x86 NUMA
architecture that has lowmem on any node but node 0?



-- Dave

