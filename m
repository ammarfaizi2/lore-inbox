Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280929AbRKCDd2>; Fri, 2 Nov 2001 22:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280930AbRKCDdU>; Fri, 2 Nov 2001 22:33:20 -0500
Received: from holomorphy.com ([216.36.33.161]:18104 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S280929AbRKCDdK>;
	Fri, 2 Nov 2001 22:33:10 -0500
Date: Fri, 2 Nov 2001 19:31:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] bootmem for 2.5
Message-ID: <20011102193154.B18699@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011102140207.V31822@w-wli.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011102140207.V31822@w-wli.des.beaverton.ibm.com>; from willir@us.ibm.com on Fri, Nov 02, 2001 at 02:02:07PM -0800
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001 at 02:02:07PM -0800, William Irwin wrote:
> A number of people have expressed a wish to replace the bitmap-based
> bootmem allocator with one that tracks ranges explicitly. I have
> written such a replacement in order to deal with some of the situations
> I have encountered.

My apologies, I found a logic error in free_all_bootmem_core() which
was not triggered during testing, but deserves correction, in addition
to a leak introduced during verbosity reduction. Without
CONFIG_KERNEL_HACKING the segment pool would be leaked, and also
free_bootmem_core() may invalidate the value of
pgdat->bdata->segment_tree.length_tree read prior to calling it.
This fix was tested on i386.


--- linux.wrong/mm/bootmem.c	Fri Nov  2 19:11:41 2001
+++ linux/mm/bootmem.c	Fri Nov  2 19:12:23 2001
@@ -659,23 +659,25 @@
 	unsigned long total = 0UL, mapstart, start, end;
 	unsigned long node_start = pgdat->bdata->node_boot_start >> PAGE_SHIFT;
 	struct page *page;
-	treap_node_t *parent, *tmp = pgdat->bdata->segment_tree.length_tree;
+	treap_node_t *parent, *tmp;
 
 	mapstart = virt_to_phys(pgdat->bdata->node_bootmem_map);
 
 #ifdef CONFIG_KERNEL_HACKING
 
 	printk("Available physical memory:\n");
-	free_bootmem_core(pgdat->bdata, mapstart,
-			RND_UP(NR_SEGMENTS*sizeof(segment_buf_t), PAGE_SIZE));
 
 #endif /* CONFIG_KERNEL_HACKING */
 
+	free_bootmem_core(pgdat->bdata, mapstart,
+			RND_UP(NR_SEGMENTS*sizeof(segment_buf_t), PAGE_SIZE));
+
 	/*
 	 * Destructive post-order traversal of the length tree.
 	 * The tree is never used again, so no attempt is made
 	 * to restore it to working order.
 	 */
+	tmp = pgdat->bdata->segment_tree.length_tree;
 	treap_find_leftmost_leaf(tmp);
 	while(tmp) {
 		segment_tree_node_t *segment = length_segment_treap(tmp);


Cheers,
Bill
-----------------
willir@us.ibm.com
