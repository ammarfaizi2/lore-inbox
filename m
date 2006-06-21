Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWFUMFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWFUMFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 08:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWFUMFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 08:05:33 -0400
Received: from soundwarez.org ([217.160.171.123]:23694 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751175AbWFUMFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 08:05:32 -0400
Subject: Re: udev bluez
From: Kay Sievers <kay.sievers@vrfy.org>
To: "Robert M. Stockmann" <stock@stokkie.net>
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0606201759140.11776-100000@hubble.stokkie.net>
References: <Pine.LNX.4.44.0606201759140.11776-100000@hubble.stokkie.net>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 14:06:47 +0200
Message-Id: <1150891607.3224.25.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 18:11 +0200, Robert M. Stockmann wrote:
> It seems the story of the greatest piece of software ever written
> is being hit by the bluez of having to support too many seperate
> addon hardware devices, which the coders themselves in many cases
> never heard of. Until the udev problems showup.
> 
> The key piece of trouble is udev which has nowadays has to run
> in close cooperation with a daemon called hald.

No, HAL receives device events the kernel sends out trough udev. That's
all, there is no dependency on HAL, or information flowing back from HAL
to udev. HAL is just a consumer of the udev events, like some other
services too.

> I wonder if linux is
> trying to solve the problems of 'broken by design' addon hardware?
> To me it just looks like polishing up a can of maggots.

Well, that's the very nature of hardware, to be broken if you look at it
from that angle. :)

> The most evil category seem to be USB camara's , photo devices, etc.

We are not aware of any general problem here, if your distro or software
stack doesn't solve that for you, try to fix it or just take a look at a
working setup. It works nicely for quite some time.

> "I've even created a standalone udev rule - 
>   BUS="usb", SYSFS{idVendor}=="04a9", SYSFS{idProduct}=="3113",
>   MODE="0660", GROUP="camera", NAME="canon", SYMLINK="camera
> 
> "aah canon ... with a canon you can't!"

Udev does not know what kind of device you have connected, it's just a
dumb usb device, you can't solve that in a generic way at that level.
Just completely forget device node names for devices like this, it can
only work for very custom setups at the udev level.

> So is there a smart way out of this mess?

That's already solved. Use HAL to get your device list. HAL identifies
and classifies all common devices and offers you an interface to query
these classifications and subscribe to events to get notified about
device state changes. It usually even provides you with the supported
method to access the content on the device.

Monitor device changes:
  $ lshal --monitor
  Start monitoring devicelist:
  -------------------------------------------------
  usb_device_4a9_30fe_noserial added
  usb_device_4a9_30fe_noserial_if0 added
  usb_device_4a9_30fe_noserial_usbraw added

Or lookup all camera's:
  $ hal-find-by-capability --capability camera
  /org/freedesktop/Hal/devices/usb_device_4a9_30fe_noserial_if0

And get information about it:
  $ lshal --long --show /org/freedesktop/Hal/devices/usb_device_4a9_30fe_noserial_if0
  udi = '/org/freedesktop/Hal/devices/usb_device_4a9_30fe_noserial_if0'
  camera.access_method = 'ptp'  (string)
  camera.libgphoto2.name = 'USB PTP Class Camera'  (string)
  camera.libgphoto2.support = true  (bool)
  info.bus = 'usb'  (string)
  info.capabilities = {'camera'} (string list)
  info.category = 'camera'  (string)
  info.parent = '/org/freedesktop/Hal/devices/usb_device_4a9_30fe_noserial'  (string)
  info.product = 'USB Imaging Interface'  (string)
  info.udi = '/org/freedesktop/Hal/devices/usb_device_4a9_30fe_noserial_if0'  (string)
  linux.subsystem = 'usb'  (string)
  linux.sysfs_path = '/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-3/1-3:1.0'  (string)
  linux.sysfs_path_device = '/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-3/1-3:1.0'  (string)
  usb.bus_number = 1  (0x1)  (int)
  usb.configuration_value = 1  (0x1)  (int)
  usb.device_class = 0  (0x0)  (int)
  usb.device_protocol = 0  (0x0)  (int)
  usb.device_revision_bcd = 2  (0x2)  (int)
  usb.device_subclass = 0  (0x0)  (int)
  usb.interface.class = 6  (0x6)  (int)
  usb.interface.number = 0  (0x0)  (int)
  usb.interface.protocol = 1  (0x1)  (int)
  usb.vendor = 'Canon, Inc.'  (string)
  usb.vendor_id = 1193  (0x4a9)  (int)
  ...


Kay

