Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270988AbTG1Upp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270977AbTG1Upl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:45:41 -0400
Received: from [217.157.19.70] ([217.157.19.70]:12559 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S271104AbTG1UnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:43:10 -0400
Date: Mon, 28 Jul 2003 22:43:08 +0200 (CEST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: 100-Watt Puppeteer -- 100-Watt Puppeteer <jtc@bmnetwerks.net>,
       =?ISO-8859-2?Q?G=E1l_Viktor?= <galv@mit.bme.hu>,
       Jonas Lundgren <neonman@linuxmail.org>,
       Patrick Scharrenberg <pittipatti@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Silicon Image SiI3112 SATA software RAID driver
Message-ID: <Pine.LNX.4.40.0307282157090.15787-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You have all written to me over the last month or two about the Silicon
Image 3112 SATA RAID controller (I posted some mails on the kernel mailing
list about this).

I haven't been looking at this for a while but I can summarize what I have
found out:

1) As some others suggested on the list, the problem with very slow
transfer and timeouts if you try to enable DMA, can be fixed by the
following lines in an appropriate rc file:

  hdparm -X66 -d1 /dev/hda
  echo "max_kb_per_request:15" > /proc/ide/hdX/settings
  (repeat for both drives, e.g. hde and hdg).

2) The Medley RAID driver from Arjan van de Ven is not working. It is
based on a copy of the Promise RAID driver, but they apparantly use
different structures or at least some different magic numbers, even though
the superblock seems to be in the same place and some of the fields seem
to be the same (like stride length).

I have made the driver work on my own system by changing the detection of
the RAID "superblocks" to look for some hardcoded information that happens
to be true for my drives.

There is no point in distributing this patch since it depends on the
serial number of my drive being in that location and I am fairly sure
there is a better way to detect this (ideally the detection should check
the serial number of the drive against this info as an extra check that
the RAID superblock is valid).

Also I am not sure how Medley RAID deals with disks of different sizes, if
it is done in the same way as for the Promise RAID or not. I don't have
time to test this for different size disks so I'll just assume it does
when fixing the driver. Also I am only using the Striped functionality not
the duplicate one so if you are using this - sorry, you're on your own.

In order to produce a proper patch for this driver I'll need some
information from other people who are using this software RAID in order to
reverse engineer their superblock and figure out what is magic numbers
and what is configuration data.

So if you are using this configuration (ie. using a striped set of two
identical drives (in Windows)) and you want to help getting it to work in
Linux, could you please mail me with the following information (in the
following I'm assuming that hde and hdg are your SATA IDE disks, otherwise
change it, and hdX means do it for both the disks) (please label each
piece of info with the command that gave it!):

- do these for each drive:
- info about the disks
cat /proc/ide/hdX/model
cat /proc/ide/hdX/geometry
cat /proc/ide/hdX/identify

- I need to find out where the Silicon Image superblock and get a hexdump of it. You need to do this for both disks in the array:

The superblock is somewhere on the last part of the disk after the
last partition, which means it's probably in the last 16k sectors (1
cylinder = 255*63 sectors in LBA). So take the number from
/proc/ide/hdX/capacity above and subtract 16k, eg. if capacity was
160086528 you get 160086528-16384=160070144.

Then do:
  dd if=/dev/hde of=hde_superblock bs=512 seek=160070144

It will copy the last 8MB of the disk to the file.

Now create a hexdump of the file:
  hexdump -C hde_superblock > hde_superblock.hex

I know that the Silicon Image software stores the model name of the
drive in its superblock, so open the file and search for that (this is
the one you got from /proc/ide/hdX/model). When you find it copy the
whole 4KB region where it appears to a textfile that you send to me
(i.e. starting from xxxxx000 xxxxxff0). Repeat this as there may be
multiple instances of the superblock.

- finally please reboot the machine and go into the Silicon Image RAID
BIOS, and copy down all the values from the striped RAID set settings
(e.g. stride length, total sectors etc.) - you have to do this by hand,
sorry no cut and paste in the bios :)..

Please collect all this information and mail it to me.

If a couple of you with different disks does all of this I guess it
will be fairly easy to create a generic patch.

Regards,

Thomas Horsten
Thomas@Horsten.com

