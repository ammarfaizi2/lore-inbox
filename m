Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287488AbSA0CHe>; Sat, 26 Jan 2002 21:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287490AbSA0CHY>; Sat, 26 Jan 2002 21:07:24 -0500
Received: from wsip68-14-236-254.ph.ph.cox.net ([68.14.236.254]:21153 "EHLO
	mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S287488AbSA0CHS>; Sat, 26 Jan 2002 21:07:18 -0500
Message-ID: <000701c1a5d5$812ef580$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Andrew Morton" <akpm@zip.com.au>, "lkml" <linux-kernel@vger.kernel.org>
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au>
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
Date: Fri, 25 Jan 2002 12:21:35 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initial testing on my system shows some good, some bad :-)

Asus A7V, 1.0GHz Athlon Thunderbird, 512M PC-133 CAS3 SDRAM
VIA VT82C686A (rev 22) Ultra ATA 66
Promise PDC20265 Ultra ATA 100

There are two CD-ROM drives, master and slave on the secondary channel of
the VIA controller. There are also four hard drives, spread across the rest
of the channels (three of them on the Promise controller), configured as a
software raid-5 array, with ext3 volumes on top of that. Kernel is
2.4.18-pre7, plus this patch, plus Ingo's O(1)-J6 scheduler patch.

The CD-ROM drives are both Creative CD-ROM Blaster 52X, but different
vintages (so probably different manufacturers). One reports as "CREATIVE
CD5233E-N", the other as "CREATIVE CD5233E-CF". The N drive is ATA Master,
the CF drive is Slave. Both reported "using DMA" previously, even though
reading audio never used DMA.

I am using cdda2wav to read the audio tracks, one track at a time, using
native IDE mode (no ide-scsi emulation). When reading from the CF drive,
everything works quite well, seems to use less CPU time (MP3 encoding
running simultaneously gets more work done :-). When reading from the N
drive, get lots of "cdrom_pc_intr: read too little data 0 < 2352", and it
takes forever to read tracks (I actually never let it complete). Using
hdparm to turn off the "using DMA" flag for the N drive results in normal
read activity, just like before the patch went in.

Performance seems really good using the patch and DMA on the working drive;
the WAV data is stored onto an ext3 volume, then read back from that volume
and encoded into MP3, stored back onto the same volume. Encoding speed
(while ripping) nearly doubled! Previously, just using Ingo's new scheduler
had improved encoding speed a little (less than 10%), but this has made a
huge improvement.

I don't have any spare IDE channels in this box, otherwise I'd split these
drives onto separate channels. I may solve that problem later today, and be
able to provide more useful debugging. If there's anything else you'd like
to know, just ask.

