Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262894AbSITQgV>; Fri, 20 Sep 2002 12:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262899AbSITQgV>; Fri, 20 Sep 2002 12:36:21 -0400
Received: from [140.239.227.29] ([140.239.227.29]:13207 "EHLO
	thunker.thunk.org") by vger.kernel.org with ESMTP
	id <S262894AbSITQgT>; Fri, 20 Sep 2002 12:36:19 -0400
To: linux-kernel@vger.kernel.org
Subject: New version of the ext3 indexed-directory patch
From: tytso@mit.edu
Phone: (781) 391-3464
Message-Id: <E17sQq8-00045P-00@think.thunk.org>
Date: Fri, 20 Sep 2002 12:41:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've done a bunch of hacking on the ext3 indexed directory patch, and I
believe it's just about ready for integration with the 2.5 tree.
Testing and comments are appreciated.

The code can be found either via bitkeeper, at:

	bk://extfs.bkbits.net/ext3-htree-2.4
and
	bk://extfs.bkbits.net/ext3-htree-2.5

Or for those people who want straight diffs, patches against 2.4 
and 2.5 can be found at:

	http://thunk.org/tytso/linux/ext3-dxdir

						- Ted

Here are my Release Notes for my changes:
	(i.e., the changes from Christopher Li's port of Daniel
	Phillip's hashtree code)

*) The Ext3 hash-tree code uses the new TEA and half-MD4 hash that ships
	with e2fsprogs 1.28

*) The code has been massively reorganized and rewritten to make it more
	maintainable.  In particular, the horrible mess which had been
	ext3_find_entry and ext3_add_entry has been broken up into
	multiple functions.  This eliminated a lot of goto's, and more
	importantly, found some memory leaks which have been eliminated.
	Some were only in the error paths, but some were in normal code
	paths that would be executed after a split, for example.

*) As a side effect of the reorganization, the ext3_find_entry() and
	ext3_readdir() paths can now support arbitrary numbers of
	indirect levels in the tree.  (The resulting code was simpler,
	too!)   The one code path that still could use some work is the
	split handling on the insert path.  Once that is generalized, we
	will be able to remove the depth restriction on the indexed tree.

*) The error handling has been cleaned up, so that they are appropriately
	reported back up to userspace, where approach.  Ext3_std_error()
	is now called when the journal routines report an error, in line
	with all of the other journalling calls in the rest of the ext3
	codebase.

*) Ext3_readdir now traverses the directory in hash sort order.  This
	(mostly) solves the requirement that readdir not return doubled
	file entries, or skip a block of files, which could happen if
	another process managed to trigger a tree split while the
	readdir operation was going on.  Unfortunately, on 32 bit
	machines, we have to use a 31-bit sort under all conditions,
	even if telldir64() is used in userspace.  This is because the
	VFS uses a single path for sys_lseek() and sys_llseek(), and so
	the ext3 code can't tell whether to send back a 32-bit value or
	a 64-bit value.  And, if we send a 64-bit positional value when
	the 32-bit lseek() was called, lseek() will bomb out.

	This is unfortunate, but the chances of our hitting this failure
	more are relatively small.  Since readdir (well, sys_getdents64)
	returns 4k of data at at time, that means a directory with
	400,000 entries have approximately 3,000 getdents() system
	calls, with each getdents() returning approximately 133 entries.
	In order to trigger the problem, the 31-bit hash collision
	must be positioned such that it straddles one of the 4k getdents
	blocks --- while a split operation is taking place.

	(If we were willing to modify the VFS layer, so that
	ext3_readdir() knew how much space was left in the filldir
	buffer, we could be even smarter about things by stopping if
	there is only space for less than all of the entries that have
	the same hash value.  I'm not entirely convinced this is
	necessary, though.  The risk is low and in the worst case, one
	or two filenames will simply be returned twice by readdir, which
	shouldn't cause problems for most applications.)

*) Ext3_readdir(), ext3_add_entry(), and ext3_find_entry() now
	automatically fall back to the old linear directory code if they
	find a indexed directory format they don't understand.  This
	allows us to add new hash versions, and/or allow the depth of
	the tree to be increased, without losing backwards compatiblity
	with deployed kernels.
