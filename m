Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261439AbSJABs3>; Mon, 30 Sep 2002 21:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261441AbSJABs3>; Mon, 30 Sep 2002 21:48:29 -0400
Received: from air-2.osdl.org ([65.172.181.6]:53903 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261439AbSJABs2>;
	Mon, 30 Sep 2002 21:48:28 -0400
Date: Mon, 30 Sep 2002 18:55:51 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Matt Domsch <Matt_Domsch@Dell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
In-Reply-To: <Pine.LNX.4.44.0209271606001.16331-100000@humbolt.us.dell.com>
Message-ID: <Pine.LNX.4.44.0209301844310.18550-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> |-- bus
> |   `-- system
> |       |-- devices
> |       |   |-- int13_dev80 -> ../../../root/bios/int13_dev80
> |       |   |-- int13_dev81 -> ../../../root/bios/int13_dev81
> |       `-- drivers
> |           |-- edd
> `-- root
>     |-- bios
>     |   |-- int13_dev80
>     |   |   |-- host_bus
>     |   |   |-- info
>     |   |   |-- interface
>     |   |   |-- name
>     |   |   `-- power
>     |   |-- int13_dev81
>     |   |   |-- host_bus
>     |   |   |-- info
>     |   |   |-- interface
>     |   |   |-- name
>     |   |   `-- power
>     |   |-- name
>     |   `-- power
> 
> 
> (Yes, the system bus isn't the right place for them to go, but it must
> go on some bus, and eventually it will get moved to a better place.)

[ Sorry, I didn't get this out earlier, but you're just too damn fast with 
your resubmissions.. ;)]

Don't use struct device for the firmware objects. They're not really
devices; they're another type of entity that has some sort of magic 
ia32 voodoo relationship with real devices. 

I recently converted ACPI to abandon the notion that the namespace objects 
were real devices. In doing so, I gave them their own top-level directory 
in driverfs. Don't do this. That's only a temporary solution until I 
create a 'firmware' or 'platform' directory for all of you people to live. 

> The 'info' file contains the full set of information returned by BIOS
> with extra error reporting.  This exists for vendor BIOS debugging purposes.
> 
> The 'host-bus' file contains the PCI (or ISA, HyperTransport, ...)
> identifying information, as BIOS knows it.
> 
> The 'interface' file contains the SCSI (or IDE, USB, ...) identifying
> information, as BIOS knows it.
> 
> 
> $ cat int13_dev80/host_bus
> PCI     02:01.0  channel: 0

How about a symlink to the bus's directory? Or the PCI device that is the 
controller? 

> $ cat int13_dev80/interface
> SCSI            id: 0  lun: 0

And, a symlink to the device itself? I liked it better the way you had it 
before :)

> $ cat int13_dev80/info
> 80 30 01 00                                             .0..
> 1e 00 09 00 00 00 00 00 00 00 00 00 00 00 00 00         ................
> 3a b9 8b 08 00 00 00 00 00 02 ff ff ff ff be dd         :...............
> 2c 00 00 00 50 43 49 00 53 43 53 49 00 00 00 00         ,...PCI.SCSI....
> 02 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00         ................
> 00 00 00 00 00 00 00 00 00 28                           .........(
> version: 3.0
> Extensions:
>         Fixed disk access
> Info Flags:
>         dma_boundry_error_transparent
>         write_verify
> num_default_cylinders: 0
> num_default_heads: 0
> sectors_per_track: 0
> number_of_sectors: 88bb93a
> PCI     02:01.0  channel: 0
> SCSI            id: 0  lun: 0

Ugh. Drop the ascii-fying hexdump for one. I'd also strongly encourage you 
to split the data in 'info' to separate files.

	-pat

