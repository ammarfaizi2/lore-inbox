Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbTABLNI>; Thu, 2 Jan 2003 06:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbTABLNH>; Thu, 2 Jan 2003 06:13:07 -0500
Received: from mx8.mail.ru ([194.67.57.18]:1544 "EHLO mx8.mail.ru")
	by vger.kernel.org with ESMTP id <S261346AbTABLNG>;
	Thu, 2 Jan 2003 06:13:06 -0500
Date: Thu, 2 Jan 2003 12:18:26 +0100 (CET)
From: Guennadi Liakhovetski <lyakh@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops 2.4.20 + ppp + ide-scsi / usb
In-Reply-To: <Pine.LNX.4.44.0301012306380.3378-100000@poirot.grange>
Message-ID: <Pine.LNX.4.44.0301021137001.10593-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aha! Here's what happened:
</var/log/messages>
...
Jan  1 21:08:20 poirot pppd[1223]: sent [LCP EchoReq id=0xf magic=0x36c1d42a]
Jan  1 21:08:20 poirot pppd[1223]: rcvd [LCP EchoRep id=0xf magic=0xa654c63c]
Jan  1 21:08:32 poirot kernel: scsi : aborting command due to timeout : pid 11654, scsi1, channel 0, id 0, lun 0 Read (10) 00 00 00 00 00 00 00 02 00
Jan  1 21:08:32 poirot kernel: hdc: timeout waiting for DMA
Jan  1 21:08:32 poirot kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Jan  1 21:08:32 poirot kernel: hdc: status timeout: status=0xc0 { Busy }
Jan  1 21:08:32 poirot kernel: hdc: drive not ready for command
Jan  1 21:08:50 poirot pppd[1223]: sent [LCP EchoReq id=0x10 magic=0x36c1d42a]
Jan  1 21:08:50 poirot pppd[1223]: rcvd [LCP EchoRep id=0x10 magic=0xa654c63c]

And that's it. Then came the fatal Oops, described in the previous post.
Yeah, after IDE-errors there were at least another 18 seconds, but,
anyway, might be related? And here's one more fragment from messages, that
seem to show another lock-up:

Dec 23 20:46:32 poirot kernel:  I/O error: dev 0b:00, sector 387984
Dec 23 20:47:40 poirot su: (to root) lyakh on /dev/tty2
Dec 23 20:47:40 poirot su: pam_unix2: session started for user root, service su
Dec 23 20:49:08 poirot kernel:  I/O error: dev 0b:01, sector 387984
Dec 23 20:50:00 poirot /USR/SBIN/CRON[2313]: (root) CMD ( /usr/lib/sa/sa1      )
Dec 23 20:59:00 poirot /USR/SBIN/CRON[2318]: (root) CMD ( rm -f /var/spool/cron/lastrun/cron.hourly)
Dec 23 21:00:00 poirot /USR/SBIN/CRON[2322]: (root) CMD ( /usr/lib/sa/sa1      )
Dec 23 21:06:16 poirot kernel: scsi : aborting command due to timeout : pid 9333, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00 00 02 00
Dec 23 21:06:16 poirot kernel: hdc: timeout waiting for DMA
Dec 23 21:06:16 poirot kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Dec 23 21:06:16 poirot kernel: hdc: status timeout: status=0xc0 { Busy }
Dec 23 21:06:16 poirot kernel: hdc: drive not ready for command
Dec 23 21:06:41 poirot kernel: scsi : aborting command due to timeout : pid 9333, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00 00 02 00
Dec 23 21:06:41 poirot kernel: SCSI host 0 abort (pid 9333) timed out - resetting
Dec 23 21:06:41 poirot kernel: SCSI bus is being reset for host 0 channel 0.
Dec 23 21:06:41 poirot kernel: scsi : aborting command due to timeout : pid 9333, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00 00 02 00
Dec 23 21:06:41 poirot kernel: SCSI host 0 abort (pid 9333) timed out - resetting
Dec 23 21:06:41 poirot kernel: SCSI bus is being reset for host 0 channel 0.
Dec 23 21:06:42 poirot kernel: scsi : aborting command due to timeout : pid 9333, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00 00 02 00
Dec 23 21:06:42 poirot kernel: SCSI host 0 abort (pid 9333) timed out - resetting
Dec 23 21:06:42 poirot kernel: SCSI bus is being reset for host 0 channel 0.
Dec 23 21:06:42 poirot kernel: scsi : aborting command due to timeout : pid 9333, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00 00 02 00
Dec 23 21:06:42 poirot kernel: SCSI host 0 abort (pid 9333) timed out - resetting
Dec 23 21:06:42 poirot kernel: SCSI bus is being reset for host 0 channel 0.
Dec 23 21:06:43 poirot kernel: scsi : aborting command due to timeout : pid 9333, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00 00 02 00
Dec 23 21:06:43 poirot kernel: SCSI host 0 abort (pid 9333) timed out - resetting
Dec 23 21:06:43 poirot kernel: SCSI bus is being reset for host 0 channel 0.
Dec 23 21:06:43 poirot kernel: scsi : aborting command due to timeout : pid 9333, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00 00 02 00
Dec 23 21:06:43 poirot kernel: SCSI host 0 abort (pid 9333) timed out - resetting
Dec 23 21:06:43 poirot kernel: SCSI bus is being reset for host 0 channel 0.
Dec 23 21:06:44 poirot kernel: scsi : aborting command due to timeout : pid 9333, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00 00 02 00
Dec 23 21:06:44 poirot kernel: SCSI host 0 abort (pid 9333) timed out - resetting
Dec 23 21:06:44 poirot kernel: SCSI bus is being reset for host 0 channel 0.
Dec 23 21:06:44 poirot kernel: scsi : aborting command due to timeout : pid 9333, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00 00 02 00
Dec 23 21:06:44 poirot kernel: SCSI host 0 abort (pid 9333) timed out - resetting
Dec 23 21:06:44 poirot kernel: SCSI bus is being reset for host 0 channel 0.
Dec 23 21:06:45 poirot kernel: scsi : aborting command due to timeout : pid 9333, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00 00 02 00
Dec 23 21:06:45 poirot kernel: SCSI host 0 abort (pid 9333) timed out - resetting
Dec 23 21:06:45 poirot kernel: SCSI bus is being reset for host 0 channel 0.
Dec 23 21:06:45 poirot kernel: scsi : aborting command due to timeout : pid 9333, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00 00 02 00
Dec 23 21:06:45 poirot kernel: SCSI host 0 abort (pid 9333) timed out - resetting
Dec 23 21:06:45 poirot kernel: SCSI bus is being reset for host 0 channel 0.
Dec 23 21:06:46 poirot kernel: scsi : aborting command due to timeout : pid 9333, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00 00 02 00
Dec 23 21:06:46 poirot kernel: SCSI host 0 abort (pid 9333) timed out - resetting
Dec 23 21:06:46 poirot kernel: SCSI bus is being reset for host 0 channel 0.
Dec 23 21:06:46 poirot kernel: hdc: ATAPI reset timed-out, status=0xd0

Thanks
---
Guennadi Liakhovetski



