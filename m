Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263854AbTDVUza (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTDVUxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:53:47 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:28634 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263854AbTDVUqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:46:13 -0400
Date: Tue, 22 Apr 2003 13:55:45 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Cc: hannal@us.ibm.com, andmike@us.ibm.com
Subject: [RFC] Device class rework [0/5]
Message-ID: <20030422205545.GA4701@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a set of patches that rework the current class support in the
kernel today into something that works a bit better, and is simpler to
use.

Currently, classes are assigned to drivers at compile time (or at the
latest, at driver_register() time) and enforce a 1 to 1 relationship
between class devices and struct device objects.  This is not practical
in the kernel, as there are a number of physical devices that
correspond to multiple "class" devices.  It's also unwieldy to bind
classes to devices so early.  They should be explicitly done later when
the class device is registered with that subsystem.

So with that in mind, here's some changes.  The rework of the driver
core is all done right now in one big patch, but I'll split it up
smaller for inclusion later on.

This patch gets rid of struct device_class and struct device_interface,
and replaces them with struct class[1], struct class_device, and struct
class_interface.  struct class is much like struct device_class used to
be, but is much smaller, and not bound to any drivers.  This makes the
driver core a lot smaller, as we get hotplug events for free now (struct
class_device is a kobject), and is more flexible.

A struct class_device is registered with a class when that device is
registered within the kernel.  As an example of this, see the tty patch
later on in this email thread.

A struct class_interface is used to get a callback whenever a struct
class_device is registered or unregistered with a class.  This can be
used to attach files to the class_device, or do more complicated things.
The patch that changes the cpufreq code in this email thread shows how
this can be used (although the cpufreq code can be further simplified
based on these changes, I've not done it yet.)

If there are no major objections to this, I'll split it up into smaller
pieces for inclusion in the kernel tree.

I'll follow this message up with 5 patches that do the following things:
 - all of the driver core conversions.  This is the meat of the
   changes.
 - Fixes for the input core to build properly.  I've not converted the
   input core to the new class model yet, but will after this.
 - Crude patches to the scsi core to get it to build properly.  This
   patch is not correct, but needed if your machines have scsi.  Mike
   Anderson has said he will fix up the scsi code based on these core
   changes.
 - cpufreq changes.  This converts the cpufreq code to the new driver
   class changes.
 - tty changes.  This converts the tty code to the new driver class
   changes.  With this patch, we now show all tty devices, and their
   device major/minor number in the /sys/class/tty/ directory.  Yes,
   this is still a bit crude (all ptys are shown, and they should not
   be), but it's an example of why these changes are needed, and how to
   add class support to a subsystem.  I'll rework this after Christoph's
   and Al Viro's tty changes are in the main tree, as we all are
   touching the same part of code.

Oh, and I didn't touch the pcmcia code yet either, with these patches,
that code will not compile properly.

Any comments?

thanks,

greg k-h

[1] Yes, that's "struct class", and yes, I mean it.  If you don't like
    it, please propose something else that describes what it does.
