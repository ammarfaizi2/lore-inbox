Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264434AbTCXV1v>; Mon, 24 Mar 2003 16:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264432AbTCXV1v>; Mon, 24 Mar 2003 16:27:51 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:42657 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264410AbTCXV1s> convert rfc822-to-8bit;
	Mon, 24 Mar 2003 16:27:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>, dougg@torque.net
Subject: Re: [patch for playing] 2.5.65 patch to support > 256 disks
Date: Mon, 24 Mar 2003 13:32:56 -0800
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
References: <200303211056.04060.pbadari@us.ibm.com> <3E7C4D05.2030500@torque.net> <20030322040550.0b8baeec.akpm@digeo.com>
In-Reply-To: <20030322040550.0b8baeec.akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303241332.56996.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 March 2003 04:05 am, Andrew Morton wrote:
> OK, thanks.  So with 48 disks you've lost five megabytes to blkdev_requests
> and deadline_drq objects.  With 4000 disks, you're toast.  That's enough
> request structures to put 200 gigabytes of memory under I/O ;)
>
> We need to make the request structures dymanically allocated for other
> reasons (which I cannot immediately remember) but it didn't happen.  I
> guess we have some motivation now.

Here is the list of slab caches which consumed more than 1 MB
in the process of inserting 4000 disks.

#insmod scsi_debug.ko add_host=4 num_devs=1000

deadline_drq    before:1280 after:1025420 diff:1024140 size:64 incr:65544960
blkdev_requests  before:1280 after:1025400 diff:1024120 size:156 incr:159762720

* deadline_drq, blkdev_requests consumed almost 80 MB. We need to fix this.

inode_cache     before:700 after:140770 diff:140070 size:364 incr:50985480
dentry_cache    before:4977 after:145061 diff:140084 size:172 incr:24094448

* inode cache increased by 50 MB, dentry cache 24 MB. 
It looks like we cached 140,000 inodes. I wonder why ? 

size-8192       before:8 after:4010 diff:4002 size:8192 incr:32784384

* 32 MB is for 4 hosts ram disk for scsi_debug  (4*8MB)

size-2048       before:112 after:4102 diff:3990 size:2060 incr:8219400
size-512        before:87 after:8085 diff:7998 size:524 incr:4190952
size-192        before:907 after:16910 diff:16003 size:204 incr:3264612
size-64         before:459 after:76500 diff:76041 size:76 incr:5779116
size-32         before:523 after:24528 diff:24005 size:44 incr:1056220

* 30MB for all other structures. I need to look closely on what these are..

Thanks,
Badari

