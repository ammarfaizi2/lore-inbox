Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbUCOWUX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbUCOWUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:20:23 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:2236 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262792AbUCOWTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:19:48 -0500
Subject: [TRIVIAL] Use valid node number when unmapping CPUs
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Content-Type: multipart/mixed; boundary="=-X2PphBQmDcj2hFJ4o1gO"
Organization: IBM LTC
Message-Id: <1079389177.3836.12.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 15 Mar 2004 14:19:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-X2PphBQmDcj2hFJ4o1gO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The cpu_2_node[] array for i386 is initialized to all 0's, meaning that
until modified at CPU bring-up, all CPUs are mapped to node 0.  When
CPUs are brought online, they are mapped to the appropriate node by
various mechanisms, depending on the underlying hardware.  When we unmap
CPUs (hotplug time), we should return the mapping for the CPU that is
going away to its original state, ie: 0.  When this code was initially
submitted, the misguided poster (me) made the mistake of putting a -1 in
the cpu_2_node[] array for the CPU going away.  This patch fixes this
mistake, and allows code to get a valid node number for all valid CPU
numbers.  This is important, because most (if not all) callers do not
error check the value returned by the cpu_to_node() macro, and they
should not have to.  The API specifies that a valid node number be
returned for any valid CPU number.

-Matt

--=-X2PphBQmDcj2hFJ4o1gO
Content-Disposition: attachment; filename=use_valid_nodenum.patch
Content-Type: text/x-patch; name=use_valid_nodenum.patch; charset=
Content-Transfer-Encoding: 7bit

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/i386/kernel/smpboot.c linux-2.6.4-valid_node_unmap/arch/i386/kernel/smpboot.c
--- linux-2.6.4-vanilla/arch/i386/kernel/smpboot.c	Wed Mar 10 18:55:27 2004
+++ linux-2.6.4-valid_node_unmap/arch/i386/kernel/smpboot.c	Mon Mar 15 13:59:49 2004
@@ -522,7 +522,7 @@ static inline void unmap_cpu_to_node(int
 	printk("Unmapping cpu %d from all nodes\n", cpu);
 	for (node = 0; node < MAX_NUMNODES; node ++)
 		cpu_clear(cpu, node_2_cpu_mask[node]);
-	cpu_2_node[cpu] = -1;
+	cpu_2_node[cpu] = 0;
 }
 #else /* !CONFIG_NUMA */
 

--=-X2PphBQmDcj2hFJ4o1gO--

