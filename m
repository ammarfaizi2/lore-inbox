Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278163AbRKNWFz>; Wed, 14 Nov 2001 17:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278085AbRKNWFq>; Wed, 14 Nov 2001 17:05:46 -0500
Received: from chamber.cco.caltech.edu ([131.215.48.55]:25568 "EHLO
	chamber.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S278042AbRKNWFe>; Wed, 14 Nov 2001 17:05:34 -0500
From: "Alex Adriaanse" <alex_a@caltech.edu>
To: <linux-kernel@vger.kernel.org>
Subject: LFS stopped working
Date: Wed, 14 Nov 2001 14:05:21 -0800
Message-ID: <JIEIIHMANOCFHDAAHBHOOEOLCMAA.alex_a@caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I've been running 2.4.14 for a few days now.  I needed LFS support, so I
recompiled glibc 2.1.3 with the new 2.4 headers, and after that I could
create large files (e.g. using dd if=/dev/zero of=test bs=1M count=0
seek=3000) just fine.

However, as of yesterday, I couldn't create files bigger than 2GB anymore.
I did not change kernels, nor did I mess with libc or anything else (I did
some Debian package upgrades/installations/recompiles, but I don't think
they should affect this) - I'm not quite sure what happened.  Now commands
such as the dd command I mentioned above will die with the message "File
size limit exceeded", leaving a 2GB file behind.  Rebooting didn't solve
anything.  My ulimits seem to be fine (file size = unlimited).

The last few lines of the strace on the dd command above shows the
following:
open("/dev/zero", O_RDONLY|0x8000)      = 0
close(1)                                = 0
open("test", O_RDWR|O_CREAT|0x8000, 0666) = 1
ftruncate64(0x1, 0xbb800000, 0, 0, 0x1) = 0
--- SIGXFSZ (File size limit exceeded) ---
+++ killed by SIGXFSZ +++

Also, cat'ing two 2GB files together into one big 4GB file (cat file1 file2
> file3) just dies after creating a 2GB file, whereas it used to work fine
(if I remember correctly).  Doing an strace on it ends with the following
lines:
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096)
= 4096
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) =
4096
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096)
= 4095
write(1, "\0", 1)                       = -1 EFBIG (File too large)
--- SIGXFSZ (File size limit exceeded) ---
+++ killed by SIGXFSZ +++

I'm doing this on a ReiserFS filesystem, but trying it on an ext2 partition
yields the same results.

Any suggestions?

Thanks,

Alex

