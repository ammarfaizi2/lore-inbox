Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283408AbRK2VhP>; Thu, 29 Nov 2001 16:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283410AbRK2Vg4>; Thu, 29 Nov 2001 16:36:56 -0500
Received: from mail.myrio.com ([63.109.146.2]:22004 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S283408AbRK2Vgp> convert rfc822-to-8bit;
	Thu, 29 Nov 2001 16:36:45 -0500
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CAE6@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Rene Rebe'" <rene.rebe@gmx.net>, linux-kernel@vger.kernel.org
Cc: reiserfs-list@namesys.com
Subject: RE: [reiserfs-list] ReiserFS on RAID5 Linux-2.4 - speed problem
Date: Thu, 29 Nov 2001 13:36:08 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

René Rebe wrote:
[...]
> I run ReiserFS on a RAID5 (of 3 IDE disks) using the latest 
> 2.4.(e.g.16)
> kernel for weeks. It works well except that is is painfully 
> slow. 
[...]

You are not the only one with these problems...

I am convinced there is a serious, negative performance 
interaction between software RAID 5 and ReiserFS, at least
on IDE.  Performance is less than 25% of what it should be.

---------------
Concise summary: 

dbench of reiserfs on a normal drive partition is slightly
* faster * than timing a raw "dd" from that partition.

But, dbench of reiserfs on a reiserfs on software RAID5
is ** only 1/4 as fast ** as a raw "dd" from the RAID5, 

And, to make it worse, software RAID 5 is significantly 
slower than I think it should be.  As a result, my nice
RAID 5 is far, far slower than an ordinary partition.
These are not just dbench numbers - all sorts of testing
shows the problem.

---------------
Here are the details:

I have four Maxtor 60 GB IDE disks, each is master on a single
cable, using two Promise Ultra TX2/100 cards.  The host is 
a dual P3-800 with 512 MB of RAM.  I bought this hardware
specifically to act as a fast, cheap, reliable server...  
I have no complaints except the speed.  

The raid disks are hde, hdg, hdi, hdk, as /dev/md0, not
partitioned, /dev/md0 is a single 180 GB reiserfs and is 
mounted on /home.  Chunk size is 1024.

Here's some low level numbers:

Single drive from the RAID:
time dd if=/dev/hdg of=/dev/null bs=1M count=1024
- elapsed time 0:37 = 27.65 MB/sec

Raw RAID5:
time dd if=/dev/md0 of=/dev/null bs=1M count=1024
- elapsed time 0:25 = 40.96 MB/sec

File on Reiserfs on RAID5:
time dd if=/home/test_file_1GB of=/dev/null bs=1M count=1024
- elapsed time 0:33 = 31.03 MB/sec

Old home partition on hda9:
time dd if=/dev/hda9 of=/dev/null bs=1M count=1024
- elapsed time 0:41 = 24 MB/sec

dbench tests:

dbench 32 on reiserfs on md0  : 10.7027 MB/sec
dbench 32 on reiserfs on hda9 : 27.7925 MB/sec

Note that when I first set this hardware up, I tried RAID0
on the same hardware and saw dbench 32 numbers of 76 MB/sec.

So, I think the dbench number for reiserfs on md0 should be
** at least ** five times faster than it is.  Are my 
expectations too high or is there a real problem here?

(tested on 2.4.15-pre5, this problem has been around for
all 2.4 kernels I've tried.)

Happy to help test and debug... please send suggestions.

Torrey Hoffman
