Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSLASuD>; Sun, 1 Dec 2002 13:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262373AbSLASuD>; Sun, 1 Dec 2002 13:50:03 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:28893 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262360AbSLASuB>; Sun, 1 Dec 2002 13:50:01 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 1 Dec 2002 10:57:09 -0800
Message-Id: <200212011857.KAA29742@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] LSM fix for stupid "empty" functions
Cc: crispin@wirex.com, greg@kroah.com, hallyn@cs.wmu.edu, hch@infradead.org,
       jmorris@intercode.com.au, olaf.dietsche#list.linux-kernel@t-online.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002, Greg Kroah-Hartmann wrote:
>On Sun, Dec 01, 2002 at 05:21:56PM +0000, Christoph Hellwig wrote:
>> On Sun, Dec 01, 2002 at 10:12:27AM -0800, Greg KH wrote:
>> > Does the kernel work if data structures are in ROM?  I would think that
>> > lots of variables in the kernel would have this problem :)
>> 
>> The nommu ports support .text in rom.
>
>But doesn't initialized variables live in .bss?  So we should be ok,
>right?

	Initialized writable variables live in .data.
	Initialized constant variables live in .rodata.
	"Uninitialized" variables live in .bss (initialized to zeros).

	You can also put a variable in a different section with the
gcc feature __attribute__((__section__("sectioname") )), as is done
for initdata and exitdata variables in include/linux/init.h.  A kernel
link script such as linux-2.5.50/arch/i386/vmlinux.ld.S then arranges
the different sections together according to which ones should
be writable, among other considerations.

	In general, which structures have to be allocated from
writable memory and which do not is a characteristic of individual
programming interfaces.  For example, most device drivers that embed a
struct device_driver must be in writable memory because the various
"bus type" registration functions usually fill in fields in the
embedded struct device_driver.  This has greatly eased migration to
struct device_driver.  An example of this is pci_register_driver
in linux-2.5.50/drivers/pci/pci-driver.c.

	Although it may be possible to eliminate much of this filling
in of struct device_driver fields by making future drivers initialize
these fields directly, it will probably still be optimal for some bus
types to use this technique to consolidate certain facilities that
are specific to one bus type, but common across drivers within that
bus type.

	For example, there is a common way to determine what IO and
memory ranges a PCI device may need from its configuration registers,
so I would like to add an optional mask to tell
pci_device_{probe,remove} to handle the associated request_region()
calls and failure branches.  This could simplify PCI drivers a bit,
because current Linux drivers have a lot of rarely tested resource
allocation failure branches, and they tend to get more complicated
when they involve potentially unwinding a bunch of allocations.  Also,
this bookkeeping might be made obselete by other hotplug PCI support,
in which case we change the code in one place to skip it.  On the
other hand, pushing this facility up to the generic device layer might
add more complexity than it would save (although that would be worth
exploring as a subsequent refinement).  So, there may continue to be
an advantage to having some bus-specific wrapper functions.

	Also, having mybus_regsiter_device() fill in these function
may simplify future modification, which is probably more true of
Greg's security module changes.  You may be able to add operations
without needing to modify every module to include dummy function for
the new operations.

	By the way, I'm not that strong an advocate of this.  I'm just
trying to explain the trade-off.  I suspect that it will be beneficial
to slim down many of the bus-specific layers in the future.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
