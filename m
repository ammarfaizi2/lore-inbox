Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263632AbUEGPj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbUEGPj4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 11:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUEGPj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 11:39:56 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:24215 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263642AbUEGPjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 11:39:48 -0400
Date: Sat, 08 May 2004 00:39:04 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: [ANNOUNCE] [PATCH] Node Hotplug Support
To: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net
Message-id: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm announcing a new project "LHNS (Linux Hotplug Node Support)"
and patches for 2.6.5:

    http://sourceforge.net/projects/lhns/



Goal
====
The main goal of LHNS is to support "node hotplug" in Linux.

Where, "node" is a container device that contains CPU, memory,
and/or I/O devices.  The definition of "node" is different from one
of "NUMA node".

  - "NUMA node" is: a block of memory and the CPUs, I/O, etc.
    physically on the same bus as the memory (according to NUMA
    project website, this is a common definition).

  - "node" used here is: a hotpluggable hardware that contains
    CPUs, memory, and/or I/O.

The "node" and "NUMA node" are not always the same.  (I'm
sorry for the inconvenient :(  For instance, the "node" could be a
device that contains:

  - processors, memory, and I/O devices
  - processors and memory
  - processors only
  - memory only
  - I/O devices only
  - etc

"node hotplug" allows you to hot-add and hot-remove "node"
without stopping the system.



Why?
====
Someone might think like "Why don't we invoke CPU, memory, IO
hotplug individually without node hotplug?".  However, CPU, 
memory, and IO hotplug cannot remove a node (container device)
from the system physically.  That's a node hotplug's job.  Also,
when hotplug request occurs on a node, node hotplug searchs
resouces on the node, and invokes CPU, memory, and IO hotplug
in proper order.   Actually, the order is very important.  For instance,
when hot-adding a NUMA node, memory should be added first
so that CPUs could allocate data in the memory while the CPUs is
being added.  Otherwise, CPUs need to allocate it in other memory
on other node.  This might cause performance issue.



Design
======
ACPI is used to do some hardware manipulation.
There is no general purpose interface to get hardware information
and manipulate hardware today, but hardware proprietary interfaces.
ACPI is one of them, and I decided to use it because:

  - Its spec is open.
  - I can use it without any hardware special knowledge:)

The following assumptions are necessary for node hotplug:

  - The system has hotpluggable "node" (hardware).
  - Each of "node" is defined as a container device (HID=PNP0A05)
    in ACPI namespace.
  - Existing CPU, memory, I/O hotplug (LHCS, LHMS, PCI HotPlug
    for Linux, etc) produce a hook (function) for Node hotplug.

"node hotplug" consists of one main part and three sub parts so far:

  - ACPI container device hotplug (main)
  - ACPI based CPU hotplug (sub)
  - ACPI based memory hotplug (sub)
  - ACPI based I/O hotplug (sub)

  "ACPI container device hotplug" is: the main part of node hotplug,
  which is supposed to do:

    [hot-addition]
    1. Its handler is invoked when ACPI notify is occured by a node
       attached to the system.
    2. This creates data structures for the node.
       If CONFIG_ACPI_NUMA_CONTAINER=y, this handles NUMA
       related data also (not implemented yet).
    3. This invokes ACPI based CPU/memory/IO hotplug in proper
       order with proper arguments (e.g. acpi_handle of the added node)
    4. This notifies userland that the node is added/removed.
    5. This writes results of hotplug processing to a log file.

    [hot-removal]
    1. Its handler is invoked when ACPI notify is occured or user issues
       hot-removal request via sysfs.
    2. This deletes data structures of the node.
       If CONFIG_ACPI_NUMA_CONTAINER=y, this handles NUMA
       related data also (not implemented yet).
    3. This invokes ACPI based CPU/memory/IO hotplug in proper
       order with proper arguments (e.g. acpi_handle of the node)
    4. This evaluates _EJ0 method of the node.
    5. This notifies userland that the node is added/removed.
    6. This writes results of hotplugging into log file.

  "ACPI based CPU/memory/IO hotplug" are: the sub part, which are
  supposed to do:

    1. They are invoked by the main part with the argument.
    2. They search ACPI namespace to check if there are any devices
       on the node that they should handle.  For instance, if ACPI
       based CPU hotplug searches ACPI namespace to see if there
       are any CPUs on an added node.
    3. If they find devices, they do something and call existing hotplug
       features:
           o LHCS (Linux Hotplug CPU Support)
           o LHMS (Linux Hotplug Memory Support)
           o PCI HotPlug for Linux
           o etc.
       with some appropriate arguments (TBD).

  Then each hotplug handles each device hotplug.

See http://lhns.sourceforge.net/ for more information and figures
(module and component diagram).



Patches
=======
The following nine patches are available at:

    http://sourceforge.net/projects/lhns/
    (Actually, these files are packed into .bz2 file.)

  - p00001_sci_emu.patch:
      SCI interrupt emulation.

  - p00002_over-20030109.patch:
      Override an original BIOS's DSDT with a DSDT that you make up.

  - p00003_procfs_util.patch
      Extension for procfs.
      A new function remove_recursive_proc_entry().

  - p00004_acpi_processor_bug.patch
      Replace remove_proc_entry() to remove_recursive_proc_entry()
      in drivers/acpi/processor.c to avoid getting Call Trace.

  - p00005_acpi_hp_config.patch
      Kconfigs and Makefiles for ACPI hotplug.

  - p00006_acpi_core.patch
      Changes to ACPI core part for hotplug.
      A new function acpi_bus_scan_free(), etc...

  - p00007_acpi_hp_util.patch
      Utility functions for ACPI hotplug.

  - p00008_acpi_container_hp.patch
      The main part of node hotplug.

  - p00009_acpi_container_hp_cpu.patch
      The sub part (CPU) of node hotplug.



Current Status
==============
The first patches have been tested in an emulation and a virtual
environment without LHCS, LHMS, etc's codes.  However, they are
very early versions of the code, so there are still many rough codes,
not Linux style codes, and TBDs.  The first patches are just nice
to show my idea and how they work.  Some sub parts and NUMA
node support have not been implemented yet.  (Please don't
enable "Hotplug memory" and "Hotplug IO" when you're doing
"make config":)



Usage
=====
See "Documents" section at http://lhns.sourceforge.net/.  There
are some documents and instructions:

  - How to build the kernel with LHNS patches
  - How to make a fake DSDT
  - How to generate SCI interrupt (emulation)
  - How to invoke hot-addition and hot-removal for container hotplug

Please feel free to take it for a spin!



Plan
====
First of all, I'd like to discuss the design of node hotplug and
interface with hotplug folks.  After I get feedback from the people,
I'll update my patches.  Also I'll release the following features in
the near future.  Then I'll make them work all together and test
them.

  - NUMA node support
  - ACPI based memory hotplug
  - ACPI based IO hotplug
  - H2P bridge hotplug
  - P2P brdige hotplug
  - IOSAPIC hotplug



Any comments, bug reports, or suggestions are welcome.

Thanks,
Keiichiro Tokunaga
