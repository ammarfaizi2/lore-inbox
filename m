Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268842AbRG3PNA>; Mon, 30 Jul 2001 11:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268889AbRG3PMu>; Mon, 30 Jul 2001 11:12:50 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:62985 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268842AbRG3PMn>; Mon, 30 Jul 2001 11:12:43 -0400
Message-ID: <3B657AD9.E15B756D@zip.com.au>
Date: Tue, 31 Jul 2001 01:18:49 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: ext3-2.4-0.9.5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


The latest ext3 patches against linux-2.4.7 and linux-2.4.7-ac3 are at

	http://www.uow.edu.au/~andrewm/linux/ext3/

Changes since 0.9.4 include:

- Fixed a bug which could trip an assertion failure when using small
  journals under heavy load in full data journalling mode.

- A patch from Ted plus the latest version of e2fsprogs plus the stomping
  of various ext3 bugs gives us preliminary support for external journals.

- Redesigned the handling of synchronous operations.  Much simplified and
  several bugs fixed.

- Drastically improved throughput with synchronous mounts - they're now as
  efficient as `chattr +S'.

- Fixed an O(n^2) bottleneck in the commit code.

- Implemented transaction handle batching for a big throughput increase
  with synchronous operations.


The external journal code seems to work OK - brief usage details are at the
web site.  The intent here is that the external journal be an NVRAM device
(or a disk) which can be used to accelerate full-data journalling. 
Simulation using a normal RAM drive indicates that we can double throughput
with some loads (dbench) but not others (synctest).  More work is needed to
fully characterise this.


For the synchronous operations I've put together an application which
attempts to simulate an MTA's behaviour.  The simulator is called
`synctest' and it is in ext3 CVS.  There's a copy at
http://www.uow.edu.au/~andrewm/synctest.c - I'd really appreciate it if the MTA
guys could poke some useful holes in the modelling.

The simulator launches a (large) number of sub-processes.  Each subprocess
does the following:

  for 100 different filenames
    create a file
    write some data to the file (5k to 250k, exponential distribution)
    optionally fsync() the file
    close the file
    optionally fsync() the file's parent dir
    rename the file
    optionally fsync() the file's parent dir
    rename the file
    optionally fsync() the file's parent dir
    rename the file
    optionally fsync() the file's parent dir
    unlink the file from 30 passes ago.

(I'm told that postfix does a lot of renaming).


Now, it makes a very great deal of difference how these files are organised
in directories.  If you have 100 processes each doing synchronous operations
in separate directories then the new transaction batching in ext3 gives it
enormous scalability, whereas ext2 basically stops.

If you have 100 processes each doing synchronous operations in a single big
directory then ext2 does OK, and ext3 is only slightly quicker than ext2. 
This is because the VFS serialises operations on particular directories via
parent->i_sem and defeats ext3 transaction batching.

Most testing was performed on a `chattr +S' directory tree because that seems
to be a convenient way to operate popular MTAs.

ext3 relied upon the `chattr' setting to provide synchronous semantics for
all directory and write operations.  For ext2, the synctest `-f' option was
used to fsync the data at the end of the write.

The following tests were executed on a modern IDE disk with disk write
caching enabled.  Internal journal.  100 processes were used in every test. 
The number of `synctest' processes per directory was altered.

The final column represents ext2 throughput without `chattr +S', but using
fsync() to sync the parent directory and the data.

processes/dir   number of      ext2 completion   ext3 completion  ext2 (no
                directories    time (minutes)    time (minutes)   chattr)

   50               2              7:24              5:10          3:24
   20               5              9:21              3:31
   10              10             11:09              3:05          6:01
    5              20             14:37              3:02
    1             100             23:10              2:44          9:44


Apparently postfix will typically use 256 directories for hashing its
mailspool files.  The reason for this is, presumably, to avoid having single
directories with hundreds of thousands of files in them.  Postfix will spawn
hundreds of processes to work on those directories.  So the last row of this
table is the interesting one.

ext2 bogs down because it has so much metadata to write - it is spread all
over the disk and cannot benefit from write clustering.

ext3 stopped scaling at 20 processes per directory because the limiting
factor was checkpointing all the data and metadata into the main filesystem. 
Seeking.  The time taken to write the data to the journal is negligible when
compared with this.  In fact, the same testing was performed with an external
journal on RAM disk and the throughput was basically unaltered.  More main
memory will really help improve things here.

A 400 megabyte journal was used.  What happens is that ext3 happily writes
all outgoing data into the journal in linear 100 megabyte chunks until you
run out of either a) journal space or b) memory.  Then the whole world stops
for 15-20 seconds while hundreds of megabytes of stuff is written all over
the main filesystem.  This is optimal, but perhaps not desirable.  Using a
smaller journal size will tame this behaviour nicely.  Or use ordered-data
mode which runs smoothly, performs well and has full synchronous behaviour
and recoverability.


Conclusions.  Assuming that `synctest' is somewhat like a real MTA, and that
the MTA is using two-level hashing we can say that:


- chattr +S on ext2 costs you 2:1 or 3:1 throughput when compared with
  fsync()-on-data and fsync()-on-dir.

- full-journalling ext3 can offer a 3x to 10x improvement over ext2,
  depending upon how ext2 is used and the directory layout/task count.

- ext2 likes to have few directories, many processes per directory.

- ext3 likes many directories, few processes per directory.

- We can write data to the journal much faster than we can checkpoint that
  data into the main filesystem, so the benefit of an external journal device
  (spinning or NVRAM) has not been demonstrated.

- The holding of i_sem over the parent is a severe scalability limitation
  with synchronous metadata operations.  Better to have:

	void *opaque;
	down(&parent->i_sem);
	file->f_op->op(&opaque, args...);
	up(&parent->i_sem);
	if (IS_SYNC(inode))
		inode->i_op->wait_on_stuff(opaque);

-
