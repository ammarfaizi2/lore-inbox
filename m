Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWHDFh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWHDFh4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWHDFh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:37:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60831 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030267AbWHDFhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:37:55 -0400
Subject: [PATCH 4 of 4] knfsd: handle non-contiguous cpu and node numbers
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1154669863.21040.2357.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 04 Aug 2006 15:37:46 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

knfsd: when allocating per-cpu or per-node rpc thread pools, handle
the case of noncontiguous cpu or node numbers.

Tested:

Machine                         ARCH    SMP NUMA    SUNRPC  nodes   cpus    hpni    hppi    pools(mode)
-------                         ----    --- ----    ------  -----   ----    ----    ----    ------------
4 cpu Xeon SMP                  x86_64  y   y       y       1       4       31      7       4 (percpu)
4 cpu Xeon SMP                  x86_64  y   y       m       1       4       31      7       4 (percpu)
4 cpu Xeon SMP                  x86_64  y   n       y       0       4       0       7       4 (percpu)
4 cpu Xeon SMP                  x86_64  y   n       m       0       4       0       7       4 (percpu)
4 cpu Xeon SMP                  x86_64  n   n       y       0       1       0       0       1 (global)
4 cpu Xeon SMP                  x86_64  n   n       m       0       1       0       0       1 (global)
4 cpu (2 node) Itanium NUMA     ia64    y   y       m       2       4       1023    3       2 (pernode)
2 cpu (1 node) Itanium NUMA     ia64    y   y       m       1       2       1023    1       1 (global)

* number of nodes and cpus from /sys/devices/system/
* hpni = value of highest_possible_node_id()
* hppi = value of highest_possible_processor_id()

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 net/sunrpc/svc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linus-git/net/sunrpc/svc.c
===================================================================
--- linus-git.orig/net/sunrpc/svc.c	2006-08-01 15:38:30.000000000 +1000
+++ linus-git/net/sunrpc/svc.c	2006-08-02 13:20:35.979647782 +1000
@@ -116,7 +116,7 @@ fail:
 static int
 svc_pool_map_init_percpu(struct svc_pool_map *m)
 {
-	unsigned int maxpools = num_possible_cpus();
+	unsigned int maxpools = highest_possible_processor_id()+1;
 	unsigned int pidx = 0;
 	unsigned int cpu;
 	int err;
@@ -144,7 +144,7 @@ svc_pool_map_init_percpu(struct svc_pool
 static int
 svc_pool_map_init_pernode(struct svc_pool_map *m)
 {
-	unsigned int maxpools = num_possible_nodes();
+	unsigned int maxpools = highest_possible_node_id()+1;
 	unsigned int pidx = 0;
 	unsigned int node;
 	int err;

-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


