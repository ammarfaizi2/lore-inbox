Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbWCUTuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbWCUTuR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWCUTuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:50:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3560 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965071AbWCUTuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:50:14 -0500
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>, ams@gnu.org,
       cascardo@minaslivre.org, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20060321183822.GC11447@thunk.org>
References: <1142475556.3764.133.camel@dyn9047017067.beaverton.ibm.com>
	 <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp>
	 <20060316183549.GK30801@schatzie.adilger.int>
	 <20060316212632.GA21004@thunk.org>
	 <20060316225913.GV30801@schatzie.adilger.int>
	 <20060318170729.GI21232@thunk.org>
	 <20060320063633.GC30801@schatzie.adilger.int>
	 <1142894283.21593.59.camel@orbit.scot.redhat.com>
	 <20060320234829.GJ6199@schatzie.adilger.int>
	 <1142960722.3443.24.camel@orbit.scot.redhat.com>
	 <20060321183822.GC11447@thunk.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 14:47:47 -0500
Message-Id: <1142970467.3443.50.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-03-21 at 13:38 -0500, Theodore Ts'o wrote:

> Hurd is definitely using the translator field, and I only recently
> discovered they are using it to point at a disk block where the name
> of the translator program (I'm not 100% sure, but I think it's a
> generic, out-of-band, #! sort of functionality).  

..

> > If they really are 100% necessary for hurd, it might be that we could
> > relegate them to an xattr.  There's the slight problem of testing,
> > though; does anyone on ext2-devel actually run hurd, ever?
> 
> Relegating them to an xatter would break compatibility with existing
> hurd filesystems.

This would be an incompat change, but one that would not be hard to
maintain.  The translator stuff looks like the kind of thing that would
_easily_ suit xattrs.  

>   We could take the arrogant "Linux is the only thing
> that matters"

I'm not proposing breaking any compatibility.  The idea was simply that
if we wanted to add new fields to that space in the inode struct, it
would be an incompat change on *all* platforms, not just hurd; and that
on hurd, an extra side-effect of that incompat flag would be that we now
look for translation etc. in an xattr.

Do you know how large the translation data is, btw?  If it's typically
just a small string, then we may actually get far better efficiency by
lumping it into the xattr blocks than by keeping it out-of-band.

> E2fsprogs previous to e2fsprogs 1.37 ignored i_extra_isize and didn't
> check whether or not the EA's in the inode were valid.  Starting in
> e2fsprogs 1.37, e2fsck understands i_extra_size and in fact does
> validate the EA's in the inode.  If we add new i_extra fields, then
> currently e2fsprogs will ignore them, and that's OK for things like
> the high precision time fields.  But if they are fields where e2fsck
> does need to know about them, then obviously we would need a COMPAT
> feature flag to signal that fact (since e2fsck will refuse to operate
> on a filesystem if ther is a COMPAT feature that it doesn't
> understand.)

The timestamps are about the only things I can think of that would be
safe to ignore.  Everything else --- i_nlinks, i_blocks, checksums,
highwatermarking --- has consistency implications and e2fsck would need
to be aware of it.

> > So for future-proofing, we do need some distinction between the fields
> > actually *used* in i_extra_isize, and those simply reserved there.  And
> > that has to be per-inode, if we want to allow easy dynamic migration to
> > newer fields.
...
> The easiest way to do future-proofing is to state that they must be
> initialized to zero.

Hmm, that should work.  It certainly works nicely for overflow fields.
It might complicate things like highwatermarking: a simple HWM
implementation would record the amount of the file that is actually
initialised in the HWM field, so "0" would actually be an unusual,
important special case.  And "0" would be a potentially valid checksum
if we use CRC32, too.  Using the per-sb field for reserved space, and
the in-inode one to determine which fields are actively in use, would
avoid such ambiguous cases.

--Stephen


