Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbTKZJvt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 04:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbTKZJvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 04:51:49 -0500
Received: from holomorphy.com ([199.26.172.102]:7613 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264137AbTKZJvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 04:51:39 -0500
Date: Wed, 26 Nov 2003 01:51:14 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Rik van Riel <riel@redhat.com>, Jack Steiner <steiner@sgi.com>,
       Anton Blanchard <anton@samba.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com
Subject: Re: hash table sizes
Message-ID: <20031126095114.GH8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Rik van Riel <riel@redhat.com>, Jack Steiner <steiner@sgi.com>,
	Anton Blanchard <anton@samba.org>,
	Jes Sorensen <jes@trained-monkey.org>,
	Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, jbarnes@sgi.com
References: <20031125231108.GA5675@sgi.com> <Pine.LNX.4.44.0311252238140.22777-100000@chimarrao.boston.redhat.com> <20031126035953.GF8039@holomorphy.com> <1590000.1069823671@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590000.1069823671@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 09:14:32PM -0800, Martin J. Bligh wrote:
> Would it not be rather more readable as something along the lines of:
> static inline int pfn_valid (int pfn) {
>         int nid = pfn_to_nid(pfn);
>         pg_data_t *pgdat;
> 
>         if (nid >= MAX_NUMNODES)
>                 return 0;		/* node invalid */
>         pgdat = NODE_DATA(nid);
>         if (!pgdat)
>                 return 0;		/* pgdat invalid */
>         if (pfn < pgdat->node_start_pfn)
>                 return 0;		/* before start of node */
>         if (pfn - pgdat->node_start_pfn >= pgdat->node_spanned_pages)
>                 return 0;		/* past end of node */
>         return 1;
> }

This header at least used to be included before the relevant structures
were declared (to all appearances, some macros have been converted to
inlines since last I looked).


On Tue, Nov 25, 2003 at 09:14:32PM -0800, Martin J. Bligh wrote:
> However, I'm curious as to why this crashes X, as I don't see how this
> code change makes a difference in practice. I didn't think we had any i386
> NUMA with memory holes between nodes at the moment, though perhaps the x440
> does.
> M.
> PS. No, I haven't tested my rephrasing of your patch either.

mmap() of framebuffers. It takes the box out, not just X. There are
holes just below 4GB regardless. This has actually been reported by
rml and some others.

False positives on pfn_valid() result in manipulations of purported page
structures beyond the bounds of actual allocated pgdat->node_mem_map[]'s,
potentially either corrupting memory or accessing areas outside memory's
limits (the case causing oopsen).

Insubstantially modified version of the above below (it looks fine, I
was just typing from memory). Compiletested only.


-- wli


diff -prauN linux-2.6.0-test10/include/asm-i386/mmzone.h pfn_valid-2.6.0-test10/include/asm-i386/mmzone.h
--- linux-2.6.0-test10/include/asm-i386/mmzone.h	2003-11-23 17:31:56.000000000 -0800
+++ pfn_valid-2.6.0-test10/include/asm-i386/mmzone.h	2003-11-26 01:40:36.000000000 -0800
@@ -84,14 +84,30 @@ extern struct pglist_data *node_data[];
 		+ __zone->zone_start_pfn;				\
 })
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
+
+static inline int pfn_to_nid(unsigned long);
 /*
- * pfn_valid should be made as fast as possible, and the current definition 
- * is valid for machines that are NUMA, but still contiguous, which is what
- * is currently supported. A more generalised, but slower definition would
- * be something like this - mbligh:
- * ( pfn_to_pgdat(pfn) && ((pfn) < node_end_pfn(pfn_to_nid(pfn))) ) 
+ * pfn_valid must absolutely be correct, regardless of speed concerns.
  */ 
-#define pfn_valid(pfn)          ((pfn) < num_physpages)
+static inline int pfn_valid(unsigned long pfn)
+{
+	u8 nid = pfn_to_nid(pfn);
+	pg_data_t *pgdat;
+
+	if (nid < MAX_NUMNODES)
+		pgdat = NODE_DATA(nid);
+	else
+		return 0;
+
+	if (!pgdat)
+		return 0;
+	else if (pfn < pgdat->node_start_pfn)
+		return 0;
+	else if (pfn - pgdat->node_start_pfn >= pgdat->node_spanned_pages)
+		return 0;
+	else
+		return 1;
+}
 
 /*
  * generic node memory support, the following assumptions apply:
