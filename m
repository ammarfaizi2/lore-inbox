Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129204AbRBNULe>; Wed, 14 Feb 2001 15:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRBNULZ>; Wed, 14 Feb 2001 15:11:25 -0500
Received: from ns.arraycomm.com ([199.74.167.5]:10427 "HELO
	bastion.arraycomm.com") by vger.kernel.org with SMTP
	id <S129108AbRBNULH>; Wed, 14 Feb 2001 15:11:07 -0500
Message-Id: <5.0.2.1.2.20010214115941.02471bb8@pop.arraycomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Wed, 14 Feb 2001 12:09:39 -0800
To: linux-kernel@vger.kernel.org
From: Jasmeet Sidhu <jsidhu@arraycomm.com>
Subject: IDE DMA Problems...system hangs
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

I am attaching my previous email for additional info.  Now I am using 
kernel 2.4.1-ac12 and these problems have not gone away.

Anybody else having these problems with a ide raid 5?

The Raid 5 performance should also be questioned..here are some number 
returned by hdparam

/dev/hda -    IBM DLTA 20GB (ext2)
/dev/md0 - 8 IBM DLTA 45GB (Reiserfs)

[root@bertha hdparm-3.9]# ./hdparm -t /dev/hda
/dev/hda:
Timing buffered disk reads:  64 MB in  2.36 seconds = 27.12 MB/sec

[root@bertha hdparm-3.9]# ./hdparm -t /dev/md0
/dev/md0:
Timing buffered disk reads:  64 MB in 22.16 seconds =  2.89 MB/sec

Is this to be expected?  This much performance loss?  Anybody else using 
IDE raid, I would really appreciate your input on this setup.

Here is the log from syslog

Feb 13 05:23:27 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Feb 13 05:23:27 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
BadCRC }
Feb 13 05:23:28 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Feb 13 05:23:28 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
BadCRC }
Feb 13 05:23:28 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Feb 13 05:23:28 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
BadCRC }
Feb 13 05:23:28 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Feb 13 05:23:28 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
BadCRC }
Feb 13 05:23:33 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Feb 13 05:23:33 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
BadCRC }
...
Feb 13 08:47:48 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Feb 13 08:47:48 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
BadCRC }
...
Feb 13 09:54:07 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Feb 13 09:54:07 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
BadCRC }
...
Feb 13 12:10:43 bertha kernel: hds: dma_intr: bad DMA status
Feb 13 12:10:43 bertha kernel: hds: dma_intr: status=0x50 { DriveReady 
SeekComplete }
Feb 13 12:12:22 bertha kernel: hdg: timeout waiting for DMA
Feb 13 12:12:22 bertha kernel: ide_dmaproc: chipset supported 
ide_dma_timeout func only: 14
Feb 13 12:12:22 bertha kernel: hdg: irq timeout: status=0x50 { DriveReady 
SeekComplete }
Feb 13 12:12:42 bertha kernel: hdg: timeout waiting for DMA
Feb 13 12:12:42 bertha kernel: ide_dmaproc: chipset supported 
ide_dma_timeout func only: 14
Feb 13 12:12:42 bertha kernel: hdg: irq timeout: status=0x50 { DriveReady 
SeekComplete }
Feb 13 12:13:02 bertha kernel: hdg: timeout waiting for DMA
Feb 13 12:13:02 bertha kernel: ide_dmaproc: chipset supported 
ide_dma_timeout func only: 14
Feb 13 12:13:02 bertha kernel: hdg: irq timeout: status=0x50 { DriveReady 
SeekComplete }
Feb 13 12:13:12 bertha kernel: hdg: timeout waiting for DMA
Feb 13 12:13:12 bertha kernel: ide_dmaproc: chipset supported 
ide_dma_timeout func only: 14
Feb 13 12:13:12 bertha kernel: hdg: irq timeout: status=0x50 { DriveReady 
SeekComplete }
Feb 13 12:13:12 bertha kernel: hdg: DMA disabled
Feb 13 12:13:12 bertha kernel: ide3: reset: success	<------- * SYSTEM HUNG 
AT THIS POINT *
Feb 13 23:31:13 bertha syslogd 1.3-3: restart.



