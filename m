Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWF1Xzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWF1Xzw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWF1Xzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:55:52 -0400
Received: from thunk.org ([69.25.196.29]:9708 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751781AbWF1Xzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:55:51 -0400
To: linux-kernel@vger.kernel.org
Subject: Proposal and plan for ext2/3 future development work
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1Fvjsh-0008Uw-85@candygram.thunk.org>
Date: Wed, 28 Jun 2006 19:55:39 -0400
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Given the recent discussion on LKML two weeks ago, it is clear that many
people feel they have a stake in the future development plans of the
ext2/ext3 filesystem, as it one of the most popular and commonly used
filesystems, particular amongst the kernel development community.  For
this reason, the stakes are higher than it would be for other
filesystems.  The concerns that were expressed can be summarized in the
following points:

	* Stability.  There is a concern that while we are adding new
		features, bugs might cause developers to lose work.
		This is particularly a concern given that 2.6 is a
		"stable" kernel series, but traditionally ext2/3
		developers have been very careful even during
		development series since kernel developers tend to get
		cranky when all of their filesystems get trashed.

	* Compatibility confusion.  While the ext2/3 superblock does
		have a very flexible and powerful system for
		indicating forwards and backwards compatibility, the
		possibility of user confusion has caused concern by
		some, to the point where there has been one proposal
		to deliberately break forwards compatibility in order
		to remove possible confusion about backwards
		compatibility.  This seems to be going too far,
		although we do need to warn against kernel and
		distribution-level code from blindly upgrading users'
		filesystems and removing the ability for those
		filesystems to be mounted on older systems without an
		explicit user approval step, preferably with tools
		that allow for easy upgrading and downgrading.

	* Code complexity.  There is a concern that unless the code is
		properly factored, that it may become difficult to
		read due to a lot of conditionals to support older
		filesystem formats.

Unfortunately, these various concerns were sometimes mixed together in
the discussion two months ago, and so it was hard to make progress.
Linus's concern seems to have been primarily the first point, with
perhaps a minor consideration of the 3rd.  Others dwelled very heavily
on the second point.

To address these issues, after discussing the matter amongst ourselves,
the ext2/3 developers would like to propose the following path forward.

1) The creation of a new filesystem codebase in the 2.6 kernel tree in
/usr/src/linux/fs/ext4 that will initially register itself as the
"ext3dev" filesystem.  This will be explicitly marked as an
CONFIG_EXPERIMENTAL filesystem, and will in affect be a "development
fork" of ext3.  A similar split of the fs/jbd will be made in order to
support 64-bit jbd, which will be used by fs/ext4 and future versions
of ocfs2.

2) Bug fixes to fix 32-bit cleanliness issues, security/oops problems
will go into fs/ext3, but all new development work will go into fs/ext4.
There is some question about whether relatively low risk features such
as slimming the extX in-core memory structure, and delayed allocation
for ext3, which have no format impacts, should go into fs/ext3, or
whether such enhancement should only benefit fs/ext4 users.  This is a
cost/benefit tradeoff for which the guidance of the LKML community about
whether the loss in code stability is worth the improvements to current
ext3 users, given the existence of the development branch.  

In addition, we are assuming that various "low risk" changes that do
involve format changes, such as support for higher resolution
timestamps, will _not_ get integrated into the fs/ext3 codebase, and
that people who want these features will have to use the
stable/development fs/ext4 codebase.

3) The ext4 code base will continue to mount older ext3 filesystems,
as this is necessary to ensure a future smooth upgrade path from ext3
to ext4 users.  In addition, once a feature is added to the ext3dev
filesystem, a huge amount of effort will be made to provide continuing
support for the filesystem format enhancements going forward, just as
we do with the syscall ABI.  (Emergencies might happen if we make a
major mistake and paint ourselves into a corner; but just as with
changes to the kernel/userspace ABI, if there is some question about
whether or not a particular filesystem format can be supported going
forward indefinitely, we will not push changes into the mainline
kernel until we are can be confident on this point.)

4) At some point, probably in 6-9 months when we are satisified with the
set of features that have been added to fs/ext4, and confident that the
filesystem format has stablized, we will submit a patch which causes the
fs/ext4 code to register itself as the ext4 filesystem.  The
implementation may still require some shakedown before we are all
confident that it is as stable as ext3 is today.  At that point, perhaps
12-18 months out, we may request that the code in fs/ext3/*.c be deleted
and that fs/ext4 register itself as supporting the ext3 filesystem as
well.

We believe this should satisfy most of the concerns that were
articulated, in particular those that Linus and Jeff were most concerned
about.  Comments are of course appreciated.

							- Ted

