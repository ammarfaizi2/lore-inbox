Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265775AbUFXWWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbUFXWWr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265879AbUFXWWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:22:01 -0400
Received: from fujitsu1.fujitsu.com ([192.240.0.1]:16779 "EHLO
	fujitsu1.fujitsu.com") by vger.kernel.org with ESMTP
	id S265875AbUFXWUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 18:20:07 -0400
Date: Thu, 24 Jun 2004 15:19:30 -0700
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [Lhms-devel] Re: [Lhns-devel] Merging Nonlinear and Numa style memory hotplug
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       Linux-Node-Hotplug <lhns-devel@lists.sourceforge.net>,
       linux-mm <linux-mm@kvack.org>,
       "BRADLEY CHRISTIANSEN [imap]" <bradc1@us.ibm.com>
In-Reply-To: <1088083724.3918.390.camel@nighthawk>
References: <20040623184303.25D9.YGOTO@us.fujitsu.com> <1088083724.3918.390.camel@nighthawk>
Message-Id: <20040624135838.F009.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dave-san.

Probably, all of your advices are right.
I was confused between my emulation environment and true NUMA machine.
I will modify them. Thanks a lot.

BTW, I have a question about nonlinear patch.
It is about difference between phys_section[] and mem_section[]
I suppose that phys_section[] looks like no-meaning now.
If it isn't necessary, __va() and __pa() translation can be more simple.
What is the purpose of phys_section[]. Is it for ppc64?

Bye.

> Some more comments on the first patch:
> 
> +#ifdef CONFIG_HOTPLUG_MEMORY_OF_NODE
> +               if (node_online(nid)) {
> +                       allocate_pgdat(nid);
> +                       printk ("node %d will remap to vaddr %08lx\n", nid,
> +                               (ulong) node_remap_start_vaddr[nid]);
> +               }else
> +                       NODE_DATA(nid)=NULL;
> +#else
>                 allocate_pgdat(nid);
>                 printk ("node %d will remap to vaddr %08lx - %08lx\n", nid,
>                         (ulong) node_remap_start_vaddr[nid],
>                         (ulong) pfn_to_kaddr(highstart_pfn
>                             - node_remap_offset[nid] + node_remap_size[nid]));
> +#endif
> 
> I don't think this chunk is very necessary.  The 'NODE_DATA(nid)=NULL;'
> is superfluous because the node_data[] is zeroed at boot:
> 
> NUMA:
> #define NODE_DATA(nid) (node_data[nid])
> non-NUMA:
> #define NODE_DATA(nid) (&contig_page_data)
> 
> Why not just make it:
> 
> +               if (!node_online(nid))
> +			continue;
> 
> That should at least get rid of the ifdef.
> 
> -       bootmap_size = init_bootmem_node(NODE_DATA(0), min_low_pfn, 0, system_max_low_pfn);
> +       bootmap_size = init_bootmem_node(NODE_DATA(0), min_low_pfn, 0,
> +           (system_max_low_pfn > node_end_pfn[0]) ?
> +           node_end_pfn[0] : system_max_low_pfn);
> 
> -       register_bootmem_low_pages(system_max_low_pfn);
> +       register_bootmem_low_pages((system_max_low_pfn > node_end_pfn[0]) ?
> +           node_end_pfn[0] : system_max_low_pfn);
> 
> How about using a temp variable here instead of those nasty conditionals?
> 
> +
> +#ifdef CONFIG_HOTPLUG_MEMORY_OF_NODE
> +               if (node_online(nid)){
> +                       if (nid)
> +                               memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
> +                       NODE_DATA(nid)->pgdat_next = pgdat_list;
> +                       pgdat_list = NODE_DATA(nid);
> +                       NODE_DATA(nid)->enabled = 1;
> +               }
> +#else
>                 if (nid)
>                         memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
>                 NODE_DATA(nid)->pgdat_next = pgdat_list;
>                 pgdat_list = NODE_DATA(nid);
> +#endif
> 
> I'd just take the ifdef out.  Wouldn't this work instead?
> 
> -               if (nid)
> -                       memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
> -               NODE_DATA(nid)->pgdat_next = pgdat_list;
> -               pgdat_list = NODE_DATA(nid);
> +               if (node_online(nid)){
> +                       if (nid)
> +                               memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
> +                       NODE_DATA(nid)->pgdat_next = pgdat_list;
> +                       pgdat_list = NODE_DATA(nid);
> +                       NODE_DATA(nid)->enabled = 1;
> +               }
> 
> +void set_max_mapnr_init(void)
> +{
> ...
> +       struct page *hsp=0;
> 
> Should just be 'struct page *hsp = NULL;'
> 
> +       for(i = 0; i < numnodes; i++) {
> +               if (!NODE_DATA(i))
> +                       continue;
> +               pgdat = NODE_DATA(i);
> +               size = pgdat->node_zones[ZONE_HIGHMEM].present_pages;
> +               if (!size)
> +                       continue;
> +               hsp = pgdat->node_zones[ZONE_HIGHMEM].zone_mem_map;
> +               if (hsp)
> +                       break;
> +       }
> 
> Doesn't this just find the lowest-numbered node's highmem?  Are you sure
> that no NUMA systems have memory at lower physical addresses on
> higher-numbered nodes?  I'm not sure that this is true.
> 
> +       if (hsp)
> +               highmem_start_page = hsp;
> +       else
> +               highmem_start_page = (struct page *)-1;
> 
> By not just BUG() here?  Do you check for 'highmem_start_page == -1' somewhere?
> 
> @@ -478,12 +482,35 @@ void __init mem_init(void)
>         totalram_pages += __free_all_bootmem();
> 
>         reservedpages = 0;
> +
> +#ifdef CONFIG_HOTPLUG_MEMORY_OF_NODE
> +       for (nid = 0; nid < numnodes; nid++){
> +               int start, end;
> +
> +               if ( !node_online(nid))
> +                       continue;
> +               if ( node_start_pfn[nid] >= max_low_pfn )
> +                       break;
> +
> +               start = node_start_pfn[nid];
> +               end = ( node_end_pfn[nid] < max_low_pfn) ?
> +                       node_end_pfn[nid] : max_low_pfn;
> +
> +               for ( tmp = start; tmp < end; tmp++)
> +                       /*
> +                        * Only count reserved RAM pages
> +                        */
> +                       if (page_is_ram(tmp) && PageReserved(pfn_to_page(tmp)))
> +                               reservedpages++;
> +       }
> +#else
> 
> Again, I don't see what this loop is used for.  You appear to be trying
> to detect which nodes have lowmem.  Is there currently any x86 NUMA
> architecture that has lowmem on any node but node 0?
> 
> 
> 
> -- Dave
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
> digital self defense, top technical experts, no vendor pitches, 
> unmatched networking opportunities. Visit www.blackhat.com
> _______________________________________________
> Lhns-devel mailing list
> Lhns-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lhns-devel

-- 
Yasunori Goto <ygoto at us.fujitsu.com>


