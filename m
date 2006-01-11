Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWAKOks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWAKOks (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWAKOks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:40:48 -0500
Received: from tornado.reub.net ([202.89.145.182]:11148 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750795AbWAKOkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:40:47 -0500
Message-ID: <43C518BC.5090903@reub.net>
Date: Thu, 12 Jan 2006 03:39:56 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060110)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, neilb@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-mm2
References: <20060110044240.3d3aa456.akpm@osdl.org> <20060110131618.GA27123@elte.hu> <17348.34472.105452.831193@cse.unsw.edu.au> <43C4947C.1040703@reub.net> <20060110213001.265a6153.akpm@osdl.org> <20060110213056.58f5e806.akpm@osdl.org> <43C4E2BE.6050800@reub.net> <20060111030529.0bc03e0a.akpm@osdl.org> <20060111111313.GD3389@suse.de> <43C4EEA4.3050502@reub.net> <20060111115616.GE3389@suse.de>
In-Reply-To: <20060111115616.GE3389@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/01/2006 12:56 a.m., Jens Axboe wrote:
> On Thu, Jan 12 2006, Reuben Farrelly wrote:
>>
>> On 12/01/2006 12:13 a.m., Jens Axboe wrote:
>>> On Wed, Jan 11 2006, Andrew Morton wrote:
>>>> Neil thinks that an IO got lost.  In the git2->git3 diff we have:
>>>>
>>>> b/drivers/scsi/Kconfig                         |   10 
>>>> b/drivers/scsi/ahci.c                          |    1 
>>>> b/drivers/scsi/ata_piix.c                      |    5 
>>>> b/drivers/scsi/libata-core.c                   |  145 +
>>>> b/drivers/scsi/libata-scsi.c                   |   48 
>>>> b/drivers/scsi/libata.h                        |    4 
>>>> b/drivers/scsi/sata_mv.c                       |    1 
>>>> b/drivers/scsi/sata_promise.c                  |    1 
>>>> b/drivers/scsi/sata_sil.c                      |    1 
>>>> b/drivers/scsi/sata_sil24.c                    |    1 
>>>> b/drivers/scsi/sata_sx4.c                      |    1 
>>>> b/drivers/scsi/scsi_lib.c                      |   50 
>>>> b/drivers/scsi/scsi_sysfs.c                    |   31 
>>>> b/drivers/scsi/sd.c                            |   85 -
>>>> b/fs/bio.c                                     |   26 
>>>>
>>>> Jens, Jeff: were any of those changes added in the final day or two, not
>>>> included in the trees which I pull?
>>> Reuben, do you have any barrier= options in your fstab for any reiser
>>> file system?
>> None whatsoever:
>>
>> /dev/md0                /                       reiserfs defaults        0 0
>> none                    /dev/pts                devpts   gid=5,mode=620  0 0
>> none                    /dev/shm                tmpfs    defaults        0 0
>> none                    /proc                   proc     defaults        0 0
>> sysfs                   /sys                    sysfs    defaults        0 0
>> /dev/sda1               /boot                   ext3     defaults        1 2
>> #/dev/sdb1              /boot-2                 ext3     defaults        1 2
>> /dev/md1                /home                   reiserfs defaults        0 0
>> /dev/md2                /var                    reiserfs defaults        0 0
>> /dev/md3                /var/www/cgi-bin        reiserfs defaults        0 0
>> /dev/md4                /tmp                    reiserfs defaults        0 0
>> /dev/md5                /backup                 reiserfs defaults        0 0
>> /dev/sda8               /var/spool/squid-1      reiserfs noatime,notail  0 0
>> /dev/sdb8               /var/spool/squid-2      reiserfs noatime,notail  0 0
>> /dev/sda9               swap                    swap     defaults        0 0
>> /dev/sdb9               swap                    swap     defaults        0 0
>> /dev/sdc1               /store                  reiserfs defaults        0 0
>> /dev/shm                /var/spool/amavisd/tmp  tmpfs 
>> defaults,size=25m,mode=700,uid=508,gid=509, 0 0
>> /dev/fd0                /media/floppy           auto 
>> pamconsole,exec,noauto,managed 0 0
> 
> Then the barrier changes from git2 -> git3 should not have anything to
> do with it. Strange... I guess you should try the git bisect method to
> narrow it down.

Ok push came to shove, so I spent the evening (early hours of the morning 
really) learning how to git my way around a little and use git bisect.  Not bad, 
people who come up with clever stuff like that would probably be clever enough 
to be able to do kernel development or something ;-)

Anyway, humour aside, I've bisected down to six revisions:

[root@tornado linux-2.6]# git bisect good
Bisecting: 6 revisions left to test after this
[93c9338713d4e11102cd09b4670ad42a336b06a3] [BLOCK] update libata to use new 
blk_ordered for barriers
[root@tornado linux-2.6]#

however I'm not sure I can go a lot further now as the tree is failing to 
compile at that point:

include/asm/mpspec_def.h:78: warning: 'packed' attribute ignored for field of 
type 'unsigned char[5u]'
block/ll_rw_blk.c:2421: error: conflicting types for 'blk_execute_rq_nowait'
include/linux/blkdev.h:617: error: previous declaration of 
'blk_execute_rq_nowait' was here
make[1]: *** [block/ll_rw_blk.o] Error 1
make: *** [block] Error 2
[root@tornado linux-2.6]#

I'm guessing there are a block of changes that all go together around this point.

Here's my BISECT_LOG:

git-bisect start
# bad: [0aec63e67c69545ca757a73a66f5dcf05fa484bf] Fix posix-cpu-timers 
sched_time accumulation
git-bisect bad 0aec63e67c69545ca757a73a66f5dcf05fa484bf
# good: [2e3e13f8e9d9b2111404cdccaa4e1b988b70acce] i2c: i2c-i801 explicitly 
enables/disables PEC
git-bisect good 2e3e13f8e9d9b2111404cdccaa4e1b988b70acce
# good: [9bbc8346fb21fad3f678220b067450e436e45dbf] s390: fix invalid return code 
in sclp_cpi
git-bisect good 9bbc8346fb21fad3f678220b067450e436e45dbf
# bad: [221fc10ec89834329e5613e3cab4569ba22da410] fs/ufs: debug mode compilation 
failure
git-bisect bad 221fc10ec89834329e5613e3cab4569ba22da410
# good: [ddaf22abaa831763e75775e6d4c7693504237997] md: attempt to auto-correct 
read errors in raid1
git-bisect good ddaf22abaa831763e75775e6d4c7693504237997
# good: [d9d166c2a9d5d01af34396793950aa695883eed4] md: allow array level to be 
set textually via sysfs
git-bisect good d9d166c2a9d5d01af34396793950aa695883eed4
# bad: [e650c305ec3178818b317dad37a6d9c7fa8ba28d] [SCSI] scsi_end_async() needs 
to take an uptodate parameter
git-bisect bad e650c305ec3178818b317dad37a6d9c7fa8ba28d
# good: [64100099ed22f71cce656c5c2caecf5c9cf255dc] [BLOCK] mark some block/ 
variables cons
git-bisect good 64100099ed22f71cce656c5c2caecf5c9cf255dc

I'll leave the setup as it is right now so if there's an easy way to narrow it 
down even further I can continue tomorrow.

Incidentally, I also tested - the problem is still in -mm3 also.

reuben



