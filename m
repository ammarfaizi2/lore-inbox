Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSEEOAa>; Sun, 5 May 2002 10:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312704AbSEEOA3>; Sun, 5 May 2002 10:00:29 -0400
Received: from goliath.siemens.de ([192.35.17.28]:35055 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S312601AbSEEOA2>; Sun, 5 May 2002 10:00:28 -0400
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: linux-kernel list <linux-kernel@vger.kernel.org>
Cc: axboe@suse.de, Juan Quintela <quintela@mandrakesoft.com>
Subject: Problem with reading CD-R/W written in TAO mode
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3-1mdk 
Date: 05 May 2002 18:00:00 +0400
Message-Id: <1020607207.3021.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using Mandrake kernel 2.4.18-13mdk (based on 2.4.19-pre7). There is
strange problem in raw-reading some CD-R/Ws (e.g. to verify checksum
like md5sum /dev/cdrom) reported by several people - read aborts with
I/O error at the end.

Experimenting with different CD-R/Ws lead to conclusion that CD-Rs
written in DAO are read correctly and those written in TAO (and possibly
multisession) give an error. Printed CD-Rs never show any error. It does
not seem to matter what program has been used to create CD - identical
problem appears using mkisofs/cdrecord and Nero (I cannot verify DAO
with cdrecord because it is not supported for my CDD-3610).

My first thought was that for some reason wrong CD size has been
reported, so I added printk to cdrom_read_toc() to verify the real size
it gets (toc->capacity). To my surprise bot DAO and TAO written CD-RWs
report identical capacity but reading disk written in TAO consistently
ends with error. There are no problems using both CDs as far as I can
tell.

Here are results of writing the same image:

-rw-r--r--    1 root     root     22118400 May  4 14:24 mindi.iso

once in DAO/close disk and once in TAO/leave disk open:

{pts/0}% dd if=/dev/cdrom of=/dev/null bs=2048
10800+0 records in
10800+0 records out
{pts/0}% dd if=/dev/cdrom of=/dev/null bs=2048
dd: reading `/dev/cdrom': Input/output error
10788+0 records in
10788+0 records out

and in dmesg:

{pts/2}% dmesg | grep 16:0
blkdev_size: dev = 16:00 size = 4294967295
ide-cd capacity = 10800 dev = 16:00
blkdev_size: dev = 16:00 size = 21600
ide-cd capacity = 10800 dev = 16:00
blkdev_size: dev = 16:00 size = 21600
end_request: I/O error, dev 16:00 (hdc), sector 43152
end_request: I/O error, dev 16:00 (hdc), sector 43156
end_request: I/O error, dev 16:00 (hdc), sector 43160
end_request: I/O error, dev 16:00 (hdc), sector 43164
end_request: I/O error, dev 16:00 (hdc), sector 43168
end_request: I/O error, dev 16:00 (hdc), sector 43172
end_request: I/O error, dev 16:00 (hdc), sector 43176
end_request: I/O error, dev 16:00 (hdc), sector 43180
end_request: I/O error, dev 16:00 (hdc), sector 43184
end_request: I/O error, dev 16:00 (hdc), sector 43188
end_request: I/O error, dev 16:00 (hdc), sector 43192
end_request: I/O error, dev 16:00 (hdc), sector 43196

errors are:

hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev 16:00 (hdc), sector 43152
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev 16:00 (hdc), sector 43156
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
... etc

Please, tell if I can provide any more info. 

regards

-andrej




