Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314121AbSDQPJ7>; Wed, 17 Apr 2002 11:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314123AbSDQPJ6>; Wed, 17 Apr 2002 11:09:58 -0400
Received: from holomorphy.com ([66.224.33.161]:51095 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314121AbSDQPJ6>;
	Wed, 17 Apr 2002 11:09:58 -0400
Date: Wed, 17 Apr 2002 08:09:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: viro@math.psu.edu
Subject: [RFC] 2.4 truncate locking
Message-ID: <20020417150912.GI23767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, viro@math.psu.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did some research on how truncate_inode_pages()'s locking works.
Please feel free to clarify and/or correct my notes on the subject,
which I'd like to turn into a docpatch soon.

Thanks to Al Viro, Rik van Riel, Arjan van de Ven, and Christoph Hellwig
for their help to clarify these rules.


Cheers,
Bill

(1) exclusion from freeing of the inode

	inode->i_count for holding a reference count to protect against
	prematurely freeing the inode.

(2) exclusion from simultaneous manipulation of the inode page lists

	pagecache_lock protects page->list and the inode list heads.


(3) exclusion from creation of memory mappings to the affected region

	inode->i_shared_lock and inode->i_mmap_lock serialize mmap
	operations, but are not held by truncate_inode_pages() and so
	proceed simultaneously. No pages are allocated by this operation
	to refer to the inode, as this is done lazily at fault-time.
	See (8) for fault-time exclusion.


(4) exclusion from writes to the affected region

	inode->i_sem

(5) exclusion from reads to the affected region

	reads beyond inode->i_size do not perform pagecache lookup
	pagecache_lock serializes pagecache access while truncation
	simultaneously proceeds

(6) exclusion from pageout of the affected region

	pagemap_lru_lock

(7) exclusion from multiple simultaneous truncate operations

	inode->i_sem

(8) exclusion from memory-mapped reads or writes of the affected region

	either

	(1) unmapping the pages from all processes referencing the pages
		to obtain unique references to them all by means of
		vmtruncate() / zap_page_range()
			*or*
	(2) a unique reference to the inode itself (vma's mapping a file
		have ->vm_file which holds a reference to the inode)

(9) exclusion from simultaneous manipulation of page->mapping

	pagemap_lru_lock

(10) exclusion from simultaneous manipulation of pages by buffer cache

	PG_locked
		and
	unique reference to page by page->buffers == NULL
