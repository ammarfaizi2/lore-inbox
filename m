Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261930AbTCaXd0>; Mon, 31 Mar 2003 18:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261931AbTCaXdZ>; Mon, 31 Mar 2003 18:33:25 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:17375 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261930AbTCaXcB> convert rfc822-to-8bit;
	Mon, 31 Mar 2003 18:32:01 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Joel.Becker@oracle.com
Subject: Re: 64-bit kdev_t - just for playing
Date: Mon, 31 Mar 2003 15:41:50 -0800
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303311541.50200.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm right here campaigning loudly for a larger dev_t. I intend 
> to never, ever make assumptions about dev_t. In fact, I'd rather not 
> deal with dev_t. But I do need a way to map 4k or 8k or 16k disks. 
> now. 
>
> Joel

 Hi Joel,

I have been playing with supporting 4000 disks on IA32 machines.
There are bunch of issues we need to resolve before we could
do that.

I am using scsi_debug to simulate 4000 disks. (Ofcourse, I had
to hack "sd" to support more than 256 disks). Anyway, I noticed
that I lost almost 350MB of my lowmem, when I simulated 4000 disks.
We are working on most of these. But there are userlevel issues
to be resolved. Here is the list ...

1) deadline_drq, blkdev_request consume 80 MB of low memory.
      - Jens is looking at it. He is working on a patch to allocate
requests dynamically.

2) sysfs inode use up 50 MB of low memory
        - 4000 disks without partitions create (4000 * 35) = 140,000 inodes in 
/sysfs.  So, it uses 50 MB of lowmem. 

3) dcache is eating up 25 MB of low memory.

4) kmalloc() slabs are consuming 55 MB. We are in the process
of identifying the heavy consumers and fixing them.
 	- Jens is fixing hash table size issues with io-schedulers.
	- I have patch to allocate "hd_struct" dynamically. So, if your disks
          does not have any partitions, you don't use any more memory.    

5) glibc and utility issues - lots of stuff are broken
    (Need a new libc)
        - mknod
        - ls
        - raw command
        - etc..

I have not done any IO on these yet. When I mount all of these and do
IO on them, we might see new issues. So with all these, I will be doubtful
if we can ever reach 16k disks on IA32.

Thanks,
Badari


