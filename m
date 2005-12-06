Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbVLFCEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbVLFCEd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbVLFCEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:04:33 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:15845 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S964916AbVLFCEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:04:32 -0500
Date: Tue, 6 Dec 2005 10:23:19 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/16] radixtree: sync with mainline
Message-ID: <20051206022319.GA3746@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Christoph Lameter <clameter@engr.sgi.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20051203071444.260068000@localhost.localdomain> <20051203071625.331743000@localhost.localdomain> <20051204155750.3972c3df.akpm@osdl.org> <20051205104446.GA6104@mail.ustc.edu.cn> <Pine.LNX.4.62.0512050923560.11455@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512050923560.11455@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 09:24:18AM -0800, Christoph Lameter wrote:
> On Mon, 5 Dec 2005, Wu Fengguang wrote:
> 
> >         return slot;
> > 
> > It should be
> > 
> >         return &slot;
> 
> That wont work. slot is a local variable. Drop this patch please.

Thanks. Sorry for the careless mistake.

But your patch do fit well in my patch :)

void *radix_tree_lookup_node(struct radix_tree_root *root,
                                unsigned long index, unsigned int level)
{
        unsigned int height, shift;
        struct radix_tree_node *slot;

        height = root->height;
        if (index > radix_tree_maxindex(height))
                return NULL;

        shift = (height-1) * RADIX_TREE_MAP_SHIFT;
        slot = root->rnode;

        while (height > level) {
                if (slot == NULL)
                        return NULL;

                slot = slot->slots[(index >> shift) & RADIX_TREE_MAP_MASK];
                shift -= RADIX_TREE_MAP_SHIFT;
                height--;
        }

        return slot;
}

void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long index)
{
        struct radix_tree_node *node;

        node = radix_tree_lookup_node(root, index, 1);
        return node->slots + (index & RADIX_TREE_MAP_MASK);
}
