Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVAYSx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVAYSx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 13:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVAYSxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:53:55 -0500
Received: from apachihuilliztli.mtu.ru ([195.34.32.124]:59405 "EHLO
	Apachihuilliztli.mtu.ru") by vger.kernel.org with ESMTP
	id S262059AbVAYSxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:53:44 -0500
Subject: reiser4 core patches: [Was: [RFC] per thread page reservation
	patch]
From: Vladimir Saveliev <vs@namesys.com>
To: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
Cc: Nikita Danilov <nikita@clusterfs.com>, linux-mm <linux-mm@kvack.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050107132459.033adc9f.akpm@osdl.org>
References: <20050103011113.6f6c8f44.akpm@osdl.org>
	 <20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com>
	 <1105019521.7074.79.camel@tribesman.namesys.com>
	 <20050107144644.GA9606@infradead.org>
	 <1105118217.3616.171.camel@tribesman.namesys.com>
	 <41DEDF87.8080809@grupopie.com> <m1llb5q7qs.fsf@clusterfs.com>
	 <20050107132459.033adc9f.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1106671038.4466.81.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 25 Jan 2005 19:39:49 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

[per thread page reservation discussion is snipped]

> And the whole idea is pretty flaky really - how can one precalculate how
> much memory an arbitrary md-on-dm-on-loop-on-md-on-NBD stack will want to
> use?  It really would be better if we could drop the whole patch and make
> reiser4 behave more sanely when its writepage is called with for_reclaim=1.

ok, we will change reiser4 to keep its pool of preallocated pages
privately as Andi suggested. This will require to have
reiser4_find_or_create_page which will do what find_or_create_page does
plus get a page from the list of preallocated pages if alloc_page
returns NULL.

So, currently, reiser4 depends on the core patches listed below. Would
you please look over them and let us know which look reasonable and
which are to be eliminated.

reiser4-sb_sync_inodes.patch
This patch adds new operation (sync_inodes) to struct super_operations.
This operation allows a filesystem to writeout dirty pages not
necessarily on per-inode basis. Default implementation of this operation
is sync_sb_inodes.

reiser4-allow-drop_inode-implementation.patch
This EXPORT_SYMBOL-s inodes_stat, generic_forget_inode, destroy_inode
and wake_up_inode which are needed to implement drop_inode.
reiser4 implements function similar to generic_delete_inode to be able
to truncate inode pages together with metadata destroying in
reiser4_delete_inode whereas generic_delete_inode first truncates pages
and then calls foofs_delete_inode.

reiser4-truncate_inode_pages_range.patch
This patch makes truncate_inode_pages_range from truncate_inode_pages.
truncate_inode_pages_range can truncate only pages which fall into
specified range. truncate_inode_pages which trucates all pages starting
from specified offset is made a one liner which calls
truncate_inode_pages_range.

reiser4-rcu-barrier.patch
This patch introduces a new interface - rcu_barrier() which waits until
all the RCUs queued until this call have been completed.
This patch is by Dipankar Sarma <dipankar@in.ibm.com>

reiser4-reget-page-mapping.patch
This patch allows to remove page from page cache in foofs_releasepage.

reiser4-radix_tree_lookup_slot.patch
This patch extents radxi tree API with a function which returns pointer
to found item within the tree.

reiser4-export-remove_from_page_cache.patch
reiser4-export-page_cache_readahead.patch
reiser4-export-pagevec-funcs.patch
reiser4-export-radix_tree_preload.patch
reiser4-export-find_get_pages.patch
reiser4-export-generic_sync_sb_inodes.patch
The above patches EXPORT_SYMBOL several functions. Others may find it
useful if they were exported. 

reiser4-export-inode_lock.patch
Reiser4 used to manipulate with super block inode lists so it needs
inode_lock exported.
We are working now to not need this. But quite many things are based on
it. Is there any chance to have it included?


Thanks

