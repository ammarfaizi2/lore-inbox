Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWC3Pq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWC3Pq7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 10:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWC3Pq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 10:46:59 -0500
Received: from nacho.alt.net ([207.14.113.18]:7585 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S1751144AbWC3Pq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 10:46:58 -0500
Date: Thu, 30 Mar 2006 15:46:51 +0000 (GMT)
To: erich <erich@areca.com.tw>
cc: =?utf-8?B?KOW7o+WuieenkeaKgCnlronlj69P?= <billion.wu@areca.com.tw>,
       Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org,
       dax@gurulabs.com
Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken
In-Reply-To: <007701c653d7$8b8ee670$b100a8c0@erich2003>
Message-ID: <Pine.LNX.4.64.0603301542590.19680@nacho.alt.net>
References: <Pine.LNX.4.64.0603212310070.20655@nacho.alt.net>
	<007701c653d7$8b8ee670$b100a8c0@erich2003>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I confirm I saw the problem while testing with ext2 and these two patches:

   areca-raid-linux-scsi-driver.patch
   areca-raid-linux-scsi-driver-update4.patch

Did update4 change the way the driver informs the scsi subsystem about the 
dimensions of a volume, or the sector size, etc?

Chris

On Thu, 30 Mar 2006, erich wrote:
> Dear Chris Caputo,
> 
> Could you tell me about the file system of testing volume on bonnie++ ?
> Does this issue come from different driver update?
> I had done more two weeks of long time testing on three machines with bonnie++
> and iometer benchmark utility.
> I have not got this phenomena in ext3 file system and reiserfs filesystem.
> But I can reproduce this message immediately on large file "900MB" copy from
> ARECA RAID volume format with ext2 file system.
> The ext2 file system seem have this bug after linux kernel version 2.6.3.
> I do same operation at linux 2.6.3 , it works fine.
> Now I am researching the files system kernel source, I hope you can help me to
> clear up the issue that what's happen with it
> 
> Best Regartds
> Erich Chen
> ----- Original Message ----- From: "Chris Caputo" <ccaputo@alt.net>
> To: "Erich Chen" <erich@areca.com.tw>
> Sent: Wednesday, March 22, 2006 7:45 AM
> Subject: new Areca driver in 2.6.16-rc6-mm2 appears to be broken
> 
> 
> > Erich,
> >
> > The new Areca driver in 2.6.16-rc6-mm2 is broken as far as I can tell.
> >
> > I applied the Areca driver in Linux 2.6.16-rc6-mm2 to a 2.6.15.6 as
> > follows:
> >
> >  cd /usr/src
> >  wget 
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm2/broken-out/areca-raid-linux-scsi-driver.patch
> > wget
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm2/broken-out/areca-raid-linux-scsi-driver-update4.patch
> >  cd /usr/src/linux
> >  cat ../areca-raid-linux-scsi-driver.patch | patch -p1
> >  cat ../areca-raid-linux-scsi-driver-update4.patch | patch -p1
> >
> > After compiling a new 2.6.15.6 kernel with the driver I was able to boot
> > and things appeared fine until I ran a bonnie++ test.  During the test the
> > following started spewing endlessly and the system was unusable:
> >
> >  ...
> >  attempt to access beyond end of device
> >  sdb1: rw=0, want=134744080, limit=128002016
> >  attempt to access beyond end of device
> >  sdb1: rw=0, want=134744080, limit=128002016
> >  attempt to access beyond end of device
> >  sdb1: rw=0, want=134744080, limit=128002016
> >  attempt to access beyond end of device
> >  sdb1: rw=0, want=134744080, limit=128002016
> >  attempt to access beyond end of device
> >  sdb1: rw=0, want=134744080, limit=128002016
> >  attempt to access beyond end of device
> >  sdb1: rw=0, want=134744080, limit=128002016
> >  attempt to access beyond end of device
> >  sdb1: rw=0, want=134744080, limit=128002016
> >  ...
> >
> > When only "areca-raid-linux-scsi-driver.patch" is used, the system works
> > fine for bonnie++ tests and general usage.
> >
> > The system is as follows:
> >
> >  AMD Opteron 280 dual-core 2.4ghz.  Revision E6, 256KB L1, 2048KB L2.
> >  SuperMicro H8DAE (rev 1.11)
> >  8 gigabytes (4 * 2GB PC3200/DDR400 REG ECC)
> >  Areca Tekram ARC-1160ML SATAII 16-port multi-lane with 256 megs RAM
> >  Areca ARC-6120 Battery Backup Module
> >  Four (4) Seagate ST3250823AS 250GB
> >  Twelve (12) Western Digital WD2500JD 250GB
> >
> > Info on the RAID config is below.
> >
> > Please let me know how I can assist.
> >
> > Thank you,
> > Chris Caputo
> >
> > ---
> >
> > # areca rsf info
> > Num Name             Disks TotalCap  FreeCap DiskChannels       State
> > ===============================================================================
> > 1  Raid Set # 00       14 3500.0GB    0.0GB FG3456789ABCDE     Normal
> > ===============================================================================
> > GuiErrMsg<0x00>: Success.
> >
> > # areca vsf info
> > # Name             Raid# Level   Capacity Ch/Id/Lun  State
> > ===============================================================================
> > 1 ARC-1160-VOL#00    1   Raid0+1   19.0GB 00/00/00   Normal
> > 2 ARC-1160-VOL#01    1   Raid0+1 1731.0GB 00/01/00   Normal
> > ===============================================================================
> > GuiErrMsg<0x00>: Success.
> >
> > # areca disk info
> > Ch   ModelName        Serial#          FirmRev     Capacity  State
> > ===============================================================================
> > 1   ST3250823AS      4ND1JKDW         3.03         250.1GB  HotSpare
> > 2   ST3250823AS      4ND1HEKE         3.03         250.1GB  HotSpare
> > 3   ST3250823AS      4ND1DEFN         3.03         250.1GB  RaidSet
> > Member(1)
> > 4   ST3250823AS      4ND1E37B         3.03         250.1GB  RaidSet
> > Member(1)
> > 5   WDC WD2500JD-00  WD-WMAEH1416638  02.05D02     250.1GB  RaidSet
> > Member(1)
> > 6   WDC WD2500JD-00  WD-WMAEH1415477  02.05D02     250.1GB  RaidSet
> > Member(1)
> > 7   WDC WD2500JD-00  WD-WMAEH1408943  02.05D02     250.1GB  RaidSet
> > Member(1)
> > 8   WDC WD2500JD-00  WD-WMAEH1428940  02.05D02     250.1GB  RaidSet
> > Member(1)
> > 9   WDC WD2500JD-00  WD-WMAEH1416508  02.05D02     250.1GB  RaidSet
> > Member(1)
> > 10   WDC WD2500JD-00  WD-WMAEH1416317  02.05D02     250.1GB  RaidSet
> > Member(1)
> > 11   WDC WD2500JD-00  WD-WMAEH1596552  02.05D02     250.1GB  RaidSet
> > Member(1)
> > 12   WDC WD2500SD-01  WD-WMAL71480351  08.02D08     250.1GB  RaidSet
> > Member(1)
> > 13   WDC WD2500JD-00  WD-WMAEH1408933  02.05D02     250.1GB  RaidSet
> > Member(1)
> > 14   WDC WD2500JD-00  WD-WMAEH1398573  02.05D02     250.1GB  RaidSet
> > Member(1)
> > 15   WDC WD2500JD-00  WD-WMAEH1409027  02.05D02     250.1GB  RaidSet
> > Member(1)
> > 16   WDC WD2500SD-01  WD-WMAL72085064  08.02D08     250.1GB  RaidSet
> > Member(1)
> > ===============================================================================
> > GuiErrMsg<0x00>: Success. 
> 
> 
