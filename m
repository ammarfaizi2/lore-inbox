Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319181AbSH2K4V>; Thu, 29 Aug 2002 06:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319182AbSH2K4V>; Thu, 29 Aug 2002 06:56:21 -0400
Received: from h-64-105-35-65.SNVACAID.covad.net ([64.105.35.65]:63925 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S319181AbSH2K4T>; Thu, 29 Aug 2002 06:56:19 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 29 Aug 2002 04:00:32 -0700
Message-Id: <200208291100.EAA11337@adam.yggdrasil.com>
To: hch@infradead.org
Subject: Re: Loop devices under NTFS
Cc: aia21@cantab.net, kernel@bonin.ca, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Aug 27, 2002 at 06:06:32PM -0700, Adam J. Richter wrote:
>> >I tell you that the address_spaces are an _optional_ abstraction.
>> >Thus using the directly from generic code is a layering violation.
>> 
>> 	That does not follow from your previous sentence.  It is
>> perfectly legitimate to check for the existence of an optional feature
>> and use it if it is there, which is what the stock 2.5.31 loop.c and
>> my version do.

>I didn't say an optional feature.  The filesystem may choose to use that
>abstraction in a totally different way than the generic code.  An example
>for such an filesystem is GFS.  Thus OpenGFS doesn't support loop devices
>at all and sistina has tp provide workaround patches for their propritary
>product.

	To the best of my knowledge, OpenGFS is not available for 2.5,
and OpenGFS patches the 2.4 kernel to use {prepare,commit}_write the
way it does (referring to
opengfs-0.0.92/kernel_patches/2.4.17/generic_file_write.patch,
although you should be happy to know that that should not be necessary
if you port it to 2.5, since 2.5 provides generic_file_write_nolock).

	If the OpenGFS wants to change the aops requirements given in
Documentation/filesystems/Locking, let's have that "review", as you
have argued for in this thread when the shoe was on the other foot.

	It is worth noting that the shoe also seems to be on the other
foot with respect to your doctine of giving priority to "mainline"
kernel conventions.  Documentation/filesystem/Locking and the existing
drivers/block/loop.c are part of the mainline kernel, and the reasons
for cryptoapi not being in the mainline kernel partly have to do with
concerns about distributability (although a much smaller issue in some
countries than under their past crypto laws).  In comparison, OpenGFS
is not in the mainline kernel, and I haven't heard any legal grumbles
from Sistina about it, so it's not being included is probably due to a
lack of users and/or maintenance.  The last OpenGFS release, 0.0.92,
was seven months ago.  Opengfs-users has had three messages since
July.  Opengfs-devel has had a total of three in the month of August,
and has been quiet for three weeks.  So, your doctine about about the
mainline kernel having priority argues against accomodating OpenGFS.
Fortunately, I don't give much weight to that policy.  My point is
just that you only make trouble for yourself with these proclamations.

	In other words, doctrinaire ex cathedra proclamations like "I
didn't say an optional feature" will not identify the most beneficial
design trade-off as reliably, convincingly or even as quickly as
analyzing end user benefits.  For example, everything above this line
could have been skipped if you would we would avoid "proof by
proclamation."  Can we please try?  Thanks in advance.

---------------------------------------------------------------------------

	If OpenGFS is being made to work under 2.5, we should be able
to arrange for /dev/loop to work on OpenGFS without making users of
encrypted loop files pay the cost of the extra copy (more on this cost
below).  Even if OpenGFS or a variant is never going to be ported to
2.5, I am willing to look at it as an example of the potential
benefits of removing aops->{prepare,commit}_write calls from loop.c,
although it may then be reasonable to conclude that the code should
not be changed until needed.

	Here are the three approaches that I can think of and their
major pros and cons:

	1. Make loop.c never use {prepare,commit}_write.
	   Pro: Shrinks loop.c
	   Con: adds a copy operation to most encrypted loop files.

	2. As you mention (but do not endorse) in your posting to gfs-devel,
	   modify loop.c so that it does not use {prepare,commit}_write
	   on OpenGFS, but does on other file systems (to avoid a data copy).
	   This kludge could, for example, be of any of these ~5 line changes:
		a. strcmp(lo->backing_file->file_dentry->d_inode->i_sb->s_type->name, "gfs")
		b. address_space_operations.pagecache_unwritable
		c. an ioctl option passed via losetup
	   Pro: Other encrypted loop files avoid a copy.
	   Con: Encrypted loop files on GFS do an extra copy;
		it's a kludge; option c is not automatic.

	3. Make OpenGFS (and potentially other future file systems)
	   export a {prepare,commit}_write that works with loop.c, as
	   documented in Documentation/filesystem/Locking.
	   Pro: Encrypted loop files on all file systems including GFS
		avoid a copy operation.  If tmpfs follows suit, then
		maybe loop.c can shrink (remove file->{read,write} IO).
	   Con: (To be discussed.)

	The pros and cons basically boil down to two questions:

	1. How beneficial is it to avoid the copy?
	   (high benefit opposes #1, slightly supports #3 over #2)
	2. What are the cons for #3?


	Let's start with the cost of the copy, which you address here:

>Blarg.  If you care for performance encrypted loop is the last thing you want.

	I think you've got it backwards.  Ultimately, the only reason
that people care about performance is to apply it to some useful
purpose.  For example, perhaps you want to create an encrypted loop
file to store and view some movies (say, because you want to protect
the authors copyright interests), or for a small confidential database.

	Bruce Schneier's x86 implementation of twofish encrypts at 18
cycles per byte on Pentium 3, which should be about 55MB/sec on a 1GHz
P3.  Here is a URL for someone who claims to have an x86 AES
implementation that does up to 58MB/sec.:
http://fp.gladman.plus.com/cryptography_technology/rijndael/ and one
that does 45MB/sec on an 800MHz Pentium III:
http://home.cyber.ee/helger/implementations/.  I believe that is about
the sustained transfer rate of one top of the line hard disk (although
the file system means there will be some seeks slowing that down), and
the file system will have a slower sustained transfer rate on one
disk, due at least to some seeking.  So, depending on CPU speed and
other computing that there is to be done, it is possible that with
read-ahead and write-behind that encryption one one CPU can be fast
enough to keep up with the maximum throughput of the filesystem on a
one disk drive.

	In this context, the cost of an extra memory copy becomes
nearly as important as it is without encryption, perhaps more
important because CPU and memory bandwidth are now more of a gating
factor.  Poking around the web,
http://old.lwn.net/2001/0405/a/sched-tests.php3 has some lmbench
numbers for a 1GHz computer, which give bcopy a speed of up to about
270MB/sec, or 20% of time used by high optimized encryption.  As the
speed ratios of processor cores to memory bandwidth increases, bcopy
will account for a larger penalty.  Also, the sizes of the data
transfers that we are talking about in a single bio are a substantial
fraction of the size of the level 2 data cache (the L1 data cache will
be completely used either way).

	Anyhow, I would guess that, given optimized encryption, will
turn out to make a difference of at least 5% in sustained bandwidth.
That's not the kind of difference that brings a system to its knees,
but it is the kind of difference that people benchmark and feel
justified in adding or keeping extra code.

	Now let's look at the costs involved in having opengfs
allow loop.c to use {prepare,commit}_write.

	I have downloaded opengfs-0.0.92.tar.gz and looked at
gfs_{prepare,commit}_write, gfs_unstuff_dinode, but I don't yet see
the specific problem that you refer to in your message on
opengfs-devel about gfs_{prepare,commit}_write assuming that a certain
lock is held.

	When I try to build 0.0.92 under linux-2.5.31, I get
compilation errors such as, src/locking/modules/memexp/memxp.h needing
<linux/locks.h>, which does not exist in 2.5, and the sourceforge cvs
version appears to have this dependency too.  The documentation in
0.0.92 only talks about 2.4, and neither 0.9.2 nor the sourceforge cvs
tree have src/fs/arch_linux_2_5.  Its documentation only talks about
2.4, and the current cvs tree on sourceforge does not have a
src/fs/arch_linux_2_5 either.  When I try to build it, with errors
such as, src/locking/modules/memexp/memxp.h needing <linux/locks.h>,
which does not exist in 2.5, and the sourceforge cvs version appears
to have this dependency as well.

	I am guessing that the basic problem is that OpenGFS wants
to do something like this:

		down(&inode->i_sem);
		Acquire file lock via pluggable lock manager (gfs_glock_i?)
		some other gfs-specific initialization
		Call __generic_file_write

		     generic_file_write calls gfs_prepare_write
		     generic_file_write calls gfs_commit_write

		     generic_file_write calls gfs_prepare_write
		     generic_file_write calls gfs_commit_write
		     .
		     .
		__generic_file_write returns
		some other gfs-specific tear-down
		Release file lock via pluggable lock manager
		up(&inode->i_sem);


	If I understand correctly, the situation is that you could
do the initialization and tear-down in every gfs_prepare_write and
gfs_commit_write.

	Would it be possible to add two more address_space operations,
along the following lines to provide a general mechanism for this
optimization?:

struct address_space_operations {
    int before_io(struct file *file, int dir, unsigned start, unsigned len);
    int after_io(struct file *file, int dir, unsigned start, unsigned len);
};

	generic_file_write is pretty big to begin with, so checking
these values once on each call to generic_file_write should not be a
big deal.

	I don't think that this would need to go into the kernel until
OpenGFS is ported to 2.5, so I think there is plenty of time to get
everyone's input on it.  Could you make OpenGFS work approximately as
optimally given that abstraction?

	In the meantime, I'm quite willing to put a kludge in loop.c
to make it use file_ops->{read,write} if the underlying file is on a
file system type named "gfs".  I would like to see OpenGFS work
without problems.  I think it's great that you guys are doing it
(although perhaps you have lately been waiting to see how real Lustre
turns out to be?).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
