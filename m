Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVCUVFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVCUVFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVCUVCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:02:24 -0500
Received: from digitalimplant.org ([64.62.235.95]:10892 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261878AbVCUUse
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:48:34 -0500
Date: Mon, 21 Mar 2005 12:48:28 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [0/9] [RFC] Steps to fixing the driver model locking
Message-ID: <Pine.LNX.4.50.0503211234040.20647-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



For quite some time, many of the driver model objects and actions have
been synchronnized with an rwsem. While this has proved to be +/- adequate
up to now, it does have some limitations. The rwsem is pretty heavy
handed, and it doesn't allow us to do things like modify a list that we're
currently iterating over.

There are a number of approaches to fixing this. This series of patches
presents one. Basically, it uses a spinlock to protect the iterations of
the list that is dropped before doing work on each node, and a refcount to
guarantee that a node doesn't go away before we're done touching it. It's
all wrapped in clean and reusable container (struct klist) and given some
helpers to make it easy to integrate. Details are in the descriptions
below and the following patches.

The lists in struct bus_type that hold its devices and drivers have been
fixed up to use the struct klist. The power management lists are probably
next.

Thoughts, comments, flames?

Thanks,


	Pat


You can pull from

	bk://kernel.bkbits.net:/home/mochel/linux-2.6-core

Which would update the following files:

 drivers/base/Makefile        |    2
 drivers/base/base.h          |    2
 drivers/base/bus.c           |  303 ++++++++-----------------------------------
 drivers/base/core.c          |    3
 drivers/base/dd.c            |  246 ++++++++++++++++++++++++++++++++--
 drivers/base/driver.c        |   62 +++++++-
 drivers/base/power/resume.c  |    8 -
 drivers/base/power/suspend.c |    4
 drivers/pnp/driver.c         |   12 +
 drivers/usb/core/usb.c       |   43 +++---
 include/linux/device.h       |   15 +-
 include/linux/klist.h        |   53 +++++++
 lib/Makefile                 |    7
 lib/klist.c                  |  248 +++++++++++++++++++++++++++++++++++
 14 files changed, 701 insertions(+), 307 deletions(-)

through these ChangeSets:

<mochel@digitalimplant.org> (05/03/21 1.2238)
   [driver core] Add a klist to struct device_driver for the devices bound to it.

   - Use it in driver_for_each_device() instead of the regular list_head and stop using
     the bus's rwsem for protection.
   - Use driver_for_each_device() in driver_detach() so we don't deadlock on the
     bus's rwsem.
   - Remove ->devices.
   - Move klist access and sysfs link access out from under device's semaphore, since
     they're synchronized through other means.



   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/21 1.2237)
   [driver core] Add a klist to struct bus_type for its drivers.


   - Use it in bus_for_each_drv().
   - Use the klist spinlock instead of the bus rwsem.



   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/21 1.2236)
   [driver core] Add a klist to struct bus_type for its devices.

   - Use it for bus_for_each_dev().
   - Use the klist spinlock instead of the bus rwsem.


   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/21 1.2235)
   [klist] Add initial implementation of klist helpers.

   This klist interface provides a couple of structures that wrap around
   struct list_head to provide explicit list "head" (struct klist) and
   list "node" (struct klist_node) objects. For struct klist, a spinlock
   is included that protects access to the actual list itself. struct
   klist_node provides a pointer to the klist that owns it and a kref
   reference count that indicates the number of current users of that node
   in the list.

   The entire point is to provide an interface for iterating over a list
   that is safe and allows for modification of the list during the
   iteration (e.g. insertion and removal), including modification of the
   current node on the list.

   It works using a 3rd object type - struct klist_iter - that is declared
   and initialized before an iteration. klist_next() is used to acquire the
   next element in the list. It returns NULL if there are no more items.
   This klist interface provides a couple of structures that wrap around
   struct list_head to provide explicit list "head" (struct klist) and
   list "node" (struct klist_node) objects. For struct klist, a spinlock
   is included that protects access to the actual list itself. struct
   klist_node provides a pointer to the klist that owns it and a kref
   reference count that indicates the number of current users of that node
   in the list.

   The entire point is to provide an interface for iterating over a list
   that is safe and allows for modification of the list during the
   iteration (e.g. insertion and removal), including modification of the
   current node on the list.

   It works using a 3rd object type - struct klist_iter - that is declared
   and initialized before an iteration. klist_next() is used to acquire the
   next element in the list. It returns NULL if there are no more items.
   Internally, that routine takes the klist's lock, decrements the reference
   count of the previous klist_node and increments the count of the next
   klist_node. It then drops the lock and returns.

   There are primitives for adding and removing nodes to/from a klist.
   When deleting, klist_del() will simply decrement the reference count.
   Only when the count goes to 0 is the node removed from the list.
   klist_remove() will try to delete the node from the list and block
   until it is actually removed. This is useful for objects (like devices)
   that have been removed from the system and must be freed (but must wait
   until all accessors have finished).

   Internally, that routine takes the klist's lock, decrements the reference
   count of the previous klist_node and increments the count of the next
   klist_node. It then drops the lock and returns.

   There are primitives for adding and removing nodes to/from a klist.
   When deleting, klist_del() will simply decrement the reference count.
   Only when the count goes to 0 is the node removed from the list.
   klist_remove() will try to delete the node from the list and block
   until it is actually removed. This is useful for objects (like devices)
   that have been removed from the system and must be freed (but must wait
   until all accessors have finished).


   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/21 1.2234)
   [usb] Use driver_for_each_device() instead of manually walking list.



   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/21 1.2233)
   [pnp] Use driver_for_each_device() in drivers/pnp/driver.c instead of manually walking list.



   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/21 1.2232)
   [driver core] Add driver_for_each_device().

   Now there's an iterator for accessing each device bound to a driver.


   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/21 1.2231)
   [driver core] Move device/driver code to drivers/base/dd.c

   This relocates the driver binding/unbinding code to drivers/base/dd.c. This is done
   for two reasons: One, it's not code related to the bus_type itself; it uses some from
   that, some from devices, and some from drivers. And Two, it will make it easier to do
   some of the upcoming lock removal on that code..



   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

<mochel@digitalimplant.org> (05/03/21 1.2230)
   [driver core] Add a semaphore to struct device to synchronize calls to its driver.

   This adds a per-device semaphore that is taken before every call from the core to a
   driver method. This prevents e.g. simultaneous calls to the ->suspend() or ->resume()
   and ->probe() or ->release(), potentially saving a whole lot of headaches.

   It also moves us a step closer to removing the bus rwsem, since it protects the fields
   in struct device that are modified by the core.



   Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

