Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268991AbUHZOtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268991AbUHZOtA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268976AbUHZOs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:48:59 -0400
Received: from mail.shareable.org ([81.29.64.88]:14022 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269014AbUHZOoj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:44:39 -0400
Date: Thu, 26 Aug 2004 15:44:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Christoph Hellwig <hch@lst.de>, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826144422.GD5733@mail.shareable.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org> <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826130718.GB820@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig and Christophe Saout, I think you two are
miscommunicating a little.

I've never looked at reiser4 code, but I think I understand what you
are both saying, so I will explain.

Christoph Hellwig wrote:
> Here comes the problem.  All the access checking/race avoidance/loop
> creation avoiced, in short the posix+extension semantics are implemented
> in the Linux VFS layer.  If you want to allow a second access method
> (e.g. Hans' pet syscall) you'd have to duplicate all VFS functioanlity
> inside reiser4.

That would be good.  Even better would be if VFS implemented the best
semantics that we agree is nice, after some experimenting with reiser4
lets us discover what works well.

> > The reiser4 core doesn't know about inodes, directories or files. It's
> > the glue code between the VFS and the storage layer that does. It's
> > implemented as a plugin. This has nothing to do with semantic
> > enhancements yet. These should be removed for now and made a 2.7 topic.
> 
> Oh yes, it is.  As soon as you use different access methods on an
> overlapping set of objects you see exactly the problems I described.
> 
> If they don't overlap there's no point for the plugins to start with,
> you'll better turn the core into a library that can be used by different
> projects then.

Firstly, the core library _is_ used by different projects.  That's the
commercial aim of reiser4: to be used by projects other than just as
Linux filesystem.  For example it might be used by a database, or a
portable application which needs to store structured data in a flat
file (with random access).  A good abstraction makes it more useful
than "just" a filesystem.

Secondly, the reiser4 design makes the "high-level plugin" interface a
good clean abstraction.  It's conceptually simple and versatile, so
simplifies the code and makes it easier to try new ideas as well.

I think the disagreement between you two comes down to the idea that a
generally useful API abstraction to file-like objects really should be
somewhere in the VFS, and not specific to a single filesystem.

Unfortunately, the problem is that reiser4 is the only filesystem
which is _technically capable_ of implementing that abstraction in a
practical way, apparently.  (I'm not sure if this is really true.
reiser4's object model is not the same as paths and inodes, but the
impedance mismatch doesn't seem huge.)

Perhaps in future some other filesystems could do it.  Then it would
make sense for the API to be common between them.

At the same time, some of the features which Hans Reiser would like to
offer users -- especially things like metadata indexing -- don't seem
to be very practical on top of the VFS abstraction.

These are conflicting goals.  Hence the argument.

VFS is very POSIX, which rules out some interesting things like
multiple views of an ordinary file (i.e. viewing a flat file and it's
structured form together), coherent files (i.e. metadata which is
calculated from the file contents and always guaranteed to match it),
and real time indexing (i.e. "grep", "locate" and "local-google" but
fancier, always up to date, and still fast).

Those features can be implemented poorly on top of POSIX, and hence
poorly on top of VFS.  We do that today.  It works, it's simple, but
it sucks.  Sometimes it goes wrong (index doesn't match files), it's
slow (locate isn't real-time, and if grep kept content indexes it
would still be too slow to verify them), and it's not really simple as
you have to use special tools for every file format these days, each
with their own unique interface.

I think we can tidy that up a lot, still using the VFS, but with some
extra hooks.  But it's not clear what hooks those would be, and how
the interesting features would be implemented by other POSIX-only
filesystems.  It'd be more useful: I want the fancy stuff to work over
NFS to a bog standard server, or over an old ext2 filesystem that
mustn't be upgraded, not just reiser4, even if I don't have the same
performance and it has to create lots of articial "metadata" files to
simulate the fancy stuff.

-- Jamie
