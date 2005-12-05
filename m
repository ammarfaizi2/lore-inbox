Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbVLEK1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbVLEK1v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 05:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVLEK1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 05:27:51 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:50626 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751361AbVLEK1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 05:27:51 -0500
Date: Mon, 5 Dec 2005 18:44:46 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 02/16] radixtree: sync with mainline
Message-ID: <20051205104446.GA6104@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	clameter@sgi.com
References: <20051203071444.260068000@localhost.localdomain> <20051203071625.331743000@localhost.localdomain> <20051204155750.3972c3df.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20051204155750.3972c3df.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 04, 2005 at 03:57:50PM -0800, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> > [PATCH] radix-tree: Remove unnecessary indirections and clean up code
> > 
> >  is only partially merged into -mm tree. This patch completes it.
> 
> md: autorun ...               
> md: ... autorun DONE.
> Unable to handle kernel paging request at virtual address 8000003c

Sorry, the bug is caused by the returning line:

        return slot;

It should be

        return &slot;

The patch originally applies to
        
                        void *radix_tree_lookup()
        
But in -mm the function turns into
        
                        void **__lookup_slot()

And in my radixtree patch, it is

                        void *radix_tree_lookup_node()

The prototypes changed forth and back, so the problem was never discovered.

Wu

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="radixtree-sync-with-mainline.patch"

Subject: radixtree: sync with mainline
Cc: Christoph Lameter <clameter@sgi.com>

The patch from Christoph Lameter:

[PATCH] radix-tree: Remove unnecessary indirections and clean up code

is only partially merged into -mm tree. This patch completes it.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
 lib/radix-tree.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

--- linux.orig/lib/radix-tree.c
+++ linux/lib/radix-tree.c
@@ -291,27 +291,25 @@ static inline void **__lookup_slot(struc
 				   unsigned long index)
 {
 	unsigned int height, shift;
-	struct radix_tree_node **slot;
+	struct radix_tree_node *slot;
 
 	height = root->height;
 	if (index > radix_tree_maxindex(height))
 		return NULL;
 
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
-	slot = &root->rnode;
+	slot = root->rnode;
 
 	while (height > 0) {
-		if (*slot == NULL)
+		if (slot == NULL)
 			return NULL;
 
-		slot = (struct radix_tree_node **)
-			((*slot)->slots +
-				((index >> shift) & RADIX_TREE_MAP_MASK));
+		slot = slot->slots[(index >> shift) & RADIX_TREE_MAP_MASK];
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
 	}
 
-	return (void **)slot;
+	return &slot;
 }
 
 /**

--HcAYCG3uE/tztfnV--
