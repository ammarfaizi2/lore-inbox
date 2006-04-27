Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751674AbWD0VLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbWD0VLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 17:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWD0VLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 17:11:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:45759 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751672AbWD0VLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 17:11:40 -0400
Date: Thu, 27 Apr 2006 14:10:12 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, kay.sievers@suse.de
Subject: [RFC] Add kernel<->userspace ABI stability documentation (try 2)
Message-ID: <20060427211012.GA1719@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I've tried to take into account all of the different comments that I
received on this proposal last time around, and have an updated patch
below that I think strikes an proper balance between the different
people.

In short, we really need a way to document the different interfaces that
the kernel has between userspace and kernelspace.  Traditionally this
has only been with the syscall interface, and a few odd proc files and
sysctls.  In recent years that interface has grown to accommodate a
variety of ram-based filesystems, and other fun ways to get data in and
out of the kernel (netlink, connector, etc.)

This patch proposes that _all_ kernel interfaces between userspace and
the kernel be documented in some manner.  Now this doesn't mean that the
man-pages for the different syscalls need to be included here, but we
really need to try to get a handle of what is changing and what will be
affected if we do change things.

Also, when interfaces are first introduced, they go through a bit of
change and stabilization as people start to use them and things happen
that the original designers did not consider (which is one of the big
strengths of our development model.)  So we need to mark a few new
interfaces as "testing" to give them a bit of time to mature and
solidify.

As an example, Solaris also has a scale of the different "maturity
levels" of its kernel interfaces, but I think there are some 8 different
levels, I'm proposing only 4 here:
  - stable
  - testing
  - obsolete
  - removed

Any comments?  Revisions that people feel still need to be made?

Objections?

thanks,

greg k-h

--------------

From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: Add kernel<->userspace ABI stability documentation


Signed-off-by: Kay Sievers <kay.sievers@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 Documentation/ABI/README                |   77 ++++++++++++++++++++++++++++++++
 Documentation/ABI/obsolete/devfs        |   13 +++++
 Documentation/ABI/stable/syscalls       |   10 ++++
 Documentation/ABI/stable/sysfs-module   |   29 ++++++++++++
 Documentation/ABI/testing/sysfs-class   |   16 ++++++
 Documentation/ABI/testing/sysfs-devices |   25 ++++++++++
 6 files changed, 170 insertions(+)

