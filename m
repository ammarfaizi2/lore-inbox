Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSFKAWX>; Mon, 10 Jun 2002 20:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSFKAWW>; Mon, 10 Jun 2002 20:22:22 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:18950 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S316579AbSFKAWU>;
	Mon, 10 Jun 2002 20:22:20 -0400
Message-ID: <3D054248.84262C73@torque.net>
Date: Mon, 10 Jun 2002 20:20:24 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Bonin <kernel@bonin.ca>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Firewire Disks. (fwd)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Bonin wrote:
>Roberto Nibali wrote:
>>> I know there is support for "firewire" in the kernel. Is there
>>> support for "firewire" disks? If so, how do I enable it?
>> 
>> 
>> Yes, there is and it is attached to the SCSI layer via the sbp2 driver. 
>> You need following set of modules to get it working:
>> 
>> scsi_mod, sd_mod, ohci1394, raw1394, ieee1394, sbp2
>
>A lot of caddies that wrap hd's have started coming out and, as you may 
>know, USB 2.0 supports 480mbps x-fer rate (ideal).  So it's pretty 
>intreguing.
>
>Does the SCSI layer via sbp2 provide functionality for USB 2.0 (EHCI) 
>disks?

Yes, disks using USB (2.0 or 1.x) and ieee1394 protocols appear
as scsi disks in linux. Prompted by your question, I decided
to check that both are functioning in lk 2.5.21. [ide-scsi is
broken in lk 2.5.21 (worked in 2.5.20) and Martin says a fix is 
coming.]

Here are 3 "scsi" disks on my system:
$ cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST318451LW       Rev: 0003
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: FIREBALL ST3.2A  Rev:     
  Type:   Direct-Access                    ANSI SCSI revision: 06
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: MAXTOR 6 Model: L040J2           Rev: AR1.
  Type:   Direct-Access                    ANSI SCSI revision: 02

The Seagate disk is "real" scsi, the Quantum is an old IDE disk
in a ieee1394 enclosure, while the Maxtor is recent ATA disk
in a USB 2.0 enclosure. Here are the modules loaded:
$ lsmod
Module                  Size  Used by
usb-storage            69776   0 
ehci-hcd               23600   0  (unused)
sbp2                   15536   0  (unused)
ohci1394               18608   0  (unused)
ieee1394               30704   0  [sbp2 ohci1394]
usbcore                65920   1  [usb-storage ehci-hcd]

Both sd_mod and scsi_mod are built into the kernel in my system.

If I use the Maxtor in either enclosure, the streaming bandwidth
is 14 MB/sec which should be more than sufficient for most 
purposes.


One interesting development in the lk 2.5 series is driverfs.
It may give us a consistent way to show what is going on here
under the covers. It will also allow user space code to use
various hotplug alerts to load up the required modules without
user intervention. Mike Sullivan's persistent naming patch could
then place the partitions at known device names.

Doug Gilbert
