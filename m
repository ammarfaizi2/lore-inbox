Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271068AbRHOGyG>; Wed, 15 Aug 2001 02:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271067AbRHOGxr>; Wed, 15 Aug 2001 02:53:47 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:42421 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S271068AbRHOGxp> convert rfc822-to-8bit; Wed, 15 Aug 2001 02:53:45 -0400
Importance: Normal
Subject: bug in raidtools: not 64 bit ready
To: mingo@redhat.com, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF5A856959.0F52DD55-ONC1256AA9.00259579@de.ibm.com>
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Date: Wed, 15 Aug 2001 08:54:43 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 15/08/2001 08:53:51
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello ,


I think I encountered a problem in the raidtools. At least the mkraid
program seems to be not 64 bit ready.
I use raidtools-19990824-0.90. with Kernel 2.4.7 on an IBM zSeries (s390x).
It is a big endian 64 bit machine.
Patch is below.

How did I faced the problem?
I tried running mkraid and got the following message:

#mkraid /dev/md/0
handling MD device /dev/md/0
analyzing super-block
/dev/dasd/6353/part1: device too small (0kB)
mkraid: aborted, see the syslog and /proc/mdstat for potential clues.


How can I solve the problem?

I looked into the code of the raid-tools and found the following problem:

in md_int.h LINE 22 md_u32 is defined as unsigned int:
typedef unsigned int md_u32;

then in  raid_io.c  LINE 367 nr_bocks s defined ad unsigned int:

md_u32 nr_blocks;

but in raid_io.c LINE 451 and 492 a long pointer is passed. Unfortunately
long is 64 bit wide so nr_blocks will be zero and the 4 Bytes after
nr_blocks have the content nr_blocks should have:
if (ioctl(fd, BLKGETSIZE, (unsigned long)&nr_blocks) == -1) {

Therefore mkraid does not work.


Here is a simple (still ugly) patch that solves this problem on 64 bit.
Better approaches are welcome.
Meanwhile,  as int and long are both 32bit  on 32 bit machines this should
cause no harm.


--- raid_io.c   Tue Aug 24 18:24:56 1999
+++ raid_io.c   Tue Aug 14 16:16:53 2001
@@ -364,7 +364,7 @@
        md_raid_info_t *array;
        md_disk_info_t *disk;
        struct stat stat_buf;
-       md_u32 nr_blocks;
+       unsigned long nr_blocks;

        if (!cfg)
                return 1;


Please CC me as I am not subscribed to the list.

--
Mit freundlichen Grüßen / Best Regards

Christian Bornträger
IBM Deutschland Entwicklung GmbH
eServer SW  System Evaluation + Test
email: CBORNTRA@de.ibm.com
Tel +49 7031-16-3507


