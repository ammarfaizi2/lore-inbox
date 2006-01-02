Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWABXHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWABXHh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 18:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWABXHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 18:07:37 -0500
Received: from cantor.suse.de ([195.135.220.2]:39649 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751120AbWABXHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 18:07:37 -0500
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org
Subject: [PATCH for 2.6.15] Make sure interleave masks have at least one node set
Date: Tue, 3 Jan 2006 00:07:28 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601030007.29105.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Otherwise a bad mem policy system call can confuse the interleaving
code into referencing undefined nodes.

Originally reported by Doug Chapman

I was told it's CVE-2005-3358
(one has to love these security people - they make everything sound important) 

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux-2.6.15rc7-work/mm/mempolicy.c
===================================================================
--- linux-2.6.15rc7-work.orig/mm/mempolicy.c
+++ linux-2.6.15rc7-work/mm/mempolicy.c
@@ -161,6 +161,10 @@ static struct mempolicy *mpol_new(int mo
 	switch (mode) {
 	case MPOL_INTERLEAVE:
 		policy->v.nodes = *nodes;
+		if (nodes_weight(*nodes) == 0) {
+			kmem_cache_free(policy_cache, policy);
+			return ERR_PTR(-EINVAL);
+		}
 		break;
 	case MPOL_PREFERRED:
 		policy->v.preferred_node = first_node(*nodes);
