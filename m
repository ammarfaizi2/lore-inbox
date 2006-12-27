Return-Path: <linux-kernel-owner+w=401wt.eu-S932887AbWL0CLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887AbWL0CLK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 21:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932888AbWL0CLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 21:11:10 -0500
Received: from server99.tchmachines.com ([72.9.230.178]:47570 "EHLO
	server99.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932887AbWL0CLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 21:11:09 -0500
X-Greylist: delayed 1625 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Dec 2006 21:11:09 EST
Date: Tue, 26 Dec 2006 17:44:09 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Andi Kleen <ak@suse.de>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: [patch] mm: Set HASHDIST_DEFAULT to 1 for x86_64 NUMA
Message-ID: <20061227014409.GA7394@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable system hashtable memory to be distributed among nodes on x86_64 NUMA

Forcing the kernel to use node interleaved vmalloc instead of bootmem
for the system hashtable memory (alloc_large_system_hash) reduces the
memory imbalance on node 0 by around 40MB on a 8 node x86_64 NUMA box:

Before the following patch, on bootup of a 8 node box:

Node 0 MemTotal:      3407488 kB
Node 0 MemFree:       3206296 kB
Node 0 MemUsed:        201192 kB
Node 0 Active:           7012 kB
Node 0 Inactive:          512 kB
Node 0 Dirty:               0 kB
Node 0 Writeback:           0 kB
Node 0 FilePages:        1912 kB
Node 0 Mapped:            420 kB
Node 0 AnonPages:        5612 kB
Node 0 PageTables:        468 kB
Node 0 NFS_Unstable:        0 kB
Node 0 Bounce:              0 kB
Node 0 Slab:             5408 kB
Node 0 SReclaimable:      644 kB
Node 0 SUnreclaim:       4764 kB

After the patch (or using hashdist=1 on the kernel command line):

Node 0 MemTotal:      3407488 kB
Node 0 MemFree:       3247608 kB
Node 0 MemUsed:        159880 kB
Node 0 Active:           3012 kB
Node 0 Inactive:          616 kB
Node 0 Dirty:               0 kB
Node 0 Writeback:           0 kB
Node 0 FilePages:        2424 kB
Node 0 Mapped:            380 kB
Node 0 AnonPages:        1200 kB
Node 0 PageTables:        396 kB
Node 0 NFS_Unstable:        0 kB
Node 0 Bounce:              0 kB
Node 0 Slab:             6304 kB
Node 0 SReclaimable:     1596 kB
Node 0 SUnreclaim:       4708 kB

I guess it is a good idea to keep HASHDIST_DEFAULT "on" for x86_64 NUMA since
x86_64 has no dearth of vmalloc space?  Or maybe enable hash distribution for
all 64bit NUMA arches?  The following patch does it only for x86_64.

Signed-off-by: Pravin B. Shelar <pravin.shelar@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.20-rc1/include/linux/bootmem.h
===================================================================
--- linux-2.6.20-rc1.orig/include/linux/bootmem.h	2006-12-21 14:34:36.321610875 -0800
+++ linux-2.6.20-rc1/include/linux/bootmem.h	2006-12-26 15:55:04.501064560 -0800
@@ -122,9 +122,9 @@ extern void *alloc_large_system_hash(con
 #define HASH_EARLY	0x00000001	/* Allocating during early boot? */
 
 /* Only NUMA needs hash distribution.
- * IA64 is known to have sufficient vmalloc space.
+ * IA64 and x86_64 have sufficient vmalloc space.
  */
-#if defined(CONFIG_NUMA) && defined(CONFIG_IA64)
+#if defined(CONFIG_NUMA) && (defined(CONFIG_IA64) || defined(CONFIG_X86_64))
 #define HASHDIST_DEFAULT 1
 #else
 #define HASHDIST_DEFAULT 0
