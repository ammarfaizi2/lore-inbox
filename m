Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283285AbRK2QCk>; Thu, 29 Nov 2001 11:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283286AbRK2QCb>; Thu, 29 Nov 2001 11:02:31 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:62046 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S283285AbRK2QCO>;
	Thu, 29 Nov 2001 11:02:14 -0500
Date: Thu, 29 Nov 2001 17:02:09 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Edward Shushkin <edward@namesys.com>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] ReiserFS on RAID5 Linux-2.4 - speed problem
Message-Id: <20011129170209.4ad1838d.rene.rebe@gmx.net>
In-Reply-To: <3C066C57.7DA3CF5E@namesys.com>
In-Reply-To: <20011129022247.43615e45.rene.rebe@gmx.net>
	<3C066C57.7DA3CF5E@namesys.com>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply!

On Thu, 29 Nov 2001 17:11:51 +0000
Edward Shushkin <edward@namesys.com> wrote:

> Thats odd!
> I don't have three various ide-controllers to reproduce your configuration,

You only need one controller in additoin to your on-board one ... 2x 2 channels
-> 4 IDE Master possible ...

> but for the raid5 of 3 various scsi disks i have that the times of dd readings for 
> if= /dev/sda, /dev/md0, /mnt/file_on_reiserfs_on_md0 relates approximately as 
> 1.5 : 1 : 1   
> So the performance doesn't decrease..
> What is about your speed for (dd if=/dev/hdx...)??

Hardware: AMD K6-2 350Mhz; 128MB RAM; Aladin5 based Gigabyte board; additinal
Promise ULTRA ATA-100 controller; vanilla 2.4.16 kernel; [glibc-2.1.3]

I tuned the kernel a bit by:
echo 1023 > /proc/sys/vm/max-readahead
(without this some short test were much worser ...)

	RAID-disk I	RAID-disk II	RAID-disk III
	host2 ch0 ma	host2 ch1 ma	host0 ch1 ma
1. hdparm -tT
	60.66 MB/sec	60.66 MB/sec	60.66 MB/sec
	20.13 MB/sec	23.62 MB/sec	15.92 MB/sec (UDMA mode II only)

2. dd if=x of=/dev/null bs=1024 count=100000 (avg. of 3 measurements)
	30.52 MB/sec	30.54 MB/sec	30.6 MB/sec (??? UDMA2 ... ?)
# ok too much is cached by LInux ... again with 400 MB:

3. dd if=x of=/dev/null bs=1024 count=400000 (avg. of 3 measurements)
	30.92 MB/sec	28.32 MB/sec	29.32 MB/sec

4. time dd if=/dev/md/0 of=/dev/null bs=1024 count=400000 (avg. of 3 measurements)
	34.567 MB/sec

4. time dd if=/home/everybody/video/movies/Matrix\ 1-2.avi of=/dev/null bs=1024 count=200000
(home is the ReiserFS on RAID5 filesystem ...) (avg. of 3 measurements)
	8.785 MB/sec

5. time dd if=/home/everybody/video/movies/Matrix\ 1-2.avi of=/dev/null bs=1024 count=400000
(home is the ReiserFS on RAID5 filesystem ...) (avg. of 3 measurements)
	9.306 MB/ses

So I have ide/discX md/0 file-from-reiserfs:
	3.2 : 3.71 : 1

Over NFS I get 7.1 MB/sec - this is MUCH better than yesterday - so the "echo 1023 >
 /proc/sys/vm/max-readahead" must have done it ... - but more would still be better ;-)
(I'll write a benchmark script and redo the test without this tuning tonight ...)

Notes:
1. The uncontinous results may be caused by a compile workstation that currently compiles
my distribution and accesed some source from time to time (not that much ...).

2. I allready "tuned" the IDE by the additional IDE controller. At the beginning
all discs were connected to the on-board Ali - which gave much worser results. So I added
the Promisse one so that each disc is a Master without Slave devices (I thought the
slowdown may be caused by the concurrend IDE-bus accesses ...)

Question: Are there some block-sizes / allignments issues I should take care when using
ReiserFS on RAID5 ?? - The current setup is a straightforward first-try with default
parameters for all tools (mkraid / mkreiserfs ... - I found no hints on the web).

> Can you measure this for ext2 on md0?

No - sorry. It is a "production" machine. I could backup all the stuff and reinitialize
RAID and reiserfs in another way when I know what to do better (except using SCSI ;-)
or what I did wrong - but I can not play arround with the data all the time ...

> Thanks,
> Edward.


k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #127875 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
