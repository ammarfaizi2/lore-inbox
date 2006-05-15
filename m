Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWEOERz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWEOERz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 00:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWEOERz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 00:17:55 -0400
Received: from smtpout.mac.com ([17.250.248.185]:28365 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751389AbWEOERy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 00:17:54 -0400
In-Reply-To: <200605142008.39420.rob@landley.net>
References: <200605121421.00044.rob@landley.net> <F68E5CEA-AB95-4E1C-9923-0882394AE16E@mac.com> <200605142008.39420.rob@landley.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6BCF90AC-FF8B-48BC-8659-DBE0DD00E270@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Which process context does /sbin/hotplug run in?
Date: Mon, 15 May 2006 00:17:44 -0400
To: Rob Landley <rob@landley.net>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 14, 2006, at 20:08, Rob Landley wrote:
> On Saturday 13 May 2006 3:24 am, Kyle Moffett wrote:
>> /
>>    /var
>>      /var/sub
>>      /var/sub2
>>        /var/sub2/sub
>>        /var/sub2/sub2
>>
>> The recursion ends there.  Basically with the first bind mount you  
>> attach the same instance of tmpfs to /tmp and /var, then you move  
>> the tmpfs from /tmp to the "/sub2" directory in the "/var" tmpfs  
>> _mountpoint_.  It's kind of confusing behavior; but the directory  
>> tree and the mount tree are basically kind of separate entities in  
>> a sense.
>
> I can CD into them endlessly, and both "ls -lR" and "find ." report  
> cycles in the tree, which surprised me that they had a specific  
> error message for that, actually.  Good enough for me. :)

Odd, I'm unable to replicate that behavior here.  If I run "ls /var/ 
sub2/sub2" I don't get any entries.  Find and ls -lR have error  
messages of that because it can occasionally be triggered with  
symlinks and such.

> And I'm not _complaining_ about it.  Just fiddling around with fun  
> stuff.  If I get really bored I'll figure a way to split the tree  
> so there are two completely unconnected mount trees in different  
> processes.  (Get a private  namespace that's chrooted into  
> something that somebody else does a umount -l on from their space.   
> Or without using umount -l, just have two processes chroot into  
> other mount points which should theoretically garbage collect the  
> old root if no processes still references it, which presumably  
> means one of the processes is init...)

Well, actually, it isn't that hard.  Just run something like this:

#! /bin/sh
mkdir /a
mkdir /b
mount -t tmpfs tmpfs /a
mount -t tmpfs tmpfs /b
mkdir /a/old
mkdir /b/old
tool_to_fork_in_new_namespace sh -c "pivot_root /a /a/old && umount - 
l /a/old && read"
pivot_root /b /b/old && umount -l /b/old && read

All you need to write is tool_to_fork_in_new_namespace which does  
clone(CLONE_NEWNS) followed by exec().

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



