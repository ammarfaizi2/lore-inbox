Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267489AbUBSTUD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267498AbUBSTTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:19:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:56975 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267489AbUBSTSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:18:06 -0500
Date: Thu, 19 Feb 2004 11:16:36 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: HOWTO use udev to manage /dev
Message-ID: <20040219191636.GC10527@kroah.com>
References: <20040219185932.GA10527@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219185932.GA10527@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a small document that I've added to the udev tarball that
explains how I managed to get udev to manage my /dev tree on a Red Hat
Fedora based machine.  All you Gentoo developers can just laugh as it's
already integrated into your distro.

Any users of other distros, feel free to send me updates to this to show
how to do it for yours.  Any distro maintainers, feel free to just
integrate udev into your system so this kind of tweaking isn't
necessary :)

thanks,

greg k-

---------------------------------------

HOWTO use udev to manage /dev

  This document describes one way to get udev working on a Fedora-development
  machine to manage /dev.  This procedure may be used to get udev to manage
  /dev on other distros, if you modify some of the steps.
  
  This will only work if you use a 2.6 based kernel, preferably the most
  recent one.  This does not prevent your machine from using a 2.4
  kernel, if you boot into one, udev will not run and your old /dev will
  be present with no changes needed.


NOTE NOTE NOTE NOTE NOTE NOTE NOTE
  This is completely unsupported.  Attempting to do this may cause your
  machine to be unable to boot properly.  USE AT YOUR OWN RISK.  Always
  have a rescue disk or CD handy to allow you to fix up any errors that
  may occur.
NOTE NOTE NOTE NOTE NOTE NOTE NOTE


 - Build and install udev as specified in the README that comes with
   udev.  I recommend using the following build options to get the
   smallest possible binaries:
	make USE_KLIBC=true USE_LOG=false DEBUG=false

 - disable udev from the boot process by running:
 	chkconfig udev off
   or
   	chkconfig --del udev
   as root.

 - place the start_udev script somewhere that is accessible by your
   initscripts.  I placed it into /etc/rc.d with the following command:
	copy extras/start_udev /etc/rc.d/
	
 - modify the rc.sysinit script to call the start_udev script as one of
   the first things that it does, but after /proc and /sys are mounted.
   I did this with the latest Fedora startup scripts with the patch at
   the end of this file.

 - make sure the /etc/udev/udev.conf file lists the udev_root as /dev.
   It should contain the following line in order to work properly.
	udev_root="/dev/"

 - reboot into a 2.6 kernel and watch udev create all of the initial
   device nodes in /dev


If anyone has any problems with this, please let me, and the
linux-hotplug-devel@lists.sourceforge.net mailing list know.

A big thanks go out to the Gentoo developers for showing me that this is
possible to do.

Greg Kroah-Hartman
<greg@kroah.com>


----------------------------------
Patch to modify rc.sysinit to call udev at the beginning of the boot
process:


--- /etc/rc.sysinit.orig	2004-02-17 11:45:17.000000000 -0800
+++ /etc/rc.sysinit	2004-02-17 13:28:33.000000000 -0800
@@ -32,6 +32,9 @@
 
 . /etc/init.d/functions
 
+# start udev to populate /dev
+/etc/rc.d/start_udev
+
 if [ "$HOSTTYPE" != "s390" -a "$HOSTTYPE" != "s390x" ]; then
   last=0
   for i in `LC_ALL=C grep '^[0-9].*respawn:/sbin/mingetty' /etc/inittab | sed 's/^.* tty\([0-9][0-9]*\).*/\1/g'`; do

 
