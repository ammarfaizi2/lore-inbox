Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289383AbSAVUOp>; Tue, 22 Jan 2002 15:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289384AbSAVUOg>; Tue, 22 Jan 2002 15:14:36 -0500
Received: from zok.SGI.COM ([204.94.215.101]:46543 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S289383AbSAVUOW>;
	Tue, 22 Jan 2002 15:14:22 -0500
Subject: Re: Possible Idea with filesystem buffering.
From: Steve Lord <lord@sgi.com>
To: Chris Mason <mason@suse.com>
Cc: Hans Reiser <reiser@namesys.com>, Rik van Riel <riel@conectiva.com.br>,
        Andreas Dilger <adilger@turbolabs.com>, Shawn Starr <spstarr@sh0n.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
In-Reply-To: <2080500000.1011727185@tiny>
In-Reply-To: <Pine.LNX.4.33L.0201221234470.32617-100000@imladris.surriel.com>
	<3C4DB36F.4090306@namesys.com>  <2080500000.1011727185@tiny>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 22 Jan 2002 14:13:18 -0600
Message-Id: <1011730398.1281.114.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-22 at 13:19, Chris Mason wrote:
> 
> 
> On Tuesday, January 22, 2002 09:46:07 PM +0300 Hans Reiser
> <reiser@namesys.com> wrote:
> 
> > Rik van Riel wrote:
> >>> The FS doesn't know how long a page has been dirty, or how often it
> >>> gets used,
> >> In an efficient system, the FS will never get to know this, either.
> > 
> > I don't understand this statement.  If dereferencing a vfs op for every
> > page aging is too expensive, then ask it to age more than one page at a
> > time.  Or do I miss your meaning?
> 
> Its not about the cost of a function call, it's what the FS does to make
> that call useful.  Pretend for a second the VM tells the FS everything it
> needs to know to age a page (whatever scheme the FS wants to use).
> 
> Then pretend the VM decides there's memory pressure, and tells the FS
> subcache to start freeing ram.  So, the FS goes through its list of pages
> and finds the most suitable one for flushing, but it has no idea how
> suitable that page is in comparison with the pages that don't belong to
> that FS (or even other pages from different mount points of the same FS
> flavor).
> 
> Since each subcache has its own aging scheme, you can't look at a page from
> subcache A and compare it with a page from subcache B.
> 
> All the filesystem can do is flush its own pages, which might be the least
> suitable pages on the entire box.  The VM has no way of knowing, and
> neither does the FS, and that's why its inefficient.
> 
> Please let me know if I misunderstood the original plan ;-)
> 
Looks like I've been missing an interesting thread here ....

Surely flushing pages (and hence cleaning them) is not a bad thing to
do, provided you do not suck up all the available I/O bandwidth in the
process. The filesystem decides to clean the pages as it is efficient
from an I/O point of view. The vm is then free to reuse lots of pages
it could not before, but it still gets to make the decision about the
pages being good ones to reuse.

The xfs kernel changes add a call to writepage into the buffer flushing
path when the data is delayed allocate. We then end up issuing I/O on
surrounding pages which end up being contiguous on disk and are not
currently locked by some other thread.


Steve

