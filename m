Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUAMXwa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUAMXwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:52:30 -0500
Received: from mail.kroah.org ([65.200.24.183]:24765 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265663AbUAMXwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:52:14 -0500
Date: Tue, 13 Jan 2004 15:52:13 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 013 release
Message-ID: <20040113235213.GA7659@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 013 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-013.tar.gz

rpms built against Red Hat FC1 are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-013-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-013-1.src.rpm

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

NOTE:  The udev.rules file format has changed!  If you have a modified
config file it MUST be changed in order to work properly.  Here's what
needs to be done:
	- The "<METHOD>, " at the beginning of the line should be
	  removed.  <METHOD> is one of the following: LABEL, CALLOUT,
	  NUMBER, TOPOLOGY, REPLACE.
	- The result of the externel program is matched with RESULT=
	  instead if ID=
	- The PROGRAM= key is only valid if the program exits with zero
	  (just exit with nozero in a script if the rule should not
	  match)

Also note the following changes in the way the udev.rules file is
processed:
	- Rules are processed in order they appear in the file.  There
	  are no priorities anymore.
	- if NAME="" is given, udev is instructed to ignore this device,
	  no node or symlink will be created.

As a result of these changes, we can now create much more powerful rules
by combining multiple key fields.  Here's two new rules that show how
you can do this:
  # combined BUS, SYSFS and KERNEL
  BUS="usb", KERNEL="video*", SYSFS_model="Creative Labs WebCam*", NAME="test/webcam%n"

  # exec script only for the first ide drive (hda), all other will be skipped
  BUS="ide", KERNEL="hda*", PROGRAM="/sbin/ide-devfs.sh %k %b %n", RESULT="hd*", NAME="%1c", SYMLINK="%2c %3c"

Also, the result of the PROGRAM call is now cached accross multiple
rules as long as a new PROGRAM key is not specified.  As an example:
    PROGRAM="/bin/echo abc", RESULT="no_match", NAME="web-no-2"
    KERNEL="video*", RESULT="123", NAME="web-no-3"
    KERNEL="video*", RESULT="abc", NAME="web-yes"
The last rule would match properly.

Many thanks for these changes go to Kay Sievers.  I really appreciate
all of the development effort.

If anyone has any problems converting existing rules files, please see
the example rules that are in the udev tarball, and feel free to ask
questions on the linux-hotplug-devel mailing list.

Thanks again to everyone who has send me patches for this release, a
full list of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h


Summary of changes from v012 to v013
============================================

<eike-hotplug:sf-tec.de>:
  o LSB init script and other stuff

<elkropac:students.zcu.cz>:
  o fix udev directory for Debian init script

<tiggi:infa.abo.fi>:
  o udev 012 old gcc fixup

Christophe Saout:
  o add IGNORE rule type
  o small cleanup

Greg Kroah-Hartman:
  o update TODO with some new, small items
  o Cset exclude: greg@kroah.com|ChangeSet|20040113010256|48515
  o update the README in a few places
  o fix -d typo in the manpage update
  o Fix stupid gcc "optimization" of 1 character printk() calls.... Ick
  o oops, forgot to fix up the PROGRAM result from ID to RESULT in the config files
  o Add alsa device rules and a few other devfs rules
  o fix a few stale comments in namedev.c
  o convert the default rules files to the new format
  o convert the test shell scripts to the config file format
  o add bus test for usb-serial bus
  o Add some helpful messages if the user uses the older config file format
  o added dri rule to the default config file
  o added init.d udev script for debian
  o add a script that tests the IGNORE rule
  o add silly script that names cdrom drives based on the cd in them
  o add cdrom rule for ide cdrom
  o replace list_for_each with list_for_each_entry, saving a few lines of code
  o add a blacklist of class devices we do not want to look at
  o 012_bk change
  o v012 release TAG: v012

Kay Sievers:
  o fix klibc with printf() and gcc
  o udev - small script optimization
  o udev - introduce format escape char
  o udev - more CALLOUT is PROGRAM now
  o udev - CALLOUT is PROGRAM now
  o update documentation for new config file format
  o more advanced user query options
  o udev - simple debug tweak
  o udev - drop all methods :)
  o udev - advanced user query options
  o udev - Makefile error
  o udev - make exec_callout() reusable
  o udev - exec status fix for klibc
  o fix Silly udev script

