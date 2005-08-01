Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVHAFcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVHAFcA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 01:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVHAFbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 01:31:53 -0400
Received: from ozlabs.org ([203.10.76.45]:16335 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262323AbVHAF3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 01:29:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17133.45774.226079.790875@cargo.ozlabs.ibm.com>
Date: Mon, 1 Aug 2005 00:27:42 -0500
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
CC: akpm@osdl.org, anton@samba.org, Mike Kravetz <kravetz@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] POWER 4 fails to boot with NUMA
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Kravetz <kravetz@us.ibm.com>

If CONFIG_NUMA is set, some POWER 4 systems will fail to boot.  This is
because of special processing needed to handle invalid node IDs (0xffff)
on POWER 4.  My previous patch to handle memory 'holes' within nodes
forgot to add this special case for POWER 4 in one place.

In reality, I'm not sure that configuring the kernel for NUMA on POWER 4
makes much sense.  Are there POWER 4 based systems with NUMA characteristics
that are presented by the firmware?  But, distros want one kernel for all
systems so NUMA is on by default in their kernels.  The patch handles those
cases.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff -urN linux-2.6/arch/ppc64/mm/numa.c g5-ppc64/arch/ppc64/mm/numa.c
--- linux-2.6/arch/ppc64/mm/numa.c	2005-06-24 13:38:52.000000000 +1000
+++ g5-ppc64/arch/ppc64/mm/numa.c	2005-08-01 15:15:55.000000000 +1000
@@ -647,7 +647,12 @@
 new_range:
 			mem_start = read_n_cells(addr_cells, &memcell_buf);
 			mem_size = read_n_cells(size_cells, &memcell_buf);
-			numa_domain = numa_enabled ? of_node_numa_domain(memory) : 0;
+			if (numa_enabled) {
+				numa_domain = of_node_numa_domain(memory);
+				if (numa_domain  >= MAX_NUMNODES)
+					numa_domain = 0;
+			} else
+				numa_domain =  0;
 
 			if (numa_domain != nid)
 				continue;
