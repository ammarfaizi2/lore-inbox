Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268271AbUIWEee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268271AbUIWEee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 00:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268260AbUIWEds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 00:33:48 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:2178 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S268262AbUIWEcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 00:32:50 -0400
Date: Wed, 22 Sep 2004 23:32:45 -0500 (CDT)
From: Ray Bryant <raybry@austin.rr.com>
To: Andi Kleen <ak@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>, Jesse Barnes <jbarnes@sgi.com>,
       Dan Higgins <djh@sgi.com>, lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>, Ray Bryant <raybry@sgi.com>,
       Paul Jackson <pj@sgi.com>, Dave Hansen <haveblue@us.ibm.com>
Message-Id: <20040923043256.2132.93167.33080@raybryhome.rayhome.net>
In-Reply-To: <20040923043236.2132.2385.23158@raybryhome.rayhome.net>
References: <20040923043236.2132.2385.23158@raybryhome.rayhome.net>
Subject: [PATCH 2/2] mm: eliminate node 0 bias in MPOL_INTERLEAVE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new patch in this series (it does not in any way replaced the
MPOL_ROUDROBIN patch, which has been dropped).

This patches fixes the following problems with MPOL_INTERLEAVE:  In
the existing implementation, every time a new process is created and it
is using MPOL_INTERLEAVE, the interleave "rotator" (current->il_next)
is set to zero.  This biases storage allocation toward lower numberd
nodes (this effect is more apparent on systems with hundreds of nodes.)
This patch fixes this problem by setting il_next to pid % MAX_NUMNODES.

Similarly, in the existing implementation of MPOL_INTERLEAVE, each time
a new policy of type MPOL_INTERLEAVE is created, current->il_next is set
to the lowest numbered node that is in the policy mask policy->v.nodes.
This biass storage allocation toward the lowest numbered node in that
mask.  This is again fixed by setting il_next to pid % MAX_NUMNODES.

Each of these cases potentially breaks the (assumed) invariant of
interleave_nodes(), that is that "bit il_next of the nodemask is set"
(because the value of il_next on entry to interleave_nodes() is returned
as the node to be used for the allocation, and we calculate the next
il_next, before returning.)

Solving this requires adding the small bit of code in interleave_nodes()
that checks the invariant and if it is not true, updates the return
value to be the next bit in the nodemask that is set.

Signed-off-by: Ray Bryant <raybry@sgi.com>

Index: linux-2.6.9-rc2-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.9-rc2-mm1.orig/mm/mempolicy.c	2004-09-21 16:49:00.000000000 -0700
+++ linux-2.6.9-rc2-mm1/mm/mempolicy.c	2004-09-21 17:44:58.000000000 -0700
@@ -435,7 +435,7 @@ asmlinkage long sys_set_mempolicy(int re
 		default_policy[policy] = new;
 	}
 	if (new && new->policy == MPOL_INTERLEAVE)
-		current->il_next = find_first_bit(new->v.nodes, MAX_NUMNODES);
+		current->il_next = current->pid % MAX_NUMNODES;
 	return 0;
 }
 
@@ -714,6 +714,11 @@ static unsigned interleave_nodes(struct 
 
 	nid = me->il_next;
 	BUG_ON(nid >= MAX_NUMNODES);
+	if (!test_bit(nid, policy->v.nodes)) {
+		nid = find_next_bit(policy->v.nodes, MAX_NUMNODES, 1+nid);
+		if (nid >= MAX_NUMNODES)
+			nid = find_first_bit(policy->v.nodes, MAX_NUMNODES);
+	}
 	next = find_next_bit(policy->v.nodes, MAX_NUMNODES, 1+nid);
 	if (next >= MAX_NUMNODES)
 		next = find_first_bit(policy->v.nodes, MAX_NUMNODES);
Index: linux-2.6.9-rc2-mm1/kernel/fork.c
===================================================================
--- linux-2.6.9-rc2-mm1.orig/kernel/fork.c	2004-09-21 16:24:49.000000000 -0700
+++ linux-2.6.9-rc2-mm1/kernel/fork.c	2004-09-21 17:41:12.000000000 -0700
@@ -873,6 +873,8 @@ static task_t *copy_process(unsigned lon
 			goto bad_fork_cleanup;
 		}
 	}
+	/* randomize placement of first page across nodes */
+	p->il_next = p->pid % MAX_NUMNODES;
 #endif
 
 	p->tgid = p->pid;
