Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267229AbTAHLzC>; Wed, 8 Jan 2003 06:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbTAHLzC>; Wed, 8 Jan 2003 06:55:02 -0500
Received: from mx7.mail.ru ([194.67.57.17]:46602 "EHLO mx7.mail.ru")
	by vger.kernel.org with ESMTP id <S267229AbTAHLzB>;
	Wed, 8 Jan 2003 06:55:01 -0500
From: "Andrey Borzenkov" <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Cc: "Greg Stark" <gsstark@MIT.EDU>
Subject: Re: More tests [Was: Problem with read blocking for a long time on /dev/scd1]
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Wed, 08 Jan 2003 15:03:30 +0300
Reply-To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E18WEvi-000Epy-00@f19.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've done some more tests:
>
> The problem still occurs with straight ide drivers, no ide-scsi
>
> The problem still occurs with 2.4.20-ac2
>
> I removed extraneous llseek syscalls from libdvdread, it's now reading
> purely sequentially and still failing. I doubt an llseek to the current
> location even gets through to the driver but I figured I would remove
> another variable.
> 
> Question: Does the readahead parameter in hdparm affect accesses to the
> raw /dev/hdd device? Does it affect atapi cdrom access?

I have seen the same phenomenon under slightly different conditions.

I am running Mandrake with supermount. In short, supermount fakes mounting device and then mounts real device on first access. On every file operation it checks for media change and invalidates and remounts media in this case.

In some cases, the best example being rpm -Uvh * on CD, this command lasts ages. The reason is long pause during file closing, as much as 5 seconds (in my case), so it takes very long time to examine all files. The device is pure IDE DVD-R (Creative) running in UDMA2 on i815e. I put timing information in ide-cd.c and ide.c and it shows that pause happens between ide_do_drive_cmd called from cdrom_queue_packet_command (from cdrom_check_status) and next corresponding ide_do_request (unfortunately, the log output happened inside of it, when request is already fetched).

Some strange things to observe: 

- this delay happens only during file close, while there are much more checks for media changes (every operation on supermount fs does it), the delayed ones are probably just 10% at most

- there is always a READ request being processed between ide_do_drive_cmd and ide_do_request; the actual delay happens between ide_do_drive_cmd and this READ request; I am going to trace all requests to CD_ROM to see when READ is generated

- when I try the above during relatively high disk activity, this usually works normally (i.e. without delays); OTOH when system is mostly idle I get these delays. I have pure IDE system, HD is on one channel, DVD in question on the other. I thought it may be related to DMA (packet commands are run with DMA disabled) but disabling DMA did not change anything.

The problem is old, it existed at least in 2.4.18 that shipped in Mandrake. Currently Mandrake is on 2.4.20 with the same problem.

I will do some tests to pinpoint the place where delays happen; I have not looked at ps output, but if delay happens in ide_do_request, there should not be many possibilities.

Regards

-andrej


