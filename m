Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268310AbUIPW7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268310AbUIPW7f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUIPW7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:59:34 -0400
Received: from [209.195.52.120] ([209.195.52.120]:29938 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S268453AbUIPW5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:57:37 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Date: Thu, 16 Sep 2004 15:57:09 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [RFC][PATCH] inotify 0.9
In-Reply-To: <Pine.LNX.3.96.1040916182127.20906B-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.60.0409161550060.22978@dlang.diginsite.com>
References: <Pine.LNX.3.96.1040916182127.20906B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Bill Davidsen wrote:

> On Thu, 16 Sep 2004, Jan Kara wrote:
>
>>> John McCutchan wrote:
>>>> Hello,
>>>>
>>>> I am releasing a new version of inotify. Attached is a patch for
>>>> 2.6.8.1.
>> <snip>
>>
>>>> --MEMORY USAGE--
>>>>
>>>> The inotify data structures are light weight:
>>>>
>>>> inotify watch is 40 bytes
>>>> inotify device is 68 bytes
>>>> inotify event is 272 bytes
>>>>
>>>> So assuming a device has 8192 watches, the structures are only going
>>>> to consume 320KB of memory. With a maximum number of 8 devices allowed
>>>> to exist at a time, this is still only 2.5 MB
>>>>
>>>> Each device can also have 256 events queued at a time, which sums to
>>>> 68KB per device. And only .5 MB if all devices are opened and have
>>>> a full event queue.
>>>>
>>>> So approximately 3 MB of memory are used in the rare case of
>>>> everything open and full.
>>>>
>>>> Each inotify watch pins the inode of a directory/file in memory,
>>>> the size of an inode is different per file system but lets assume
>>>> that it is 512 byes.
>>>>
>>>> So assuming the maximum number of global watches are active, this would
>>>> pin down 32 MB of inodes in the inode cache. Again not a problem
>>>> on a modern system.
>>>
>>> Did you work for Microsoft? Bloat doesn't count? And is this going to be
>>>  low memory you pin? And is every file create or delete (or update of
>>> atime) going to blast this mess through cache looking for people to notify?
>>>>
>>>> On smaller systems, the maximum watches / events could be lowered
>>>> to provide a smaller foot print.
>>>
>>> Let's rethink this and say the max is by default and by use of proc or
>>> sys or whatever's in vogue today you can enable the feature by setting a
>>> non-zero value.
>>   As I understand the patch it won't have any nontrivial memory
>> footprint in case you won't use inotify. Only in case someone wants to
>> watch inode, appropriate structure is allocated, inode pined etc. The
>> numbers above are in the case you watch maximum possible number of
>> inodes etc...
>
> The point I was making is that this doesn't scale well, because it eats
> resources which may be unavailable on many systems, and which others are
> trying to conserve. Since this may limit the use it presents a problem
> with usefulness.
>
>>   Maybe you should not be so fast in using your flamethrower;)
>
> I didn't intend this as a flame, but I do feel this implementation doesn't
> scale. I offered another approach off the top of my head, which appears to
> me to be more scalable. I claimed no expertise, I just made a suggestion,
> based on my first thought on how I would attack the problem in a way which
> appears more scalable.

IIRC you suggested a bitmap of all the inodes on a filesystem.

on my desktop this is what I see for inodes
dlang@dlang:~$ df -i
Filesystem            Inodes   IUsed   IFree IUse% Mounted on
/dev/sda3            1048576  168266  880310   17% /
/dev/sda5            2097152  158128 1939024    8% /home
/dev/sda1             524288   41797  482491    8% /mnt

so at 8 per byte you are taking about ~500K just to store the info about 
which ones somone is interested in watching (and note that this is only a 
9GB drive, think about what happens on multi TB systems), then you have to 
have another structure to track the events and which node each event goes 
to (and what programs are interested in watching which inodes)

I don't think that a bitmap of all possible inodes is going to be the 
right thing either.

now it's very possible that you were meaning something else, but it's not 
clear what so please try again to restate your idea.

> If we are going to 4k stack because larger memory blocks are hard to find,
> I have to suspect that anything which locks up blocks size in MB is going
> to cause problems. I didn't even ask what would happen on NUMA machines,
> because that's not my usual concern.

actually the memory for this doesn't need to be a contiuous block so it 
doesn't run into this problem

> I'm still horified by the memory requirements :-(

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
