Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265593AbTF2Gnw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 02:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265596AbTF2Gnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 02:43:52 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:32014 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265593AbTF2Gns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 02:43:48 -0400
Date: Sun, 29 Jun 2003 02:57:42 -0400
From: rmoser <mlmoser@comcast.net>
Subject: File System conversion -- ideas
To: linux-kernel@vger.kernel.org
Message-id: <200306290257420680.0109B84A@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know I spout a ... wtf?  HTML composing?  *attempts to eliminate*

I know I spout a lot of crap, and wish I could just do it all (can we get
a "Make a small device driver for virtual hardware in Linux 2.4 and 2.5"
tutorial up on kernel.org?!), but I think I've got some good ideas.  At
any rate, the good is kept and the bad is weeded out, right?

Anyhow, I'm thinking still about when reiser4 comes out.  I want to
convert to it from reiser3.6.  It came to my attention that a user-space
tool to convert between filesystems is NOT the best way to deal with
this. Seriously, you'd think it would be, right?  Wrong, IMHO.

You have the filesystem code for every filesystem Linux supports.  It's
there, in the kernel.  So why maintain a kludgy userspace tool that has
to be rewritten to understand them all?  I have a better idea.

How about a kernel syscall?  It's possible to do this on a running
filesystem but it's far too difficult for a start, so let's start with
unmounted filesystems mmkay?

**** BEGIN WELL STRUCTURED MESSAGE ****

I'm going to go over a method of building into the kernel a filesystem
conversion suite.  I am first going to go over a brief overrun of the concept,
then I will draw up a roadmap, and then I will explain why I believe this is
the best way to solve this problem.

What I am suggesting is a kernel syscall suite that will allow a simple
userspace application to invoke a conversion between filesystems on an
unmounted filesystem.  The idea is that instead of maintaining the tool,
you (sorry I keep wanting to say "we" for no reason, so excuse me if I do)
simply code this and then maintain the kernel as usual, almost forgetting
about the tool because it changes with the kernel.

The first thing that has to happen is that the kernel filesystem drivers must
be altered to allow the filesystems to draw out the meta-data and group it
with the data, transmit it to the conversion functions, and have this data given
to them to be rewritten.  This will require a quick pre-pass of each individual
inode and a comparison to decide if the converted filesystem will actually
fit on disk; ext3 being converted to ext3 with a larger block size will FAIL if
the conversion causes the data to be bigger than the media.

The second thing that must happen is a syscall has to be added that allows
for conversion to be invoked.  Simple.  Preferably these functions would fork
from the kernel in a new thread or process and work in userspace, to avoid
locking the kernel as they execute and lagging the userspace by making the
kernel eat massive resources.

The last thing is that a user-space program to invoke these syscalls has to be
coded.

Here is a suggested roadmap, with excessive detail:

1) Create a method for storing meta-data for each file/directory on a filesystem
which is being slowly destroyed.  The data structures have to house everything
including the data that goes into the inode tables and all meta-data about the
inode, plus the data for the file/directory itself.  It MUST be object oriented,
because some meta-data will not transfer from one filesystem to another.  Each
unit should, possibly MUST, be compressed, since it MAY be larger than the
original input and also because it likely will have to be stored in the space of the
original data, unless the data is slowly shifted down the filesystem.  It is
preferable to make this datasystem fault tolerant, so that if it goes down, the
conversion can be continued without damage.  It should be possible to plan a
conversion on umount, so that the root filesystem may be converted at shutdown.
  - Object oriented:  Store meta-data that may not be recognized by the new
    filesystem
  - Journalized:  Don't break!
  - Compress data unit:  Don't get bigger than input.  Option is per-unit (compressed
    files get bigger when compressed!)
  - Store data that is needed to resume the conversion at any time: There may be
    a collossal system crash during conversion!
  - Differentiate between each filesystem structure and the datasystem used during
    conversion:  Must be able to disassemble one filesystem and reassemble it to
    another WITHOUT getting lost!
  - ... I had another important thing I forgot for now.  You guys are smart and there's
    more of you than me.  You figure it out.

2) Write this datastructure into the filesystems section of the kernel.

3) Rewrite the filesystem drivers in the kernel to be able to communicate with
the filesystem conversion datastructure code.  This will allow the slow systematic
destruction of the filesystem in place and at the same time the slow systematic
creation of the new filesystem for EVERY filesystem [with write support?] in the
kernel.

4) Impliment a syscall to initiate this process.  The functions should be run in
userspace if it is possible to fork execution out of the kernel and into userspace.
These syscalls include the checks to make sure the filesystem is not mounted.

5) Impliment a userspace program to call these functions.  It is slave to syscalls;
it does NOT do the checks itself.

6) Revisit steps 1 through 5 as needed until the process works properly.

7) Continue on to recode kernel VFS to allow the conversion to take place on a
running filesystem, and to allow that filesystem to be mounted even if the
conversion was forcibly stopped.  This will allow a smoother conversion of the
root filesystem and allow the user to keep running during conversion of the root
filesystem, although with likely a massive latencey issue.

I believe this is the best method of dealing with the problem of filesystem
conversion. Current methods include making a new, empty filesystem and
copying over all files as root with a 'umask 000' command first.  Future methods
excluding this one may include a userspace program with understanding of
multiple filesystems, or a userspace program that understands kernel modules.
These have the following flaws:

 - Copying the files requires a large amount of disk space to create a new
    partition and place the new filesystem on it.  Also, it alters the entire
    partition layout and forces the user to either ping-pong between partitions
    or rewrite his /etc/fstab and possibly his root= parameter in his kernel command
    line.
 - A userspace program with filesystems coded in will require constant matinence
    as new filesystems are created and old filesystems are maintained.  The
    constant development of filesystems such as ext2/3 (i.e. 2.0 doesn't understand
    the extra features in the version of ext2 that 2.2 has) and reiserfs causes this
    to require the rewriting of code in the userspace program, which is redundant
    because the filesystem has already been implimented in an incompatible
    manner in the kernel itself.
 - A userspace program using kernel modules will be more prone to bugs, as it has
    to simultaneously grok all version of kernel modules.  The structure of kernel
    modules changes as time goes on.  The program will grow and grow, or lose the
    ability to communicate with older kernel versions.  It has the advantage that it
    may be written to also grok older kernel modules; however, the entire
    infrastructure described above may be backported to older kernel versions,
    making this argument moot.

My method has the flaw that you have to get the kernel developers to agree to it.
If Linus is reading this, I'd like to at least ask that you hold back rejecting this until
the other developers have a chance to examine it (pessimistic outlook I have on
things, isn't it?).  It also has the flaw of requiring massive kernel-level work to
impliment, which in itself may render the kernel useless if not done quite right.
These changes to the filesystem drivers should not affect the filesystem drivers
until the kernel explicitely calls them to do the conversions (and when the option
is enabled in the make {menu | x}config).  It is flawed also in that it requires
massive CPU and possibly memory; but that is expected of any conversion of
filesystems.

Well, tell me what you think.  This is where my thinking ends.

