Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbUKDR7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbUKDR7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbUKDR5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:57:51 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:57788 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262279AbUKDR4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:56:01 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix find_next_best_node
Date: Thu, 4 Nov 2004 09:55:57 -0800
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_t0miBs94/S4MAph"
Message-Id: <200411040955.57369.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_t0miBs94/S4MAph
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

If NUMA is enabled, find_next_best_node is responsible for helping build the 
zonelist for each pgdat in the system.  However, if one sets 
PENALTY_FOR_NODE_WITH_CPUS to a large value in an attempt to prefer nodes w/o 
CPUs, the local node is erroneously placed after all nodes w/o CPUs in the 
pgdat's zonelist.  This small patch fixes that by just checking if the local 
node is part of the zonelist yet, and if not, returns it first.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_t0miBs94/S4MAph
Content-Type: text/plain;
  charset="us-ascii";
  name="local-node-with-penalty-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="local-node-with-penalty-fix.patch"

===== mm/page_alloc.c 1.239 vs edited =====
--- 1.239/mm/page_alloc.c	2004-10-25 13:06:48 -07:00
+++ edited/mm/page_alloc.c	2004-11-04 09:41:23 -08:00
@@ -1213,6 +1213,12 @@
 		if (test_bit(n, used_node_mask))
 			continue;
 
+		/* Use the local node if we haven't already */
+		if (!test_bit(node, used_node_mask)) {
+			best_node = node;
+			break;
+		}
+
 		/* Use the distance array to find the distance */
 		val = node_distance(node, n);
 

--Boundary-00=_t0miBs94/S4MAph--
