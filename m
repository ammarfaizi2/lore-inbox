Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269687AbRHCXQO>; Fri, 3 Aug 2001 19:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269685AbRHCXQF>; Fri, 3 Aug 2001 19:16:05 -0400
Received: from weta.f00f.org ([203.167.249.89]:6032 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269679AbRHCXP4>;
	Fri, 3 Aug 2001 19:15:56 -0400
Date: Sat, 4 Aug 2001 11:16:45 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010804111645.C17925@weta.f00f.org>
In-Reply-To: <20010804100143.A17774@weta.f00f.org> <Pine.GSO.4.21.0108031814510.5264-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0108031814510.5264-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 06:33:37PM -0400, Alexander Viro wrote:

    Like an oopsable race absolutely trivial to exploit for any user
    with write access to fs?

:(

    	a) dentry can freed under you. Just rename the parent while
    you are syncing it. Then you'll block on attempt to take ->i_sem
    on grandparent and merrily go to hell when parent will be moved
    away and rename(2) will do dput() on grandparent.

Can I lock a dentry to prevent this?

    	b) access to ->d_parent requires at least one of the
    following: dcache_lock, BKL, i_sem or ->i_zombie on inode of
    parent.

I assume BLK lock is undesirable here?  dcache_lock seems quite
reasonable and very cheap.  I can't see how else to do it as getting
inode of parent required d_parent.

    	c) as it is, you will get a hell of IO load on a dumb fs.
    dumb == anything that uses file_fsync() as ->fsync() of
    directories.  You'll do full sync of fs on every bloody step.

Yes, but it reality it's not that bad. As is, reiserfs and ext3 (used
to, might not now) sync pending transaction on fsync anyhow.  Run lilo
recently on reiserfs of ext3?  Ever seemed slow?  strace -f and you'll
see it calls fsync after writing to the map files each time (no idea
why) and it it still acceptable.

    	d) sequence of inodes you sync has only one property
    guaranteed: at some moment nth inode is a parent of
    (n-1)th. That's it. E.g. it's easy to get a situation when _none_
    of the inodes you sync had ever been a grandparent of the original
    inode.

I'm not sure I follow you hear... is this because of bind semantics or
somethng else?  I can see it relevant in the case of a fs mount in
/var/somewhere/blah when you fsync /var/somewhere/blah/dir/file, you
don't need to go past blah --- but how would I detect this 'edge'?




Thanks!

  --cw
