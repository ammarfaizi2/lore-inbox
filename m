Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWEJKv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWEJKv1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWEJKv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:51:27 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:41951
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S964912AbWEJKv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:51:26 -0400
Date: Wed, 10 May 2006 11:51:02 +0100
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, haveblue@us.ibm.com, kravetz@us.ibm.com
Subject: [PATCH] sparsemem record nid during memory present
Message-ID: <20060510105102.GA9533@shadowen.org>
References: <1147241173.8091.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <1147241173.8091.21.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here is the updated version.  Better commentry on what we are doing
and how long the data is kept (suggested by Dave Hansen).  Also added a 
SECTION_NID_SHIFT to better describe its use.  This showed a small
buglett as we were shifting by 4 (1<<2) instead of 2; now fixed.

-apw
=== 8< ===
sparsemem record nid during memory present

Record the node id as we mark sections for instantiation.  Use this
nid during instantiation to direct allocations.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 include/linux/mmzone.h |    5 +++++
 mm/sparse.c            |   22 ++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)
diff -upN reference/include/linux/mmzone.h current/include/linux/mmzone.h
--- reference/include/linux/mmzone.h
+++ current/include/linux/mmzone.h
@@ -508,6 +508,10 @@ struct mem_section {
 	 * pages.  However, it is stored with some other magic.
 	 * (see sparse.c::sparse_init_one_section())
 	 *
+	 * Additionally during early boot we encode node id of
+	 * the location of the section here to guide allocation.
+	 * (see sparse.c::memory_present())
+	 *
 	 * Making it a UL at least makes someone do a cast
 	 * before using it wrong.
 	 */
@@ -547,6 +551,7 @@ extern int __section_nr(struct mem_secti
 #define SECTION_HAS_MEM_MAP	(1UL<<1)
 #define SECTION_MAP_LAST_BIT	(1UL<<2)
 #define SECTION_MAP_MASK	(~(SECTION_MAP_LAST_BIT-1))
+#define SECTION_NID_SHIFT	2
 
 static inline struct page *__section_mem_map_addr(struct mem_section *section)
 {
diff -upN reference/mm/sparse.c current/mm/sparse.c
--- reference/mm/sparse.c
+++ current/mm/sparse.c
@@ -102,6 +102,22 @@ int __section_nr(struct mem_section* ms)
 	return (root_nr * SECTIONS_PER_ROOT) + (ms - root);
 }
 
+/*
+ * During early boot, before section_mem_map is used for an actual
+ * mem_map, we use section_mem_map to store the section's NUMA
+ * node.  This keeps us from having to use another data structure.  The
+ * node information is cleared just before we store the real mem_map.
+ */
+static inline unsigned long sparse_encode_early_nid(int nid)
+{
+	return (nid << SECTION_NID_SHIFT);
+}
+
+static inline int sparse_early_nid(struct mem_section *section)
+{
+	return (section->section_mem_map >> SECTION_NID_SHIFT);
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
