Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265743AbRF2HrO>; Fri, 29 Jun 2001 03:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265747AbRF2HrE>; Fri, 29 Jun 2001 03:47:04 -0400
Received: from [202.96.44.20] ([202.96.44.20]:21943 "HELO smtp.263.net")
	by vger.kernel.org with SMTP id <S265743AbRF2Hqy>;
	Fri, 29 Jun 2001 03:46:54 -0400
Message-ID: <001501c1006e$fcf37220$0101a8c0@weqeqe>
Reply-To: "Zeng Yu" <yu_zeng@263.net>
From: "Zeng Yu" <yu_zeng@263.net>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Ramdisk Bug Report
Date: Fri, 29 Jun 2001 15:41:57 +0800
Organization: Capitel
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Since the first question about ramdisk, I've done more test against the
problem both on kernel 2.2.16 and 2.4.4/2.4.5. Here's my test result:
kernel 2.4.4/2.4.5 have two ramdisk bugs.
1. the ramdisk uses two same size mem of buffers and cache, and the cache
   can NOT be used by other processes untill the ramdisk be unmounted.
2. the ramdisk can dynamically grow as more space is required, but it can
   NOT dynamically shrink as the space is released.
both bugs don't exist on kernel 2.2.16.

The test method is as follows:(on a 256M pentium 4 box, with default
mamimum ramdisk_size 100M)
for bug 1:
 mke2fs -m0 /dev/ram1; mke2fs -m0 /dev/ram2
 mount /dev/ram1 /mnt1; mount /dev/ram2 /mnt2
 dd if=/dev/zero of=/mnt1/data bs=1k count=96000
 #now ram1 is 100M, should have space for another 100M ramdisk, BUT
 dd if=/dev/zero of=/mnt2/data bs=1k count=96000
 system hang!

for bug 2:
 mke2fs -m0 /dev/ram1; mke2fs -m0 /dev/ram2
 mount /dev/ram1 /mnt1; mount /dev/ram2 /mnt2
 dd if=/dev/zero of=/mnt1/data bs=1k count=96000
 #same as above, but try to free allocated ramdisk buffers first
 rm /mnt1/data
 #ram1 should shrink to about zero thus leave space for another 100M
 #ramdisk, BUT
 dd if=/dev/zero of=/mnt2/data bs=1k count=96000
 system still hang!


