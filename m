Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130998AbRAELeK>; Fri, 5 Jan 2001 06:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131004AbRAELeA>; Fri, 5 Jan 2001 06:34:00 -0500
Received: from zeus.kernel.org ([209.10.41.242]:43280 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130998AbRAELd5>;
	Fri, 5 Jan 2001 06:33:57 -0500
Date: Fri, 5 Jan 2001 11:29:56 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
        Andreas Dilger <adilger@enel.ucalgary.ca>,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: [RFC] ext2_new_block() behaviour
Message-ID: <20010105112956.V1290@redhat.com>
In-Reply-To: <20010104232541.J1290@redhat.com> <200101050706.f0576lB12236@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200101050706.f0576lB12236@webber.adilger.net>; from adilger@turbolinux.com on Fri, Jan 05, 2001 at 12:06:47AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 05, 2001 at 12:06:47AM -0700, Andreas Dilger wrote:
> Stephen, you write:
> > On Thu, Jan 04, 2001 at 05:31:12PM -0500, Alexander Viro wrote:
> > > BTW, what inumber do you want for whiteouts? IIRC, we decided to use
> > > the same entry type as UFS does (14), but I don't remember what was
> > > the decision on inumber. UFS uses 1 for them, is it OK with you?
> > 
> > 0 is used for padding, so 1 makes sense, yes.
> 
> Sorry, but what are whiteouts?  Inode 1 in ext2 is the bad blocks inode,
> so it will never be used for a valid directory entry, but depending on
> what it is we may want to make sure e2fsck is OK with it as well.

Whiteouts are used for union filesystems, where you layer one
filesystem over another so that all modifications are made in the
"upper" layer, but unmodified files stay in the "lower" layer.  That
way, you can layer an empty filesystem on top of some other directory
and get what is essentially a free snapshot of that directory.

In such a scheme, whiteouts are used if you unlink a file from the
union mount.  The lower-layered filesystem is effectively readonly as
far as the union is concerned, so we record the unlink by adding a
whiteout entry in the upper filesystem.  A lookup for that name in the union
filesystem will find the whiteout and will return ENOENT immediately
without looking to see if the entry exists in the lower filesystem.

We still need to return the whiteouts to user space for getdents(),
though: union filesystems normally deal with readdir() by reading the
whole set of dentries into user space and sorting them there, so the
whiteout is semantically significant to getdents(). 

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
