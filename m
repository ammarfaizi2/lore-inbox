Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268710AbUIQMCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268710AbUIQMCY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 08:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268708AbUIQMCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 08:02:23 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:14538 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268716AbUIQMAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 08:00:41 -0400
Date: Fri, 17 Sep 2004 21:00:35 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [RFC&PATCH 1/2] PCI Error Recovery (readX_check)
In-reply-to: <412FDE7B.3070609@jp.fujitsu.com>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Cc: Grant Grundler <iod00d@hp.com>, Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-id: <414AD1E3.8040703@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja, en-us, en
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
References: <412FDE7B.3070609@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last month I wrote:
> I understand the needs of Documentation/pci-errors.txt for driver 
> developers,

So I wrote the document and here it is.
I'd fully appreciate it if someone could proofread this document.

Thanks,
H.Seto

#####

		Description about error recovery on PCI

	by Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com> on Sep-2004

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This document describes about the implementation and usage of driver APIs
to enable error detection and how to make PCI/PCI-X transactions safe.



1. Resources used in PCI recovery
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Generally, system has multiple PCI buses, every bus could have multiple
devices, and bus could be connected to another bus by bus bridge.
Every (PCI-to-PCI)bridge is also handled as a PCI device.

Often host bus bridge(Host-to-PCI bridge, connecting PCI system to the host)
is also implemented as a PCI device, but this is not always true since
it isn't definitely defined in the PCI specification.

Normal(Non-bridge) PCI device has a set of status register for itself,
and bridge has 2 sets of status register for both of its neighbor buses.

Device driver can notice an error on the device by checking the status
register of device. And also the driver could check the status registers
of bridge for errors on bus.

Note that the status register of bridge could be referred from multiple
device drivers because the bus under the bridge could have multiple devices.

Successful recovery relies on the PCI-X bus protocol, where devices
report data parity errors to their device drivers instead of causing
the chipset to generate a fatal error (ex. MCA on ia64) to the system.

Resources you can use for recovery are:

   - PCI-X bus protocol support (requirement)
   - status register of device
   - status register of bridge
   - status register of host bus bridge (if available)



2. Which is recoverable?
~~~~~~~~~~~~~~~~~~~~~~~~

Errors during PCI/PCI-X transactions are reported by PERR# or SERR# signals.

SERR# indicates a severe system error in the system that makes it impossible
to continue operation of the system. Generally SERR# is translated to a fatal
error which result in a system shut down.

PERR# indicates parity error during the data phase. Devices should be report
and detect data parity errors. Since there are only few platforms supporting
PCI error recovery, there is a traditional abuse that many platforms are
configured to escalate recoverable PERR#s as fatal SERR#s without any try.

PERR#s on the PCI/PCI-X bus can affect the following transaction:

   - I/O read
   - I/O write
   - Memory-mapped I/O read
   - Memory-mapped I/O write
   - DMA from memory to device
   - DMA from device to memory

Now we are taking them into the scope of what the PCI error recovery is
trying to support.

   I/O read:
   Memory-mapped I/O read:

     In case of memory-mapped I/O read(transfer from a device to a CPU),
     errors occurred on the path(bus) is not detectable on the device.
     In such case, we should check the status of bridge.

     However, usually there are multiple devices under the one bridge,
     the status register of bridge is a shared resource of devices.
     So it could happen the status indicating an error caused by one device
     could be referred or cleared by drivers handling other device under
     the same bridge.

     Therefore some negotiations are required to access the status register
     of bridges.

   I/O write:
   Memory-mapped I/O write:

     In case of memory-mapped I/O write(transfer from a CPU to a device),
     since errors occurred on the path(bus) come down to the destination,
     errors are detectable on the device.

     But also here is a traditional issue that if the device is configured
     to report a parity error, PERR# asserted from it would be reported to
     the system. Depending on the chipset or system configuration, it will
     be escalated as a fatal error.

     Under the PCI-X protocol, this error will be recoverable by the device
     signaling its device driver. The PCI-X device will send a "Write Data
     Parity Error" message to notify the parity error, this will not cause
     any side effect such as SERR#.

   DMA from memory to device:
   DMA from device to memory:

     In both directions, DMA transfers are handled by the memory controller.
     The errors and completion of the transfer are delivered to the device and
     the status register of device is changed to indicate the result of DMA.
     Device driver could check the status to determine proper action such as
     device reset or repeat transaction.

     Recovery for DMA transfer also requires the PCI-X support to prevent the
     system from PERR# escalation.

Let me paraphrase:

   We can use existing interfaces under the PCI-X support to recover almost
   all type of PCI transactions except mmio read where we should check the
   bridge status.
   Special consideration on bridge status is required for mmio read recovery.



