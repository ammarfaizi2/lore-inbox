Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbSKBPfV>; Sat, 2 Nov 2002 10:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261274AbSKBPfV>; Sat, 2 Nov 2002 10:35:21 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:6329 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261268AbSKBPfQ>;
	Sat, 2 Nov 2002 10:35:16 -0500
Date: Sat, 2 Nov 2002 15:41:29 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: John Gardiner Myers <jgmyers@netscape.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
Message-ID: <20021102154129.GA4402@bjl1.asuk.net>
References: <20021031230215.GA29671@bjl1.asuk.net> <Pine.LNX.4.44.0210311642300.1562-100000@blue1.dev.mcafeelabs.com> <20021101020119.GC30865@bjl1.asuk.net> <3DC30DED.6040207@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC30DED.6040207@netscape.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Gardiner Myers wrote:
> The cost of removing and readding the listener to the file's wait queue 
> is part of what epoll is amortizing.

Not really.  The main point of epoll is to ensure O(1) processing time
per event - one list add and removal doesn't affect that.  It has a
constant time overhead, which I expect is rather small - but Davide
says he's measuring that so we'll see.

> There's also the oddity that I noticed this week: pipes don't report 
> POLLOUT readiness through the classic poll interface until the pipe's 
> buffer is completely empty.  Changing this to report POLLOUT readiness 
> when the pipe's buffer is not full apparently causes NIS to break.

There's a section in the Glibc manual which talks about pipe
atomicity.  A pipe must guarantee that a write of PIPE_BUF bytes or
less either blocks or is accepted whole.  So you can't report POLLOUT
just because there is room in the pipe - there must be PIPE_BUF room.

Furthermore, the manual says that after writing PIPE_BUF bytes,
further writes will block until some bytes are read.  This latter does
not seem a useful requirement to me - I think that a pipe could be
larger than the PIPE_BUF atomicity value, but perhaps it is defined in
POSIX or SUS to be like this.  (Someone care to check?)

Together these would seem to imply the behaviour noted by John.

-- Jamie
