Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130309AbRADRjS>; Thu, 4 Jan 2001 12:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131125AbRADRjI>; Thu, 4 Jan 2001 12:39:08 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:54020 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S130309AbRADRi5>; Thu, 4 Jan 2001 12:38:57 -0500
Date: Thu, 04 Jan 2001 12:38:45 -0500
From: Chris Mason <mason@suse.com>
To: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Christoph Rohland <cr@sap.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] filemap_fdatasync & related changes
Message-ID: <6740000.978629925@tiny>
In-Reply-To: <Pine.LNX.4.21.0101041437550.1188-100000@duckman.distro.conectiva>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, lets just fix filemap_fdatasync.  We can tackle the msync/fsync
interaction with screwed up FS writepages later, since all of the existing
writepage funcs are safe.  The problems I see with filemap_fdatasync when
writepage returns 1:

The page dirty bit is not reset.
the page is never unlocked.

So how about something like this in filemap_fdatasync

ret = writepage(page) ;
if (ret == 1) {
    /* writepage declined to write it out,
    ** leave it on the locked list, but make
    ** sure the dirty bit stays on so the page
    ** doesn't disappear
    */
    SetPageDirty(page) ;
    UnlockPage(page) ;
}

And then, in filemap_fdatawait:

list_del(&page->list) ;
if (PageDirty(page))
    list_add(&page->list, &mapping->dirty_pages) ;
else
    list_add(&page->list, &mapping->clean_pages) ;

-chris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
