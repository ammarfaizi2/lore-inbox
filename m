Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUHXFaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUHXFaW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 01:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265722AbUHXFaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 01:30:22 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:48264 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266591AbUHXFY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 01:24:59 -0400
Date: Tue, 24 Aug 2004 14:24:51 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: [RFC&PATCH 1/2] PCI Error Recovery (readX_check)
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Message-id: <412AD123.8050605@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja, en-us, en
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I've forgotten to cc-ing, so send again.)

Hi, all

This is a request for comments about "PCI error recovery."

Some little time (six months!) ago, we had a discussion about this topic,
and at the last we came to the conclusion that "check the bridge status."
Based on this (Linus's idea), I have reconsider the design and refine the
implementation.  I'd really appreciate it if you could find a problem of
the following ideas and could feedback it to me.

-----

At first, again, my goal is:
    "Enable some possible error recovery on drivers by error notification."

Today, errors on some type of transaction such as:
    - memory mapped I/O write
    - DMA from device to memory
    - DMA from memory to device
are recoverable because the error (ex. parity error) is visible on the
status register of the device.

However, in the case of memory mapped I/O read, the result of the
transaction is not visible on the device. Whether there had a error
or not is visible on bus bridges locates upper the device.

We have to be careful since there are some platforms that host bus bridges
couldn't be used for recovery (ex. host isn't PCI device.)
If so, we have to use a PCI-to-PCI bridge just under the host bridge
instead of using the host bridge.

Put simply, we need to check the status of the "highest" bus bridge only
in the case of mmio read.

And, the status of the highest bridge is shared by some other devices,
so clearing the status from one device could affect checking from the
other device.  Therefore, to check the status of the highest bridge, we
should handle the status from out of device drivers, never in each drivers.

So what I have to consider next is the implementation of notification on
mmio read which we should check the highest bridge status.

---

Okay, let's talk about the actual implementation :-)

The requirement is:
    "Guarantee the result of mmio read on error while multiple mmio read
       by devices under same bridge is running."

To realize this, satisfy all of 1 to 3:

#1:
    We have to know which device under the same bridge doing mmio read.

Add a list "working_device" on the pci_dev struct to check the running
device.  Register the device to the highest bridge device at the beginning
of a session containing some mmio reads, and unregister the device at the
end of the session.

#2:
    Clear the bridge status when no devices under the bridge do mmio read.

Take a lock during a mmio read which could change the status, and during
a clearing the status.  Logically, rwlock is convenient.
    - Processing mmio read: read_lock
    - Clearing the status:  write_lock
To reduce more load on this lock, check the status before clear it, and
skip clearing if the status have no error.

#3:
    Send the error status to all drivers in session before clear it.

There is no way to know which device cause a error if there are multiple
devices doing mmio read.  (Using spinlock instead of rwlock is a possible
way, but clearly it would impact on I/O performance, so I ignore the way.)
Thus, the best we can do now is send the error to all concerning driver.
I mean, notify the error to all devices registered to the "working_device"
list of the highest bridge, by updating "err_status" value which newly
added to the pci_dev struct.  Note that we should take the write_lock from
the updating "err_status" to the clearing the bridge status.  Or the result
of I/O between the updating and the clearing would vanish into the night.

---

I suppose the basic mmio read of RAS-aware driver as like as following:

========================================================================
int retries = 2;

do {
       clear_pci_errors(dev);		/* clear bridge status */
       val = readX_check(dev, addr);	/* memory mapped I/O read */
       status = read_pci_errors(dev);	/* check bridge status */
} while (status && --retries > 0);
if (status)
	/* error */
========================================================================

The basic design of new-found functions are:

$1. clear_pci_errors(DEVICE)
   - find the highest(host or top PCI-to-PCI) bridge of DEVICE
   - check the status of the highest bridge, and if it indicates error(s):
     - write_lock
     - update each err_status of all devices registered to the working_device
       list of the highest bridge, by "|=" the value of the bridge status
     - clear the bridge status
     - write_unlock
   - clear the err_status of DEVICE
   - register DEVICE to the highest bridge

$2. readX_check(DEVICE, ADDR)
   - read_lock
   - I/O (read)
   - read_unlock

$3. read_pci_errors(DEVICE)
   - find the highest bridge of DEVICE
   - store the status of the highest bridge as STATUS
   - check ( STATUS | DEVICE->err_status )
   - return 1 if error (ex. Master/Target Abort, Party Error), else return 0


Note:
This time, here is no initialize for the control register of the highest
bridge.  The generic initialization could be implemented in the code,
but the values are user configurable and occasionally some bus needs
specific value, so now I don't write it yet.


Thanks,
H.Seto





