Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143378AbREKUUi>; Fri, 11 May 2001 16:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143392AbREKUU3>; Fri, 11 May 2001 16:20:29 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:41490 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S143378AbREKUUS>; Fri, 11 May 2001 16:20:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
Date: Fri, 11 May 2001 22:20:01 +0200
X-Mailer: KMail [version 1.2]
Cc: phillips@bonn-fries.net,
        Linux kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <200105111634.f4BGY8l6015883@webber.adilger.int>
In-Reply-To: <200105111634.f4BGY8l6015883@webber.adilger.int>
MIME-Version: 1.0
Message-Id: <01051122200102.01990@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 May 2001 18:34, Andreas Dilger wrote:
> Al writes:
> > On Fri, 11 May 2001, Andreas Dilger wrote:
> > > I've tested again, now with kdb, and the system loops in
> > > ext2_find_entry() or ext2_add_link(), because there is a
> > > directory with a zero rec_len. While the actual cause of this
> > > problem is elsewhere, the fact that ext2_next_entry() will loop
> > > forever with a bad rec_len is a bug not in the old ext2 code.
> >
> > No. Bug is that data ends up in pages without being validated.
> > That's the real thing to watch for - if ext2_get_page() is the only
> > way to get pages in cache you get all checks in one place and done
> > once.
>
> OK, I don't think that Daniel is aware of this, I wasn't either.  He
> is using ext2_bread() modified to access the page cache instead of
> the buffer cache.

Oh yes, I'm well aware it, that's what I mean by the "bullet proofing" 
item on my to-do list.  I don't quite agree with the idea of embedding 
the checking of directory entry format inside the ext2_get_page 
routine, it should be moved outside ext2_get_page, on basic principal.
Never mind that this routine is only used to get pages of directory 
files, it's still not nice.  Anyway, I think the thing to do is graft a 
similar one-time check onto ext2_bread.  We can't use Al's PG_checked 
mechanism because we might have read only one buffer out of several on 
the page.

> It turns out that in adding the checks for rec_len, I fixed my
> original bug, but added another...  Please disregard my previous
> patch.

In any event, I couldn't apply it due to patch giving a 'malformed' 
error - did you edit it after diffing?  I'll wait for a revised patch - 
there's quite a lot of stuff in there including formatting changes, 
ext2 warnings, etc.

--
Daniel
