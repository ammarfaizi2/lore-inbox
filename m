Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbTJEKMO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 06:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTJEKMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 06:12:14 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:29846 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263055AbTJEKMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 06:12:12 -0400
Message-ID: <3F7FEE6F.9050601@colorfullife.com>
Date: Sun, 05 Oct 2003 12:11:59 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pwaechtler@mac.com, Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: POSIX message queues
References: <Pine.GSO.4.58.0310051047560.12323@ultra60>
In-Reply-To: <Pine.GSO.4.58.0310051047560.12323@ultra60>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Benedyczak wrote:

>Hello
>
>For quite a long time there are two implementations of posix mqueues
>around. I think it is time to decide at least if both of them have
>chances of beeing applied to official kernel. So I would
>like to know if Peter Waechtler's implementations is considered superior
>or there is possible some discussion and further work on our
>implementation is worthwhile.
>  
>
Could you try to merge your work? Or at least: look at each others work. 
For example Krzysiek/Michal's implementation has wake-one semantics, 
which is IMHO a requirement.

Krzysiek: What is MQ_IOC_CLOSE? It looks like a stale ioctl. Please 
remove such code from the patch.

The last time I looked at your patch I noticed a race between creation and setting queue attributes. Did you fix that?


>There are a lot of differencies but if the most important one is use of
>ioctl vs syscalls it can be changed (in fact our implementation loong time
>ago used syscalls).
>  
>
I personally prefer syscalls, but that's just my personal preference. 
For example the notification info is a structure, and printing it to a 
text stream and then parsing it back again is just odd. And I don't see 
how you can fix the O_CREAT+unusual mq_maxmsg races.
Why do you check against MQ_MAXMSG in user space? That's wrong. The 
kernel will reject too large limits, probably depending on 
/proc/sys/kern/ configuration. Checking in user space doesn't gain 
anything, except that you loose the ability for runtime changes.
Please reuse the load_msg/store_msg functions instead of a 
kmalloc(arg.msg_len, GFP_KERNEL) + copy_from_user. kmalloc(16384) is not 
reliable - it needs a continuous block of 16 kB, and after a long 
runtime, the memory is so fragmented that such memory may not exist. 
This is a known problem for x86_64: They would prefer to have 16 kB 
blocks for the stack, but this results in errors during stress testing.
proc_write_max_queues: off-by-one error. tmp[16] ='\0' overwrites the stack.
Is is necessary that the filesystem is visible to user space? What about 
chroot environments, or environments with per-user mount points. I don't 
like the dependence on /proc/mounts.

>In another words: is our implementation in the position
>of NGPT or better? ;-)
>  
>
Do you know if Ulrich Drepper has looked at your user space libraries? 
Your code must end up in glibc, and he's the maintainer.

--
    Manfred

