Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263265AbSJHUUE>; Tue, 8 Oct 2002 16:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbSJHUTO>; Tue, 8 Oct 2002 16:19:14 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:12561
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261427AbSJHTLh>; Tue, 8 Oct 2002 15:11:37 -0400
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
From: Robert Love <rml@tech9.net>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, riel@conectiva.com.br
In-Reply-To: <20021008190513.GA4728@tapu.f00f.org>
References: <1034044736.29463.318.camel@phantasy>
	<20021008183824.GA4494@tapu.f00f.org>
	<1034102950.30670.1433.camel@phantasy> 
	<20021008190513.GA4728@tapu.f00f.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Oct 2002 15:17:16 -0400
Message-Id: <1034104637.29468.1483.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-08 at 15:05, Chris Wedgwood wrote:

> > In other words, this flag pretty much disables the pagecache for
> > this mapping, although we happily keep it around for write-behind
> > and read-ahead.  But once the data is behind us and safe to kill, we
> > do.  It is manual drop-behind.
> 
> OK.  What might use this though?  What applications might want to
> disable the page-cache but still use write-behind?

Streaming I/O wants read-ahead.  Filesystems themselves implement the
write-behind and we do not want to circumvent so much of the kernel.

The point of O_STREAMING is one change: drop pages in the pagecache
behind our current position, that are free-able, because we know we will
never want them.  Its a hint from the application saying "I will never
revisit this so dump it".

O_DIRECT is a much bigger can of worms.  You lose a lot of what the
kernel provides.  You have to do things in block-sized chunks.  Etc.
etc.

> > O_DIRECT has a lot of semantics, one of which is to attempt to
> > minimize cache effects.
> 
> It depends on the OS.  Some OS are broken and treat O_DIRECT as a
> hint, Linux and IRIX know it's a *requirement*.

Yep.  Linux treats most "hints" (e.g. madvise) as a requirement - it
fails if it cannot do it.  That is against the spec most of the time,
but oh well...

> > O_STREAMING would be for your TiVo or network audio streamer.  Any
> > file I/O that is inherently sequential and access-once.  No point
> > trashing the pagecache with its data - but otherwise the behavior is
> > normal.
> 
> Actually, this sounds perfect for O_DIRECT.  But I don't know much
> about streaming video.
>
> Since you only want the data once, why use the page-cache at all and
> needlessly copy?  Certainly, the requirements for O_DIRECT are not
> that hard to meet or implement.
>
> Don't get me wrong, I'm not saying this is a bad thing at all.  The
> patch is small and elegant so it's hard to object; I'm just trying to
> understand where in practice I would use this over O_DIRECT.

Shrug.  I do not have much experience with O_DIRECT.  I suspect the
synchronous nature and the requirement of aligned buffers is not ideal.

With O_STREAMING you can simply set the flag and use your normal I/O and
normal interfaces and have a field day.

Andrew, any experience on one vs. the other?

	Robert Love 

