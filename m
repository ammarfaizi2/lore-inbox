Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWCUEDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWCUEDo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 23:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWCUEDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 23:03:44 -0500
Received: from thunk.org ([69.25.196.29]:8925 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964981AbWCUEDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 23:03:43 -0500
Date: Mon, 20 Mar 2006 23:03:05 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060321040305.GB8257@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Andreas Dilger <adilger@clusterfs.com>,
	Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	Laurent Vivier <Laurent.Vivier@bull.net>
References: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp> <1142475556.3764.133.camel@dyn9047017067.beaverton.ibm.com> <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp> <20060316183549.GK30801@schatzie.adilger.int> <20060316212632.GA21004@thunk.org> <20060316225913.GV30801@schatzie.adilger.int> <20060318170729.GI21232@thunk.org> <20060320063633.GC30801@schatzie.adilger.int> <1142894283.21593.59.camel@orbit.scot.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142894283.21593.59.camel@orbit.scot.redhat.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 05:38:02PM -0500, Stephen C. Tweedie wrote:
> But it's probably not too late.  I would expect that the vast majority
> of filesystems won't have any inodes that have fully-occupied xattr
> space.  It would be easy enough to define a new flag that indicates that
> there is always X amount of space reserved for inode fields, and to set
> that in fsck if all inodes on the fs obey that restriction.  Then it
> just comes down to picking a number X that is likely to satisfy all the
> short-term demands for new inode fields.

Yes, that's what I'm proposing that we do.  My original plan was to
use an incompat flag that would guarantee that there would be enough
space for likely short-term new inode fields, but perhaps it doesn't
have to be an incompat flag.  At least in theory it could be a compat
flag, and then we release a new e2fsprogs which enforces the guarantee
that at least that much space is reserved in every single inode, and
offers to remove one or more EA's in order to satisfy that guarantee.  

There is a chance that someone who has a filesystem with the compat
feature enabled, a kernel has the support for high-resolution
time-stamps, and an old e2fsprogs will get screwed, but only if the EA
space is totally filled up.  But maybe that's an acceptable risk, and
the worst that will happen is that make(1) will get confused.

> I think we're probably early enough in the adoption of large inodes that
> we don't have to make that compromise, and we can reserve some space for
> guaranteed use by inode fields with a single minimally-invasive compat
> change (say, a flag enabling a field in the superblock which defines how
> many bytes we can always safely use for extended inode fields.)

Ah, it sounds like you're thinking the same thing I am.  OK, that
seems like a reasonable compromise.  We are taking a bit of a
shortcut, but it seems reasonable to assume that distro's will have
the right version of e2fsprogs if they want to use this feature; if
they don't users won't be able to enable the new compat flag anyway,
which means the chances of the user noticing a real problem is pretty
low.

						- Ted
