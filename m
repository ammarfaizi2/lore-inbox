Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265006AbUGMNda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbUGMNda (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 09:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUGMNda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 09:33:30 -0400
Received: from a4.complang.tuwien.ac.at ([128.130.173.65]:43971 "EHLO
	a4.complang.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S265006AbUGMNd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 09:33:26 -0400
Subject: Re: XFS: how to NOT null files on fsck?
To: cw@f00f.org (Chris Wedgwood)
Date: Tue, 13 Jul 2004 15:33:23 +0200 (CEST)
From: "Anton Ertl" <anton@mips.complang.tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org, jk-lkml@sci.fi (Jan Knutar),
       lkml@tlinx.org (L A Walsh)
In-Reply-To: <20040713095300.GA2986@taniwha.stupidest.org>
Reply-To: anton@mips.complang.tuwien.ac.at
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1BkNPP-0002cI-Tl@a4.complang.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Tue, Jul 13, 2004 at 11:34:54AM +0200, Anton Ertl wrote:
> 
> > It would be the former owner of the block.
> 
> there might not be a former owner (in most cases there probably isn't)

If the owner of the file is not the former owner of the block, the FS
certainly should not put the block in the file.

> > So, how do you tell?
> 
> code inspection and/or testing

How do you test?

Code inspection is good, but I think it needs to be complemented by
testing.

> > Where is data not critical?
> 
> that depends on the person and situation, for me personally lots of my
> data isn't critical.  certainly it's annoying to loose data but
> probably not life threatening

We are balancing three things: making the file system nicer; working
around non-nice file-systems in the applications; and losing data
(even if it's just annoying rather than life-threatening).  IMO losing
data is the worst of these alternatives, and making file system nicer
is the best one.

> > I had such a problem even with a widely-used application like GNU
> > Emacs (many years ago, may be fixed now), casting doubt on your
> > claim that fixing the application is easy.
> 
> emacs will usually rename the old file so at the very least you have
> that

Emacs does that only once per session, and I tend to stay in an Emacs
session for days or weeks (and others probably do so, too).  Then
there is the auto-save file, but unfortunately eager meta-data updates
trash that, too (see
<http://www.complang.tuwien.ac.at/anton/sync-metadata-updates.html>).

> > ext3 data=ordered will probably also work better in most cases than an
> > FS with eager meta-data updates (like, apparently, XFS), but I don't
> > think it guarantees in-order semantics.
> 
> i thought that was the point of it?  as best as i can tell the
> metadata changes will become visible after the data has updated

Right, but that's not sufficient.  I am not an expert on ext3, but
from the description I have read that's all it guarantees.  If an
application does a meta-data update, and then a data update, the disk
state on crash might be that the data update was done and the
meta-data update was not, which is not any of the states that ever
existed logically.

> however, in the case of something like kde/emacs/whatever you can
> *still* loose data
> 
> consider something like:
> 
> 	open with truncate
> 	crash
> 
> or more likely:
> 
> 	open with truncate
> 	write some data
> 	crash
> 
> there is also an even more common case than either of these:
> 
>         open with truncate
> 	write data, get -ENOSPC
> 	spplication terminates/aborts
> 
> at which point you've stomped on your file.  it's non uncommong for
> KDE to do this (even though the window would apparently be very small)

There are certainly ways that an application can lose data even with a
fully synchronous file system (which is the semantically nicest thing
you can ask for (ignoring transactions)), but I am not talking about
that.  Applications can be tested against that relatively easily by
killing the application and seeing if the files are ok.

I am talking about ways that data can be lost because the file system
does not have the nice semantics of a fully synchronous one.  The
in-order guarantee is something that can be implemented relatively
efficiently and that does not add any local ways that data can be lost
or become inconsistent (it does add ways to become inconsistent in
distibuted applications, though, but there are fewer of these
applications around, and their programmers are more used to thinking
about concurrency, and thus hopefully better prepared to insert fsybcs
etc. at the right place).

- anton
