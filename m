Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261503AbTCOUAq>; Sat, 15 Mar 2003 15:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261504AbTCOUAq>; Sat, 15 Mar 2003 15:00:46 -0500
Received: from packet.digeo.com ([12.110.80.53]:37518 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261503AbTCOUAn>;
	Sat, 15 Mar 2003 15:00:43 -0500
Date: Sat, 15 Mar 2003 12:03:43 -0800
From: Andrew Morton <akpm@digeo.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.5.64-mm7 - dies on smp with raid
Message-Id: <20030315120343.71faf732.akpm@digeo.com>
In-Reply-To: <3E736505.2000106@aitel.hist.no>
References: <20030315011758.7098b006.akpm@digeo.com>
	<3E736505.2000106@aitel.hist.no>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2003 20:03:29.0859 (UTC) FILETIME=[F2C11130:01C2EB2D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> mm7 crashed where mm2 works.
> The machine is a dual celeron with two scsi disks with
> some raid-1 & raid-0 partitions.
> 
> deadline or anicipatory scheduler does not make a difference.
> It dies anyway, attempting to kill init.
> 
> Here's what I managed to  write down before the 30 second reboot
> kicked in:
> 
> EIP is at md_wakeup_thread
> 
> stack:
> do_md_run
> autorun_array
> autorun_devices
> autostart_arrays
> md_ioctl
> dentry_open
> kmem_cache_free
> blkdev_ioctl
> sys_ioctl
> init
> init
> 
> This happened during the boot process. The kernel is compiled
> with gcc 2.95.4 from debian testing. The machine uses devfs
> 

A lot of md updates went into Linus's tree overnight.  Can you get some more
details for Neil?

Here is a wild guess:

diff -puN drivers/md/md.c~a drivers/md/md.c
--- 25/drivers/md/md.c~a	2003-03-15 12:02:04.000000000 -0800
+++ 25-akpm/drivers/md/md.c	2003-03-15 12:02:14.000000000 -0800
@@ -2818,6 +2818,8 @@ int md_thread(void * arg)
 
 void md_wakeup_thread(mdk_thread_t *thread)
 {
+	if (!thread)
+		return;
 	dprintk("md: waking up MD thread %p.\n", thread);
 	set_bit(THREAD_WAKEUP, &thread->flags);
 	wake_up(&thread->wqueue);

_

