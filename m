Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162245AbWKPCp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162245AbWKPCp1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162242AbWKPCpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:45:10 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:44175 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162234AbWKPCpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:45:04 -0500
Message-Id: <20061116024544.195213000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:42 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Yeisley <dan.yeisley@unisys.com>,
       Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@engr.sgi.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: [patch 10/30] init_reap_node() initialization fix
Content-Disposition: inline; filename=init_reap_node-initialization-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Daniel Yeisley <dan.yeisley@unisys.com>

It looks like there is a bug in init_reap_node() in slab.c that can cause
multiple oops's on certain ES7000 configurations.  The variable reap_node
is defined per cpu, but only initialized on a single CPU.  This causes an
oops in next_reap_node() when __get_cpu_var(reap_node) returns the wrong
value.  Fix is below.

Signed-off-by: Dan Yeisley <dan.yeisley@unisys.com>
Cc: Andi Kleen <ak@suse.de>
Acked-by: Christoph Lameter <clameter@engr.sgi.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 mm/slab.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.2.orig/mm/slab.c
+++ linux-2.6.18.2/mm/slab.c
@@ -867,7 +867,7 @@ static void init_reap_node(int cpu)
 	if (node == MAX_NUMNODES)
 		node = first_node(node_online_map);
 
-	__get_cpu_var(reap_node) = node;
+	per_cpu(reap_node, cpu) = node;
 }
 
 static void next_reap_node(void)

--
