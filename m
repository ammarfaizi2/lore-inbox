Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423147AbWCUSis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423147AbWCUSis (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423008AbWCUSio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:38:44 -0500
Received: from thunk.org ([69.25.196.29]:25063 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1423260AbWCUSil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:38:41 -0500
Date: Tue, 21 Mar 2006 13:38:22 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>, ams@gnu.org,
       cascardo@minaslivre.org
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060321183822.GC11447@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Andreas Dilger <adilger@clusterfs.com>,
	Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	Laurent Vivier <Laurent.Vivier@bull.net>, ams@gnu.org,
	cascardo@minaslivre.org
References: <1142475556.3764.133.camel@dyn9047017067.beaverton.ibm.com> <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp> <20060316183549.GK30801@schatzie.adilger.int> <20060316212632.GA21004@thunk.org> <20060316225913.GV30801@schatzie.adilger.int> <20060318170729.GI21232@thunk.org> <20060320063633.GC30801@schatzie.adilger.int> <1142894283.21593.59.camel@orbit.scot.redhat.com> <20060320234829.GJ6199@schatzie.adilger.int> <1142960722.3443.24.camel@orbit.scot.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142960722.3443.24.camel@orbit.scot.redhat.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 12:05:22PM -0500, Stephen C. Tweedie wrote:
> > It would also be good to understand what HURD is actually doing with
> > those other fields (if anything, does it even exist anymore?), since
> > it is literally holding TB of space unusable on Linux ext3 filesystems
> > that could better be put to use.  There are i_translator, i_mode_high,
> > and i_author held hostage by HURD, and I certainly have never seen or
> > heard of any good description of what they do or if Linux would/could
> > ever use them, or if HURD could live without them.

Hurd is definitely using the translator field, and I only recently
discovered they are using it to point at a disk block where the name
of the translator program (I'm not 100% sure, but I think it's a
generic, out-of-band, #! sort of functionality).  I don't know about
the other fields, but I can find out.

> If they really are 100% necessary for hurd, it might be that we could
> relegate them to an xattr.  There's the slight problem of testing,
> though; does anyone on ext2-devel actually run hurd, ever?

Relegating them to an xatter would break compatibility with existing
hurd filesystems.  We could take the arrogant "Linux is the only thing
that matters", and just screw them, and the net result will probably
be that Hurd will never implement some of the advanced features we've
been talking about.  They might not anyways, though.  A real problem
is that as far as I know, the hurd ext2 developers aren't on the
ext2-devel mailing list.

I've cc'ed two people that sent me a request to add some additional
debugfs functionality to support hurd; maybe they can help by telling
us whether or not hurd is using i_mode_high and i_author, and whether
or not hurd has any likelihood of tracking new ext3 features that we
might add in the future or not.

> > I'm fully in the "the chance of any real problem is vanishingly small"
> > camp, even though Lustre is one of the few users of large inodes.  The
> > presence of the COMPAT field would not really be any different than just
> > changing ext3_new_inode() to make i_extra_isize 16 by default, except to
> > cause breakage against the older e2fsprogs.
> 
> Setting i_extra_isize will break older e2fsprogs anyway, won't it?
> e2fsck needs to have full knowledge of all fs fields in order to
> maintain consistency; if it doesn't know about some of the fields whose
> presence is implied by i_extra_isize, then doesn't it have to abort?

E2fsprogs previous to e2fsprogs 1.37 ignored i_extra_isize and didn't
check whether or not the EA's in the inode were valid.  Starting in
e2fsprogs 1.37, e2fsck understands i_extra_size and in fact does
validate the EA's in the inode.  If we add new i_extra fields, then
currently e2fsprogs will ignore them, and that's OK for things like
the high precision time fields.  But if they are fields where e2fsck
does need to know about them, then obviously we would need a COMPAT
feature flag to signal that fact (since e2fsck will refuse to operate
on a filesystem if ther is a COMPAT feature that it doesn't
understand.)

> So for future-proofing, we do need some distinction between the fields
> actually *used* in i_extra_isize, and those simply reserved there.  And
> that has to be per-inode, if we want to allow easy dynamic migration to
> newer fields.
>
> So a per-superblock field guaranteeing that there's at least $N bytes of
> usable *potential* i_extra_isize in each inode, and a per-inode
> i_extra_isize which shows which fields are *actively* used, gives us
> both pieces of information that we need.

The easiest way to do future-proofing is to state that they must be
initialized to zero.  That's how we handle unusued fields in the
superblock, after all, and it means that it's relatively easy to add
new superblock fields without needing to cause compatibility
problems..  If you absolutely, positively need e2fsck to abort if it
doesn't understand a particular field, that's what a COMPAT feature
flag is for.  Otherwise, new kernels can simply check to see if the
field is non-zero, and if so, honor it, and old-kernels will simply
ignore the new information.  In many cases, that's more than
sufficient.

						- Ted
