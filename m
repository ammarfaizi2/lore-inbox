Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBMSqe>; Tue, 13 Feb 2001 13:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBMSqO>; Tue, 13 Feb 2001 13:46:14 -0500
Received: from ip164-150.fli-ykh.psinet.ne.jp ([210.129.164.150]:24259 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S129027AbRBMSqD>;
	Tue, 13 Feb 2001 13:46:03 -0500
Message-ID: <3A8980CA.5A5DADB3@yk.rim.or.jp>
Date: Wed, 14 Feb 2001 03:45:31 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Ralf Oehler <ro@GDImbH.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Kernel panic: Ththththaats all folks
In-Reply-To: <200102131612.RAA26210@marvin.GDImbH.Com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My system:
> Pentium-II, 350 MHz, 64MB
> Adaptec AHA-2940A (-> aic7xxx.o)
> kernel: 2.4.0
> patch:  SGI-debugger (kdb-v1.7-2.4.0)
>
> Some more details:
> My jukebox consists of a picker device (sg.o) and some MO-drives (sd_mod.o)
> The sg.o attaches to all these devices, while sd attaches to the drives only.
> My jukebox driver registers as scsi-disk-device, moves a medium to a free drive
> (via sg), opens sd for the drive and further maps
> ( see ll_rw_blk.c: generic_make_request() ) the requests to sd.
> For testing I run more copy-processes to mounted virtual jukebox-disks
> than there are physical drives. So the picker-thread alternatingly moves the
> involved media between their storage-slots the drives while the copy-processes
> do stop-and-go.
> It works well, just until SCSI timeouts occur...
>
> The kernel-panic occurs, independently of the presence of tagged queuing, some time
> (seconds or minutes) after the occurence of disconnected timeouts for the
> SCSI-READ/WRITE commands to the MO-drives (by sd_mod.o).
> I see some messages about bus-resets in the syslog, then the kernel stops.
>
> Can anybody help ...?

I used to see kernel panic when I  used a 7 CD changer
(Nakamichi MBR-7) if I mount two CDs and
tried to access them simultaneously.
It was during 2.2.xx, and 2.3.yy development.
I can't recall what happened during 2.0.zz.

My problem with just 2 CDs mounting seems to have been
solved in the latest 2.4.1 kernel and the driver.
I use tmscsim (DC390) driver.
Admittedly, just two CDs in a seven CD changer drive
is not a heavy workload in comparison to yours.
So the bug is still lurking somewhere but is now harder
to spot by casual users.

I vaguely recall one thing.
During the earlier 2.3.1xx or even during 2.2.yy development and
debugging efforts.
some timeout values in the driver and SCSI subsystem
were tweaked to see if the change would affect
the behavior of the drive. I remember
the symptom or the frequencey of the kenrel hung
were lessened.
The hung never disappered completely, though
in my setting. (However, at certain point in
time during 2.3.1xx
development, using BusLogic Flashpoint
card and the buslogic driver
somehow eliminated the kernel panic I saw with DC390
card with tmscsim driver. So I figured that a very subtle
interaction of timeout values and such were responsible
for the problem. I tried to see if I could find the
difference of timeout values between tmscsim and buslogic
driver, but didn't follow through due to lack of time then.
My guess is that it must have been the timeout value setting
as well as the use of new and old scsi error handler code back then.)

It might be that you need to see if there are
hard-coded timeout values in aic7xxx.o and
see if they could be LENGTHENED without breaking
scsi compatibility with other devices: but you don't
have other devices on the same scsi chain, do you?

When these timeout occurs and resets are invoked,
the old scsi error handler can get into a big trouble
sometimes,  and it has been a constant irritation for
scsi users with esoteric devices such as yours,
slow-starting scanners, or CD changers like mine.

It seems that old SCSI standards never mentioned
anything about device startup time or
dead time during transition of the media into the
drive,  or for that matter, the time it takes DAT drives
to rewind the tape and so the
application and/or driver writer needs to
take care of these long silent/dead time without causing
timeout (and yet not miss the real time out from other
faster devices.)

BTW, I was pleasantly surprised to see the nicely formatted
dump of registers and such. It seems that kdb is really
useful for the type of analysis at hand!

Happy Hacking,

Chiaki Ishikawa


