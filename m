Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132752AbRDUQry>; Sat, 21 Apr 2001 12:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132754AbRDUQro>; Sat, 21 Apr 2001 12:47:44 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:58374 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132752AbRDUQr0> convert rfc822-to-8bit; Sat, 21 Apr 2001 12:47:26 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: Jens Axboe <axboe@suse.de>
Subject: Re: Problems with Toshiba SD-W2002 DVD-RAM drive (IDE)
Date: Sat, 21 Apr 2001 18:47:07 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01041714250400.01376@antares> <01041914440701.01232@antares> <20010419150332.B22159@suse.de>
In-Reply-To: <20010419150332.B22159@suse.de>
MIME-Version: 1.0
Message-Id: <01042118470700.01914@antares>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

I took some time to try to understand why "mke2fs -b 2048 /dev/hdc"
wants 500MB memory. Here is a first explanation:
# mke2fs -m 0 -n /dev/hdc
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
406650880 inodes, 813284544 blocks
0 blocks (0.00%) reserved for the super user
First data block=0
24820 block groups
32768 blocks per group, 32768 fragments per group
16384 inodes per group

813284544 4k blocks would be 3.7 Terabyte.
(Strangely enough, calling mke2fs with any blocksize parameter results in a memory
allocation larger then my memory available.)

I took some more time to understand at what point the wrong size is introduced.
I got the source rpm, set CFLAGS to "-g", ran gdb, and nailed down the point:

(gdb) l
80      #endif
81              if (fd < 0)
82                      return errno;
83
84      #ifdef BLKGETSIZE
85              if (ioctl(fd, BLKGETSIZE, &size) >= 0) {
86                      close(fd);
87                      *retblocks = size / (blocksize / 512);
88                      return 0;
89              }
(gdb) n
86                      close(fd);
(gdb) print size
$1 = -2083658236
(gdb) bt
#0  ext2fs_get_device_size (file=0xbffff911 "/dev/hdc", blocksize=1024, 
    retblocks=0xbffff534) at ../../../lib/ext2fs/getsize.c:86
#1  0x804aca3 in PRS (argc=4, argv=0xbffff75c) at ../../misc/mke2fs.c:993
#2  0x804af2e in main (argc=4, argv=0xbffff75c) at ../../misc/mke2fs.c:1081
#3  0x40044baf in __libc_start_main () from /lib/libc.so.6
 
I am afraid I'd need help to go deeper.

Cheers,
Stefan J.

-- 
Stefan R. Jaschke <stefan@jaschke-net.de>
http://www.jaschke-net.de
