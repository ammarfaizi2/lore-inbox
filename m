Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbSJADcS>; Mon, 30 Sep 2002 23:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261466AbSJADcS>; Mon, 30 Sep 2002 23:32:18 -0400
Received: from ausadmmsrr501.aus.amer.dell.com ([143.166.83.88]:21775 "HELO
	AUSADMMSRR501.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S261464AbSJADcP>; Mon, 30 Sep 2002 23:32:15 -0400
X-Server-Uuid: ff595059-9672-488a-bf38-b4dee96ef25b
Message-ID: <20BF5713E14D5B48AA289F72BD372D68C1E8F5@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: mochel@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: RE: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
Date: Mon, 30 Sep 2002 22:37:37 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 1187C70B1600824-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat, thanks for the feedback and changes, I appreciate it!

> Don't use struct device for the firmware objects. They're not really
> devices; they're another type of entity that has some sort of magic 
> ia32 voodoo relationship with real devices. 

Ahh, yes, it's not the right abstraction, just the easiest for this pass.
I'll look at how ACPI does it and make my own object type.  I was wondering
how to get rid of the superfluous 'power' attribute I didn't need...

> > $ cat int13_dev80/host_bus
> > PCI     02:01.0  channel: 0
> 
> How about a symlink to the bus's directory? Or the PCI device 
> that is the controller? 

Ok.

> > $ cat int13_dev80/interface
> > SCSI            id: 0  lun: 0
> 
> And, a symlink to the device itself? I liked it better the 
> way you had it before :)

Can I have both? :-)  (I hadn't implemented the symlink before, just faked
it, but I definitely want a symlink, needed the stuff exported to do it
right - thanks!}

> Ugh. Drop the ascii-fying hexdump for one.

I've been over this with Greg privately.  I moved it to raw_data, separate,
but there.  I know of only one BIOS that implements the spec right, and that
is pre-release, because I could say "see, here's what you're returning, it's
wrong these 4 ways..." in a language the BIOS guys understand - the raw
hexdump of the return struct.  This will be critical to getting the changes
required to be useful ubiquitous.

> I'd also strongly encourage you to
> split the data in 'info' to separate files.

Yep, done, with tests such that if the attribute is invalid or for some
reason shouldn't exist, it doesn't get created.  The default* files for
example - if the bios puts 0s there, they don't get made.  Likewise if the
PCI / SCSI info isn't given by bios, those don't get made either.

Here's my tree now.
.
|-- bus
|   `-- system
|       |-- devices
|       |   |-- int13_dev80 -> ../../../root/bios/int13_dev80
|       |   |-- int13_dev81 -> ../../../root/bios/int13_dev81
|       `-- drivers
|           |-- edd
`-- root
    |-- bios
    |   |-- int13_dev80
    |   |   |-- default_cylinders
    |   |   |-- default_heads
    |   |   |-- default_sectors_per_track
    |   |   |-- raw_data
    |   |   |-- extensions
    |   |   |-- host_bus
    |   |   |-- info_flags
    |   |   |-- interface
    |   |   |-- name
    |   |   |-- power
    |   |   |-- sectors
    |   |   `-- version
    |   |-- name
    |   `-- power

$ cat default_cylinders
0x0

$ cat default_heads
0x0

$ cat default_sectors_per_track
0x0

$ cat raw_data
int 13h fn 48h return struct:

1e 00 09 00 00 00 00 00 00 00 00 00 00 00 00 00         ................
3a b9 8b 08 00 00 00 00 00 02 ff ff ff ff be dd         :...............
2c 00 00 00 50 43 49 00 53 43 53 49 00 00 00 00         ,...PCI.SCSI....
02 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00         ................
00 00 00 00 00 00 00 00 00 28                           .........(

Warning: Spec violation.  Key should be 0xBEDD, is 0xDDBE
Warning: Spec violation.  Padding should be 0x20, is 0x00.

$ cat extensions
Fixed disk access

$ cat host_bus
PCI     02:01.0  channel: 0

$ cat info_flags
DMA boundry error transparent
write verify

$ cat interface
SCSI            id: 0  lun: 0

$ cat name
BIOS int 13h device 80h

$ cat power
0

$ cat sectors
0x88bb93a

$ cat version
0x30


I may try walking the disk class device list for matches rather than the
individual bus type lists - would be slightly faster and possibly less
intrusive.  That's a helpful abstraction for me.

My current stuff is in BK at http://mdomsch.bkbits.net/linux-2.5-edd.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

