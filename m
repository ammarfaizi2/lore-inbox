Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269819AbRHDHOY>; Sat, 4 Aug 2001 03:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269820AbRHDHOR>; Sat, 4 Aug 2001 03:14:17 -0400
Received: from Huntington-Beach.Blue-Labs.org ([208.179.59.198]:48237 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S269818AbRHDHN7>; Sat, 4 Aug 2001 03:13:59 -0400
Message-ID: <3B6BA0B8.1080704@blue-labs.org>
Date: Sat, 04 Aug 2001 03:14:00 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010803
X-Accept-Language: en-us
MIME-Version: 1.0
CC: Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Any known ext2 FS problems in 2.4.7?
In-Reply-To: <200108032301.f73N18E01809@lynx.adilger.int> <3B6B6D89.90804@blue-labs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, the assumed guilty party that just at 4.5gigs flat tonight was the 
rsync for the kernel mirror.

Here are the facts.
a) lsof didn't report any large files opened by rsync
b) lsof currently reports about 80k in deleted files
c) the directory where rsync runs from, the destination directory of the 
mirror, both report expected sizes, the mirror is a little over 9 gigs 
like it should be, the script directory is tiny.
e) dmesg shows nothing
f) du of the partitions shows the expected usage of about 13gigs.

4.5gigs just disappeared into nothingness.  I can't find it with any 
tools.  I have to shut this machine down to single user mode and run 
e2fsck to recover the space.

David


David Ford wrote:

> Yes I'm sure, this machine has been running for a long time quite well 
> save the reported problems.
>
> a) fsck on boot, yes
> b) manual fsck and reboot every few days, yes
> c) fstab is correct :P
> d) missing space isn't account for in du, lsof, or any other tool that 
> i'm aware of
> e) 4.5 gigs is a lot of space to eat over a couple days, particularly 
> when this server's disk use varies by a couple hundred megs per day
> f) only the e2fs partition has problems, the other partitions are 
> fine, no journal replays or otherwise
>
> After a fresh clean fsck'd start, the machine runs fine for a day or 
> two, then in about one day disk space grinds away.  Bringing it to 
> single user mode with nothing running but the kernel threads and a few 
> init children, lsof shows nothing but a few libs open, and no deleted 
> or otherwise open for write files.
>
> All my other machines run fine.  Also note as I said, it only does 
> this under 2.4.7, if I boot into 2.4.5 it will stay up for weeks until 
> the reported-and-fixed OOPs kills it.  No disk space issues there.
>
> David
>
> Andreas Dilger wrote:
>
>> David Ford writes:
>>
>>> I'm starting to go through a cycle every 2-3 days where I have to 
>>> bring one particular machine down to init l1, kill any processes and 
>>> remount RO, then run e2fsck on the e2fs partition.  Over that period 
>>> of time, disk space is eaten without accouting. 'du' shows about 13 
>>> gigs used when I sum up all the directories.  Roughly 4.5 gigs is 
>>> missing.  During e2fsck, there are many many pages of deleted inodes 
>>> with zero dtime, ref count fixups, and free inode count fixups.  
>>> When I say many, I mean that this pIII 667 scrolls for about four 
>>> minutes...
>>>
>>> There is nothing special about this partition, it doesn't do it 
>>> while running 2.4.5-ac15, but I can't use that kernel either because 
>>> it OOPSes as I reported.  That OOPS was fixed for 2.4.7, but this 
>>> disk space issue is rather frustrating.  Fortunately all my other 
>>> systems are reiserfs and work fine.
>>>
>>> /dev/ide/host0/bus0/target0/lun0/part2 on / type ext2 
>>> (rw,usrquota=/usr/local/admin/system-info/quota-home)
>>>
>>> I haven't mucked with any /proc settings other than "16384" 
>>> >/proc/sys/fs/file-max.  It's also worthy to note that this machine 
>>> also likes to break and spontaneously reboot about once every day.  
>>> No klog, no console, no nothing, just bewm.  Again 2.4.5 didn't do 
>>> this.
>>>
>>
>> Are you sure you are running e2fsck on this partition at boot time?
>> I mean, if it is rebooting spontaneously every day, but you need to run
>> e2fsck manually to clean up the filesystem every 2-3 days, the fsck 
>> after
>> reboot should already clean up the filesystem for you.  If you _don't_
>> run e2fsck on this filesystem (you need a non-zero number in the 6th
>> column of /etc/fstab) that would explain the problem.
>>
>> The "missing space" you are seeing is because files are being held open
>> (thus not reported by "du", which only can check linked files, but 
>> reported
>> by "df" which shows the whole filesystem stats).  If the files are held
>> open at the time of a crash, then you need to run e2fsck to clean up all
>> of these "orphans".  You should be able to see what process is 
>> causing this
>> by running "lsof | grep deleted" to find open-but-deleted files.
>>
>> Note that reiserfs still has the same problem (AFAIK, I don't think it
>> is fixed in the stock kernels, although there is a patch available),
>> so even though it doesn't _need_ reiserfsck at boot time, you still
>> don't get the space back until it is run.  If the other machines don't
>> crash all the time, the space won't be "lost", so you may not notice it.
>> Ext3 cleans up orphans at boot time (no fsck needed).
>>
>> Cheers, Andreas
>>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



