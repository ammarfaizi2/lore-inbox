Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313045AbSDSVns>; Fri, 19 Apr 2002 17:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313054AbSDSVnr>; Fri, 19 Apr 2002 17:43:47 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:26618 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S313045AbSDSVnp>; Fri, 19 Apr 2002 17:43:45 -0400
Message-ID: <3CC08DFF.787F6E54@austin.ibm.com>
Date: Fri, 19 Apr 2002 16:37:03 -0500
From: James L Peterson <peterson@austin.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@au.ibm.com>, paulus@ozlabs.au.ibm.com
CC: mj@suse.cz, linux-kernel@vger.kernel.org
Subject: PowerPC Linux and PCI
In-Reply-To: <OF8A238806.80D1511C-ON87256B75.00773B75@boulder.ibm.com> <20020307220318.GA4664@haven>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize if this message is directed incorrectly; any hints you could
give on who else to ask on this would be appreciated.

I'm trying to get Linux running on a 405GP system with PCI.  Actually
it's on the mambo simulator and I'm writing the PCI support.  My
information about PCI comes from the PCI System Architecture
book by MindShare; also the PPC405GP User's Manual. My problem is
basically a big-endian/little-endian problem.  All of the documents
agree that the Vendor ID is in bytes 0 and 1, and the Device ID
is in bytes 2 and 3.  The header file include/linux/pci.h agrees:

#define PCI_VENDOR_ID  0x00 /* 16 bits */
#define PCI_DEVICE_ID  0x02 /* 16 bits */

But in drivers/pci/pci.c, when we are trying to discover
a particular device, in pci_scan_device, the code
reads out a dword (a 32-bit quantity) and then masks
out the two subfields:

if (pci_read_config_dword(temp, PCI_VENDOR_ID, &l))
  return NULL;
     ....
  memcpy(dev, temp, sizeof(*dev));
 dev->vendor = l & 0xffff;
 dev->device = (l >> 16) & 0xffff;

It seems to me this is incorrect for a big-endian machine
(like PowerPC).  If we read the two 16-bit parts out of the
first 32-bit part, we will end up with:

        0       1            2        3
        vendor-id       device-id

with a big-endian machine, but

       0        1           2         3
      device-id         vendor-id

for a little endian machine.  This would make the mask and
shift definition to the vendor and device field correct for little
endian, but swapped for big-endian.

There is a similar problem for the read of the Class Code
and Revision ID dword in pci_setup_device, where, again,
they read the dword and then shift to get the "upper 3  bytes"
while on a big-endian machine, you would actually want the
"lower 3 bytes" for the 3-byte Class Code field.

The fixes to this code is fairly simple -- always read the size
of field that is defined from the bytes where it is defined to be --
but I am more confused by why this has not shown up before.
This seems a fundamental problem -- incorrectly defining the
device and vendor fields for a PCI device -- which would have
prevented PCI devices from working on PowerPC systems
(or any other big-endian system), but I don't see #ifdef's for
it, or platform-specific code to correct it or anything else.
Yet since these fields are defined by hardware manufacturers,
I would expect they are always as defined by the PCI document,
that is always little-endian.  So it seems that the code can't work,
and yet ...

I'd appreciate any comments or recommendations.

jim

James Peterson
IBM Austin Research Lab
Austin, Texas


