Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293347AbSCZNAj>; Tue, 26 Mar 2002 08:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311464AbSCZNAa>; Tue, 26 Mar 2002 08:00:30 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:32357 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S293347AbSCZNAT>; Tue, 26 Mar 2002 08:00:19 -0500
Date: Tue, 26 Mar 2002 13:02:12 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Christoph Hellwig <hch@caldera.de>, Christoph Rohland <cr@sap.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, velco@fadata.bg
Subject: Re: [PATCH] updated radix-tree pagecache
In-Reply-To: <3CA045BC.AA75D788@zip.com.au>
Message-ID: <Pine.LNX.4.21.0203261227570.1084-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2002, Andrew Morton wrote:
> 
> Aside: This is not related to ratcache: shmem_getpage_locked() is
> setting PG_dirty but not adding the page to mapping->dirty_pages.  Is
> this intended?

Yes.  It used to be the case that if a tmpfs file page got on to
mapping->dirty_pages, fsync on that file would never escape from
filemap_fdatasync if there was no swap.  Hence also "SetPageDirty"
in several places which originally said "set_page_dirty".

Nowadays the "if (!PageLaunder(page)) return fail_writepage(page);"
at the start of shmem_writepage would prevent that hang, and
prevents a subtler tmpfs file corruption we realized later on.

But the dirty_pages list is still a waste of time for tmpfs:
its data does not need to be committed to stable storage.

Hugh

