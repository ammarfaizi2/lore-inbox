Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266576AbTAFLXQ>; Mon, 6 Jan 2003 06:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266584AbTAFLXP>; Mon, 6 Jan 2003 06:23:15 -0500
Received: from smtp04.iprimus.com.au ([210.50.76.52]:44552 "EHLO
	smtp04.iprimus.com.au") by vger.kernel.org with ESMTP
	id <S266576AbTAFLXN>; Mon, 6 Jan 2003 06:23:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Paul <krushka@iprimus.com.au>
Reply-To: krushka@iprimus.com.au
To: linux-kernel@vger.kernel.org
Subject: Fwd: File system corruption
Date: Mon, 6 Jan 2003 21:38:13 +1000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <0301062138130A.01466@paul.home.com.au>
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 06 Jan 2003 11:31:44.0133 (UTC) FILETIME=[30A01B50:01C2B577]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I sent the following email regarding a suspected bug to the IDE maintainer 
mentioned in the DOCs but haven't got a response.

Can anyone point me in the right direction here?

Thanks, Paul.

----------  Forwarded Message  ----------
Subject: File system corruption
Date: Tue, 17 Dec 2002 22:27:26 +1000
From: Paul <krushka@iprimus.com.au>
To: andre@linux-ide.org


Hi Andre,

I hope I am emailing the right person :)

I am currently having a problem with a compact flash card corrupting its
FAT16 filesystem.  The compact flash card is used in an IDE to compact flash
adaptor board.  We manufacture the board and have used this without problem
in over 100 units so far and the card functions perfectly in Windows 98/2000
and when used with other flash cards.

I have been able to determine that the corruption only appears in a certain
flash card size and manufactured after a certain period from Sandisk.  I have
others on order from other manufacturers to test this further.  I have tested
this in linux 2.4.10, 2.4.18 and 2.4.20...all with the same result.  I have
used Sandisk 32MB and 64MB cards in the past with no problems.  The lastest
batch of 32MB card we received worked correctly, the 64MB batch did not.  I
have listed the hdparm output for both 64MB cards:

Good Sandisk:

/dev/hdd:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 490/8/32, sectors = 125152, start = 0

# /sbin/hdparm -i /dev/hdd

/dev/hdd:

 Model=SanDisk SDCFB-64, FwRev=Vdg 1.23, SerialNo=06210224227
 Config={ HardSect NotMFM Removeable DTR>10Mbs nonMagnetic }
 RawCHS=490/8/32, TrkSize=0, SectSize=576, ECCbytes=4
 BuffType=DualPort, BuffSize=1kB, MaxMultSect=1, MultSect=off
 CurCHS=490/8/32, CurSects=-369098751, LBA=yes, LBAsects=125440
 IORDY=no
 PIO modes: pio0 pio1
 DMA modes:

 ============================================
 Bad Sandisk

# /sbin/hdparm /dev/hdd

/dev/hdd:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 978/4/32, sectors = 125184, start = 0

# /sbin/hdparm -i /dev/hdd

/dev/hdd:

 Model=SanDisk SDCFB-64, FwRev=Rev 3.03, SerialNo=X0409 20020924041900
 Config={ HardSect NotMFM Removeable DTR>10Mbs nonMagnetic }
 RawCHS=978/4/32, TrkSize=0, SectSize=512, ECCbytes=4
 BuffType=DualPort, BuffSize=1kB, MaxMultSect=1, MultSect=off
 CurCHS=978/4/32, CurSects=-385875967, LBA=yes, LBAsects=125184
 IORDY=no
 PIO modes: pio0 pio1
 DMA modes:
===================================

You can see that the batch of cards that cause corruption have a newer
firmware version (rev 3.03) and the reported CHS translation has changed.  I
have checked the BIOS reports the same as the hdparm programme and also that
the kernel also has the same values, they are 978/4/32 as hdparm reports.

I have tried 12 different IDE adaptors with the same error.  I have tried 2
different VIA Eden mainboards.  I tried my home system with a different
Northbridge/Southbridge (VT82C693A/VT82C686A and VT8601/VT8231) all with the
same results.

To reproduce this problem I only need to mount any compact flash card from
the new batch (we have tried over 10 different cards), write a file of any
size (even less than 200 bytes) then unmount the drive.  calling "sync"
before unmounting makes no difference.  When the drive is mounted again the
filesystem will be corrupted 100% of the time.  I use md5sum to check the
file when the drive is mounted again (fails every time).

I have an output from ./ver_linux below if that helps:

[root@paul scripts]# ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux paul.home.com.au 2.4.20 #1 Fri Dec 13 23:10:14 EST 2002 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.10r
modutils               2.4.2
e2fsprogs              1.19
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ppp_async ppp_generic slhc mga agpgart autofs 8139too
mii ipchains usb-storage scsi_mod usb-uhci usbcore

The funny thing is that I can take this same flash card (or any card from
that batch) and the same IDE adaptor and it works perfectly under Windows
98/2000 on the same machine so I assume it is a kernel problem or filesystem
problem of some sort.  Perhaps it's a bug in the compact flash that Windows
doesn't trigger?

Would you have any suggestion of what I can try next? or perhaps the
appropriate person to email (perhaps vfat filesystem maintainer)?

Kind Regards,

Paul Krushka

-------------------------------------------------------
