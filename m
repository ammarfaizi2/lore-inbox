Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUAYSt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 13:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265176AbUAYSt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 13:49:58 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:9478 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265175AbUAYStx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 13:49:53 -0500
To: Marc Mongenet <Marc.Mongenet@freesurf.ch>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.4.25pre7 - cannot mount 128MB vfat fs on Minolta camera
References: <4013D155.3080900@freesurf.ch>
	<87y8rw2eyy.fsf@devron.myhome.or.jp> <40140221.40901@freesurf.ch>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 26 Jan 2004 03:48:55 +0900
In-Reply-To: <40140221.40901@freesurf.ch>
Message-ID: <87isiz3luw.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is this known problem? Any idea?

Thanks.

Marc Mongenet <Marc.Mongenet@freesurf.ch> writes:

> OGAWA Hirofumi wrote:
> > Marc Mongenet <Marc.Mongenet@freesurf.ch> writes:
> >
> >>Hi, I have a Minolta DiMAGE F100 camera and two memory cards,
> >>a 16 MB and a 128 MB.
> >>With kernel 2.2.25 I can mount the 16 MB but not the 128 MB.
> >>With kernel 2.4.16 to 2.4.25pre6 I can mount the 128 MB but not the 16 MB.
> >>With kernel 2.4.25pre7 I can mount the 16 MB but not the 128 MB.
> >>
> >>There is probably something special with the filesystem used by Minolta
> >>because I have to format it with the camera to be recognized by the camera.
> > What error did you get? Please send output of dmesg and first
> > 256KB of 128MB card.
> 
> Well, 10 minutes after finally reporting the problem, I discovered that
> it is different than described above...
> 
> So, I can mount the 16 MB card or the 128 MB card with any kernel,
> BUT I have to reboot the system when I change the cards. Example:

Thanks for good testing.

First of /dev/sda1 contains the valid FAT format. But it appears on
offset of 0x5000.

0000000    0000    0000    0000    0000    0000    0000    0000    0000
*
0005000    00eb    2090    2020    2020    2020    0020    2002    0001
0005010    0002    0002    f800    001f    0020    0008    0061    0000
0005020    d39f    0003    0080    0029    0000    4e00    204f    414e
0005030    454d    2020    2020    4146    3154    2036    2020    0000
0005040    0000    0000    0000    0000    0000    0000    0000    0000
*
00051f0    0000    0000    0000    0000    0000    0000    0000    aa55
0005200    fff8    ffff    ffff    ffff    0000    0000    0000    0000

0x5000-0x5200 is the valid FAT format for 128MB.  These must be on
offset of 0x0-0x200.

> 1) boot the system
> 
> 2) turn on camera with 16 MB card
> Jan 25 18:35:39 kameha kernel: hub.c: new USB device 00:1d.1-1, assigned address 5
> 
> 3)
> # cat /etc/fstab | grep f100
> /dev/sda1       /f100           vfat    users,noauto            0       0
> # mount /f100
> # ls /f100
> dcim
> # umount /f100
> #
> 
> 4) turn off camera
> Jan 25 18:38:28 kameha kernel: usb.c: USB disconnect on device 00:1d.1-1 address 5
> 
> 5) put 128 MB card inside, turn on again
> Jan 25 18:39:00 kameha kernel: hub.c: new USB device 00:1d.1-1, assigned address 6
> 
> 6)
> # mount /f100
> Jan 25 18:39:11 kameha kernel: FAT: bogus logical sector size 0
> Jan 25 18:39:11 kameha kernel: VFS: Can't find a valid FAT filesystem on dev 08:01.
> mount: wrong fs type, bad option, bad superblock on /dev/sda1,
>         or too many mounted file systems
> 
> 7)
> # dmesg

[...]

> i810_audio: Connection 0 with codec id 2
> ac97_codec: AC97 Audio codec, id: ADS116 (Unknown)
> i810_audio: AC'97 codec 2 supports AMAP, total channels = 2
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> host/usb-uhci.c: $Revision: 1.275 $ time 13:15:45 Jan 25 2004
> host/usb-uhci.c: High bandwidth mode enabled
> PCI: Setting latency timer of device 00:1d.0 to 64
> host/usb-uhci.c: USB UHCI at I/O 0xe800, IRQ 16
> host/usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> PCI: Setting latency timer of device 00:1d.1 to 64
> host/usb-uhci.c: USB UHCI at I/O 0xe880, IRQ 19
> host/usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 2 ports detected
> PCI: Setting latency timer of device 00:1d.2 to 64
> host/usb-uhci.c: USB UHCI at I/O 0xec00, IRQ 18
> host/usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 3
> hub.c: USB hub found
> hub.c: 2 ports detected
> host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> Initializing USB Mass Storage driver...
> usb.c: registered new driver usb-storage
> USB Mass Storage support registered.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 8192 buckets, 64Kbytes
> TCP: Hash tables configured (established 262144 bind 65536)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 104k freed
> hub.c: new USB device 00:1d.0-2, assigned address 2
> usb.c: USB device 2 (vend/prod 0x46d/0xc00e) is not claimed by any active driver.
> hub.c: new USB device 00:1d.1-1, assigned address 2
> scsi1 : SCSI emulation for USB Mass Storage devices
>    Vendor: MINOLTA   Model: DiMAGE F100       Rev: 1.00
>    Type:   Direct-Access                      ANSI SCSI revision: 02
> Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
> SCSI device sda: 29120 512-byte hdwr sectors (15 MB)
> sda: Write Protect is off
>   sda: sda1
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 2
> eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> usb.c: USB disconnect on device 00:1d.1-1 address 2
> hub.c: new USB device 00:1d.1-1, assigned address 3
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 3
> FAT: bogus logical sector size 0
> VFS: Can't find a valid FAT filesystem on dev 08:01.
> FAT: bogus logical sector size 0
> VFS: Can't find a valid FAT filesystem on dev 08:01.
> usb.c: USB disconnect on device 00:1d.1-1 address 3
> hub.c: new USB device 00:1d.1-1, assigned address 4
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 4
> FAT: bogus logical sector size 0
> VFS: Can't find a valid FAT filesystem on dev 08:01.
> usb.c: USB disconnect on device 00:1d.1-1 address 4
> hub.c: new USB device 00:1d.1-1, assigned address 5
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 5
> usb.c: USB disconnect on device 00:1d.1-1 address 5
> hub.c: new USB device 00:1d.1-1, assigned address 6
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 6
> FAT: bogus logical sector size 0
> VFS: Can't find a valid FAT filesystem on dev 08:01.
> FAT: bogus logical sector size 0
> VFS: Can't find a valid FAT filesystem on dev 08:01.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
