Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbUDOIL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 04:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbUDOIL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 04:11:58 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:9104 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263881AbUDOILb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 04:11:31 -0400
Date: Thu, 15 Apr 2004 17:09:39 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: [RFC] New sysfs tree for hotplug
To: lhcs-devel@lists.sourceforge.net, lhms-devel@lists.sourceforge.net,
       linux-hotplug-devel@lists.sourceforge.net,
       pcihpd-discuss@lists.sourceforge.net, lhns-devel@lists.sourceforge.net
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-largesys-devel@lists.sourceforge.net
Message-id: <20040415170939.0ff62618.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi hotplug folks,

I'm interested in hotplug features, especially physical insertion/removal.  I'd
like to propose here a new sysfs tree for hotplug.  Please comment on my
proposal, because this is a request for comments:-)

1. Current sysfs for hotplug
----------------------------
 In 2.6, there are some sysfs files for hotplug.  For instance, PCI has that
kind of files to control hotplug features.  PCI related sysfs entries for hotplug
are created under /sys/bus/pci/slots/:

    /sys/bus/pci/slots/<slot#>/<files>

There are some files under <slot#> directory.  Some of them are supposed
to expose kenrel information, the others are supposed to control hotplug.
Recently, CPU and memory hotplug are being worked actively.  According 
to their patch, they seem to be trying to create sysfs files under the following
directory.

    /sys/devices/system/


2. Problem
----------
 Recent large machines have many PCI devices and some boards that
contain devices (e.g. CPU, memory, and/or I/O devices).  A certain PCI
device (PCI1) might be connected with other one (PCI2), which means that
there is a dependency between PCI1 and PCI2.  Similarly, there is a 
dependency between the board and devices attached on the board.
In this situation, we need to know the dependency first when we want to
hot-remove such devices or board.  However, I don't think that the flat sysfs
layout represents a dependency between each device quite well.


3. Suggestion
-------------
 To solve the problem, I'd like to propose the following idea.

["hotplug" directory]
   This directory is to represent a hierarchy of hotpluggable devices.
  "hotpluggable device" means a device that can be powered off and
  removed physically from the system running.  The hierarchy describes a 
  dependency between each device.  This directory would be placed, like:

      /sys/devices/hotplug

  Any systems that enable hotplug (e.g. ACPI, DLPAR) can create their
  own directory right under the "hotplug" directory, like:

      /sys/devices/hotplug/acpi
      /sys/devices/hotplug/dlpar

  Each of systems can create directories and files under the own directory,
  and these directories should be easy for user to use.


[ACPI based Hotplug Case]
   I think that ACPI is one of the systems tha know dependencies of devices.
  So, I'd like to show an example here how ACPI based hotplug can work
  under the "hotplug" directory.  (I still have a lot of things to think, though.)

  In ACPI based hotplug, "hotpluggable device" could be defined as follows:

      A device that its device object in ACPI namespace has _EJ0 and _STA
      method, and the _STA returns 0x0F (present).

      [Hotpluggable device (simplified ASL)]
        Scope (\_SB_) {
            Device (DEV1) {
                Method (_EJ0) {...}
                Method (_STA) {... return 0x0F}
            }
        ...


  The above hotpluggable device is represented under the "hotplug" directory,
  like:

      /sys/devices/hotplug/acpi/DEV1

  Plus, a control file, "eject", which is used for invoking a corresponding
  device hot-removal handler, is created under each hotpluggable devices'
  directory, like:

      /sys/devices/hotplug/acpi/DEV1/eject

  The directory "DEV1" and the file "eject" are deleted when the device is
  removed.  A point here is:

        While a device is attached to the system, a corresponding directory
        appears on sysfs.  When the device is removed from the system, the 
        directory is also deleted.

  As mentioned above, basically a directory is created only for hotpluggable
  devices.  However, there is a special case that a directory is created for
  devices that include a hotpluggable device.

      /sys/devices/hotplug/acpi/DEV2/DEV1/eject
      (where, DEV2 is not a hotpluggable device)

  In addition, the special directory is deleted when the child hotpluggable
  device is removed.


Let's take a look at a sample here.
Assume that you have a large machine containing many devices, and the
devices are defined in ACPI namespace like below.

    [Simplified ASL]
      Scope (\_SB_) {
          Device (DEV1) {
              Method (_EJ0) {...}
              Method (_STA, 0) { Return (0x0F) }

              Device (DEV2) {
                  Method (_STA, 0) { Return (0x0F) }
              }

              Device (DEV3) {
                  Method (_EJ0) {...}
                  Method (_STA, 0) { Return (0x0F) }
               }

              Device (DEV4) {
                  Method (_STA, 0) { Return (0x0F) }
                  Device (DEV5) {
                      Method (_EJ0) {...}
                      Method (_STA, 0) { Return (0x00) }
                  }
                  Device (DEV6) {
                      Method (_EJ0) {...}
                      Method (_STA, 0) { Return (0x0F) }
                  }
              }
          }
      }


In this case, "hotplug" tree looks like:

    sys/devices/hotplug/acpi/
        `-DEV1/
            |-eject
            |
            |-DEV3/
            |   `-eject
            |
            `-DEV4/
                `-DEV6/
                    `-eject


Any comments or questions are welcomed.


Thanks,
Kei
