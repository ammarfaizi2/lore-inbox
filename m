Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbTH2QRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbTH2QQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:16:28 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:28061 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id S261396AbTH2QOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:14:19 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200308291611.h7TGBv6j010283@wildsau.idv.uni.linz.at>
Subject: Re: usb-storage: how to ruin your hardware(?)
In-Reply-To: <bin9ne$u7n$1@tangens.hometree.net>
To: hps@intermeta.de
Date: Fri, 29 Aug 2003 18:11:57 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Back it up:
> dd if=/dev/sda of=/tmp/save bs=512 count=<number of blocks on your flash disk>

that was exactly the first thing I did when I got the exchange-flashdisk :->
 
> Clean it:
> dd if=/dev/zero of=/dev/sda bs=512 count=100
> 
> See what happens. If it does not work any longer, we can take a peek
> at the backup (especially the first few sectors).

overwriting the drive with zeroes doesn't harm it. but in the meantime,
I found out how I managed to confuse the drive. as I wrote in a previous
email, I tried to make the drive look like it has a "real partition table",
I just copied the one from /dev/hda. Then, I did an mke2fs. Of course,
my harddisk is larger then the flashdisk, but I expected an error-message
and not the behaviour I see. So, one can say, trying to access the drive
beyond its physical limits "ruins" it. But it's always possible to repair
such a drive with the vendor supplied formating utility, which is windows
only, which is why I didn't notice it until three days ago. (First time I
use such a thing).

so, I know now how to reliably "ruin" the drive:
  o fdisk /dev/sda
  o go to expert menu
  o change number of cylinders to 2048. the drive only has 1024.
  o make a partition with 1-2048 cylinders.
  o mke2fs this partition.

I know this is kinda useless. But I would expect getting errors from
the drive in case it tries to access memory not present, instead of
just shutting down. This also applies to the format-process: instead
of saying "error", formating will result in confusion of the machine.
Instead of getting an error-message, the usb-layer will experience
timeouts in usb_bulk_sumit(sp?). Two kernel processes, an [usb] and a
 [scsi]-module, will be in state D(efunct). The system load will climb
up to 2, eventually 3. Unplugging the USB-Stick won't help either,
but instead, the kernel-log will be flooded with usb-interrupt messages
(even though no usb-device present). In this state, one can only reboot
the machine.

After rebooting (or putting the flaskdisk into a different computer),
the "ruined" flashdrive doesn't react to simple scsi-commands anymore:

(I just stick the drive into the USB-slot):

root@clio# dmesg
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08
Info fld=0xa00 (nonstd), Current sd00:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
sda : block size assumed to be 512 bytes, disk size 1GB.
sda: test WP failed, assume Write Enabled
 sda: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
 unable to read partition table
 I/O error: dev 08:00, sector 0
Device 08:30 not ready.
 I/O error: dev 08:30, sector 0
Device 08:30 not ready.
 I/O error: dev 08:30, sector 0

but no problem, as stated above, the vendor-formating utility will
bring the flashdisk back to live.

If you are interested, I can try to capture what happens when formating
the drive beyond its physical limits. I know the saying "garbage in,
garbage out", but probably im a bit puzzled that this makes the
machine unusable. I wonder if the never-ending printing of
usb-interrupt-messages, alltough no usb-device present, is the correct
behaviour or if there's something missing in the error-handling?

best regards,
h.rosmanith





