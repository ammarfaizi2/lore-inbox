Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262403AbSJDUOd>; Fri, 4 Oct 2002 16:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262402AbSJDUOM>; Fri, 4 Oct 2002 16:14:12 -0400
Received: from [198.149.18.6] ([198.149.18.6]:33202 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262383AbSJDUNK>;
	Fri, 4 Oct 2002 16:13:10 -0400
Subject: 2.5 O)DIRECT problem
From: Steve Lord <lord@sgi.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Oct 2002 15:17:54 -0500
Message-Id: <1033762674.2457.73.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I ran into a problem with 2.5's O_DIRECT read path,

	generic_file_direct_IO usually ends up in generic_direct_IO
	this does bounds checking on the I/O and then flushes any
	cached data.

	Once we return to generic_file_direct_IO we unconditionally
	call invalidate_inode_pages2 if there are any cached pages.

If we make a non-aligned O_DIRECT read call, the end result is we
call invalidate_inode_pages2, but we do not do the filemap_fdatawrite,
filemap_fdatawait calls. End result is we throw the buffered data away.

Either the flush needs to happen before the bounds checks, or the
invalidate should only be done on a successful write. It looks 
pretty hard to detect the latter case with the current structure,
we can get EINVAL from the bounds check and possibly from an
aligned, but invalid memory address being passed in.

This is worse for xfs than for other filesystems since if we do the
invalidate without the flush first, we end up with a delayed allocate
extent in memory and no data to flush into it. Various spots in the
filesystem dislike this.

I can fix it inside xfs by doing my own flush and invalidate first, but
the generic code should really be fixed.

Thoughts?

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
