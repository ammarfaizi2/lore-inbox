Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSJ3Ajt>; Tue, 29 Oct 2002 19:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262510AbSJ3Ajt>; Tue, 29 Oct 2002 19:39:49 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:15019 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262506AbSJ3Ajs>;
	Tue, 29 Oct 2002 19:39:48 -0500
Date: Wed, 30 Oct 2002 00:44:57 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: New nanosecond stat patch for 2.5.44
Message-ID: <20021030004457.GC22170@bjl1.asuk.net>
References: <20021029163052.GH28982@clusterfs.com> <Pine.LNX.3.96.1021029151551.8154A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1021029151551.8154A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> I admit to being one of the "thousands" people, and even if I have 100k
> inodes (more likely to be 10% of that) it's in the order of a MB, and any
> machine which has 100k inodes open is likely to be large enough to ignore
> a MB. One advantage of keeping the HRT in the in-core inode is that it
> allows parallel make to work correctly even on a filesystem which doesn't
> have space to save that information.
> 
> Feel free to tell me if that last isn't true.

It isn't true if the parallel make actually uses your RAM for
something, thus flushing some of the inodes from RAM.

Admittedly it is no worse than we have at the moment.  However, at the
moment it is possible, to construct a "make" or other program of that
ilk which can always make a safe decision: if it's ambiguous whether a
file needs to be remade, then remake the file.

As soon as we have inodes time stamp resolution being spontanously
lowered (because some of the inodes are flushed from RAM and some
aren't), then it's not possible to make a safe program like that
anymore, unless you simply ignore the high resolution time stamps
_all_ the time, even when they are present.

You can just do that - it's correct behaviour.  But it would be better
to use the high precision when available, as that reduces the number
of unnecessary remakes.

> 4 - the time could be stored in register values, ticks, or whatever else,
> avoiding any conversion to ns. Then the time could be converted only when
> the inode was read, written out, etc. 
> 
> I'd really like your comments on these, you probably see things I've
> missed.

I know of exactly one application which depends on atime information:
checking whether you have new mail in your inbox.  That's done by
comparing atime and mtime on the mailbox.  Mail readers read the file
after writing it, MTAs will simply write it.

For this to function correctly, what's important is that the atime is
updated to be at least the mtime.  So for nanosecond atime updates, it
makes sense that the _first_ read following a write should update the
atime -- if not using the current clock, then simply copying the mtime
value.

-- Jamie
