Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbUBWN61 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbUBWN5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:57:51 -0500
Received: from mail.shareable.org ([81.29.64.88]:21890 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261870AbUBWNzd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:55:33 -0500
Date: Mon, 23 Feb 2004 13:55:20 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040223135520.GA30321@mail.shareable.org>
References: <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org> <20040220170438.GA19722@elte.hu> <Pine.LNX.4.58.0402200911260.2533@ppc970.osdl.org> <20040220184822.GA23460@elte.hu> <20040221075853.GA828@elte.hu> <20040223105953.GA2992@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223105953.GA2992@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > monotonity is important: two successive directory operations to not be
> > possible within the same nanosecond. This is not possible with current
> > hardware - but how about future hardware? Can we make an assumption like
> > this?
> 
> Does not ndelay(1) if samba notices mtime is too young in the samba code
> fix that?

No, because Samba cannot tell.  To Samba, it looks like the directory
hasn't changed, when it has.

Another issue is that most machines don't have nanosecond resolution
clocks (e.g. m68k is limited to timer interrupt resolution, and some
x86 machines cannot use the cycle counter), and most filesystems don't
store them either.

The right place to put the delay is in the kernel, when mtime is set
or when it is read, or both.

Important: you *don't* have to delay unless someone has _read_ the
mtime since the last time it was set, _and_ if the mtime wouldn't be
changed by the current operation, _and_ if you cannot simply increment
the low-order bits of mtime due to known limits on the system clock
resolution.

So maintain a flag per inode that says "this inode's mtime has been
read".  It is set whenever the mtime is read, or whenever the inode is
written to disk if you are implementing persistence (because you never
know if someone reads it from the disk at another time).  The flag
does not have to be stored - this works with all filesystems.

Also, you don't have to put the delay where the mtime is updated.  You
can also put it where the mtime is _read_, and then only when the flag
is not set.  Or you can balance it equally between both operations, so
that neither operation can be a DOS for the other.

The delaying strategy works very nicely for filesystems that store low
resolution clocks (i.e. nearly all of them), because even though the
delay is longer (e.g. sleep(1) for ext2, sleep(2) for FAT), that flag
is rarely alternated so you hardly ever need the delay - and mtimes
are still observed to be strictly monotonic.

(You can further eliminate the need for delays by assigning some bits
as a sub-generation counter instead of a timestamp.  This is
equivalent to pretending the system clock has lower resolution than
the filesystem can store. In fact, taking bits _away_ from mtime and
using them a sub-generation counter instead provides better
performance with the guarantee of monotonicity.)

It's a generally useful feature, but I'm not sure why we're looking at
this for Samba, which needs the O_CLEAN mechanism more than it needs
change-detection - for this, Samba can already use the existing
dnotify even though the interface is a bit cumbersome, whereas O_CLEAN
or its equivalent isn't available yet.

-- Jamie
