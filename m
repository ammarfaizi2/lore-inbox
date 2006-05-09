Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWEINfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWEINfV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 09:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWEINfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 09:35:21 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:64262 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932512AbWEINfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 09:35:21 -0400
Message-ID: <44609A7B.7010103@shadowen.org>
Date: Tue, 09 May 2006 14:34:51 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com
Subject: Re: [PATCH] SPARSEMEM + NUMA can't handle unaligned memory regions?
References: <20060509070343.57853679F2@ozlabs.org>
In-Reply-To: <20060509070343.57853679F2@ozlabs.org>
Content-Type: multipart/mixed;
 boundary="------------070408080004010000000900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070408080004010000000900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Michael Ellerman wrote:
> I can't believe I'm the first person to see this, so I imagine I'm missing
> something. Perhaps it's only an issue on powerpc?
> 
> I have a machine with some memory at 0, then a hole, and then some more memory
> which doesn't start on a section boundary. This is causing the following
> crash:
> 
> add_region nid 1 start_pfn 0x77c0 pages 0x840
> add_region nid 1 start_pfn 0x0 pages 0x6000
> 
> ...
> 
> Unable to handle kernel paging request for data at address 0x00002430
> Faulting instruction address: 0xc0000000004f2940
> cpu 0x4: Vector: 300 (Data Access) at [c000000000737aa0]
>     pc: c0000000004f2940: .__alloc_bootmem_node+0x28/0x7c
>     lr: c0000000000a47a0: .sparse_init+0xa8/0x138
>     sp: c000000000737d20
>    msr: 8000000000001032
>    dar: 2430
>  dsisr: 40000000
>   current = 0xc000000000538410
>   paca    = 0xc000000000539780
>     pid   = 0, comm = swapper
> enter ? for help
> 4:mon> r
> R00 = c0000000000a47a0   R16 = 0000000005ff5000
> R01 = c000000000737d20   R17 = 0000000000000004
> R02 = c0000000007331e0   R18 = 00000000100d0000
> R03 = 0000000000000000   R19 = 00000000100b0000
> R04 = 0000000000038000   R20 = 00000000100d0000
> R05 = 0000000000000080   R21 = 0000000010070000
> 
> The root cause is that we have no memory at pfn 7000 and so early_pfn_to_nid()
> is giving us back -1 in sparse_early_mem_map_alloc(). We then pass -1 to
> NODE_DATA() which gets us NULL, and hence __alloc_bootmem_node() explodes.
> 
> AFAICT there's no logic to prevent us creating sections with no zeroth page,
> and in fact my box is doing it. Therefore it's not valid to assume we can
> get the nid from the zeroth page in a section. All we know is that there's
> one or more pages in that section for which early_pfn_to_nid() will work.
> 
> So I came up with this hack. Loop through all pages in the section until
> we get a valid nid, this should always work.
> 
> We also call early_pfn_to_nid() in node_memmap_size_bytes(), but I didn't
> touch that because it's not used on powerpc so I can't test it.
> 
> With this patch my machine boots and seems to be happy.

We see to have a few options:

1) default the nid to something -- right now most of the non powerpc
architectures return 0 when the nid cannot be found thus avoiding this
panic.

2) nid search -- we can do pretty much what is in this patch probabally
with some optimisations like trying the first and last pfn in the
section first.

3) record the nid -- when we record the memory present in the system we
are passed the nid.

Somehow the last of these seems the most logical given we have the
correct information at the time we record that we need to instantiate
the section.  So I had a quick go at something which seems to have come
out pretty clean.  Attached is a completly untested patch to show what I
am proposing.

-apw

--------------070408080004010000000900
Content-Type: text/plain;
 name="sparsemem-record-nid-during-memory-present"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sparsemem-record-nid-during-memory-present"

sparsemem record nid during memory present

Record the node id as we mark sections for instantiation.  Use this
nid during instantiation to direct allocations.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 sparse.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)
diff -upN reference/mm/sparse.c current/mm/sparse.c
--- reference/mm/sparse.c
+++ current/mm/sparse.c
@@ -102,6 +102,20 @@ int __section_nr(struct mem_section* ms)
 	return (root_nr * SECTIONS_PER_ROOT) + (ms - root);
 }
 
+/*
+ * During early boot we need to record the nid from which we will
+ * later allocate the section mem_map.  Encode this into the section
+ * pointer.  Overload the section_mem_map with this information.
+ */
+static inline unsigned long sparse_encode_early_nid(int nid)
+	return (nid << SECTION_MAP_LAST_BIT);
+}
+
+static inline int sparse_early_nid(struct mem_section *section)
+	unsigned long nid = section->section_mem_map;
+	return (nid >> SECTION_MAP_LAST_BIT);
+}
+
 /* Record a memory area against a node. */
 void memory_present(int nid, unsigned long start, unsigned long end)
 {
@@ -116,7 +130,8 @@ void memory_present(int nid, unsigned lo
 
 		ms = __nr_to_section(section);
 		if (!ms->section_mem_map)
-			ms->section_mem_map = SECTION_MARKED_PRESENT;
+			ms->section_mem_map = sparse_encode_early_nid(nid) |
+							SECTION_MARKED_PRESENT;
 	}
 }
 
@@ -175,8 +190,8 @@ static int sparse_init_one_section(struc
 static struct page *sparse_early_mem_map_alloc(unsigned long pnum)
 {
 	struct page *map;
-	int nid = early_pfn_to_nid(section_nr_to_pfn(pnum));
 	struct mem_section *ms = __nr_to_section(pnum);
+	int nid = sparse_early_nid(ms);
 
 	map = alloc_remap(nid, sizeof(struct page) * PAGES_PER_SECTION);
 	if (map)

--------------070408080004010000000900--
