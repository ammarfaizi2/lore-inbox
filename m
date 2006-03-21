Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWCUCMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWCUCMF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 21:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWCUCMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 21:12:05 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:34719 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1030282AbWCUCME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 21:12:04 -0500
Date: Tue, 21 Mar 2006 10:19:07 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 02/23] radixtree: look-aside cache
Message-ID: <20060321021907.GA6753@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
References: <20060319023413.305977000@localhost.localdomain> <20060319023449.288540000@localhost.localdomain> <Pine.LNX.4.64.0603200754540.21825@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603200754540.21825@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 08:01:01AM -0800, Christoph Lameter wrote:
> On Sun, 19 Mar 2006, Wu Fengguang wrote:
> 
> > Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Hmm... This signoff exists because you are using some bit of earlier 
> patches by me?

Yes, the __lookup_slot() part of your patch named
        [PATCH] radix-tree: Remove unnecessary indirections and clean up code
is integrated into this patch, for Andrew found that it simply cannot be a
standalone patch:
        http://www.ussg.iu.edu/hypermail/linux/kernel/0512.0/0922.html

> Typically the _node endings mean that one can specify a node number where 
> to allocate memory.

Ah, I named it _node for this function is a generalized radix_tree_lookup().
The main difference is that radix_tree_lookup() returns the data in leaf node,
whereas radix_tree_lookup_node() returns the data or one of its parent nodes.

If _node is a misleading name, will _parent or _level do the job?

> Wont partial lookups like this complicate further work on the radixtree? 

Yes the new function is a bit of confusing ;)
But the change of code is minimal. Conceptually it works as follows:

-void *radix_tree_lookup(struct radix_tree_root *root,
-                               unsigned long index)                                              
+void *radix_tree_lookup_node(struct radix_tree_root *root,
+                               unsigned long index, unsigned int level)
 {
        unsigned int height, shift;
        struct radix_tree_node *slot;
@@ -300,7 +304,7 @@ static inline void **__lookup_slot(struc
        shift = (height-1) * RADIX_TREE_MAP_SHIFT;
        slot = root->rnode;

-       while (height > 0) {
+       while (height > level) {
                if (slot == NULL)
                        return NULL;

The main concern might be Nick's RCU patch. Since this function or
the look-aside cache concept do not collide with RCU's basic
assumptions, the impact should be minimal.

> Could you  get your speed optimizations into radixtree.c so that others 
> can use it in the future?

Sure.
There are three set of optimized functions that can be used by others:

- radix_tree_lookup_node(): used by the radix tree look-aside cache
                            code and context based read-ahead.
- radix_tree_cache_lookup()/radix_tree_cache_lookup_node():
- radix_tree_scan_hole()/radix_tree_scan_hole_backward():
  currently only used by context based read-ahead.

In the future I'd like to introduce a new function named
radix_tree_scan_data() to replace __lookup(), and rebase
radix_tree_gang_lookup() on it.

This change makes possible for a better __do_page_cache_readahead()
implementation based on radix_tree_scan_hole()/radix_tree_scan_data().

Cheers,
Wu
