Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264035AbTCUUf6>; Fri, 21 Mar 2003 15:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264034AbTCUUep>; Fri, 21 Mar 2003 15:34:45 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:38602 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP
	id <S264031AbTCUUeM>; Fri, 21 Mar 2003 15:34:12 -0500
Message-ID: <3E7B79D5.3060903@cox.net>
Date: Fri, 21 Mar 2003 13:45:09 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4a) Gecko/20030311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: small devfs patch for 2.5.65, plan to replace /sbin/hotplug
References: <20030321014048.A19537@baldur.yggdrasil.com>
In-Reply-To: <20030321014048.A19537@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> 	I believe that the only change in this version of devfs is
> moving the code to invoke the user level devfs_helper program to a
> separate file, fs/devfs/notify.c.  This change will simplify a future
> code shrink inspired by David Brownell's suggesting that I think about
> unifying hotplug with devfs.  In the future I would like to lift
> fs/devfs/notify.c out of devfs so that the code that currently invokes
> user level helpers for hot plug events can be replaced with two calls
> to a renamed devfs_event() on
> /sys/bus/<bustype>/devices/<bus#>/<whatever>, one for insertion and
> one for removal.

Are you still considering smalldevfs for 2.6 inclusion? If not, then I'd like to 
discuss with you (and Greg KH) the possibility of just eliminating devfs 
entirely, and moving to a userspace version that is driven entirely by 
/sbin/hotplug.

There are already adequate hotplug events generated in 2.5.65+ to create and 
remove all necessary /dev entries, other than /dev/console (and that gets 
created by the initramfs being unpacked). If the devfs concept of "devfs_only" 
(no major/minor access to device drivers) is truly gone (as it appears to be), 
then the userspace variant of devfs would be quite simple: process the hotplug 
event and read the appropriate information out of sysfs to get the dev_t for the 
device, then follow user-specified policies to create /dev entries.

Unless I'm missing something obvious, "devfs" could be just a synonym for a 
specific tmpfs instance, with no built-in behavior at all. At initramfs unpack 
time it would be mounted on /dev, /dev/console would be created, and then 
/sbin/hotplug would create/remove entries as the drivers to their thing.

When the real root filesystem gets mounted, devfs could then be mounted again on 
the new /dev (just like devfs now) and everything's running smoothly.

