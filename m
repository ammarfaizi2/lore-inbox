Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTEVWI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 18:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbTEVWI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 18:08:28 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:60132 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263281AbTEVWI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 18:08:27 -0400
Date: Thu, 22 May 2003 15:19:54 -0700
From: Andrew Morton <akpm@digeo.com>
To: maneesh@in.ibm.com, Jens Axboe <axboe@suse.de>
Cc: ivg2@cornell.edu, linux-kernel@vger.kernel.org, page0588@sundance.sjsu.edu,
       greg@kroah.com, tytso@us.ibm.com
Subject: Re: kernel BUG at include/linux/dcache.h:271!
Message-Id: <20030522151954.1230ef53.akpm@digeo.com>
In-Reply-To: <20030522115702.GA1150@in.ibm.com>
References: <200305211911.51467.ivg2@cornell.edu>
	<20030522115702.GA1150@in.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 May 2003 22:21:31.0876 (UTC) FILETIME=[7F4F9240:01C320B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni <maneesh@in.ibm.com> wrote:
>
> The problem is that we have multiple ramdisks but all have
> common request queue and common elevator. In terms of sysfs we 
> have multiple kobjects for multiple ramdisks, but one single kobject for the 
> ramdisks' common elevator. 
> 
> While initializing, different kobjects are allocated for the ramdisks but,
> the common elevator uses the same kobject. In other words, every init
> of a ramdisk, the common elevator.kobj->parent will be different and it will
> allocate a new dentry, overwrite the elevator.kobj->dentry
> and loose the earlier allocated dentries. (see: elv_register_queue())
> 
> While exiting, it ends up in removing the same dentry (allocated at the last)
> again and BUGs in dget on dentry with zero ref count.
> 
> Not sure where it should be fixed 
> ramdisk 
>  - should have separate queues on for each ramdisk
> 
> elevator 
>  - should not re-register already registered queue in elv_register_queue
> 
> sysfs 
>  - should handle kobject with multiple parent kobjects 

I can't think of anywhere else where we are likely to want to support
multiple devices from a single queue in this manner, so perhaps the best
solution is to remove the exceptional case: allocate a separate queue for
each ramdisk instance.

Jens, do you agree?


