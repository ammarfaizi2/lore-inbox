Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVBGDE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVBGDE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 22:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVBGDE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 22:04:58 -0500
Received: from ozlabs.org ([203.10.76.45]:62603 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261344AbVBGDEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 22:04:51 -0500
Subject: Re: [linux-usb-devel] 2.6: USB disk unusable level of data
	corruption
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <200502041241.28029.david-b@pacbell.net>
References: <1107519382.1703.7.camel@localhost.localdomain>
	 <200502041241.28029.david-b@pacbell.net>
Content-Type: text/plain
Date: Mon, 07 Feb 2005 13:55:22 +1100
Message-Id: <1107744922.8689.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-04 at 12:41 -0800, David Brownell wrote:
> On Friday 04 February 2005 4:16 am, Rusty Russell wrote:
> > 
> > Is USB/SCSI just terminally broken under 2.6?  
> 
> I don't think so, but there are problems that appear in some
> hardware configs and not others.  Many folk report no problems;
> a (very) few report nothing but.
> 
> If you've verified this on 2.6.10, then you certainly have
> have the ehci-hcd (re)queueing race fix that has made a big
> difference for some folk.  I don't know of any other issues
> in that driver that could explain usb-storage problems.
> 
> What hardware config do you have?
> 
>   - Whose EHCI controller and revision?  I've never had
>     good luck with VIA VT6202.  ("lspci -v".)

OK, it's an IBM Thinkpad X31:

0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI
Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: IBM: Unknown device 052e
        Flags: bus master, medium devsel, latency 0, IRQ 11
        Memory at c0000000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2080]

Kernel messages when plugged in:
usb 4-3: new high speed USB device using address 5
scsi3 : SCSI emulation for USB Mass Storage devices
  Vendor: HTS72606  Model: 0M9AT00           Rev: MH4O
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: assuming drive cache: write through
 /dev/scsi/host3/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 >
Attached scsi disk sda at scsi3, channel 0, id 0, lun 0
USB Mass Storage device found at 5

>   - Whose USB storage adapter?  ("lsusb -v", or in this
>     case the /proc/bus/usb/devices entry would be ok.)
>     GeneSys adapters have been the most problematic,
>     but they're hardly the only ones with quirks.

Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x0dc4 Macpower Peripherals, Ltd
  idProduct          0x00c4
  bcdDevice            0.02
  iManufacturer           1 Macpower
  iProduct                2 2.5HDD
  iSerial                 3 8000D1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          4 Myson 8818
    bmAttributes         0xc0
      Self Powered
    MaxPower               10mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      5 SFF-8070i
      bInterfaceProtocol     80
      iInterface              5 USB2.0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  bNumConfigurations      1

> Thing is, that driver stack isn't especially thin:  SCSI isn't
> the top, and it's got usb-storage, usbcore, and a USB HCD under
> it.  That makes it harder to track down root causes, even when
> there is just a single one and it's in those drivers (rather
> than being hardware misbehavior).

I have some spare partitions on the disk, so I've written a program
which writes using DIRECT_IO and verifies the results.  It took less
than an hour under my filesystem load, so I'll see if I can get this to
trigger it (currently N children writing to separate blocks, but if that
doesn't trigger it I'll get more sophisticated with readers and
writers).

Thanks for the response,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

