Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318188AbSIEUNk>; Thu, 5 Sep 2002 16:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318190AbSIEUNk>; Thu, 5 Sep 2002 16:13:40 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:8965 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318188AbSIEUNd>; Thu, 5 Sep 2002 16:13:33 -0400
Message-ID: <3D77BB7C.5F20939F@zip.com.au>
Date: Thu, 05 Sep 2002 13:15:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D77A22A.DC3F4D1@zip.com.au>
		<Pine.BSO.4.33.0209051439540.12826-100000@citi.umich.edu>
		<3D77ADC3.938C09F8@zip.com.au> <shsvg5k9pg3.fsf@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> >>>>> " " == Andrew Morton <akpm@zip.com.au> writes:
> 
>      > You may have more success using the stronger
>      > invalidate_inode_pages2().
> 
> Shouldn't make any difference. Chuck is seeing this on readdir() pages
> which, of course, don't suffer from problems of dirtiness etc on NFS.

Well the VM will take a ref on the page during reclaim even if it
is clean.

With what sort of frequency does this happen?  If it's easily reproducible
then dunno. If it's once-an-hour then it may be page reclaim, conceivably.
The PageLRU debug test in there will tell us.

> I've noticed that the code that used to clear page->flags when we
> added a page to the page_cache has disappeared. Is it possible that
> pages are being re-added with screwy values for page->flags?

It's possible - those flags were getting set all over the place,
and for add_to_swap(), the nonatomic rmw was an outright bug.

The intent now is to set the initial page state in prep_new_page()
and to then modify it atomically from there on in ways which make
sense, rather than "because that's what the code used to do".
Something may have got screwed up in there.  Suggest you print
out page->flags from in there and we can take a look.

It's a bit worrisome if NFS is dependent upon successful pagecache
takedown in invalidate_inode_pages.
