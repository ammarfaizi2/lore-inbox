Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUITUQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUITUQY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 16:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUITUQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 16:16:24 -0400
Received: from mail.tmr.com ([216.238.38.203]:6158 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S264503AbUITUQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 16:16:07 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [RFC][PATCH] inotify 0.9
Date: Mon, 20 Sep 2004 16:16:58 -0400
Organization: TMR Associates, Inc
Message-ID: <cindco$ats$1@gatekeeper.tmr.com>
References: <cic9os$ibd$1@gatekeeper.tmr.com><1095263565.19906.19.camel@vertex> <1095352742.23385.148.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1095710936 11196 192.168.12.100 (20 Sep 2004 20:08:56 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <1095352742.23385.148.camel@betsy.boston.ximian.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Thu, 2004-09-16 at 11:07 -0400, Bill Davidsen wrote:
> 
> 
>>Did you work for Microsoft? Bloat doesn't count? And is this going to be 
>>  low memory you pin? And is every file create or delete (or update of 
>>atime) going to blast this mess through cache looking for people to notify?
> 
> 
> No.  I suggest looking at the source.
> 
> We are pinning the very inodes we are using.  So,

Well, I guess I misread the intent, I was assuming an inode could be 
watched even if it wasn't (at the time of watch) being used. So while I 
may want to know when any inode in a directory is used, I don't 
particularly desire to have them all pinned in memory.

If you say that's the only way, then clearly only huge system will be 
able to do that type of monitoring.
> 
> 	(a) There is no cache effects because the inodes are already
> 	    in use.  So when you go to, say, write to a file the kernel
> 	    already has the inode handy, and we just check in O(1) to
> 	    see if the inode has a watcher on it.  We never walk a list
> 	    of inodes (why would you ever do that?  how would you do
> 	    that?).
> 	(b) Many of the pinned inodes are already in memory, cached,
> 	    since the probability of of used inodes and watched inodes
> 	    is high.  Right now, on a system without inotify, I have
> 	    60MB of inodes in memory.
> 	(c) The inodes are pinned to prevent races.  Or, don't even
> 	    look at it like this.  Just look at it as elevating the
> 	    ref count on the data structure while we are using it.

I'm not clear on what race you would get sending a notify to a user mode 
process that an inode had changed, but if you say there could be one I 
can't argue.
> 
> But here is the kicker: I don't think this pinning behavior is any
> different than dnotify.  So this is a total utter nonissue.

If you assume you are going to create the same resource demands doing 
one thing as another then it becomes a non-issue. I was suggesting that 
it would be desirable not to use as many resources.
> 
> 
>>>Older release notes:
>>>I am resubmitting inotify for comments and review. Inotify has
>>>changed drastically from the earlier proposal that Al Viro did not
>>>approve of. There is no longer any use of (device number, inode number)
>>>pairs. Please give this version of inotify a fresh view.
>>
>>We are hacking all over the kernel to save 4k in stack size and you want 
>>to pin up to 32MB?
> 
> 
> The 4K is 4K per process, and it is done not to save 4K once (or even
> 4K*number of processes) but because first order allocations (8KB on x86)
> become nontrivial as memory becomes fragmented.
> 
> I bet on most modern systems there is already much more than 32MB of
> inodes in memory, and you have to explicitly add watches anyhow.

If by modern you mean huge memory servers, you are right. If you mean 
modest desktops which might be able to identify problems by watching a 
set of inodes, I suspect the inode usage is lower.
> 
> 
>>If I were doing this, and I admit I may not understand all of the 
>>features, I would have a bitmap per filesystem of inodes being watched, 
>>and anything which did an action which might require notify would check 
>>the bit. If the bit were set the filesystem and inode info would be 
>>passed to user space which could do anything it wanted. Use of the 
>>netlink is an example of ways to do this.
> 
> 
> Race, race, race, if even possible to implement "a bitmap per filesystem
> of inodes" in a sane way.
> 
> 
>>Then the user program could do whatever it wanted in nice pageable 
>>space, allow as many watchers as it wished, and be flexible to anything 
>>a site wanted, scalable, could use semaphores, fifos, network 
>>monitoring, message queues... in other words low impact, scalable, and 
>>flexible.
> 
> 
> If you assume that you have to pin the inodes while you watch them (and
> you do), then inotify really is this minimum abstraction that you talk
> of.

As I said, if you assume pinning the inodes you can't make any 
significant reduction in memory use.
> 
> 
>>Feel free to tell me there is some urgent need for this feature to be 
>>present and fast, I learn new things every day.
> 
> 
> You act like file notification is something new.  Every operating system
> provides this feature.  Linux currently does, too: dnotify.
> 
> But dnotify sucks, and modern systems are hitting its numerous limits.
> So, enter inotify.

I guess all of us running laptops and the like with memory in MB rather 
then GB just aren't modern... the limit we hit is mostly memory size.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
