Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277115AbRJQTx5>; Wed, 17 Oct 2001 15:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277119AbRJQTxs>; Wed, 17 Oct 2001 15:53:48 -0400
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:48863 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S277115AbRJQTxi>; Wed, 17 Oct 2001 15:53:38 -0400
X-Mailer: Windows Eudora Light Version 1.5.2
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
From: Heikki Tuuri <Heikki.Tuuri@innobase.inet.fi>
Subject: Bugs in file cache, file system, and VM in 2.2 and 2.4?
Message-Id: <20011017195410.CNNE1174.fep07.tmt.tele.fi@omnibook>
Date: Wed, 17 Oct 2001 22:54:11 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is not a detailed bug report because I assume
these problems are already known. I list some of
my observations:

1) I ran on 2.2.14 a simple MySQL/InnoDB test
perl run-all-tests --small-test --small-tables
--create-options=type=innodb

The computer had sofware RAID.

I observed the following:

Sometimes a 300 kB block read from a file
contained 8 bytes reset to zero at an 8 kB
boundary. A file cache bug?

There were also semi-random crashes of threads
usually in < 20 seconds. I was able to track them
with printfs, but the gdb stack never revealed any
bug in MySQL/InnoDB. The same test runs ok on other
platforms. A bug in VM?

2) A friend of mine runs 2.2.19 with ext2, and RAID
mirroring. On two separate machines the file system
has become corrupted so badly that InnoDB log files
disappeared. With a repair disk program the files were
recovered, but, for example, a 30 kB file had become
a 3 kB file. RAID did not help because also the mirror
image was corrupt. InnoDB preallocates its log files
by writing them full of zeros, and their size does
not change. How can file system corruption change a
file size?

3) Once Linux refused to write to log files, giving
an error 'system call interrupted (or -cepted?)'.
When my friend freed some space on the partition,
it worked again. The log files are preallocated.
How can the amount of free disk space affect writing
to within files?

4) My friend ran 2.4.?? (probably .10). InnoDB
reported database page checksum error. Restarting
the database did not help. But after rebooting the
computer the page seemed to be ok again. File cache
corruption? The disk image was good, but the cached
image corrupt?

We have tried using raw disk partitions, but there
is some evidence that corruption occurs also with
them in 2.2.19. Does 2.2.19 write to the raw disk
directly, or does it go through the file cache?

fsync in 2.2.19 is slow. In 2.4 it seems to be so
fast that using raw disk partitions does not speed
up writing. But fdatasync on the other hand seemed to
corrupt files in 2.4.

Linux is the only platform from which MySQL/InnoDB
users have reported corrupt database pages, and I
myself saw these errors in case 1 (2.2.14) above.
InnoDB calculates checksums before writing to data
files, and checks pages when read.

On my development machine, dual Xeon running 2.4.4-SMP
I have never seen page corruption or random thread
crashes.

Some of these bugs may be in MySQL/InnoDB, but
some seem to be in the operating system.

Thus, what is the problem? Do some drivers corrupt
kernel memory or file cache?

Does 2.4 write to raw disks past the file cache?

Is it possible for a layman to debug the Linux
kernel somehow?

The quality problems above are an issue to database
users. I know from Linux desktops and web servers
that Linux is stable in those uses, but with
databases it seems to have problems with some
software/hardware combinations.

Regards,

Heikki Tuuri
Innobase Oy


