Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290784AbSAaBDi>; Wed, 30 Jan 2002 20:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290790AbSAaBDa>; Wed, 30 Jan 2002 20:03:30 -0500
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:13966 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S290784AbSAaBDV>; Wed, 30 Jan 2002 20:03:21 -0500
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200201310102.CAA17256@faui1a.informatik.uni-erlangen.de>
Subject: linux-kernel@vger.kernel.org
To: velco@fadata.bg
Date: Thu, 31 Jan 2002 02:02:04 +0100 (MET)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Momchil Velikov wrote:

+int move_from_swap_cache(struct page *page, unsigned long index,
+               struct address_space *mapping)
+{
+       void **pslot;
+       int err;
+
+       if (!PageLocked(page))
+               BUG();
+
+       spin_lock(&swapper_space.i_shared_lock);
+       spin_lock(&mapping->i_shared_lock);
+
+       err = radix_tree_reserve(&mapping->page_tree, index, &pslot);
+       if (!err) {
+               swp_entry_t entry;
+
+               block_flushpage(page, 0);
+               entry.val = page->index;
+               __delete_from_swap_cache(page);
+               swap_free(entry);
+
+               *pslot = page;
+               page->flags = ((page->flags & ~(1 << PG_uptodate | 1 << PG_error
+                                               | 1 << PG_referenced | 1 << PG_arch_1
+                                               | 1 << PG_checked))
+                              | (1 << PG_dirty));
+               page->index = index;
+               add_page_to_inode_queue (mapping, page);
+               atomic_inc(&page_cache_size);
+       }
+
+       spin_lock(&mapping->i_shared_lock);
+       spin_lock(&swapper_space.i_shared_lock);

Don't you mean spin_unlock here?

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
