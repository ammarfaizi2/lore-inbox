Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUBYACA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 19:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbUBYABz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 19:01:55 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:6789 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262541AbUBYAAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 19:00:36 -0500
Subject: new driver (hvcs) review request and sysfs questions
From: Ryan Arnold <rsa@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, boutcher@us.ibm.com, rsa@us.ibm.com,
       Hollis Blanchard <hollisb@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 24 Feb 2004 18:00:26 -0600
Message-Id: <1077667227.21201.73.camel@SigurRos.rchland.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greeting all,

We are writing a device driver to support IBM Power5 firmware
functionality that allows us to host the consoles of hundreds of OS
partitions on a single Linux partition without requiring hundreds of
serial ports.  The patch providing this ability is at:

http://www-124.ibm.com/linux/patches/?patch_id=1377

Rather than having a hundred virtual terminal server devices
(vty-server@) to support a hundred OS images, each vty-server@ can be
connected to the console device (vty@) of several "partner" partitions
and the vty-server@ can switch between them.  Please don't shoot the
messenger on this design, we are just implementing the device driver to
support function implemented in the firmware.

Greg K-H has said that he'd like to make comments on this driver's sysfs
design on the LKML, so the link provided earlier also contains "tree"
output of /sys on a Power5 system running this driver and the hvcs
driver's sysfs design follows in the remainder of this email.

The ppc64 vio bus registers the vty-server@ device's kobject before it
is exposed to the driver by firmware.  The sysfs entry for this kobject
natively resides in /sys/devices/vdevice/vty-server@3000000* and is
symlinked in several places in the sysfs tree, notably under the vio bus
directory in /sys/bus/vio/devices and /sys/bus/vio/drivers/hvcs/, which
is the hvcs driver's sysfs directory.

An example of the vio bus's "devices" sysfs directory is shown below.

Pow5:/sys/bus/vio/devices # ls
.               l-lan@3000000c  l-lan@30000010       vty-server@30000004
..              l-lan@3000000d  rtc@4001             vty@30000000
IBM,sp@4000     l-lan@3000000e  v-scsi@30000002
l-lan@3000000b  l-lan@3000000f  vty-server@30000003

The hvcs driver sysfs entry looks like the following:

Pow5:/sys/bus/vio/drivers/hvcs # ls
.  ..  rescan  vty-server@30000003  vty-server@30000004

By design, firmware only notifies the hvcs driver of vty-server@
lifetimes, but not changes in partner info.  Since an eServer admin can
change partner info dynamically we have provided the hvcs driver sysfs
directory /sys/bus/vio/drivers/hvcs/ with the "rescan" attribute which
will query firmware and update the partner info for all the vty-server@
vdevices that this driver manages when a '1' is written to it.  Reading
the attribute will indicate the state: 1:update in process, 0:done.

An alternate approach is to move this rescan entry into the per-device
vty-server@3000000* directory or have the entry available in both the
driver and device directories.

An example vty-server@3000000* directory looks like the follow:

Pow5:/sys/bus/vio/drivers/hvcs/vty-server@30000004 # ls 
.  ..  current_vty  detach_state  dev_node  partner_clcs  partner_vtys

The "detach_state" attribute is provided to the device prior to hvcs
device attribute additions.

Since a vty-server@ can theoretically have more than one vty@ configured
as a partner we have provided each vty-server@ sysfs dir with two
read-only attributes that provide lists of easily parsed data:
"partner_vtys" and "partner_clcs".

Reading partner_vtys (as shown below) returns a list of partner vty@
vdevices.  Note that vty@ device numbering is per-partition-unique and
the vty@ entries you see in the example below are how the vty@ vdevices
appear in the sysfs tree on their own partition (reference:
/sys/bus/vio/devices/vty@30000000 above), but we could leave off the
"vty@" portion of the ID in this entry.

Pow5:/sys/bus/vio/drivers/hvcs/vty-server@30000004 # cat partner_vtys
vty@30000000
vty@30000001
vty@30000002
vty@30000000
vty@30000000

Reading partner_clcs (as shown below) returns a list of "converged
location codes" which are composed of a system serial number followed by
"-V*" (* = target partition number) and "-C*" (* = slot of the
adapter).  This is the format given for the clc as it is returned from
firmware.  The clc could be pre-parsed by the driver and output to only
show pertinent partition and/or slot data.  The first vty@ partner
corresponds to the first clc item, the second vty@ partner to the second
clc item, etc.

Pow5:/sys/bus/vio/drivers/hvcs/vty-server@30000004 # cat partner_clcs
U9111.520.100048A-V3-C0
U9111.520.100048A-V3-C2
U9111.520.100048A-V3-C3
U9111.520.100048A-V4-C0
U9111.520.100048A-V5-C0

Currently a third read only entry resides under the vty-server@ vdevice
sysfs directory and that is "dev_node" which we use to tell us what
/dev/hvcs* entry (a dynamic major/minor tty device) we should create and
use to interact with this vty-server@.  This will disappear when I
figure out how udev will be used to create the /dev/ entries for my
vty-server@ vdevices.

A vty-server@ can be connected to a single vty@ at a time.  When there
are multiple vty@ partners available the user needs a method for
directing his vty-server@ to connect to the desired vty@ partner.

The entry, "current_vty" prints the clc of the currently selected
partner vty@ when read. The current_vty can be changed by writing a
valid partner clc to the entry. Changing the current_vty when a
vty-server@ is already connected to a vty@ does not affect the current
connection.  The change takes effect when the currently open connection
is freed.

Greg, I would appreciate if you could comment on my usage of sysfs.  I
would also appreciate additional comments on the driver and sysfs usage
from everyone else.

P.S. who is maintainer of the char device tree?

Thanks,
Ryan S. Arnold <rsa@us.ibm.com>
IBM LTC, Rochester MN

