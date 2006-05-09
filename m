Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWEIO2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWEIO2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWEIO2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:28:32 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:6663 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750728AbWEIO2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:28:32 -0400
Message-ID: <4460A6F3.5060303@shadowen.org>
Date: Tue, 09 May 2006 15:28:03 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Michael Ellerman <michael@ellerman.id.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, haveblue@us.ibm.com, kravetz@us.ibm.com
Subject: Re: [PATCH] SPARSEMEM + NUMA can't handle unaligned memory regions?
References: <20060509070343.57853679F2@ozlabs.org> <44609A7B.7010103@shadowen.org>
In-Reply-To: <44609A7B.7010103@shadowen.org>
Content-Type: multipart/mixed;
 boundary="------------010401010401070604080803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010401010401070604080803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andy Whitcroft wrote:

> We see to have a few options:
> 
> 1) default the nid to something -- right now most of the non powerpc
> architectures return 0 when the nid cannot be found thus avoiding this
> panic.
> 
> 2) nid search -- we can do pretty much what is in this patch probabally
> with some optimisations like trying the first and last pfn in the
> section first.
> 
> 3) record the nid -- when we record the memory present in the system we
> are passed the nid.
> 
> Somehow the last of these seems the most logical given we have the
> correct information at the time we record that we need to instantiate
> the section.  So I had a quick go at something which seems to have come
> out pretty clean.  Attached is a completly untested patch to show what I
> am proposing.

Ok.  Attached is a version which builds and boots.  The patch looks
pretty simple.  Michael could you give it a spin on the broken machine
for me.

-apw

--------------010401010401070604080803
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
 sparse.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)
diff -upN reference/mm/sparse.c current/mm/sparse.c
--- reference/mm/sparse.c
+++ current/mm/sparse.c
@@ -102,6 +102,22 @@ int __section_nr(struct mem_section* ms)
 	return (root_nr * SECTIONS_PER_ROOT) + (ms - root);
 }
 
+/*
+ * During early boot we need to record the nid from which we will
+ * later allocate the section mem_map.  Encode this into the section
+ * pointer.  Overload the section_mem_map with this information.
+ */
+static inline unsigned long sparse_encode_early_nid(int nid)
+{
+	return (nid << SECTION_MAP_LAST_BIT);
+}
+
+static inline int sparse_early_nid(struct mem_section *section)
+{
+	unsigned long nid = section->section_mem_map;
+	return (nid >> SECTION_MAP_LAST_BIT);
+}
+
 /* Record a memory area against a node. */
 void memory_present(int nid, unsigned long start, unsigned long end)
 {
@@ -116,7 +132,8 @@ void memory_present(int nid, unsigned lo
 
 		ms = __nr_to_section(section);
 		if (!ms->section_mem_map)
-			ms->section_mem_map = SECTION_MARKED_PRESENT;
+			ms->section_mem_map = sparse_encode_early_nid(nid) |
+							SECTION_MARKED_PRESENT;
 	}
 }
 
@@ -167,6 +184,7 @@ static int sparse_init_one_section(struc
 	if (!valid_section(ms))
 		return -EINVAL;
 
+	ms->section_mem_map &= ~SECTION_MAP_MASK;
 	ms->section_mem_map |= sparse_encode_mem_map(mem_map, pnum);
 
 	return 1;
@@ -175,8 +193,8 @@ static int sparse_init_one_section(struc
 static struct page *sparse_early_mem_map_alloc(unsigned long pnum)
 {
 	struct page *map;
-	int nid = early_pfn_to_nid(section_nr_to_pfn(pnum));
 	struct mem_section *ms = __nr_to_section(pnum);
+	int nid = sparse_early_nid(ms);
 
 	map = alloc_remap(nid, sizeof(struct page) * PAGES_PER_SECTION);
 	if (map)

--------------010401010401070604080803--
