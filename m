Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266716AbTCEA0J>; Tue, 4 Mar 2003 19:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266810AbTCEA0J>; Tue, 4 Mar 2003 19:26:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16146 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266716AbTCEA0H>; Tue, 4 Mar 2003 19:26:07 -0500
Date: Wed, 5 Mar 2003 00:36:35 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [CFT] PCI probing for cardbus
Message-ID: <20030305003635.A25251@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could people please test these patches and let me know of any problems.
They work for me.  There should be no user-visible changes in behaviour
from this set, apart from drivers/hotplug breaking again.  These are all
against base 2.5.63, and will follow in separate mails.

pci-1.diff

- Separate out bus resource allocator (pci_bus_alloc_resource)
- Provide pci_enable_bridges to setup command register for all
  pci bridges

pci-2.diff

- Eliminate the stack allocation of a struct pci_dev, and make
  pci_scan_slot() take a bus and a devfn argument.
- Add "dev->multifunction" to indicate whether this is a multifunction
  device.
- Run header fixups before inserting the new pci device into any
  device lists or announcing it to the drivers.
- Convert some more stuff to use the list_for_each* macro(s).

  No real behavioural change yet.

pci-3.diff

  This is the first patch which we start breaking things.

  The pci_find* functions search using the following lists:
        bus->children   (for subordinate buses)
        pci_root_buses  (for all root buses)
        pci_devices     (for devices)

  This leaves one list which we can add devices to without any drivers
  finding the new devices before we've finished with them.  (Jeff - some
  drivers do go scanning the bus_list, notably de4x5.c:srom_search.)

- initialise bus->node list head.

- pci_scan_slot will scan the specified slot, and add the discovered
  devices to the bus->devices list only.  These devices will not
  appear on the global device list, and do not show in sysfs, procfs.
  pci_scan_slot returns the number of functions found.  If you want
  to find the devices, you have to scan bus->devices and look for
  devices where list_empty(&dev->global_list) is true.

- new function "pci_bus_add_devices" adds newly discovered devices
  to the global device lists, and handles the sysfs and procfs
  stuff, making the devices available to drivers.  All our buses
  which have an empty list head are treated as "new" (since they
  are not attached to the parent buses list of children) and are
  also added.  Currently, no buses will be in this state when this
  function is called.

- new function "pci_scan_child_bus" scans a complete bus, building
  a list of devices on bus->devices only, performing bus fixups
  via pcibios_fixup_bus() and scanning behind bridges.  It does
  make devices externally visible.

- pci_do_scan_bus retains its original behaviour - ie, it scans
  and makes devices available immediately.

pci-4.diff

- Convert setup-bus.c resource allocation to scan bus->devices rather
  than bus->children.  As noted previously, newly discovered child
  buses will not be on the parents list of children buses, so when
  we're trying to assign resources, we need to scan the bus for
  devices with subordinate buses rather than using the list of children
  buses.

pci-5.diff

  Now we tackle pci_add_new_bus and pci_scan_bridge.  The hotplug code
  currently uses this, but I'd like it to die off; pci_scan_bridge()
  should be used to scan behind bridges.  This may mean hotplug needs
  some changes to pci_scan_bridge - if so, we need to find out what
  changes are required and fix it.

  pci_alloc_child_bus() does what pci_add_new_bus() did, except it
  doesn't attach the new bus to the parents list of child buses.  The
  only way this bus can be reached from the parent bus is by scanning
  the parents devices list, and locating a device with a non-NULL
  subordinate bus.  The only code which should be doing this is the
  PCI code.

  Since the new bus will have an empty list head for bus->node, we can
  detect unattached buses prety easily.  (see pci-3.diff.  maybe we want
  a pci_bus_unattached() to make it more readable?)

  pci_scan_bridge() changes slightly - we use our new pci_scan_child_bus()
  function from pci-3.diff, which doesn't attach devices to the global
  tree.  This means callers of pci_scan_child_bus() and pci_scan_bridge()
  (ie, hotplug) will need to call pci_bus_add_devices().


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

