Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbSJ2BGe>; Mon, 28 Oct 2002 20:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbSJ2BGe>; Mon, 28 Oct 2002 20:06:34 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:63985 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261413AbSJ2BGd>;
	Mon, 28 Oct 2002 20:06:33 -0500
Message-ID: <3DBDDF70.9050609@us.ibm.com>
Date: Mon, 28 Oct 2002 17:08:00 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: mochel@osdl.org, alan@lxorguk.ukuu.org.uk, davej@suse.de,
       mjbligh@us.ibm.com, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] DriverFS Topology + per-node (NUMA) meminfo
References: <20021028233518.53C5E2C105@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <3DBD88EA.7000402@us.ibm.com> you write:
> 
>>Rusty Russell wrote:
>>
>>>On Mon, 21 Oct 2002 14:50:25 -0700
>>>Matthew Dobson <colpatch@us.ibm.com> wrote:
>>>
>>>This clashes with my "move cpu driverfs to generic code" patch.
>>
>>Yes, yes it does.  It does a lot of similar things though.
> 
> Hey, great minds think alike 8)

Indeed!


>>My patch does not take advantage of the DECLARE_PER_CPU macros, etc.
> 
> A minor optimization which can be done later.  The important bit is
> not creating entries for cpus where !cpu_possible(cpu).

Very true.  I only instantiate entries for cpus that are online at the 
time of the initcall.  With the cpu callback stuff that you had in your 
patch, we can easily instantiate cpus that (magically? ;) come on line 
at a later point.


>> <snip>
 >>
>>What do you think of my patch (other than the obvious that it conflicts 
>>with yours)?
> 
> If I'm reading correctly, you move the cpus under "node" dirs when
> it's a NUMA system.  I can see the cute appeal, but it makes it harder
> to answer "how many cpus do I have?": a program would need to do a
> "find" which is kinda icky (also hard to write HOWTOs).  So I'd prefer
> symlinks to the node, and no hierarchy.

Well, in either (NUMA/non-NUMA) case, there are symlinks to the CPUs 
under class/cpu/devices:
[root@elm3b79 devices]# ls -al class/cpu/devices/
total 0
drwxr-xr-x    2 root     root            0 Oct 25 07:59 .
drwxr-xr-x    4 root     root            0 Oct 25 07:59 ..
lrwxrwxrwx    1 root     root           22 Oct 25 07:59 0 -> 
../../../root/sys/cpu0
lrwxrwxrwx    1 root     root           22 Oct 25 07:59 1 -> 
../../../root/sys/cpu1
lrwxrwxrwx    1 root     root           22 Oct 25 07:59 2 -> 
../../../root/sys/cpu2
lrwxrwxrwx    1 root     root           22 Oct 25 07:59 3 -> 
../../../root/sys/cpu3
lrwxrwxrwx    1 root     root           22 Oct 25 07:59 4 -> 
../../../root/sys/cpu4
lrwxrwxrwx    1 root     root           22 Oct 25 07:59 5 -> 
../../../root/sys/cpu5
lrwxrwxrwx    1 root     root           22 Oct 25 07:59 6 -> 
../../../root/sys/cpu6
lrwxrwxrwx    1 root     root           22 Oct 25 07:59 7 -> 
../../../root/sys/cpu7

These actually work really well because they don't move..  I like the 
idea (maybe it is just cute) of exposing the topology in a hierarchical 
(directory) fashion when possible.  And class/cpu/devices seems like a 
fairly logical place to go inquiring about cpus...


> driver/base/cpu.c should probably be moved into kernel/cpu.c anyway.

What about driver/base/node.c & memblk.c?  My thoughts were to maintain 
a separation between driverfs-only and other in-core code.


> I think exposing the struct cpu array is a good idea, so archs can add
> properties if they want (ie. node information).

Cool.  I didn't think it was particularly important at first, but Pat 
showed me the error of my ways ;)


> But Patrick is the architect, I'm just a grunt, so it's his call 8)
> Rusty.

Good call!  What do you think, O architect? ;)

Cheers!

-Matt

