Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVCHMb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVCHMb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 07:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVCHMb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 07:31:28 -0500
Received: from thunk.org ([69.25.196.29]:32898 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261230AbVCHMbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 07:31:20 -0500
Date: Tue, 8 Mar 2005 07:31:09 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Junfeng Yang <yjf@stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devl@stanford.edu
Subject: Re: [CHECKER] crash after fsync causing serious FS corruptions (ext2, 2.6.11)
Message-ID: <20050308123109.GA7005@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Junfeng Yang <yjf@stanford.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ext2-devl@stanford.edu
References: <Pine.GSO.4.44.0503070124460.29202-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0503070124460.29202-100000@elaine24.Stanford.EDU>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 01:57:10AM -0800, Junfeng Yang wrote:
> FiSC (our FS checker) issues a warning on ext2, complaining that crash
> after fsync causes file system to corrupt.  FS corrupts in two different
> ways: 1. file contains illegal blocks (such as block # -2) 2. one block
> owned by two different files.
> 
> I diagnosed the warning a little bit and it appears that this warning can
> be triggered by the following steps:
> 
> 1. a file is truncated, so several blocks are freed
> 2. a new file is created, and the blocks freed in step 1 are reused
> 3. fsync on the new file
> 4. crash and run fsck to recover.
> 
> fsync should guarantee that a specific file is persistent on disk.
> Presumably, operations on other files should not mess up with the file we
> just fsync (true ?)  However, I also understand that ext2 by default
> relies on e2fsck to provide file system consistency.  Do you guys consider
> the above warning as a bug or not?  Any clarification on this will be very
> helpful.

Whether or not it is a bug is debateable.  (Talking to certain *BSD
folks on this subject will cause them to jump and down and froth at
the mouth.)  It is *expected* behaviour, yes, and it is mitigated by
two factors.  (1) Metadata for ext2 is synced out every 5 seconds,
while data is synced out every 60, so the max window for this race
described above is 5 seconds, and in practice rarely shows up if you
are not using fsync.  (2) Unlike BSD's fsck, when a block is owned by
two different files, we offer an option to clone the affected files so
data isn't lost, while BSD's fsck shoots both files and asks questions
later.

I believe the warning should go away if you mount -o sync (but then
the filesystem will perform very slowly :-).

As I had alluded to earlier, this has historically been a bone of
contention with the *BSD folks since ext2 was much, much faster than
the BSD FFS, and the main reason why is that the FFS had all sorts of
logic to make sure metadata blocks would be synced in certain order to
make life easier for their fsck, and this made ext2 substantially
faster than the BSD FFS.  Given that most people only pay attention to
benchmarks, this upset them.  Ext2's approach relied on a simpler and
more performant kernel implementation, and a more intelligent fsck.
Also, as I had pointed out to the BSD folks, BSD 4.3/4.4's FFS also
had the property that they did just enough write ordering to guarantee
that fsck -p would run smoothly, but not enough to make any guarantees
about recently written files, and only a filesystem weenie would care
that fsck was clean when user data files were silently corrupted after
a crash.  (This was all pre-soft updates, by the way.)

The tradeoff as far as ext2 was concerned was that if you got unlucky
and managed to trigger this warning it did require a manual fsck
instead of an automatic fsck.  In actual practice, in the real world
this happened extremely rarely.  

Should we fix it today?  Given that we have ext3, I'd probably answer
no.  It's a known property of ext2; we've lived with it for over ten
years, and to add this would just slow down ext2 (which gets used
often as benchmark standard to aspire to), and make the ext2 codebase
more complicated.

							- Ted

