Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131093AbQLGQfE>; Thu, 7 Dec 2000 11:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131047AbQLGQey>; Thu, 7 Dec 2000 11:34:54 -0500
Received: from ganymede.or.intel.com ([134.134.248.3]:58118 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S131085AbQLGQeo>; Thu, 7 Dec 2000 11:34:44 -0500
Message-ID: <3A2FB558.C4C13106@intel.com>
Date: Thu, 07 Dec 2000 08:05:44 -0800
From: Randy Dunlap <randy.dunlap@intel.com>
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "torvalds@transmeta.com" <torvalds@transmeta.com>, rmk@arm.linux.org.uk,
        lkml <linux-kernel@vger.kernel.org>
Subject: [Fwd: 2.4.0-test12-pre7]
Content-Type: multipart/mixed;
 boundary="------------C3D29665DED92D8B174E3AA4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C3D29665DED92D8B174E3AA4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> From: Russell King [mailto:rmk@arm.linux.org.uk]
> 
> Linus Torvalds writes:
> >     - me: UHCI drivers really need to enable bus mastering.
> 
> But it'll already be turned on if pci_assign_unassigned_resources() is
> called.  This calls pdev_enable_device for every single device, which
> turns on the bus master bit in the PCI command register.
> 
> Is it intentional that pci_assign_unassigned_resources should:
> 1. enable all devices?
> 2. enable bus master on all devices?

Russell beat me to this question (must have something to do
with that .uk location).

I think that Linus's patch is correct and that
pci/setup_res.c::pdev_enable_device() shouldn't be doing this:

	/* ??? Always turn on bus mastering.  If the device doesn't support
	   it, the bit will go into the bucket. */
	cmd |= PCI_COMMAND_MASTER;

First, the ??? makes it iffy.

Second, if the device doesn't support it, OK, but if the device
does support bus mastering and the device has been programmed
from a previous kernel/driver bootup (i.e., the device isn't reset
by a soft boot), then the device still knows some memory addresses
to DMA into, but it shouldn't be using those.  This is addressed
in a Word .doc file at www.pcisig.com/developers/docs/ :
"Warm Boot on PCI Machines".  The short summary is that soft reset
should disable bus mastering and not re-enable it.
This doc says that device drivers (or expansion ROM code) are
responsible for setting the bus master bit.

Third, removing this will help find drivers that don't do
  pci_set_master() when they should (like UHCI HCDs).  :(

~Randy
-- 
_______________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------
--------------C3D29665DED92D8B174E3AA4
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: by orsmsx31.jf.intel.com 
	id <01C06065.2CCBA1C0@orsmsx31.jf.intel.com>; Thu, 7 Dec 2000 07:48:42 -0800
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F063E0631@orsmsx31.jf.intel.com>
To: Russell King <rmk@arm.linux.org.uk>, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.0-test12-pre7
Date: Thu, 7 Dec 2000 07:48:42 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"

> From: Russell King [mailto:rmk@arm.linux.org.uk]
> 
> Linus Torvalds writes:
> >     - me: UHCI drivers really need to enable bus mastering.
> 
> But it'll already be turned on if pci_assign_unassigned_resources() is
> called.  This calls pdev_enable_device for every single device, which
> turns on the bus master bit in the PCI command register.
> 
> Is it intentional that pci_assign_unassigned_resources should:
> 1. enable all devices?
> 2. enable bus master on all devices?

Russell beat me to this question (must have something to do
with that .uk location).

I think that Linus's patch is correct and that
pci/setup_res.c::pdev_enable_device() shouldn't be doing this:

--------------C3D29665DED92D8B174E3AA4--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
