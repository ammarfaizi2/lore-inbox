Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277951AbRJOB2R>; Sun, 14 Oct 2001 21:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277954AbRJOB2H>; Sun, 14 Oct 2001 21:28:07 -0400
Received: from tunnel-44-107.vpn.uib.no ([129.177.44.107]:40840 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S277951AbRJOB1z>; Sun, 14 Oct 2001 21:27:55 -0400
Message-ID: <3BCA3CAF.5050807@fi.uib.no>
Date: Mon, 15 Oct 2001 03:32:31 +0200
From: Igor Bukanov <boukanov@fi.uib.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE DVD problem under 2.4: status=0x51 { DriveReady SeekComplete Error }
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to setup my Dell Inspiron 7500 notebook (Celeron 466/512MB) with 
TORiSAN DVD-ROM DRD-U62 (RPC-2 drive :-( ) to watch DVD and found the 
following when using decss to read the encrypted vob files (other ways 
to access the file eventually produce the same error) under  2.4.12 
kernel, RedHat Linux 7.1. After I authenticated the drive and got a 
title key for some file, css-cat always fails on the first 2-3 attempts 
to read the file due to input-output error with kernel message:

hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x50
end_request: I/O error, dev 16:00 (hdc), sector 563008

After that vob file  on third-forth attempt can be successfullyread. I 
added error printouts to the program and find out that on the first 
attempt css-cat in general fails during read call on some 2k block at 
the very beginning of the file, on the second attempt it proceeds 
farther, but around 1000-2000 block it fails again and in general the 
third attempt either fails around the same offset or proceed with 
calling read on each 2K block without problems. Then I tried to use 
after the drive authentication something like
dd bs=2048 if=/mnt/cdrom/  of=/dev/null
it shows exactly the same behavior as css-cat.

When I use dd to read a vob file from a newly inserted DVD without any 
authentication, it fails to read about 5% of all 2K file blocks with the 
same error or with messages like:

hdc: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: DMA disabled
hdc: ATAPI reset complete
hdc: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdc: cdrom_decode_status: error=0x30

Sometimes on the second attempt it managed to read a block initially 
reported as bad, but in general quite a few blocks were not accessible 
at all until obtaining title key via tstdvd from the decss package. I 
can understand that my RPC-2 DVD-ROM can introduce "errors" on some 
sectors until issuing authentication ioctl calls but why I have the read 
errors unless I tried to read the drive 3-4 times after the authentication?

I also tried to mount dvd as the udf file system instead of iso9660 or 
use ide-scsi with no difference.

Regards, Igor

