Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266917AbUFZBkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266917AbUFZBkt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 21:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266918AbUFZBkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 21:40:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:50106 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266917AbUFZBkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 21:40:43 -0400
Date: Fri, 25 Jun 2004 18:39:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm lock ordering summary
Message-Id: <20040625183947.44c7e635.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0406260153380.20414-100000@localhost.localdomain>
References: <20040625174150.7ad7ee97.akpm@osdl.org>
	<Pine.LNX.4.44.0406260153380.20414-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
>  please add page_map_lock and anon_vma->lock (but where and how many?).

Like this?

There seem to be a few missing bits.



--- 25/mm/filemap.c~lock-ordering-update	2004-06-25 18:37:32.565669464 -0700
+++ 25-akpm/mm/filemap.c	2004-06-25 18:37:32.570668704 -0700
@@ -55,16 +55,17 @@
 /*
  * Lock ordering:
  *
  *  ->i_mmap_lock		(vmtruncate)
  *    ->private_lock		(__free_pte->__set_page_dirty_buffers)
  *      ->swap_list_lock
  *        ->swap_device_lock	(exclusive_swap_page, others)
  *          ->mapping->tree_lock
+ *    ->page_map_lock()		(try_to_unmap_file)
  *
  *  ->i_sem
  *    ->i_mmap_lock		(truncate->unmap_mapping_range)
  *
  *  ->mmap_sem
  *    ->i_mmap_lock
  *      ->page_table_lock	(various places, mainly in mmap.c)
  *        ->mapping->tree_lock	(arch-dependent flush_dcache_mmap_lock)
@@ -82,16 +83,20 @@
  *    ->sb_lock			(fs/fs-writeback.c)
  *    ->mapping->tree_lock	(__sync_single_inode)
  *
  *  ->page_table_lock
  *    ->swap_device_lock	(try_to_unmap_one)
  *    ->private_lock		(try_to_unmap_one)
  *    ->tree_lock		(try_to_unmap_one)
  *    ->zone.lru_lock		(follow_page->mark_page_accessed)
+ *    ->page_map_lock()		(page_add_anon_rmap)
+ *    ->anon_vma.lock		(anon_vma_prepare)
+ *    ->inode_lock		(zap_pte_range->set_page_dirty)
+ *    ->private_lock		(zap_pte_range->__set_page_dirty_buffers)
  *
  *  ->task->proc_lock
  *    ->dcache_lock		(proc_pid_lookup)
  */
 
 /*
  * Remove a page from the page cache and free it. Caller has to make
  * sure the page is locked and that nobody else uses it - or that usage
_

