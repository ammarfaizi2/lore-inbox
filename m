Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751709AbWB0TBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbWB0TBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbWB0TBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:01:54 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:56220
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751708AbWB0TBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:01:53 -0500
Date: Mon, 27 Feb 2006 11:01:50 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz
Cc: gregkh@suse.de, Kay Sievers <kay.sievers@vrfy.org>
Subject: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227190150.GA9121@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

As has been noticed recently by a lot of different people, it seems like
we are breaking the userspace<->kernelspace interface a lot.  Well, in
looking back over time, we always have been doing this, but no one seems
to notice (proc files changing format and location, netlink library
bindings, etc.)

Linux is a dynamic system, we add and change things all the time based
on the need of its developers and users.  Because of this, we now run on
more platforms than any other operating system ever has, from the
world's top supercomputers, to the phone in your pocket.  It is how we
have survived so far, and is how we will survive in the future.

In order to ensure that we can continue to be dynamic in the future, and
not get bogged down by interfaces that are half-baked, or just turn out
to be wrong once we implement them and find ways to break them (anyone
remember the sys_futex evolution?) we need to be able to handle the
changes in the userspace<->kernelspace ABI properly.

So, here's a first cut at how we can do this.  Lots of other operating
systems explicity document what the interfaces to it are, and give a
"stability" rating of those interfaces (for one example, look at
http://opensolaris.org/os/community/onnv/devref_toc/devref_7/ ).  I feel
that we too need to document this interface, in order to keep everyone
in the loop and not cause any unwanted surprises at times they do not
need them (like right before a company's deadline.)

I've sketched out a directory structure that starts in
Documentation/ABI/ and has five different states, "stable", "testing",
"unstable", "obsolete", and "private".  The README file describes these
different states, and how things can move between them.  I've also
seeded the directories with some well known examples of the different
interfaces that are already in these states.

So, any comments?  Criticisms?

thanks,

greg k-h

p.s. I'd like to thank Kay Sievers for the main idea behind this
structure and need to document this.


-----------------------

From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: Add kernel<->userspace ABI stability documentation


Signed-off-by: Kay Sievers <kay.sievers@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 Documentation/ABI/README                 |   92 +++++++++++++++++++++++++++++++
 Documentation/ABI/obsolete/devfs         |   13 ++++
 Documentation/ABI/private/alsa           |    8 ++
 Documentation/ABI/stable/syscalls        |   10 +++
 Documentation/ABI/stable/sysfs-module    |   29 +++++++++
 Documentation/ABI/testing/sysfs-class    |   16 +++++
 Documentation/ABI/unstable/sysfs-devices |   25 ++++++++
 7 files changed, 193 insertions(+)

--- /dev/null
+++ gregkh-2.6/Documentation/ABI/README
@@ -0,0 +1,92 @@
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
+	This directory documents the interfaces that have determined to
+	be stable.  Userspace programs are free to use these interfaces
+	with no restrictions, and backward compatibility for them will
+	be guaranteed for at least 2 years.  Most simple interfaces
+	(like syscalls) are expected to never change and always be
+	available.
+
+  testing/
+	This directory documents interfaces that are felt to be stable,
+	as the main development of this interface has been completed.
+	The interface can be changed to add new features, but the
+	current interface will not break by doing this.
+	Userspace programs can start to rely on these interfaces, but
+	they must be aware of changes that can occur before these
+	interfaces move to be marked stable.  Programs that use these
+	interfaces are strongly encouraged to add their name to the
+	description of these interfaces, so that the kernel developers
+	can easily notify them if any changes occur (see the description
+	of the layout of the files below for details on how to do this.)
+
+  unstable/
+	This directory documents interfaces that are known to be
+	unstable, and not ready for widespread use by a lot of different
+	programs.  That is not to say that they can not be used, but
+	developers of such programs should track their changes very
+	closely.  Again, programs that uses these interfaces are
+	strongly encouraged to add their names to the description of the
+	interfaces so that they can be notified of changes.
+
+  obsolete/
+  	This directory documents interfaces that are still remaining in
+	the kernel, but are marked to be removed at some later point in
+	time.  The description of the interface will document the reason
+	why it is obsolete and when it can be expected to be removed.
+
+  private/
+	This interface is private between the kernel and a helper
+	userspace program or library.  If you wish to use this interface
+	(like alsa or netlink) userspace must use the helper library and
+	not use the raw kernel interface directly.
+
+
+Every file in these directories will contain the following information:
+
+What:		Short description of the interface
+Created:	Date created
+Contact:	Primary contact for this interface (may be a mailing list)
+Description:	Long description of the interface and how to use it.
+Users:		All users of this interface who wish to be notified for
+		when it changes.  This is very important for interfaces
+		in the "testing" stage, and the "unstable" stage, so
+		that kernel developers can work with userspace
+		developers to ensure that things do not break in ways
+		that are unacceptable.  It is also important to get
+		feedback for these interfaces to make sure they are
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
+Interfaces may be moved from unstable to testing whenever the developers
+feel they are finished with the interface.  Interfaces should not remain
+in unstable for very long periods of time without good reasons.
+
+Interfaces may be removed entirely from the kernel without notice if
+they are in the unstable state.
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
+++ gregkh-2.6/Documentation/ABI/unstable/sysfs-devices
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
--- /dev/null
+++ gregkh-2.6/Documentation/ABI/private/alsa
@@ -0,0 +1,8 @@
+What:		Kernel Sound interface
+Date:		Feburary 2006
+Who:		Jaroslav Kysela <perex@suse.cz>
+Description:
+		The use of the kernel sound interface must be done
+		through the ALSA library.  For more details on this,
+		please see http://www.alsa-project.org/ and contact
+		<alsa-devel@alsa-project.org>
