Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261876AbSJDUYO>; Fri, 4 Oct 2002 16:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSJDUYO>; Fri, 4 Oct 2002 16:24:14 -0400
Received: from packet.digeo.com ([12.110.80.53]:44255 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261876AbSJDUYN>;
	Fri, 4 Oct 2002 16:24:13 -0400
Message-ID: <3D9DFA34.581D9D98@digeo.com>
Date: Fri, 04 Oct 2002 13:29:40 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Lord <lord@sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 O)DIRECT problem
References: <1033762674.2457.73.camel@jen.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2002 20:29:40.0666 (UTC) FILETIME=[C41BB1A0:01C26BE4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:
> 
> Hi Andrew,
> 
> I ran into a problem with 2.5's O_DIRECT read path,
> 
>         generic_file_direct_IO usually ends up in generic_direct_IO
>         this does bounds checking on the I/O and then flushes any
>         cached data.
> 
>         Once we return to generic_file_direct_IO we unconditionally
>         call invalidate_inode_pages2 if there are any cached pages.
> 
> If we make a non-aligned O_DIRECT read call, the end result is we
> call invalidate_inode_pages2, but we do not do the filemap_fdatawrite,
> filemap_fdatawait calls. End result is we throw the buffered data away.

Well you could always switch to Linus' current BK tree, in
which invalidate_inode_pages2() is a no-op (whoops).

> Either the flush needs to happen before the bounds checks, or the
> invalidate should only be done on a successful write. It looks
> pretty hard to detect the latter case with the current structure,
> we can get EINVAL from the bounds check and possibly from an
> aligned, but invalid memory address being passed in.

Yes I agree; let's just do the sync before any checks.

I think it should be moved into generic_file_direct_IO(),
because that's the place where the invalidation happens, yes?