3. Bridge status and Bus error
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

On data transfer, the data go through all bus and bridge on the route.

If a error has occur on a bus, all forwarding bridges on the route would
reflect the error on its status register.

ex.)

   ==Host==
      |
    [H2P Bridge]
      |
   --------BUS0--------
      |
    [P2P Bridge1]
      |
   --------BUS1--------
      |              |
    [P2P Bridge2]  [P2P Bridge3]
      |              |
      |             --------BUS3--------
      |                      |
   --------BUS2--------    [devZ]
        |        |
      [devX]   [devY]

If BUS1 errors on transfer from a devX to a CPU, the error will be indicated
on the status register of P2P Bridge1 and H2P Bridge. P2P Bridge2 could not
be aware the error on BUS1 because it could be happen that Bridge2 cannot
receive any information from Bridge1 via broken BUS1. (Still can the driver
talk to Bridge2 via BUS1? Is it danger to rely on the status of Bridge2?)

Therefore, to maximize the scope of bus error detection, we have to check
the status of the "highest(=nearest to the host)" bridge, and the bridge
must be realized as a PCI device(it could be not host bus bridge).



4. Design and Implementation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

4.1 Design
~~~~~~~~~~

Usually device drivers are coded with no consciousness of other drivers.
Therefore it is not true that PCI device driver can notice the bus error
just only checking the status registers of bridge. Because there could be
other drivers that could change the value of the bridge status.

Therefore again, some negotiations between device drivers are required to
access the status register of bridges.

What we are going to deal with is a problem in case that one bridge is
shared by multiple devices. In case that no bridge is shared is no problem.

If the bridge is shared, there are 2 ways:

  - Do I/Os separately (with spinlock protection):
     Only one of device drivers under one bridge can I/O at one time.
     In this case there is no other driver who check or change the bridge
     status, so the value of bridge status is guaranteed not to indicate
     errors caused by other I/Os.

  - Do I/Os concurrently (with rwlock protection):
     Multiple device drivers under one bridge can I/O at one time.
     In this case it is required that drivers should not change the bridge
     status while other driver is checking the status, and also that drivers
     who want to clear the status but find there are already errors from
     anywhere should notify the error to all other drivers running I/O.
     The value of bridge status indicates just only existent of error.
     Who cause the error is not distinguishable.

The former is easy to implement, but will have great impact to I/O performance.
The latter is little complicated, but will not have such performance impact.

Ordinarily, errors occur uncommonly, and even if it had occurred, it would
be either "recoverable by single retry since it was a usual soft-error" or
"unrecoverable since it was a seldom hard-error." Almost all of in this worst
case, no matter who knows who cause the error, all device drivers sharing
the same bridge should take care of the error sooner or later.

Though we take the latter way.


4.2 Procedure
~~~~~~~~~~~~~

Required procedure of device driver is:

   1) Clear the status

     Until the status indicating an old error, new error cannot appear on
     the status. To detect new errors, clearing of the status register is
     required. However, the existence of old error should be notified to
     all working I/Os, but there is no way to know who are working on.
     So we create a "working_device" list on bridge, and have all device
     drivers to register its own device to the list at the beginning of I/O.

     Actions in this step are:
      - Get write_lock to protect the status and the working_device list
      - If there are old error, notify it to all devices in working_device
      - Clear the status
      - Register oneself to working_device
      - Release write_lock and Ready to I/O

   2) do I/Os (mmio read)

     States could be changed by results of each I/Os (i.e. error).
     To prevent the status from vanishing, I/O needs to be excluded while
     other device driver is clearing the status. Each I/Os can execute at
     same time, but I/O and clearing cannot execute at same time.

     Actions in this step are:
      - Get read_lock to protect the status
      - Do I/Os
      - (something like barrier could be here, depends on arch)
      - Release read_lock and Ready to next I/O

   3) Check the status

     Driver can know errors by notice from other driver clearing the bridge
     status or checking the status by itself. After all, there is no longer
     need to receive error notice from other driver, so unregistering of the
     device from "working_device" list should be the end of this step.

     Actions in this step are:
      - Get write_lock to protect the status and the working_device list
      - Check whether there were any error notice
      - Check the status register of bridge
      - Unregister oneself from working_device
      - Release write_lock
      - Return the result, error or non-error


4.3 Implements
~~~~~~~~~~~~~~

