Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313242AbSEIOz0>; Thu, 9 May 2002 10:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313217AbSEIOzZ>; Thu, 9 May 2002 10:55:25 -0400
Received: from [199.128.236.1] ([199.128.236.1]:59142 "EHLO
	intranet.reeusda.gov") by vger.kernel.org with ESMTP
	id <S313206AbSEIOzX>; Thu, 9 May 2002 10:55:23 -0400
Message-ID: <630DA58AD01AD311B13A00C00D00E9BC05D20134@CSREESSERVER>
From: "Martinez, Michael - CSREES/ISTM" <MMARTINEZ@intranet.reeusda.gov>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>,
        "Martinez, Michael - CSREES/ISTM" <MMARTINEZ@intranet.reeusda.gov>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Anyone aware of known issues with the scsi driver in kernel-s
	mp-2 .4.2-2?
Date: Thu, 9 May 2002 10:55:41 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

THanks Richard,

and Thanks to everyone who responded. There are several suggestions I
received, things I must work on.

-mike

-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com]
Sent: Thursday, May 09, 2002 10:15 AM
To: Martinez, Michael - CSREES/ISTM
Cc: 'linux-scsi@vger.kernel.org'; 'linux-kernel@vger.kernel.org'
Subject: Re: Anyone aware of known issues with the scsi driver in
kernel-smp-2 .4.2-2?


On Thu, 9 May 2002, Martinez, Michael - CSREES/ISTM wrote:

> I'm using kernel-smp-2.4.2-2, and I'm having some problems with my
> scsi tape, which is a HP SureDat device; and using Sony DDS-3 DAT tapes.
> 
> Any sort of write and recover procedure (tar; dump; cat; dd) results in
> random byte mistakes in the recovered data. These byte mistakes always
> follow the form of being offset from the original byte, by 2.
> 
> For example, if the original byte had an octal value of 88; then the
                                           ^^^^^
FYI there is no octal value of 88, perhaps you mean hex or decimal?

> recovered byte would be 90.

A value change from 0x88 to 0x90 = 0x08, must be decimal.

> 
> A file of 12kbytes would have on average five or six of these mistakes. 
> 
> Has anyone heard of an issue with the SCSI driver that would produce this
> type of problem?
> 

My machines use SCSI tapes, both DAT and video-8, every night.
I do recoveries on the average once a week and have never
found bad data (Linux 2.4.18).

It's practically impossible for the SCSI driver(s) to change data.
Bugs could result in overwriting buffers, etc., but the data that
got spilled would have been "good".

You could have some module that is writing data somewhere it shouldn't
and corrupting buffers.

I would suggest:

(1) Remove any modules, not in use (just `rmmod` from a running machine).
Try to backup/restore some directory tree and see if it's "fixed".

(2)  If you updated from an earlier version, make sure that the user-mode
'bdflush' is not running. Periodic sync() is now done in the kernel.
I found that the user-mode sync() has some race condition that will
cause problems on a SMP machine. For instance, if you are doing a
kernel compile and you execute `sync()` from another task, the
kernel compile may error-out with 'file-not-found' errors. This
problem has been around since the internal bdflush (kflushd) was
incorporated.

This may be messing up your file-system during a tape restore. It
can also mess up your file-system without you knowing it, just
modify the init startup so it never starts bdflush.

(3)  All known tape-drives do CRC so the data coming out should be
good, but... you could have an intermittent SCSI cable-connection so
that data bit 1 is sometimes not present when it should be. That
can change some data values by 2. As a hack, just change the cable
if you have another laying around. The act of unplugging and re-plugging
SCSI cables often removes accumulated dirt or oxides that are messing
up data.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
