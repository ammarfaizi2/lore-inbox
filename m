Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbTLVTmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 14:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbTLVTmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 14:42:14 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:17347 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264319AbTLVTmG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 14:42:06 -0500
Message-ID: <3FE74801.2010401@us.ibm.com>
Date: Mon, 22 Dec 2003 11:37:37 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mbligh@aracnet.com, Andrew Morton <akpm@osdl.org>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [TRIVIAL PATCH] Use valid node number when unmapping CPUs
Content-Type: multipart/mixed;
 boundary="------------070803050204070904090002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070803050204070904090002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The cpu_2_node array for i386 is initialized to 0 for each CPU, 
effectively mapping all CPUs to node 0 unless changed.  When we unmap 
CPUs, however, we stick a -1 in the array, mapping the CPU to an invalid 
node.  This really isn't helpful.  We should map the CPU to node 0, to 
make sure that callers of cpu_to_node() and friends aren't returned a 
bogus node number.  This trivial patch changes the unmapping code to 
place a 0 in the node mapping for removed CPUs.

Cheers!

-Matt

--------------070803050204070904090002
Content-Type: text/plain;
 name="use_node0_on_unmap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="use_node0_on_unmap.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-vanilla/arch/i386/kernel/smpboot.c linux-2.6.0-patched/arch/i386/kernel/smpboot.c
--- linux-2.6.0-vanilla/arch/i386/kernel/smpboot.c	Wed Dec 17 18:58:49 2003
+++ linux-2.6.0-patched/arch/i386/kernel/smpboot.c	Thu Dec 18 14:36:06 2003
@@ -520,7 +520,7 @@ static inline void unmap_cpu_to_node(int
 	printk("Unmapping cpu %d from all nodes\n", cpu);
 	for (node = 0; node < MAX_NUMNODES; node ++)
 		cpu_clear(cpu, node_2_cpu_mask[node]);
-	cpu_2_node[cpu] = -1;
+	cpu_2_node[cpu] = 0;
 }
 #else /* !CONFIG_NUMA */
 

--------------070803050204070904090002--

