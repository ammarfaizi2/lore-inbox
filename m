Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268155AbUIPPWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268155AbUIPPWB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268157AbUIPPRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:17:40 -0400
Received: from mail.tmr.com ([216.238.38.203]:35076 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268203AbUIPPGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:06:45 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [RFC][PATCH] inotify 0.9
Date: Thu, 16 Sep 2004 11:07:24 -0400
Organization: TMR Associates, Inc
Message-ID: <cic9os$ibd$1@gatekeeper.tmr.com>
References: <1095263565.19906.19.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1095346781 18797 192.168.12.100 (16 Sep 2004 14:59:41 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <1095263565.19906.19.camel@vertex>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan wrote:
> Hello,
> 
> I am releasing a new version of inotify. Attached is a patch for
> 2.6.8.1.
> 
> I am interested in getting inotify included in the mm tree. 
> 
> Inotify is designed as a replacement for dnotify. The key difference's
> are that inotify does not require the file to be opened to watch it,
> when you are watching something with inotify it can go away (if path
> is unmounted) and you will be sent an event telling you it is gone and
> events are delivered over a fd not by using signals.
> 
> New in this version:
> Driver now supports reading more than one event at a time
> Bump maximum number of watches per device from 64 to 8192
> Bump maximum number of queued events per device from 64 to 256
> 
> --COMPLEXITY--
> 
> I have been asked what the complexity of inotify is. Inotify has
> 2 path codes where complexity could be an issue:
> 
> Adding a watcher to a device
> 	This code has to check if the inode is already being watched 
> 	by the device, this is O(1) since the maximum number of 
> 	devices is limited to 8.
> 
> 
> Removing a watch from a device
> 	This code has to do a search of all watches on the device to
> 	find the watch descriptor that is being asked to remove.
> 	This involves a linear search, but should not really be an issue
> 	because it is limited to 8192 entries. If this does turn in to
> 	a concern, I would replace the list of watches on the device
> 	with a sorted binary tree, so that the search could be done
> 	very quickly.
> 
> 
> The calls to inotify from the VFS code has a complexity of O(1) so
> inotify does not affect the speed of VFS operations.
> 
> --MEMORY USAGE--
> 
> The inotify data structures are light weight:
> 
> inotify watch is 40 bytes
> inotify device is 68 bytes
> inotify event is 272 bytes
> 
> So assuming a device has 8192 watches, the structures are only going
> to consume 320KB of memory. With a maximum number of 8 devices allowed
> to exist at a time, this is still only 2.5 MB
> 
> Each device can also have 256 events queued at a time, which sums to
> 68KB per device. And only .5 MB if all devices are opened and have
> a full event queue.
> 
> So approximately 3 MB of memory are used in the rare case of 
> everything open and full.
> 
> Each inotify watch pins the inode of a directory/file in memory,
> the size of an inode is different per file system but lets assume
> that it is 512 byes. 
> 
> So assuming the maximum number of global watches are active, this would
> pin down 32 MB of inodes in the inode cache. Again not a problem
> on a modern system. 

Did you work for Microsoft? Bloat doesn't count? And is this going to be 
  low memory you pin? And is every file create or delete (or update of 
atime) going to blast this mess through cache looking for people to notify?
> 
> On smaller systems, the maximum watches / events could be lowered
> to provide a smaller foot print.

Let's rethink this and say the max is by default and by use of proc or 
sys or whatever's in vogue today you can enable the feature by setting a 
non-zero value.
> 
> Older release notes:
> I am resubmitting inotify for comments and review. Inotify has
> changed drastically from the earlier proposal that Al Viro did not
> approve of. There is no longer any use of (device number, inode number)
> pairs. Please give this version of inotify a fresh view.

We are hacking all over the kernel to save 4k in stack size and you want 
to pin up to 32MB?
> 
> 
> Inotify is a character device that when opened offers 2 IOCTL's.
> (It actually has 4 but the other 2 are used for debugging)
> 
> INOTIFY_WATCH:
>         Which takes a path and event mask and returns a unique 
>         (to the instance of the driver) integer (wd [watcher descriptor]
>         from here on) that is a 1:1 mapping to the path passed. 
>         What happens is inotify gets the inode (and ref's the inode)
>         for the path and adds a inotify_watcher structure to the inodes
>         list of watchers. If this instance of the driver is already
>         watching the path, the event mask will be updated and
>         the original wd will be returned.
> 
> INOTIFY_IGNORE:
>         Which takes an integer (that you got from INOTIFY_WATCH) 
>         representing a wd that you are not interested in watching
>         anymore. This will:
> 
>         send an IGNORE event to the device
>         remove the inotify_watcher structure from the device and 
>         from the inode and unref the inode.
>         
> 
> After you are watching 1 or more paths, you can read from the fd
> and get events. The events are struct inotify_event. If you are
> watching a directory and something happens to a file in the directory
> the event will contain the filename (just the filename not the full
> path).
> 
> Aside from the inotify character device driver. 
> The changes to the kernel are very minor. 
> 
> The first change is adding calls to inotify_inode_queue_event and
> inotify_dentry_parent_queue_event from the various vfs functions. This
> is identical to dnotify.
> 
> The second change is more serious, it adds a call to
> inotify_super_block_umount
> inside generic_shutdown_superblock. What inotify_super_block_umount does
> is:
> 
> find all of the inodes that are on the super block being shut down,
> sends each watcher on each inode the UNMOUNT and IGNORED event
> removes the watcher structures from each instance of the device driver 
> and each inode.
> unref's the inode.
> 
> I have tested this code on my system for over three weeks now and have
> not had problems. I would appreciate design review, code review and
> testing.
> 
> John

If I were doing this, and I admit I may not understand all of the 
features, I would have a bitmap per filesystem of inodes being watched, 
and anything which did an action which might require notify would check 
the bit. If the bit were set the filesystem and inode info would be 
passed to user space which could do anything it wanted. Use of the 
netlink is an example of ways to do this.

Then the user program could do whatever it wanted in nice pageable 
space, allow as many watchers as it wished, and be flexible to anything 
a site wanted, scalable, could use semaphores, fifos, network 
monitoring, message queues... in other words low impact, scalable, and 
flexible.

Feel free to tell me there is some urgent need for this feature to be 
present and fast, I learn new things every day.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
