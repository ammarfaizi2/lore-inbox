Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVC0TaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVC0TaU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 14:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVC0TaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 14:30:20 -0500
Received: from peabody.ximian.com ([130.57.169.10]:28838 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261470AbVC0TaB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 14:30:01 -0500
Subject: [RFC] Some thoughts on device drivers and sysfs
From: Adam Belay <abelay@novell.com>
To: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Content-Type: text/plain
Date: Sun, 27 Mar 2005 14:24:59 -0500
Message-Id: <1111951499.3503.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the original design goals of sysfs was to provide a standardized
location to keep driver configuration attributes.  Although sysfs
handles this very well for bus devices and class devices, there isn't
currently a method to export attributes for device drivers and their
specific bound device instances to userspace.

I would like to propose that we create a new type of device that would
act as the layer between physical (bus devices) and logical (class
devices).  It could be referred to as a "driver device".  Driver devices
would bind to a bus devices and create one or more class devices.  Their
type would be of "struct device_driver".  As an example, this would
allow us to move something like /proc/driver/emu10k1/0000:01:09.0 into
sysfs.

(physical)	     |		  (logical)
------------------------------------------------
|bus device -->	driver device --> class device |
------------------------------------------------

struct driver_device {
	struct list_head node;
	unsigned long id;
	struct kobject kobj;
	struct device_driver *drv;
	struct device *dev;
	int state;
};

In sysfs, a new directory could be created to represent driver devices.
It might look like the following:

bus
|
\- pci
 |
 \- devices
  |
  \- link to device0
  \- link to device1
 \- drivers
  |
  \- link to random_drv (in other words random_drv can drive this bus)

device
|
\- device0
[...]
\- device1
[...]

driver (this directory is new)
|
\- random_drv
 |
 \- 0 (a sequential instance number) <-- this is a driver device
  |
  \- link to device0
  \- link to class0
  \- a file to control driver state (start, stop, etc.)
  \- driver attributes for this link
 \- 1
  |
  \- link to device1
  \- link to class1
  \- a file to control driver state
  \- driver attributes for this link

class
|
\-some_type
 |
 \- class0
[...]
 \- class1
[...]

This would allow us to represent per-device driver attributes in sysfs.
As an added benefit, driver devices would allow the tracking and control
of driver state, which may be needed for dynamic power management.  I
look forward to any comments.

Thanks,
Adam


