Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVA0LPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVA0LPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 06:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVA0LPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 06:15:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46534 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262564AbVA0LBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 06:01:23 -0500
Date: Thu, 27 Jan 2005 11:01:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Vladimir Saveliev <vs@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, Nikita Danilov <nikita@clusterfs.com>,
       linux-mm <linux-mm@kvack.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: reiser4 core patches: [Was: [RFC] per thread page reservation patch]
Message-ID: <20050127110112.GA26283@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Vladimir Saveliev <vs@namesys.com>, Andrew Morton <akpm@osdl.org>,
	Nikita Danilov <nikita@clusterfs.com>,
	linux-mm <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com> <1105019521.7074.79.camel@tribesman.namesys.com> <20050107144644.GA9606@infradead.org> <1105118217.3616.171.camel@tribesman.namesys.com> <41DEDF87.8080809@grupopie.com> <m1llb5q7qs.fsf@clusterfs.com> <20050107132459.033adc9f.akpm@osdl.org> <1106671038.4466.81.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106671038.4466.81.camel@tribesman.namesys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, currently, reiser4 depends on the core patches listed below. Would
> you please look over them and let us know which look reasonable and
> which are to be eliminated.

> reiser4-sb_sync_inodes.patch
> This patch adds new operation (sync_inodes) to struct super_operations.
> This operation allows a filesystem to writeout dirty pages not
> necessarily on per-inode basis. Default implementation of this operation
> is sync_sb_inodes.

ok.

> reiser4-allow-drop_inode-implementation.patch
> This EXPORT_SYMBOL-s inodes_stat, generic_forget_inode, destroy_inode
> and wake_up_inode which are needed to implement drop_inode.
> reiser4 implements function similar to generic_delete_inode to be able
> to truncate inode pages together with metadata destroying in
> reiser4_delete_inode whereas generic_delete_inode first truncates pages
> and then calls foofs_delete_inode.

Not okay.  I though I explained you how to do it instead already?

> reiser4-truncate_inode_pages_range.patch
> This patch makes truncate_inode_pages_range from truncate_inode_pages.
> truncate_inode_pages_range can truncate only pages which fall into
> specified range. truncate_inode_pages which trucates all pages starting
> from specified offset is made a one liner which calls
> truncate_inode_pages_range.

Ok.

> reiser4-rcu-barrier.patch
> This patch introduces a new interface - rcu_barrier() which waits until
> all the RCUs queued until this call have been completed.
> This patch is by Dipankar Sarma <dipankar@in.ibm.com>

No idea, but if Dipankar things it's okay it probably is.

> reiser4-reget-page-mapping.patch
> This patch allows to remove page from page cache in foofs_releasepage.

probably ok, Andrew?

> reiser4-radix_tree_lookup_slot.patch
> This patch extents radxi tree API with a function which returns pointer
> to found item within the tree.

Idea is okay, implementation needs work:

__lookup_slot should be called radix_tree_lookup_slot and exported direcly.

radix_tree_lookup should be an inlined wrapper in the header, and kill
the != NULL comparims, it's superflous:

static inline void *radix_tree_lookup(struct radix_tree_root *root,
		unsigned long index)
{
	void **slot = radix_tree_lookup_slot(root, index);
	return slot ? *slot : NULL;
}

> reiser4-export-remove_from_page_cache.patch

Probably okay, but why do you need both remove_from_page_cache
and __remove_from_page_cache?

> reiser4-export-page_cache_readahead.patch

ok

> reiser4-export-pagevec-funcs.patch

ok

> reiser4-export-radix_tree_preload.patch

this one is nasty.  not your fault though, but why do we even
have global radix-tree preloads instead of pools.  What do you
need it for?

> reiser4-export-find_get_pages.patch

Why don't you use pagevecs instead?

> reiser4-export-generic_sync_sb_inodes.patch

Can't find this one in current -mm

> reiser4-export-inode_lock.patch
> Reiser4 used to manipulate with super block inode lists so it needs
> inode_lock exported.
> We are working now to not need this. But quite many things are based on
> it. Is there any chance to have it included?

No.  Modules must not look at inode_lock, it's far too much of an
implementation detail.
