Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422746AbWBNSH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422746AbWBNSH0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422748AbWBNSH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:07:26 -0500
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:37639 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S1422746AbWBNSHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:07:25 -0500
Subject: [PATCH] x86_64 Early initialization of cpu_to_node
From: Daniel Yeisley <dan.yeisley@unisys.com>
Reply-To: dan.yeisley@unisys.com
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, ak@suse.de, shai@scalex86.org, kiran@scalex86.org,
       alokk@calsoftinc.com
Content-Type: text/plain
Date: Tue, 14 Feb 2006 13:08:08 -0500
Message-Id: <1139940489.2776.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2006 18:07:08.0361 (UTC) FILETIME=[78384390:01C63191]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The early initialization of cpu_to_node code as it is now only updates
the cpu_to_node array, and does not update cpu_pda()->nodemember.  This
will cause numa_node_id() to return 0 on systems where CPU 0 is not on
Node 0.  This leads to a kernel panic in slab.c.  
I've tested the patch below on a 16 processor x86_64 ES7000-600 server,
and no longer see the panic I saw with the original 2.6.16-rc3.

Signed-off-by:  Dan Yeisley <dan.yeisley@unisys.com>
---

diff -Naur -p linux-2.6.16-rc3/arch/x86_64/mm/numa.c linux-2.6.16-rc3-a/arch/x86_64/mm/numa.c
--- linux-2.6.16-rc3/arch/x86_64/mm/numa.c	2006-02-12 19:27:25.000000000 -0500
+++ linux-2.6.16-rc3-a/arch/x86_64/mm/numa.c	2006-02-14 08:36:10.000000000 -0500
@@ -351,7 +351,7 @@ void __init init_cpu_to_node(void)
 			continue;
 		if (apicid_to_node[apicid] == NUMA_NO_NODE)
 			continue;
- 		cpu_to_node[i] = apicid_to_node[apicid];
+		numa_set_node(i,apicid_to_node[apicid]);
 	}
 }
 


