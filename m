Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261557AbSJZVyq>; Sat, 26 Oct 2002 17:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbSJZVyq>; Sat, 26 Oct 2002 17:54:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30214 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261557AbSJZVyp>;
	Sat, 26 Oct 2002 17:54:45 -0400
Message-ID: <3DBB108A.2050803@pobox.com>
Date: Sat, 26 Oct 2002 18:00:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Switching from IOCTLs to a RAMFS
References: <Pine.LNX.4.44.0210241525560.983-100000@cherise.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:

>>Is there a namespace doc or guideline we can look at?
>>(for existing nodes, sure, but more guidelines for future nodes)
>>    
>>
>
>There's nothing official, at least not yet. I know that's a pretty crappy 
>thing to say, but I've been this -><- close to doing for some time now..
>
hehe, that's cool :)

I'll just continue to point people to mochel@osdl.org when they ask 
about a procfs alternative :)


>But, then we border on what exactly we want in sysfs. The original intent 
>was to provide a simple ASCII-based interface, and _not_ provide device 
>nodes.
>
>As things have matured, and more people want to move stuff out of procfs
>and replace ioctls with custom filesystem interfaces, I've questioned the
>original intent. In the end, I'm really ambivalent about whether to use
>sysfs or a custom filesystem for custom interfaces beyond the simple
>ASCII-based one. I'm not trying to either save or conquer the world with 
>sysfs, and it would make my life a whole lot easier if no one at all used 
>it. ;)
>
>But, I have arguments for both sides: 
>
>If sysfs is used, there are the arguments I presented last time: once fs
>to mount, one API to create files in different subsystems, easier
>association between objects.
>
>While it's easy to create your own filesystem, either using fs/libfs.c 
>helpers and/or fs/nfsd/nfsctl.c as your based, you still end up with a lot 
>of replicated code. There will be copy-n-paste no matter what. I know it's 
>not a really solid argument, but how much overhead is it going to incur if 
>every subsystem and/or every object that belongs to each subsystem is 
>exporting a filesystem instance? 
>  
>

Like I touched on in IRC, there is room for both sysfs and per-driver 
filesystems.

I think just about everyone agrees that ioctls are a bad idea and a huge 
maintenance annoyance.  So, what is the alternate solution?  IMO your 
choices are presenting a device node for control via read(2), write(2), 
and poll(2), or exporting a bunch of ASCII-controlled interfaces.  While 
I certainly agree with the overall strategy of sysfs, I can't see it as 
being the best interface for wholesale replacement of groups of ioctls. 
 So that leaves per-driver filesystems, which have a bunch of benefits...
* allows for implementation of true character devices (chardevs), 
something which sysfs was never intended to do
* solves module unloading problem, because filesystems must be mounted 
before accessing and umounted before removal, which implies that there 
will be no races at the open(2) level
* we all admit that sysfs doesn't attempt to solve similar problems as 
devfs.  so if one wants to do a sane device filesystem, a custom fs is 
needed
* mount options are the current best solution for providing decent 
default file permissions for dynamically instantiated file nodes.  It 
keeps policy in userspace while still providing dynamic file nodes in 
the kernel.  per-driver filesystems give you the granularity needed to 
accomplish this.
* as fs/nfsd/nfsctl.c and libfs.c shows, you don't have to worry about 
code bloat, so the only real overhead is the structures that are 
involved in superblock/vfsmount operations

There were a couple other benefits I have forgotten by now :)

    Jeff




