Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315042AbSENCGa>; Mon, 13 May 2002 22:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315048AbSENCG3>; Mon, 13 May 2002 22:06:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21515 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315042AbSENCG2>;
	Mon, 13 May 2002 22:06:28 -0400
Message-ID: <3CE071F7.347C78B5@zip.com.au>
Date: Mon, 13 May 2002 19:09:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Chubb <peter@chubb.wattle.id.au>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, axboe@suse.de, martin@dalecki.de,
        neilb@cse.unsw.edu.au
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <20020513131339.A4610@infradead.org> <15584.23204.925373.44968@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:
> 
> ...
> Christoph>  - why is the get_block block argument
> Christoph> a sector_t?  It presents a logical filesystem block which
> Christoph> usually is larger than the sector, not to mention that for
> Christoph> the usual blocksize == PAGE_SIZE case a ulong is enough as
> Christoph> that is the same size the pagecache limit triggers.
> 
> For filesystems that *can* handle logical filesystem blocks beyond the
> 2^32 limit (i.e., that use >32bit offsets in their on-disc format),
> the get_block() argument has to be > 32bits long.  At  the moment
> that's only JFS and XFS, but reiserfs version 4 looks as if it might
> go that way.  We'll need this especially when the pagecache limit is
> gone.

I think Christoph's point is that a pagecache index is not a sector
number.  We agree that we need to plan for taking it to 64 bits, but
it should be something different. Like pageindex_t, or whatever.

This:

--- linux-2.5.15/include/linux/mm.h	Tue Apr 30 17:56:30 2002
+++ 25/include/linux/mm.h	Mon May 13 19:08:21 2002
@@ -148,7 +148,7 @@ struct vm_operations_struct {
 typedef struct page {
 	struct list_head list;		/* ->mapping has some page lists. */
 	struct address_space *mapping;	/* The inode (or ...) we belong to. */
-	unsigned long index;		/* Our offset within mapping. */
+	sector_t index;			/* Our offset within mapping. */
 	atomic_t count;			/* Usage count, see below. */
 	unsigned long flags;		/* atomic flags, some possibly
 					   updated asynchronously */

looks rather silly, no?

-
