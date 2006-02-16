Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWBPC3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWBPC3b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 21:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWBPC3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 21:29:31 -0500
Received: from cantor2.suse.de ([195.135.220.15]:3822 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750872AbWBPC3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 21:29:30 -0500
From: Neil Brown <neilb@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Thu, 16 Feb 2006 13:29:24 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17395.58244.839605.685011@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Possibly bug in radix_tree_delete, and fix.
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Nick,
 I believe there is a bug in radix_tree_delete introduced by:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d5274261ea46f0aae93820fe36628249120d2f75

The nature of the bug is that if a tag is set on a node that is being
deleted, then that tag is unconditionally cleared in the parent of the
node, even if the deleted node has siblings with the tag still set.

I don't know what the large-scale consequences of this bug might be,
but I'm kinda hoping fixing it will fix a nasty NFS client related
oops we are seeing in radix_tree_tag_set ....

My suggested patch is below.

Please review, confirm, and Ack:

Thanks,
NeilBrown


Fix over-zealous clearing of tags in radix_tree_delete.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./lib/radix-tree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff ./lib/radix-tree.c~current~ ./lib/radix-tree.c
--- ./lib/radix-tree.c~current~	2006-02-16 13:22:28.000000000 +1100
+++ ./lib/radix-tree.c	2006-02-16 13:23:19.000000000 +1100
@@ -755,7 +755,7 @@ void *radix_tree_delete(struct radix_tre
 	for (tag = 0; tag < RADIX_TREE_TAGS; tag++) {
 		if (tag_get(pathp->node, tag, pathp->offset)) {
 			tag_clear(pathp->node, tag, pathp->offset);
-			tags[tag] = 0;
+			tags[tag] = any_tag_set(pathp->node, tag);
 			nr_cleared_tags++;
 		} else
 			tags[tag] = 1;
