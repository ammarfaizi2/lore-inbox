Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269526AbTCDULy>; Tue, 4 Mar 2003 15:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269527AbTCDULy>; Tue, 4 Mar 2003 15:11:54 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:22924 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S269526AbTCDULv>; Tue, 4 Mar 2003 15:11:51 -0500
Date: Tue, 4 Mar 2003 14:22:13 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Matt Domsch <Matt_Domsch@dell.com>
cc: Greg KH <greg@kroah.com>, <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>, <mochel@osdl.org>
Subject: Re: Displaying/modifying PCI device id tables via sysfs
In-Reply-To: <1046753776.12441.92.camel@iguana>
Message-ID: <Pine.LNX.4.44.0303041414270.23375-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Mar 2003, Matt Domsch wrote:

> /sys
> `-- bus
>     `-- pci
>         `-- drivers
>             `-- 3c59x
>                 |-- dynamic_id_0  (these are simple DRIVER_ATTRs)
>                 |-- dynamic_id_1
>                 |-- dynamic_id_2
>                 `-- new_id
> 
> Where dynamic_id_[012] are new dynamic entries, created by writing
> values into new_id.  Both file types would be of the format (analogous
> to pci_show_resources):
> echo "0x0000 0x0000 0x0000 0x0000 0x0000 0x0000" > new_id
> with fields being vendor, device, subvendor, subdevice, class,
> class_mask.

I dont' think what you actually want is changing the id table - after all, 
it's only walked when registering the driver (+ hotplug).

What you really want is a way to call the drivers' probe routine for a 
device which isn't in its tables.

So why not simply

echo "0x0000 0x0000 0x0000 0x0000 0x0000 0x0000" > .../3c59x/probe

It shares one caveat with the approach above, i.e. struct pci_device_id
has a field called "unsigned long driver_data", and as such is really hard
to fill from userspace. I think in the common case it's not used and can
be just set to zero, but if the driver e.g. expects it to point to a
driver-private structure describing the device, you lose.

And you need one more thing, i.e. the ability to load a driver without
hardware being present. E.g. pci_module_init() is supposed to return
-ENODEV when modular and no hardware is found. Actually, it doesn't
anymore, since someone (I think you, Pat ;) broke it.

--Kai




