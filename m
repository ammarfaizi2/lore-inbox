Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVAJPX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVAJPX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 10:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbVAJPX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 10:23:28 -0500
Received: from ozlabs.org ([203.10.76.45]:30369 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262289AbVAJPXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 10:23:21 -0500
Date: Tue, 11 Jan 2005 02:19:50 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, nathanl@austin.ibm.com
Subject: [PATCH] ppc64: Make NUMA code handle unexpected layouts
Message-ID: <20050110151950.GY14239@krispykreme.ozlabs.ibm.com>
References: <20050110133838.GT14239@krispykreme.ozlabs.ibm.com> <20050110134120.GU14239@krispykreme.ozlabs.ibm.com> <20050110143536.GV14239@krispykreme.ozlabs.ibm.com> <20050110144339.GW14239@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110144339.GW14239@krispykreme.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Nathan Lynch <nathanl@austin.ibm.com>

Ran into this on a 4GB partition - all but about ~300MB was thrown away.

Does this look ok?  It works for me, but I've not tested on firmware
without the bug.

Fall back to non-numa setup upon discovering unexpected memory layout
as presented by firmware, instead of throwing away regions.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Acked-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/mm/numa.c~numa_broke_fix arch/ppc64/mm/numa.c
--- foobar2/arch/ppc64/mm/numa.c~numa_broke_fix	2005-01-10 23:36:39.922337007 +1100
+++ foobar2-anton/arch/ppc64/mm/numa.c	2005-01-10 23:46:46.069205815 +1100
@@ -345,8 +345,6 @@ new_range:
 			numa_domain = 0;
 		}
 
-		node_set_online(numa_domain);
-
 		if (max_domain < numa_domain)
 			max_domain = numa_domain;
 
@@ -361,14 +359,19 @@ new_range:
 				init_node_data[numa_domain].node_start_pfn +
 				init_node_data[numa_domain].node_spanned_pages;
 			if (shouldstart != (start / PAGE_SIZE)) {
-				printk(KERN_ERR "WARNING: Hole in node, "
-						"disabling region start %lx "
-						"length %lx\n", start, size);
-				continue;
+				/* Revert to non-numa for now */
+				printk(KERN_ERR
+				       "WARNING: Unexpected node layout: "
+				       "region start %lx length %lx\n",
+				       start, size);
+				printk(KERN_ERR "NUMA is disabled\n");
+				goto err;
 			}
 			init_node_data[numa_domain].node_spanned_pages +=
 				size / PAGE_SIZE;
 		} else {
+			node_set_online(numa_domain);
+
 			init_node_data[numa_domain].node_start_pfn =
 				start / PAGE_SIZE;
 			init_node_data[numa_domain].node_spanned_pages =
@@ -388,6 +391,14 @@ new_range:
 		node_set_online(i);
 
 	return 0;
+err:
+	/* Something has gone wrong; revert any setup we've done */
+	for_each_node(i) {
+		node_set_offline(i);
+		init_node_data[i].node_start_pfn = 0;
+		init_node_data[i].node_spanned_pages = 0;
+	}
+	return -1;
 }
 
 static void __init setup_nonnuma(void)
_

