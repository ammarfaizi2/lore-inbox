Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWBXERK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWBXERK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 23:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWBXERJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 23:17:09 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:30124 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932534AbWBXERI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 23:17:08 -0500
In-Reply-To: <b637ec0b0602230042s1736ed73lb54022a3dae70a0d@mail.gmail.com>
References: <b637ec0b0602230042s1736ed73lb54022a3dae70a0d@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <765FD537-0E30-4EF7-8297-46ECEDCED3E7@ieee.org>
Cc: "kernel list" <linux-kernel@vger.kernel.org>,
       usb-storage@lists.one-eyed-alien.net, mdharm-usb@one-eyed-alien.net,
       linux-usb-users@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [usb-storage] Problems with USB MMC/SD card reader
Date: Thu, 23 Feb 2006 20:17:00 -0800
To: "Fabio Comolli" <fabio.comolli@gmail.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Feb 23 08:44:16 kepler kernel: SCSI device sdb: 1988608 512-byte  
hdwr sectors (1018 MB)
 > ...
 > Feb 23 08:44:16 kepler kernel: SCSI device sdb: 1988608 512-byte  
hdwr sectors (1018 MB)

Is stuttering the log of max Lba normal?  I think I remember yes?

 > but immediately after that the logs get flooded by error messages:
 > ...
 > Feb 23 08:44:18 kepler kernel: sdb: Current: sense key=0x3
 > Feb 23 08:44:18 kepler kernel:     ASC=0x11 ASCQ=0x0
 > Feb 23 08:44:18 kepler kernel: Info fld=0x1e51f9
 > Feb 23 08:44:18 kepler kernel: end_request: I/O error, dev sdb,  
sector 1987065
 > Feb 23 08:44:18 kepler kernel: Buffer I/O error on device sdb1,  
logical block 248352
 > and so on until I disconnect the device.

Ick.

x 3 11 = SK ASC from a Scsi device is a claim that Ecc is saying one  
or more bits of the data read are wrong, as if your flash media were  
wearing out.  Here above we were told max Lba = 1988608 - 1 =  x1E57FF.

"Info fld" is probably kmesg-ese meaning sense bytes 3:4:5:6 echoed  
when byte 0 mask x80 set, i.e., the Lba in error.  In this snippet of  
log we have:

x 3 11 00 1E51F9
x 3 11 00 1E51F9
x 3 11 00 1E5271
x 3 11 00 1E5271
x 3 11 00 1E5271

This isn't a consistently repeated log - our host & device together  
haven't livelocked in one spot - instead they have reported the first  
two of a burst of two or more errors that are being tried 2 or 3 or N  
times.

 > ... works perfecly on the same machine in Windows XP ...

Might Linux differ from Windows by failing early by design if the  
last blocks are unreliable?

I see we have reason to believe Windows can read data from this card  
thru this reader without error.  Do we also have reason to believe  
Windows can read all blocks correctly without error?

Have we looked at the event log in Windows?  I mean the one near the  
Disk Manager and Device Manager, that divides into App, Security, and  
System.  x 3 11 complaints from the device often show up there.  To  
see recent events, you can sort by timestamp or clear before  
experimenting.

If I were you, I'd next try plugging in without automount and then a  
dd, both in Linux and in the Windows patched to include dd, to see if  
those dd agree that all the bits read without error.

I'd expect dd reports failed reads in both Linux and Windows, until I  
had reason to think otherwise, like an evil root cause for the  
stuttered log of max Lba.
