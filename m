Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291327AbSBMDp3>; Tue, 12 Feb 2002 22:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291329AbSBMDpT>; Tue, 12 Feb 2002 22:45:19 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28935 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291327AbSBMDpK>; Tue, 12 Feb 2002 22:45:10 -0500
Date: Tue, 12 Feb 2002 22:42:59 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <3C69B5D7.CFF9E8EA@zip.com.au>
Message-ID: <Pine.LNX.3.96.1020212223440.8017B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Andrew Morton wrote:

> Alan Cox wrote:
> > 
> > > I don't see why it should be different for applications
> > > that write data after sync has started.
> > 
> > The guarantee about data written _before_ the sync started is also being
> > broken unless I misread the code
> 
> That would be very broken.
> 
> The theory is: newly dirtied buffers are added at the "new"
> end of the LRU.  write_some_buffers() starts at the "old"
> end of the LRU.
> 
> So if write_unlock_buffers writes out the "oldest"
> nr_buffers_type[BUF_DIRTY] buffers, then it knows
> that it has written out everything which was dirty
> at the time it was called.
> 
> Or did I miss something?

Alan is right about the first version of the patch not getting all dirty
buffers I haven't looked at the latest version but the change seems to be
correct. Other than that I agree that "everything which was dirty at the
time it was called" is exactly right, what the user expects and what the
SuS says.

However, after thinksing about the SuS, it says (paraphrase) "queued but
not necessarily written." So if I read that right sync() is intended to be
a non-blocking operation. We can do that, but there is one thing which
must be added: with all the various patches which hack the elevator code,
we need a flag which says "do not add anything more to this pass." That
makes the SuS implementation of sync() possible, and makes the completion
of the operation deterministic. When all the dirty blocks are written the
operation is done.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

