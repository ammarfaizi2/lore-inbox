Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVCYFyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVCYFyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 00:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVCYFyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 00:54:38 -0500
Received: from digitalimplant.org ([64.62.235.95]:61394 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261345AbVCYFyb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:54:31 -0500
Date: Thu, 24 Mar 2005 21:54:24 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [0/12] More Driver Model Locking Changes 
Message-ID: <Pine.LNX.4.50.0503242145200.29800-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the next round of driver model locking changes. These build off of
the previous set of changes, including the klist patch. They eradicate all
of the uses of the subsystems' rwsem in the driver core.

It does include the fix posted earlier that happened when removing the
driver.

A summary is listed below. The patches follow.

Thanks,


	Pat


You may pull from

	bk://kernel.bkbits.net:/home/mochel/linux-2.6-core

Which will update the following files:

 drivers/base/bus.c        |   12 -------
 drivers/base/core.c       |   51 ++++++++----------------------
 drivers/base/dd.c         |   77 +++++++++++++++++++++++++---------------------
 drivers/base/driver.c     |    3 -
 drivers/scsi/scsi_sysfs.c |   14 +++++---
 drivers/usb/core/usb.c    |    4 +-
 include/linux/device.h    |   13 +------
 include/linux/klist.h     |    2 +
 lib/klist.c               |   21 +++++++++++-
 9 files changed, 92 insertions(+), 105 deletions(-)

through these ChangeSets:

<mochel@digitalimplant.org> (05/03/24 1.2250)
   [driver core] Fix up bogus comment.
   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/24 1.2249)
   [driver core] Use a klist for device child lists.

   - Use klist iterator in device_for_each_child(), making it safe to use for
     removing devices.
   - Remove unused list_to_dev() function.
   - Kills all usage of devices_subsys.rwsem.


   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/24 1.2248)
   [scsi] Use device_for_each_child() to unregister devices in scsi_remove_target().


   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/24 1.2247)
   [klist] Don't reference NULL klist pointer in klist_remove().


   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/24 1.2246)
   [driver core] Call klist_del() instead of klist_remove().

   - Can't wait on removing the current item in the list (the positive refcount *because*
     we are using it causes it to deadlock).


   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/24 1.2245)
   [driver core] Remove struct device::driver_list.


   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/24 1.2244)
   [driver core] Remove struct device::bus_list.


   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/24 1.2243)
   [driver core] Fix up bus code and remove use of rwsem.

   - Don't add devices to bus's embedded kset, since it's not used by anyone anymore.
   - Don't need to take the bus rwsem when calling {device,driver}_attach(), since
     those functions use the klists and the klists' spinlocks.


   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/24 1.2242)
   [usb] Fix up USB to use klist_node_attached() instead of list_empty() on lists that will go away.


   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/24 1.2241)
   [klist] add klist_node_attached() to determine if a node is on a list or not.


   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/24 1.2240)
   [driver core] Use bus_for_each_{dev,drv} for driver binding.

   - Now possible, since the lists are locked using the klist lock and not the
     global rwsem.


   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/24 1.2239)
   [driver core] Remove the unused device_find().


   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

