Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264850AbUGZCls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbUGZCls (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 22:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUGZCls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 22:41:48 -0400
Received: from [61.49.234.179] ([61.49.234.179]:34285 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S264850AbUGZCln
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 22:41:43 -0400
Date: Mon, 26 Jul 2004 10:37:41 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200407261737.i6QHbff04878@freya.yggdrasil.com>
To: akpm@osdl.org, gotrooted@pop.com.br, linux-kernel@vger.kernel.org,
       maillist@jg555.com, ramon.rey@hispalinux.es
Subject: Future devfs plans (sorry for previous incomplete message)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	[Sorry for the previous incomplete message on lkml.  It was
the first time I've seen xterm segfault in a long time.]

	Please do not delete devfs, as it provides important
functionality unavailable elsewhere, and I have some plans to improve
its implementation further.

Part 1: Advantages of devfs

	devfs allows for creation of devices when user level programs
need them rather than based on "hot plug" or modprobe-related events,
neither of which do not exist for many devices and do not necessarily
indicate need for the driver.  This allow distributions to include a
support for many more devices, without wasting a lot of unswappable
memory, which adds up when there are a lot of potential devices and,
in some cases, can make Linux perform better on platforms with limited
RAM.  I can think of four classes of such devices:

	1. hardware that does not generate "hot plug" events, such as
	   a conventional floppy disk drive.  This way, distributions
	   can have support for all of these devices turned on without
	   bloating the kernel.

	2. software devices, such as /dev/loop.  Again, this way
	   distributions can include support for any such devices that
	   may be developed without a substantial cost in unswappable RAM.

	3. hardware that is incidentally plugged in, but which might not
	   be used in the current session from boot to shutdown.  With the
	   increasing popularity of USB and firewire, a user might have a
	   "webcam", a still digital camera, a digital video converter, a
	   flash reader, a printer, a scanner and an external disk that
	   happen attached to the computer's USB network, with the user
	   having no intention of using any of them during the current
	   session from boot to shutdown.  This way, the cost of leaving
	   some things plugged in for convenience is reduced.

	4. user level disk partitioning, which I've used for years, shrinking
	   the kernel a bit, and possibly enabling one to avoid spinning
	   up disks that are not going to be used.

	In addition, devfs's use of names rather than number for
device identification in the kernel has the potential in the future to
help avoid issues of device ID number collisions, the "Linux assigned
names and numbers authority", and so on.  System administrators that
do not like using devfs names directly can use the mechanisms provided
by devfs user level software to map to device names that they do like.

	In any software, there is always a limit point to the
"mechanism versus policy" slogan where the complexity costs of
providing more generality are believe to outweigh the benefits for the
near future, especially if further generality could be added later if
the need were to arrise.  For example, most ethernet devices are named
"eth%d", although we could conceivably add a translation layer for
that in the future.  I believe that at some point in the distant
future, as part of a rearrangement of the distinctions between block
devices, char devices and device mappers, the method for connecting
the string passed to devfs_register() and the file name that
ultimately appears in /dev might change, but removing devfs in the
meantime would do more to impede such an effort and also would be
throwing the baby out with the bath water due to other advantages of
devfs discussed above.


Part 2: Future plans for devfs

	Some time ago, I posted patches to replace the stock devfs
implementation with a much smaller one based on a specialized fork of
ramfs, replacing the devfs daemon with a facility for having the
kernel exec a helper program on devfs events.  The kernel code was
about a fourth the size of stock devfs, and the user level code was
also reduced by a similar factor.  I use slightly updated version of
that system on several systems every day, under 2.6.7.  I can post
updated patches for this, but I also plan to implement some change
soon.

	I plan to split out the functionality for invoking a user
level helper program on attempts to find or create a file, which
should provide the following advantages:

	1. non-devfs configurations will be able to have demand loading
	   of device drivers that devfs systems currently enjoy.

	2. The kernel memory footprint costs of CONFIG_DEVFS will be
	   even smaller, although the size of CONFIG_DEVFS +
	   CONFIG_lookup_helper will probably be slightly more than
	   that of my current mini-devfs.

	3. It may provide a daemonless alternative to autofs for some
	   simple but common uses.

	4. It will probably at least take us a step toward kicking dnotify
	   out to a demand loaded module (hey, it's unswappable memory that
	   every system currently uses, every byte counts).

	5. It will probably provide a more general mechanism for
	   implementing dnotify-like systems that people periodically post
	   to the linux-kernel mailing list.

	I have not yet written this vaporware, partly because I'm still
pondering the question of whether the facility for exec'ing a user
level program should be done as a few new lines in ramfs, a fork of
ramfs, or an extentsion and restructuring of dnotify.  It should not
be many lines of code.  It's just that I want to get it right.

	Doing this as a ramfs variant would seem to contain the
changes and assure the non-users of this facility that there would be
no cost to them.  So why not do it as a ramfs variant?  Alas, doing
the user level helper facility as a ramfs variant would require adding
a parameter to inode_operations.lookup() because we need to filter out
the lookup event that occurs when an inode is being created.
Otherwise, in certain cases, loading a module that registers multiple
devices can cause a deadlock when the module's initial registration of
the device causes the devfs helper to block on trying to load the same
module again.  Also, I wonder if there might be some use for layering
this facility on top of other file systems, such as /proc or /sys or
arbitrary storage file systems, but I haven't yet been able to come up
with any example.  So, I think that making some general interface that
both dnotify and this facility could be clients of will probably be
the best approach, but there are definitely pros and cons to this
choice, and keeping that code small is something that I want to be
careful about.

	I can post a new mini-devfs patch if there is interest,
although it may be the weekend before I have time to do even that.

	In the meantime, please do not delete devfs.  Thanks in
advance.

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l


