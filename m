Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265482AbTFMSQL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbTFMSQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:16:03 -0400
Received: from cc-linux4.ethz.ch ([129.132.19.124]:50617 "HELO lombi.mine.nu")
	by vger.kernel.org with SMTP id S265482AbTFMSPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:15:34 -0400
Mime-Version: 1.0
Message-Id: <p04320409bb0fb23f89f8@[192.168.3.11]>
In-Reply-To: <20030613155934.GA19307@namesys.com>
References: <p04320407bb0f79fd523e@[192.168.3.11]>
 <20030613155634.GA18478@namesys.com> <20030613155934.GA19307@namesys.com>
Date: Fri, 13 Jun 2003 20:07:55 +0200
To: Oleg Drokin <green@namesys.com>
From: Christian Jaeger <christian.jaeger@ethlife.ethz.ch>
Subject: Re: Lockups with loop'ed sparse files on reiserfs?
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:59 Uhr +0400 13.06.2003, Oleg Drokin wrote:
>  > Were there anything interesting on the console where your kernel outputs
>  > its messages (the host kernel?)?

IIRC nothing was output, at least I don't remember anything that I 
thought was significant. But see below re kern.log entries.

>Any chance to hit say sysrq-T/sysrq-P to find out where CPU spins?

I've never used those, I'll have to learn about those debugging 
options first. Where should I go to?

>BTW, while we are at it, were there enough space on the partition with sparse
>files to hold all the data you was writing there?

I did calculate all space bevor I started a few days ago. I did now 
recalculate on current free space on the partitions and in fact on 
one partition there's not enough space (anymore?):

losetup /dev/loop0 /root/raid5_1
losetup /dev/loop1 /root/raid5_2
   du /root -> 1675228 k free. 650*1024*2=1331200 k, => ok
losetup /dev/loop2 /mnt/hdd8/raid5_3
losetup /dev/loop3 /mnt/hdd8/raid5_4
losetup /dev/loop4 /mnt/hdd8/raid5_5
   du /mnt/hdd8/ -> 1973856 k free. 650*1024*3=1996800k => *not* ok.
   (pity that I already deleted those 3 files)
losetup /dev/loop5 /mnt/hda11/raid5_6
   du /mnt/hda11	-> 849044 free. => ok.
losetup /dev/loop6 /mnt/hdd6/.c/raid5_8
losetup /dev/loop7 /mnt/hdd6/.c/raid5_9
   this is a vfat partition so no sparse files (and 2.9GB free too)
(The files looks like:
-rw-------    1 root     root     681574400  8. Jun 23:46 raid5_6
)

Now the question is wbat happens if a partition is full.
In fact I've seen this in kern.log (full log at
http://pflanze.mine.nu/~chris/scratch/kern.log ):

Jun 13 11:34:57 pflanze kernel: raid5: md0, not all disks are 
operational -- trying to recover array
...
Jun 13 11:34:57 pflanze kernel: md0: resyncing spare disk [dev 07:07] 
to replace failed disk

Though I think that was before I started writing stuff onto the array.

What does happen if a raid array fails (i.e. 2 disks fail and there's 
no spare, or 1 spare and 3 disks fail etc.)? If it's not an important 
array (i.e. no swap or root filesystem on it), is there a reason for 
the system to go down? Isn't it possible to just mark the mounted 
filesystem  as erroneous and return EIO to applications accessing it?

There's also the case 1, using uml. In this case I'm sure there was 
no problem with space. The sparse filesystem image file I used is 
exactly 500'000'000 bytes, and there's 1675228 k free space on the 
partition where it is put on.

Christian.
