Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTDUSmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbTDUSmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:42:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1737 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261978AbTDUSmV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:42:21 -0400
Date: Mon, 21 Apr 2003 19:54:24 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       "David S. Miller" <davem@redhat.com>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new system call mknod64
Message-ID: <20030421185424.GO10374@parcelfarce.linux.theplanet.co.uk>
References: <20030421182734.GN10374@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0304211132130.3101-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304211132130.3101-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 11:35:31AM -0700, Linus Torvalds wrote:
> 
> On Mon, 21 Apr 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > > I personally think that anything that uses "dev_t" in _any_ other way than 
> > > <major,minor> is fundamentally broken.
> > 
> > Do you consider internal use of MKDEV-produced constants broken?
> 
> Since they are always in canonical format, there is no way for them to 
> have the aliasing issue. However, even then they _should_ be careful, 
> since it would be very confusing (and bad) if they consider
> 
> 	0x00010100 	(major 1, minor 256)
> 
> to be fundamentally different from
> 
> 	0x01ff		(major 1, minor 255)
> 
> and cause problems that way.
> 
> In other words, if I'm a device driver, and I say that I want "range 
> 0-0xfff" for "major 2", then I had better get _all_ of it.

Sure.  However, note that right now there is only one driver that
wants a range bigger than 256 (and has to split it).  UNIX 98 ptys.
All other character devices ask for less than that.  Block devices
are not asking for large ranges at all (it's either "map that area
this way" or "here's the range of device numbers for partitions of
that disk").

IOW, the only case that might be tempting is devpts.  And there we
simply don't care whether it's current 128:0--128:255, 129:0--129:255, ...
or 128:0--2047.  These guys live on a virtual fs that doesn't get
exported over network.

For now I'd propose to wrap large ranges over the major boundary _and_
have devpts ask for single range.  That allows to clean pty.c now (and have
current behaviour preserved) and after the switch we get only one change -
all these guys migrate to major 128.  Which, AFAICS, is a Good Thing(tm).
Everything else stays with the numebrs that are used now.

Comments?
