Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUGEChA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUGEChA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 22:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265916AbUGEChA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 22:37:00 -0400
Received: from almesberger.net ([63.105.73.238]:56585 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S265910AbUGECg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 22:36:57 -0400
Date: Sun, 4 Jul 2004 23:36:51 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: prio_tree generalization
Message-ID: <20040704233651.A1453@almesberger.net>
References: <20040704222438.A11865@almesberger.net> <20040705020740.GA3246@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040705020740.GA3246@dualathlon.random>; from andrea@suse.de on Mon, Jul 05, 2004 at 04:07:40AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> that's a nice effort, I agree prio_tree.c is better suited for lib/ than
> mm/ but the code already looks quite generic and well written.

The code is great, no problem there. But at some places, it needs
a macro that extracts the indices from each node. Callbacks are
likely to be too expensive, and e.g. with VMAs, the indices are
actually calculated, so just passing offsets wouldn't work
either.

> why don't you move the shared code to lib/prio_tree.c instead of
> duplicating it in every object?

Yes, there are some more functions that should be shareable,
i.e. prio_tree_replace, prio_tree_parent, and prio_tree_next.
Also prio_tree_expand might be a candidate.

But this still leaves a few that depend on GET_INDEX.

> I thought prio_tree_next was already the equivalent of rb_next for
> prio-trees.

Yeah, it kind of is, but I'm looking for something more
light-weight, that just gives me an adjacent node. Also, I
want to be able to go back. Here's my prio_tree_prev (minus
the comments). It should look familiar to you :-)


struct prio_tree_node *prio_tree_succ(struct prio_tree_node *node)
{
	if (!prio_tree_right_empty(node)) {
		node = node->right;
		while (!prio_tree_left_empty(node))
			node = node->left;
		return node;
	}

	while (!prio_tree_no_parent(node) && node == node->parent->right)
		node = node->parent;

	return prio_tree_no_parent(node) ? NULL : node->parent;
}


Of course, this kind of iteration only makes sense if your tree
isn't just a bag of random ranges.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
