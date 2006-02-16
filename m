Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWBPDnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWBPDnI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 22:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWBPDnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 22:43:07 -0500
Received: from cantor.suse.de ([195.135.220.2]:6125 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932086AbWBPDnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 22:43:07 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 16 Feb 2006 14:43:01 +1100
Message-Id: <1060216034301.11136@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: Nick Piggin <npiggin@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix over-zealous tag clearing in radix_tree_delete
References: <20060216144112.11116.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Against 2.6.16-rc2-mm1.  For inclusion in 2.6.16 please.

### Comments for Changeset

If a tag is set for a node being deleted from a radix_tree,
then that tag gets cleared from the parent of the node, even
if it is set for some siblings of the node begin deleted.

This patch changes the logic to include a test for any_tag_set similar
to the logic a little futher down.  Care is taken to ensure that
'nr_cleared_tags' remains equals to the number of entries in the
'tags' array which are set to '0' (which means that this tag is not
set in the tree below pathp->node, and should be cleared at
pathp->node and possibly above.

Acked-by: Nick Piggin <npiggin@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./lib/radix-tree.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff ./lib/radix-tree.c~current~ ./lib/radix-tree.c
--- ./lib/radix-tree.c~current~	2006-02-16 13:22:28.000000000 +1100
+++ ./lib/radix-tree.c	2006-02-16 14:31:21.000000000 +1100
@@ -753,12 +753,14 @@ void *radix_tree_delete(struct radix_tre
 	 */
 	nr_cleared_tags = 0;
 	for (tag = 0; tag < RADIX_TREE_TAGS; tag++) {
+		tags[tag] = 1;
 		if (tag_get(pathp->node, tag, pathp->offset)) {
 			tag_clear(pathp->node, tag, pathp->offset);
-			tags[tag] = 0;
-			nr_cleared_tags++;
-		} else
-			tags[tag] = 1;
+			if (!any_tag_set(pathp->node, tag)) {
+				tags[tag] = 0;
+				nr_cleared_tags++;
+			}
+		}
 	}
 
 	for (pathp--; nr_cleared_tags && pathp->node; pathp--) {
