Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbSKSQzY>; Tue, 19 Nov 2002 11:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbSKSQzY>; Tue, 19 Nov 2002 11:55:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26588 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265168AbSKSQzX>;
	Tue, 19 Nov 2002 11:55:23 -0500
Date: Tue, 19 Nov 2002 18:02:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Paul Larson <plars@linuxtestproject.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: writing to sysfs appears to hang
Message-ID: <20021119170205.GC11884@suse.de>
References: <1037401217.11295.145.camel@plars> <20021116004723.GB3153@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021116004723.GB3153@beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15 2002, Mike Anderson wrote:
> Paul Larson [plars@linuxtestproject.org] wrote:
> > I've been playing with sysfs and notices something odd.  If I do this:
> > echo 1 > /sys/devices/sys/name
> > the process appears to be hung.  ^c won't return control to me.  If I
> > log in on another console though, I can't find it running in the process
> > list.  All I can do is kill the login process.  No kernel errors when I
> > do this, just the hung terminal.
> > 
> > -Paul Larson
> 
> I repeated your example and in a quick look at the backtrace
> the echo is in a loop calling down into sysfs_write_file/dev_attr_store.
> 
> I think the problem is that if a device does not have a attribute store
> function the return value from dev_attr_store is incorrect.

This has been in the deadline-rbtree patches for some time (uses writes
to sysfs, too).

===== fs/sysfs/inode.c 1.59 vs edited =====
--- 1.59/fs/sysfs/inode.c	Wed Oct 30 21:27:35 2002
+++ edited/fs/sysfs/inode.c	Fri Nov  8 14:33:59 2002
@@ -243,7 +243,7 @@
 	if (kobj && kobj->subsys)
 		ops = kobj->subsys->sysfs_ops;
 	if (!ops || !ops->store)
-		return 0;
+		return -EINVAL;
 
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page)


-- 
Jens Axboe

