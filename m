Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262904AbUKRWsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbUKRWsy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUKRWq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 17:46:58 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:54913 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262962AbUKRWoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 17:44:19 -0500
Date: Thu, 18 Nov 2004 14:44:12 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 046 release
Message-ID: <20041118224411.GA10876@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 046 version of udev.  It can be found at:
  	kernel.org/pub/linux/utils/kernel/hotplug/udev-046.tar.gz

(yes, there has also been releases for versions 040, 041, 042, 043, 044,
and 045, I just forgot to announce them...)

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

And there is a general udev web page at:
	http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html

This release has a completly new backend database.  If you have had
_any_ problems with udev lockups, 100% cpu utilitization, or issues with
large machines having a zillion udev processes hanging around, please
try this release.

For those of you without any udev issues, I recommend the 045 release
at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-045.tar.gz

It's the same backend database, and has lots of bugfixes and tweaks
since the 039 release.

Major changes in this release from the 045 release:
	- no more tdb backend, we now have 1 file per sysfs entry in
	  /dev/.udevdb that holds the information we need.  Yes, this is
	  a bit more memory than previously used, but we get the locking
	  issues fixed for free as we rely on the kernel file locking
	  rules to get it correct.  Anyway, you should have /dev mounted
	  on a tmpfs not ramfs so the memory is swapable.
	- new keywords to match on (DRIVER and SUBSYSTEM)
	- lots of good wait_for_sysfs fixes (we now take advantage of
	  the new 2.6.10-rc2 kernel information and don't have to guess
	  at what files we might have to wait for.)
	- loads of bugfixes and rule files tweaks.
	
Thanks to Kay Sievers for all the work he's been doing on udev lately,
especially the database backend fixes.  I really appreciate it.

Also thanks to everyone who has send me patches for the recent releases,
a full list of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h


Summary of changes from v045 to v046
============================================

Greg Kroah-Hartman:
  o make spotless for releases

Kay Sievers:
  o Don't try to print major/minor for devices without a dev file
  o remove get_device_type and merge that into udev_set_values()
  o prevent udevd crash if DEVPATH is not set
  o add ippp and bcrypt to the exception lists of wait_for_sysfs
  o let klibc add the trailing newline to syslog conditionally
  o disable logging for udevstart
  o add NAME{ignore_remove} attribute
  o remove historical SYSFS_attr="value" format
  o don't wait for sysfs if the kernel(2.6.10-rc2) tells us what not to expect
  o change key names in udevinfo sysfs walk to match the kernel
  o support DRIVER as a rule key
  o support SUBSYSTEM as a rule key
  o rename udevdb* to udev_db*
  o Make dev.d/ handling a separate processing stage
  o make the udev object available to more processing stages
  o remove udev_lib dependency from udevsend, which makes it smaller
  o add ACTION to udev object to expose it to the whole process
  o make udevinfo's -r option also workimg for symlink queries
  o let udev act as udevstart if argv[1] == "udevstart"
  o improve udevinfo sysfs info walk
  o add sysfs info walk to udevinfo
  o pass the whole event environment to udevd
  o replace tdb database by simple lockless file database


Summary of changes from v044 to v045
============================================

Martin Schlemmer:
  o Some updates for Gentoo's udev rules


Summary of changes from v043 to v044
============================================

Greg Kroah-Hartman:
  o add cdsymlinks.sh support to gentoo rules file
  o fix gentoo legacy tty rule
  o remove 'sudo' usage from the Makefile
  o make udev-test.pl test for root permissions before running

Kay Sievers:
  o reduce syslog noise of udevsend if multiple instances try to start udevd
  o add i2c-dev to the list of devices without a bus


Summary of changes from v042 to v043
============================================

Greg Kroah-Hartman:
  o add test target to makefile
  o add dumb script to show all sysfs devices in the system

Kay Sievers:
  o Shut up wait_for_sysfs class/net failure messages, as it's not possible to
    get that right for all net devices. Kernels later than 2.6.10-rc1 will
    handle that by carrying the neccessary information in the hotplug event.  
  o wait() for specific pid to return from fork()
  o Don't use any syslog() in signal handler, cause it may deadlock
  o Add support for highpoint ataraid to volume_id to suppress label reading on raid set members.
  o Add a bunch of devices without "device" symlinks
  o Exit, if udevtest cannot open the device (segfault)
  o Patches from Harald Hoyer <harald@redhat.com>
  o Apply the default permissions even if we found a entry in the permissions
    file. Correct one test, as the default is applied correctly now and the
    mode will no longer be 0000.
  o add test for format chars in multiple symlinks to replace
  o Add net/vmnet and class/zaptel to the list of devices without physical device


Summary of changes from v040 to v042
============================================

Greg Kroah-Hartman:
  o add inotify to the rules for gentoo

Kay Sievers:
  o skip waiting for device if we get a bad event for class creation and not for a device underneath it
  o add net/pan and net/bnep handling
  o switch wait for bus_file to stat() instead of open() add net/tun device handling add ieee1394 device handling
  o Remove the last klibc specific line from the main udev code Move _KLIBC_HAS_ARCH_SIG_ATOMIC_T to the fixup file which is automatically included by the Makefile is we build with klibc
  o ignore *.rej files from failed patches
  o update to libsysfs 1.2.0 and add some stuff klib_fixup Now we have only the sysfs.h file different from the upstream version to map our dbg() macro.
  o improve klibc fixup integration
  o cleanup udevd/udevstart
  o expose sysfs functions for sharing it


Summary of changes from v039 to v040
============================================

<jk:blackdown.de>:
  o wait_for_sysfs update for dm devices

Greg Kroah-Hartman:
  o sparse cleanups on the tree
  o fix stupid cut-and-paste error for msr devices on gentoo boxes
  o add *~ to bk ignore list
  o delete udevruler.c as per Kay's request
  o fix up the wait_for_sysfs_test script a bit

Kay Sievers:
  o fix debug in volume id / fix clashing global var name
  o volume_id fix
  o $local user
  o cleanup netif handling and netif-dev.d/ events
  o big cleanup of internal udev api
  o don't wait for dummy devices
  o close the syslog
  o Fix ppp net devices in wait_for_sysfs
  o Fix wait_for_sysfs messages (more debugging info)