Followings show changes in struct pci_dev, pci_bus:

   struct pci_dev {
   	...
	list_head working_device;
		/*
		   List for management of devices sharing same bridge.
		   Device drivers should have its device be linked to
		   the bridge using this list, while the device is doing
		   I/Os under the bridge.
		 */
	unsigned  error_status;
		/*
		   You have to clear this before do I/O using this device.
		   If you find an error on the bridge when you are going to
		   clear the bridge status, you have to notify the error to
		   all devices registered to working_device list of the
		   bridge by making error_status of the device to indicate
		   error. Conversely your device could be notice errors on
		   the bridge by checking error_status changed by other
		   device driver or not.
		 */
	...
   }
   struct pci_bus {
   	...
   	struct rw_semaphore bus_lock;
		/*
		  Use for register/unregister of working_device,
		  actual I/O, and clearing the bridge status.
		 */
   	...
   }

Recovery procedure using new APIs and internals of the APIs:

   1) Clear and Save bridge status for checking the result of mm I/O read
     void clear_pci_errors(struct pci_dev *)

     {
	write_lock();
	if( bridge->state == error ) {
		for_each(device, bridge->working_device)
			device->error_status = error;
		bridge->state = 0;
	}
	this->error_status = error;
	add_list(this, bridge->working_device);
	write_unlock();
     }

   2) Real memory mapped I/O read transactions for each types
     X readX_check(struct pci_dev*, X *addr) [ X = (u8, u16, u32) ]

     {
	read_lock();
	readX();
	barrier();
	read_unlock();
     }

   3) Check the result of mm I/O read
     int read_pci_errors(struct pci_dev *)

     {
	write_lock();
	del_list(this, bridge->working_device);
	berr = bridge->state;
	write_unlock();
	derr = this->error_status;
	return (berr|derr) ? 1 : 0 ;
     }



5. Usage of API
~~~~~~~~~~~~~~~

   void clear_pci_errors(struct pci_dev *)

     Clear all status registers concerning the device before executing of I/O.
     And prepare to check registering the device to the highest bridge.
     You should call this at the beginning of session you want to check.

   X readX_check(struct pci_dev*, X *addr) [ X = (u8, u16, u32) ]

     Do actual I/O, with exclusion control to guarantee against the error.
     Don't merge standard function such as:
         X readX(addr)
     in same session. Or the value of status register will not be guaranteed.

   int read_pci_errors(struct pci_dev *)

     Check status registers for the errors.
     Returned value 0 means no error, and others mean an error.
     You should call this at the last of session you want to check.

     If you get an error from this, it does not directly mean that an error
     caused by this session, but that an error occurred on this session or on
     other session handled by other driver handling a device on same bridge.



6. Sample code - template
~~~~~~~~~~~~~~~~~~~~~~~~~

You can write RAS-aware driver using pattern as like as following:

  +----------------------------------------------------------------------------+
  |									      |
  |	int get_data_buffer(struct pci_dev *dev, u32 *buf, int words)	      |
  |	{								      |
  |		int i;							      |
  |		unsigned long ofs = pci_resource_start(dev, 0) + DATA_OFFSET; |
  |									      |
  |		clear_pci_errors(dev);					      |
  |									      |
  |		/* Get the whole packet of data.. */			      |
  |		for (i = 0; i < words; i++)				      |
  |			*buf++ = readl_check(dev, ofs);			      |
  |									      |
  |		/* Did we have any trouble? */				      |
  |		if (read_pci_errors(dev))				      |
  |			return -EIO;					      |
  |									      |
  |		/* All systems go.. */					      |
  |		return 0;						      |
  |	}								      |
  |									      |
  +----------------------------------------------------------------------------+

Device driver could implement some possible recovery such as device reset,
repeat transaction, reallocate buf and so on.



7. Notes
~~~~~~~~

7.1 Expected Environment - High-end system configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

These infrastructure are not for desktops but for enterprise servers.

It is assumed that most high-end hardware has enough bridges and that
the number of devices sharing same bridge would be minimized.

Any "mixed" bridge, having 2 types of device driver, is not acceptable.
All drivers should be RAS-aware driver supporting PCI error recovery
infrastructure. Don't use non-aware driver in such situation.

As you know, my implementation was not designed on the assumption that
"1 bridge = 1 device" like on ppc64, but on "1 bridge = 1 device group."
Of course, there could be some group of only 1 device.
It will depend on the structure of the system which you could configure it.


7.2 One for all, All for one
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Devices in same group can run at same time keeping with a certain level of
performance, and not mind being affected(or even killed!) by (PCI bus)error
caused by someone in the group.  They either swim together or sink together.

Fortunately, such error is rare occurrence, and even if it had occurred,
it would be either "recoverable by a retry since it was a usual soft-error"
or "unrecoverable since it was a seldom hard-error."

Without this new recovery infrastructure, there is no way for system to know
which drivers should retry the transaction to determine whether the error was
a soft one or a hard one, and also system cannot have these drivers not to
return the broken data to user.

So now, system will choose to down, last resort comes first.


