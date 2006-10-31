Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946016AbWJaVTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946016AbWJaVTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946006AbWJaVTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:19:13 -0500
Received: from usea-naimss1.unisys.com ([192.61.61.103]:35854 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1423650AbWJaVTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:19:12 -0500
Subject: [PATCH] init_reap_node() initialization fix
From: Daniel Yeisley <dan.yeisley@unisys.com>
To: linux-kernel@vger.kernel.org
Cc: ak@novell.com, akpm@osdl.org
Content-Type: text/plain
Date: Tue, 31 Oct 2006 16:05:19 -0500
Message-Id: <1162328719.12872.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.1 (2.9.1-2.fc7) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2006 21:19:09.0021 (UTC) FILETIME=[340EB8D0:01C6FD32]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like there is a bug in init_reap_node() in slab.c that can
cause multiple oops's on certain ES7000 configurations.  The variable
reap_node is defined per cpu, but only initialized on a single CPU.
This causes an oops in next_reap_node() when __get_cpu_var(reap_node)
returns the wrong value.  Fix is below.


Signed-off-by: Dan Yeisley <dan.yeisley@unisys.com>
---

diff -Naur linux-2.6.19-rc3-org/mm/slab.c linux-2.6.19-rc3-work/mm/slab.c
--- linux-2.6.19-rc3-org/mm/slab.c      2006-10-23 19:02:02.000000000 -0400
+++ linux-2.6.19-rc3-work/mm/slab.c     2006-10-30 11:45:28.000000000 -0500
@@ -883,7 +883,7 @@
        if (node == MAX_NUMNODES)
                node = first_node(node_online_map);
 
-       __get_cpu_var(reap_node) = node;
+       per_cpu(reap_node,cpu) = node;
 }
 
 static void next_reap_node(void)