--- /dev/null
+++ gregkh-2.6/Documentation/ABI/README
@@ -0,0 +1,77 @@
+This directory attempts to document the ABI between the Linux kernel and
+userspace, and the relative stability of these interfaces.  Due to the
+ever changing nature of Linux, and the differing maturity levels, these
+interfaces should be used by userspace programs in different ways.
+
+We have four different levels of ABI stability, as shown by the four
+different subdirectorys in this location.  Interfaces may change levels
+of stability according to the rules described below.
+
+The different levels of stability are:
+
+  stable/
+	This directory documents the interfaces that have the developer
+	has defined to be stable.  Userspace programs are free to use
+	these interfaces with no restrictions, and backward
+	compatibility for them will be guaranteed for at least 2 years.
+	Most simple interfaces (like syscalls) are expected to never
+	change and always be available.
+
+  testing/
+	This directory documents interfaces that are felt to be stable,
+	as the main development of this interface has been completed.
+	The interface can be changed to add new features, but the
+	current interface will not break by doing this, unless grave
+	errors or security problems are found in them.  Userspace
+	programs can start to rely on these interfaces, but they must be
+	aware of changes that can occur before these interfaces move to
+	be marked stable.  Programs that use these interfaces are
+	strongly encouraged to add their name to the description of
+	these interfaces, so that the kernel developers can easily
+	notify them if any changes occur (see the description of the
+	layout of the files below for details on how to do this.)
+
+  obsolete/
+  	This directory documents interfaces that are still remaining in
+	the kernel, but are marked to be removed at some later point in
+	time.  The description of the interface will document the reason
+	why it is obsolete and when it can be expected to be removed.
+	The file Documentation/feature-removal-schedule.txt may describe
+	some of these interfaces, giving a schedule for when they will
+	be removed.
+
+  removed/
+	This directory contains a list of the old interfaces that have
+	been removed from the kernel.
+
+Every file in these directories will contain the following information:
+
+What:		Short description of the interface
+Date:		Date created
+KernelVersion:	Kernel version this feature first showed up in.
+Contact:	Primary contact for this interface (may be a mailing list)
+Description:	Long description of the interface and how to use it.
+Users:		All users of this interface who wish to be notified for
+		when it changes.  This is very important for interfaces in
+		the "testing" stage, so that kernel developers can work
+		with userspace developers to ensure that things do not
+		break in ways that are unacceptable.  It is also important
+		to get feedback for these interfaces to make sure they are
+		working in a proper way and do not need to be changed
+		further.
+
+
+How things move between states:
+
+Interfaces in stable may move to obsolete, as long as the proper
+notification is given.
+
+Interfaces may be removed from obsolete and the kernel as long as the
+documented amount of time has gone by.
+
+Interfaces in the testing state can move to the stable state when the
+developers feel they are finished.  They can not be removed from the
+kernel tree without going through the obsolete state first.
+
+It's up to the developer to place their interface in the category they
+wish for it to start out in.
--- /dev/null
+++ gregkh-2.6/Documentation/ABI/obsolete/devfs
@@ -0,0 +1,13 @@
+What:		devfs
+Date:		July 2005
+Contact:	Greg Kroah-Hartman <gregkh@suse.de>
+Description:
+	devfs has been unmaintained for a number of years, has unfixable
+	races, contains a naming policy within the kernel that is
+	against the LSB, and can be replaced by using udev.
+	The files fs/devfs/*, include/linux/devfs_fs*.h will be removed,
+	along with the the assorted devfs function calls throughout the
+	kernel tree.
+
+Users:
+
--- /dev/null
+++ gregkh-2.6/Documentation/ABI/stable/syscalls
@@ -0,0 +1,10 @@
+What:		The kernel syscall interface
+Description:
+	This interface matches much of the POSIX interface and is based
+	on it and other Unix based interfaces.  It will only be added to
+	over time, and not have things removed from it.
+
+	Note that this interface is different for every architecture
+	that Linux supports.  Please see the arch specific documentation
+	for details on the syscall numbers that are to be mapped to each
+	syscall.
--- /dev/null
+++ gregkh-2.6/Documentation/ABI/stable/sysfs-module
@@ -0,0 +1,29 @@
+What:		/sys/module
+Description:
+	The /sys/module tree consists of the following structure:
+
+	/sys/module/MODULENAME
+		The name of the module that is in the kernel.
+		This module name will show up both if the module is built
+		directly into the kernel, or if it is loaded as a dyanmic
+		module.
+
+	/sys/module/MODULENAME/parameters
+		This directory contains individual files that are each
+		individual parameters into the module that are are able to be
+		changed at runtime.  See the individual module documentation as
+		to the contents of these parameters and what they accomplish.
+
+		Note: The individual parameter names and values are not
+		considered stable, only the fact that they will be placed into
+		this location within sysfs.  See the individual driver
+		documentation for details as to the stability of the different
+		parameters.
+
+	/sys/module/MODULENAME/refcnt
+		If the module is able to be unloaded from the kernel, this file
+		will contain the current reference count of the module.
+
+		Note: If the module is built into the kernel, or if the
+		CONFIG_MODULE_UNLOAD kernel configuration value is not enabled,
+		this file will not be present.
--- /dev/null
+++ gregkh-2.6/Documentation/ABI/testing/sysfs-class
@@ -0,0 +1,16 @@
+What:		/sys/class/
+Date:		Febuary 2006
+Contact:	Greg Kroah-Hartman <gregkh@suse.de>
+Description:
+		The /sys/class directory will consist of a group of
+		subdirectories describing individual classes of devices
+		in the kernel.  The individual directories will consist
+		of either subdirectories, or symlinks to other
+		directories.
+
+		All programs that use this directory tree must be able
+		to handle both subdirectories or symlinks in order to
+		work properly.
+
+Users:
+	udev <linux-hotplug-devel@lists.sourceforge.net>
--- /dev/null
+++ gregkh-2.6/Documentation/ABI/testing/sysfs-devices
@@ -0,0 +1,25 @@
+What:		/sys/devices
+Date:		February 2006
+Contact:	Greg Kroah-Hartman <gregkh@suse.de>
+Description:
+		The /sys/devices tree contains a snapshot of the
+		internal state of the kernel device tree.  Devices will
+		be added and removed dynamically as the machine runs,
+		and between different kernel versions, the layout of the
+		devices within this tree will change.
+
+		Please do not rely on the format of this tree because of
+		this.  If a program wishes to find different things in
+		the tree, please use the /sys/class structure and rely
+		on the symlinks there to point to the proper location
+		within the /sys/devices tree of the individual devices.
+		Or rely on the uevent messages to notify programs of
+		devices being added and removed from this tree to find
+		the location of those devices.
+
+		Note that sometimes not all devices along the directory
+		chain will have emitted uevent messages, so userspace
+		programs must be able to handle such occurances.
+
+Users:
+	udev <linux-hotplug-devel@lists.sourceforge.net>
