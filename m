Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbSKKTIR>; Mon, 11 Nov 2002 14:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbSKKTIR>; Mon, 11 Nov 2002 14:08:17 -0500
Received: from packet.digeo.com ([12.110.80.53]:43233 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265890AbSKKTIQ>;
	Mon, 11 Nov 2002 14:08:16 -0500
Message-ID: <3DD001B1.F5F2CC9D@digeo.com>
Date: Mon, 11 Nov 2002 11:14:57 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swap writepages swizzled
References: <Pine.LNX.4.44.0211111826590.1278-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2002 19:14:58.0342 (UTC) FILETIME=[A021D460:01C289B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> ...
> optional patch
> to try_to_free_buffers, once upon a time swap came that way,
> happily ever after it doesn't, so the test seems misleading.
> 

Alas, swapcache pages can still have buffers attached.

It's pretty rare.  Suppose an application has paged in a page from
an ext3 file.  It is sleeping on the completion of the read. Now,
the file is ftruncated.  Pagetables are torn down and truncate_inode_pages
tries to throw away the pagecache.  But the particular page which is
being faulted in has an elevated refcount, so it is not succesfully
freed by truncate.  It _is_ removed from pagecache.

The page is instantiated in the faulter's pagetables as an anonymous
page just floating out there somewhere.

It doesn't have its buffers removed either, because it was attached
to an ext3 transaction at the time of the truncate, and try_to_release_page()
failed.

We end up with an anonymous, swappable page which has buffers.

So we need to keep that test.
