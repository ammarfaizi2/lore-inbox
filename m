Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265427AbTFMQS3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265424AbTFMQS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:18:28 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:62706 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S265433AbTFMQR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:17:58 -0400
Message-ID: <3EE9FC6B.6020204@mvista.com>
Date: Fri, 13 Jun 2003 09:31:39 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
References: <Pine.LNX.4.44.0306121407040.11379-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0306121407040.11379-100000@cherise>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patrick Mochel wrote:

>*Sigh* You're asking for trouble, aren't you? 
>
>For the new spectators in the crowd, Steven, Greg and I have been on a 
>private email thread about this. This is the original email that he sent, 
>with all comments made to him completely disregarded.. 
>
>  
>
>>I have been looking at the udev idea that Greg KH has developed.  
>>Userland device enumeration definately is the way to go, however, there 
>>are some problems with using /sbin/hotplug to transmit device 
>>enumeration events:
>>
>>1) performance of fork/exec with lots of devices is very poor
>>    
>>
>
>Please define: 
>
>- 'lots'
>  
>
i tested 12 devices

>- 'poor'
>
80% slower for enumeration.

>
>
>The performance of /sbin/hotplug doesn't matter. It's a blip on the radar.  
>If you have lots of devices (e.g. 1000 SCSI disks) the time it takes to
>fork + exec /sbin/hotplug is nothing compared to what it would take to
>spin up and probe each of the disks. If you don't have a lot of devices,
>then you're going to be spending a lot less time running /sbin/hotplug. So
>little that it's not going to make a difference, I'm willing to wager.
>
>If you have accurate time measurements, then I would be interested in
>seeing them. Though, I request that you test the following:
>
>- The default /sbin/hotplug for Redhat 9 systems 
>- The default /sbin/hotplug for Montavista systems. 
>- Greg's mini-hotplug 
>- Your sdeq
>
>Please test against an identical kernel, with and without your patch.  
>Please also post links to (or attach) the /sbin/hotplug binaries and
>scripts that you tested with. And, please post the complete 'tree -d'
>output of sysfs on the system(s) you tested on.
>
>  
>
>>2) lots of processes can be forked with no policy to control how many 
>>are forked at once potentially leading to OOM
>>    
>>
>
>Have you seen this happen? Sure, it's theoretically possible, but I highly 
>doubt it will ever happen on a real system. Typically, if you have an 
>astronomical number of devices, then you'll have an incredible amount of 
>memory, too. Please post a bug report when you see this.
>  
>
I have not seen this happen, however, it seems clear that it would 
happen if /sbin/hotplug were called a sufficient number of times.

>  
>
>>3) /sbin/hotplug events can occur out of order, eg: remove event occurs, 
>>/sbin/hotplug sleeps waiting for something, insert event occurs and 
>>completes immediately.  Then the remove event completes, after the 
>>insert, resulting in out-of-order completion and a broken /dev.  I have 
>>seen this several times with udev.
>>    
>>
>
>This is true, and I'll let Greg handle this one. 
>
>  
>
>>4) early device enumeration (character devices, etc) are missed because 
>>/sbin/hotplug is not available during early device init.
>>    
>>
>
>initramfs, as well as one of many cold-plugging solutions out there should
>suffice for this. If they don't, we would welcome and appreciate your
>effort in helping overcome these deficiencies by evolving the current
>system rather than attempting a hostile takeover.
>  
>
I am not attempting a hostile takeover. The patch provides an ADDITIONAL 
solution to what is already available which significantly improves 
performance.

>  
>
>>To solve these problems, I've developed a driver and some minor 
>>modifications to the lib/kobject.c to queue these events and allow a 
>>user space program to read the events at its leisure.  The driver 
>>supports poll/select for effecient use of the processor.
>>    
>>
>
>Listen, it's not going to fly. Greg is hotplug czar, and I won't take the 
>patches if he doesn't like them. 
>  
>
This is not a hotplug issue, it is strictly a system device enumeration 
issue.

>Secondly, you're just not going to replace hotplug. At least not now. 
>/sbin/hotplug works today and has no serious, provable issues, besides 
>events coming in out of order. Incredibly long boot times, OOM situations 
>just have not happened. And, we've agreed that we're not going to 
>implement an overdesigned solution to fix problems that aren't there yet. 
>Show us REAL bugs and we'll work on making what we have better. 
>  
>
I have no intention of replacing hotplug. The patch is in addition to 
hotplug, and uses the good infrastructure Greg and yourself have already 
put in place.

>Thirdly, /sbin/hotplug is an ASCII interface, providing flexibility in the
>userspace agent implementations. Your character device (which is not
>appreciated) forces the userspace tools to use select(2), poll(2), or
>ioctl(2). No simple read(2)/write(2). Binary interfaces == Bad(tm). If you 
>have doubts, please read the threads concerning binary vs. ASCII 
>interfaces over the last two years before replying. 
>  
>
I believe it is highly desireable to be able to use select. Imagine the 
case where the kernel generates an event, and some external agent, that 
wants to enumerate devices, must also generate an event. This allows a C 
program to select which fd to use for I/O. I don't understand the 
problems with binary interfaces, as they are numerous in the kernel. For 
an example, take a look at the syscall interface!

>I'm not even going to go as far as comment on the code, since conceptually 
>its FITH. 
>
>Finally, I think you need a serious attitude readjustment. You've exceeded 
>all expectations in the level of jackass that you've acheived. You 
>completley disregarded Greg's comments in a private thread started from 
>the SAME EXACT email. You were pompous and arrogant to the person whose 
>code you're trying to replace. Then, you have the nerve to start over on 
>this list. Did you think we wouldn't notice? If anything, you've 
>guaranteed that I will never take your emails seriously again. 
>  
>
I did not disregard Greg's comments. The bottom line is the performance 
issues and out-of-order issues have not been addressed. Perhaps the 
out-of-order issue can be addressed, but performance of /sbin/hotplug 
will _always_ be slower then the operation of one process on an event 
queue. You can wait until enough people bitch about the performance of 
/sbin/hotplug and evolve /sbin/hotplug into the scheme I propose, or you 
can take this patch as is. I really don't care as I don't make patches 
available for my benefit; they are for the benefit of the community.

Finally, I didn't realize the sandbox was full. If you don't want to 
play with my toys, you certainly don't have to.

Thanks
-steve

>I really wish the device driver people at Montavista would pool their 
>collective partial clues and figure WTF the rest of the world is doing. 
>Do you guys listen? Do you read email? Hello? McFly? 
>
>I'm frankly sick of you people wasting our time with these half-assed, 
>hare-brained hacks that you expect us to love and integrate. You never try 
>to evolve the current system; it's always a case of rewriting something 
>that at least works with a completely new interface. You don't listen to 
>our input, and you disappear after a few emails. Then, you try it all 
>again a few months later. 
>
>It's frustrating because you're obviously talented and have the
>time+energy to help, but you never seem to attempt to align yourselves 
>with us or the rest of the kernel. 
>
>Please, either a) re-read the email threads, the papers, the magazine
>articles, and/or the text file documentation and attempt to work with us;  
>or b) stop trying to get us to listen.
>
>
>	-pat
>
>
>
>
>
>  
>

