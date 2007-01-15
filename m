Return-Path: <linux-kernel-owner+w=401wt.eu-S932112AbXAOXav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbXAOXav (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 18:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbXAOXav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 18:30:51 -0500
Received: from smtp.cce.hp.com ([161.114.21.22]:37751 "EHLO
	ccerelrim01.cce.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112AbXAOXau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 18:30:50 -0500
X-Greylist: delayed 1193 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 18:30:50 EST
From: "Bob Picco" <bob.picco@hp.com>
Date: Mon, 15 Jan 2007 18:10:50 -0500
To: akpm@osdl.org
Cc: pj@sgi.com, bob.picco@hp.com, linux-kernel@vger.kernel.org
Subject: [PATCH] CPUSET related breakage of sys_mbind
Message-ID: <20070115231050.GA32220@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-PMX-Version: 5.2.1.279297, Antispam-Engine: 2.4.0.264935, Antispam-Data: 2007.1.15.145933
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


current->mems_allowed is defined for CONFIG_CPUSETS. This broke !CPUSETS
build. I compiled and linked tested both variants.

Signed-off-by: Bob Picco <bob.picco@hp.com>

 include/linux/cpuset.h |    6 ++++++
 mm/mempolicy.c         |    2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

Index: linux-2.6.20-rc4-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/mm/mempolicy.c	2007-01-15 09:21:58.000000000 -0500
+++ linux-2.6.20-rc4-mm1/mm/mempolicy.c	2007-01-15 17:51:15.000000000 -0500
@@ -882,9 +882,9 @@ asmlinkage long sys_mbind(unsigned long 
 	int err;
 
 	err = get_nodes(&nodes, nmask, maxnode);
-	nodes_and(nodes, nodes, current->mems_allowed);
 	if (err)
 		return err;
+	cpuset_nodes_allowed(&nodes);
 	return do_mbind(start, len, mode, &nodes, flags);
 }
 
Index: linux-2.6.20-rc4-mm1/include/linux/cpuset.h
===================================================================
--- linux-2.6.20-rc4-mm1.orig/include/linux/cpuset.h	2007-01-15 09:21:32.000000000 -0500
+++ linux-2.6.20-rc4-mm1/include/linux/cpuset.h	2007-01-15 14:01:30.000000000 -0500
@@ -75,6 +75,11 @@ static inline int cpuset_do_slab_mem_spr
 
 extern void cpuset_track_online_nodes(void);
 
+static inline void cpuset_nodes_allowed(nodemask_t *nodes)
+{
+	nodes_and(*nodes, *nodes, current->mems_allowed);
+}
+
 #else /* !CONFIG_CPUSETS */
 
 static inline int cpuset_init_early(void) { return 0; }
@@ -145,6 +150,7 @@ static inline int cpuset_do_slab_mem_spr
 }
 
 static inline void cpuset_track_online_nodes(void) {}
+static inline void cpuset_nodes_allowed(nodemask_t *nodes) {}
 
 #endif /* !CONFIG_CPUSETS */
 
