Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261491AbSJHSou>; Tue, 8 Oct 2002 14:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbSJHSon>; Tue, 8 Oct 2002 14:44:43 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:32271
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261483AbSJHSnb>; Tue, 8 Oct 2002 14:43:31 -0400
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
From: Robert Love <rml@tech9.net>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, riel@conectiva.com.br
In-Reply-To: <20021008183824.GA4494@tapu.f00f.org>
References: <1034044736.29463.318.camel@phantasy> 
	<20021008183824.GA4494@tapu.f00f.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Oct 2002 14:49:09 -0400
Message-Id: <1034102950.30670.1433.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-08 at 14:38, Chris Wedgwood wrote:

> > Attached patch implements an O_STREAMING file I/O flag which enables
> > manual drop-behind of pages.

I answered this in a previous email to this list:

    In a lot of ways.  This flag changes no semantics except to not let
    pages from the mapping populate the page cache for very long.
    
    In other words, this flag pretty much disables the pagecache for
    this mapping, although we happily keep it around for write-behind
    and read-ahead.  But once the data is behind us and safe to kill, we
    do.  It is manual drop-behind.
    
    O_DIRECT has a lot of semantics, one of which is to attempt to
    minimize cache effects.  It is also synchronous, requires properly
    aligned buffers, and pretty much minimizes interaction with as much
    of the kernel as possible.  I am not overly familiar with its uses,
    but I always assumed the big user is applications that implement
    their own caching layer.
    
    O_STREAMING would be for your TiVo or network audio streamer.  Any
    file I/O that is inherently sequential and access-once.  No point
    trashing the pagecache with its data - but otherwise the behavior is
    normal.
    
Basically, with O_STREAMING you want normal semantics except drop-behind
of the pages.  You even still want the pagecache caching your data -
just the not-yet-written write-behind data and the not-yet-read
read-ahead data.

With O_DIRECT you get a whole different can-of-worms.  Basically you cut
out a lot of the kernel.  You can do normal libc file I/O on an
O_STREAMING file with no semantic changes; except the drop-behind of the
pages.

	Robert Love

