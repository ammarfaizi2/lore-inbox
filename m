Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264649AbUF1FJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264649AbUF1FJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 01:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbUF1FJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 01:09:53 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:64630 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264649AbUF1FJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 01:09:44 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 0/19] New set of input patches
Date: Mon, 28 Jun 2004 00:08:21 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406280008.21465.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 2nd version of my set of input patches that mostly do serio sysfs
integration. Among the changes - dropped psmouse KVM resync patch as it was
bogus, added platform devices to those of serio providers that don't have
proper parent device (i8042, q40kbd, etc).

01-psmouse-state-locking.patch
        - Acquire underlying serio lock when changing psmouse state to
          prevent interrupt handler running on us

02-serio-connect-mandatory.patch
        - Make serio driviers connect/disconnect methods mandatory as these
          methods open/close serio ports and link ports and drivers together.
          Presently if a driver does not implement connect method it will not
          be able to bind to a port anyway.

03-serio-rename-1.patch
        - Rename serio->driver to serio->port_data as with sysfs integration
          driver is not the best name for arbitrary data

04-serio-rename-2.patch
        - Rename serio_dev to serio_driver as they are drivers in sysfs sense

05-serio-dynamic-alloc.patch
        - Switch from static to dynamic serio port allocation so serio ports
          drivers can be freely unloaded even if not all references to ports
          are dropped (sysfs req.)

06-serio-no-recursion.patch
        - Do not do recursive discovery of children ports, needed for sysfs
          and generally better for stack usage.

07-serio-sysfs.patch
        - sysfs integration. Register ports and drivers in driver model, link
          them all together under /sys/bus/serio. Every driver has a default
          attribute "descrip[tion" (from serio_driver->description); serio
          ports have "decription", "driver" and "legacy_position".
          Legacy_position porvides access to serio->phys to allow matching
          with data in /proc/bus/input/devices

08-serio-rebind.patch
        - allow user to disconnect or rebind serio port by writing appropriate
          data to it's sysfs attribute:
              echo -n "psmouse" > /sys/bus/serio/devices/serio0/driver
              echo -n "none" > /sys/bus/serio/devices/serio0/driver
              echo -n "reconnect" > /sys/bus/serio/devices/serio0/driver
              echo -n "rescan" > /sys/bus/serio/devices/serio0/driver

09-serio-manual-bind.patch
        - allow marking some drivers as requiring manual bind (to be used when
          driver does not do automatic HW discovery)

10-serio_raw.patch
        - raw access to serio data ala 2.4 /dev/psaux

(*) 11-platform-device-simple.patch
        - Add platform_device_register_simple to register platform devices
          requiring minimal resource and memory management. The release
          function resides in driver core and that allows drivers registering
          such devices be unloaded without waiting for the last reference to
          be dropped.
	
12-i8042-to-platform-device.patch
        - Convert i8042 to platform device instead of system device so
          its ports have proper parent.

13-serio-add-platform-devices.patch
	- Add platform devices to ct82c710, maceps2, q40kbd and rpckbd.

14-serio-set-up-parents.patch
        - Set up parent devices for serio ports in ambakmi, gscps2,
          pcips2 and sa1111ps2.c

15-synaptics-passthrough-handling.patch
        - If data looks like a pass-through packet and tuchpad has
          pass-through capability do not pass it to the main handler
          if child port is disconnected.

(*) 16-bus-default-drv-attrs.patch
        - Add bus' default driver attributes (similar to defaulr device
          attributes)

17-serio-use-bus-default-attrs.patch
        - Use bus' default driver and device attributes to manage serio
          attributes 

(*) 18-add-driver-find.patch
        - Add driver_find function, similar to device_find, to search for a
          driver by its name.

19-serio-use-driver-find.patch
        - Use driver_find in serio_rebind_driver instead of implementing it
          locally.

(*) These patches have also been sent to Greg KH.

This time I tried compiling the stuff using defconfing for SPACR64 and PPC64
(thanks to Andrew for pointing to me availability of cross-compile
tools), so I should be a bit better now... Alpha failed on cpumask.h...

The patches are against today's Linus tree + recent pull form Vojtech's tree
+ recent pull from Greg KH's tree. I have patches against 2.6.7 that will
bring it to my version of the tree at:

	http://www.geocities.com/dt_or/input/2_6_7/

-- 
Dmitry
