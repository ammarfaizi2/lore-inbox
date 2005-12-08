Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbVLHTUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVLHTUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 14:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVLHTUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 14:20:04 -0500
Received: from gold.veritas.com ([143.127.12.110]:21181 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932264AbVLHTUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 14:20:02 -0500
Date: Thu, 8 Dec 2005 19:19:45 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: set_page_dirty vs set_page_dirty_lock
In-Reply-To: <20051208190913.GA28482@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0512081908530.11737@goblin.wat.veritas.com>
References: <20051208190913.GA28482@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 08 Dec 2005 19:19:52.0087 (UTC) FILETIME=[5D1D0270:01C5FC2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2005, Michael S. Tsirkin wrote:

> Hi!
> The comment at set_page_dirty_lock says:
> 
> /*
>  * set_page_dirty() is racy if the caller has no reference against
>  * page->mapping->host, and if the page is unlocked.  This is because another
>  * CPU could truncate the page off the mapping and then free the mapping.
>  *
>  * Usually, the page _is_ locked, or the caller is a user-space process which
>  * holds a reference on the inode by having an open file.
>  *
>  * In other cases, the page should be locked before running set_page_dirty().
>  */
> 
> Still, I wander whether it might be OK to use set_page_dirty
> in another case - if I previously got a reference to the page
> with get_user_pages?
> The page wouldnt be written back in this case, would it?

It might be, there's no guarantee not.  So if it was written back just
before you did your own dirtying of the page, you do need to set page dirty
again after (usually when releasing the pages got).  And get_user_pages is
a typical case when set_page_dirty_lock is really needed - you don't
usually have any hold on the inode (if any) that backs those pages.

It can be very inconvenient (I don't know what to do for drivers/scsi/sg.c
than set_page_dirty and hope for the best, since it cannot wait for a lock
where it needs to).  But I'm afraid you do have the very case where
set_page_dirty_lock is appropriate.

Many would be pleased if we could manage without set_page_dirty_lock.

> What if I'm in the middle of a system call?

What if you are?

Hugh