--------------------------------------------------
To: linux-kernel@vger.kernel.org
Subject: DMA blues... (Raid5 + Promise ATA/100)


I have a software raid setup using the latest kernel, but the system keeps 
crashing.

Each drive is connected to the respective ide port via ATA100 capable 
cables.  Each drive is a master..no slaves.  The configuration is that 
/dev/hdc is a hot spare and /dev/hd[e,g,i,k,m,o,q,s] are all setup as raid 
5.  These are all 75GB drives and are recognized as such.

I have searched the linux-kernel archives and saw many posts addressing the 
problems that I was experiencing, namely the freezing caused by the code in 
the body of delay_50ms() in drivers/ide/ide.c.  This was fixed in the 
current patch and as discussed earlier on the linux-kernel mailing list by 
using mdelay(50).  This fixed the problems to some extent, the system 
seemed very reliable and I did not get a single "DriveStatusError BadCRC" 
or a "DriveReady SeekComplete Index Error" for a while.  But after I had 
copied  a large amount of data to the raid, about 17GB, the system crashed 
completely and could only be recovered by a cold reboot.  Before using the 
latest patches, the system would usually crash after about 4-6GB of data 
had been moved.  Here are the log entries...

Feb 12 06:41:12 bertha kernel: hdo: dma_intr: status=0x53 { DriveReady 
SeekComplete Index Error }
Feb 12 06:41:12 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
BadCRC }
Feb 12 06:45:42 bertha kernel: hdo: timeout waiting for DMA
Feb 12 06:45:42 bertha kernel: hdo: ide_dma_timeout: Lets do it again!stat 
= 0x50, dma_stat = 0x20
Feb 12 06:45:42 bertha kernel: hdo: irq timeout: status=0x50 { DriveReady 
SeekComplete }
Feb 12 06:45:42 bertha kernel: hdo: ide_set_handler: handler not null; 
old=c01d0710, new=c01dac70
Feb 12 06:45:42 bertha kernel: bug: kernel timer added twice at c01d0585.
Feb 12 09:13:15 bertha syslogd 1.3-3: restart.

Let me know If I should post any additional information that might help in 
troubleshooting.  Is this a possible issue with the kernel code or is this 
a problem with hardware?  Any help is appreciated...

- Jasmeet Sidhu

Some other info that might help:

[root@bertha /root]# uname -a
Linux bertha 2.4.1-ac9 #1 Mon Feb 12 02:43:08 PST 2001 i686 unknown

Patches Applied to Kernel 2.4.1:
	1) ide.2.4.1-p8.all.01172001.patch
	2) patch-2.4.1-ac9

Asus A7V VIA KT133 and Onboard Promise ATA100 Controller (PDC20267)
1GHz AMD Thunderbird Athalon Processor
Four Promise PCI ATA100 Controllers (PDC20267)
Netgear GA620 Gigabit Ethernet Card

Boot Drive (Root + Swap)
hda: IBM-DTLA-307020, ATA DISK drive

Raid 5 Drives:
hdc: IBM-DTLA-307075, ATA DISK drive	*SPARE*
hde: IBM-DTLA-307075, ATA DISK drive
hdg: IBM-DTLA-307075, ATA DISK drive
hdi: IBM-DTLA-307075, ATA DISK drive
hdk: IBM-DTLA-307075, ATA DISK drive
hdm: IBM-DTLA-307075, ATA DISK drive
hdo: IBM-DTLA-307075, ATA DISK drive
hdq: IBM-DTLA-307075, ATA DISK drive
hds: IBM-DTLA-307075, ATA DISK drive 

