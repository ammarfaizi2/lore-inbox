Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTL2JeR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 04:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTL2JeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 04:34:17 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:33439 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263158AbTL2Jc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 04:32:56 -0500
Date: Mon, 29 Dec 2003 15:02:13 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: [RFC 0/5] sysfs backing store (leaves only)
Message-ID: <20031229093213.GA1649@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

The following patch set(mailed separately) implements a backing store 
mechanism for sysfs filesystem but only for leaf entires. In the previous 
attempt I tried to do backing store for all the entires in sysfs (directories 
& regular files) but that prototype had problems related to coherency between 
sysfs tree and VFS based dentry tree and solution for which will probably need 
VFS layer changes.

In leaves only backing store, attribute files, text or binary, are created on 
demand and there is no need to pin the dentries & inodes corresponding to 
such sysfs files. Generally there are around 60-70% leaf entries in sysfs
tree. Non-regular files (directories and symlinks) are pinned as usual. This
helps in solving the coherency problem as we can use the parent inode's (or
directory's) i_sem while creating, removing or walking files present in 
a given directory.

There are no changes in the way sysfs or kobjects are used. All interfaces
are same and function as without this patch.

Please review the patch set following this posting. I have also collected 
following numbers in support of the backing store.

Test1
-----
Following test shows how dentries are created on demand and are pruned 
whenever there is a memory pressure. 

- after boot
[root@llm04 root]# cat /proc/sys/fs/dentry-state
6900    5783    45      0       0       0

[root@llm04 root]# mount -t sysfs none /sys
[root@llm04 root]# cat /proc/sys/fs/dentry-state
6902    5784    45      0       0       0

[root@llm04 root]# tree /sys | tail -1
848 directories, 2171 files
[root@llm04 root]# cat /proc/sys/fs/dentry-state
9081    7968    45      0       0       0

Ran some memory stress test (mmapstress01 from ltp-full-20031106)
and parallely watching dentry statistics. 

[root@llm04 tmp]# ./mmapstress01 -p 4 -f 1000000000
write error: No space left on device
mmapstress01    1  FAIL  :  Test failed

[root@llm04 root]# while true; do cat /proc/sys/fs/dentry-state; sleep 2; done
9087    7974    45      0       0       0
9089    7976    45      0       0       0
9091    7977    45      0       0       0
9091    7977    45      0       0       0
9091    7977    45      0       0       0
9091    7977    45      0       0       0
9091    7897    45      0       0       0
9091    7879    45      0       0       0
6977    5844    45      0       0       0   <===== dcache pruning started here
6423    5293    45      0       0       0
6422    5294    45      0       0       0
6422    5294    45      0       0       0
6422    5294    45      0       0       0

As the numbers are collected from /proc/sys/fs/dentry-state, they are for 
entire system. But because during measurement there were file creation/removal 
in sysfs tree only, I think we can consider most of them correspond to sysfs.
The test was done on a 4-way SMP box with 512 MB RAM.


Test 2
------
One more test I did was trying to create 4000 scsi_debug disks and observe the 
lowmem statistics on a 2-way SMP box with 4.5 GB RAM.

After creating 4000 debug disks we have the following stats: 
(Please bear that I couldn't actually create 4000 disks because of error I was 
getting regarding scsi generic device (minor number exceeded 255) but I was 
able to create lots of sysfs entries more than 50 thousand.

With backing store patch
========================
		/proc/sys/fs/dentry-state 			LowFree 
no sysfs 	22903   4132    45      0       0       0 	780664 kB
mount 		22904   4133    45      0       0       0 	780600 kB

cat /sys/block/sdk/queue/nr_requests
128
		22905   4134    45      0       0       0 	780600 kB

tree /sys | tail -1
18557 directories, 48510 files
		71410   52639   45      0       0       0 	749040 kB

umount -f /sys/
		22905   4134    45      0       0       0 	780088 kB


Without backing store 
=====================
		/proc/sys/fs/dentry-state; 			LowFree 
no sysfs	71395   4114    45      0       0       0;	 767412 kB
mount sysfs	71396   4115    45      0       0       0;       767476 kB

cat /sys/block/sdk/queue/nr_requests
128
		71396   4115    45      0       0       0;        767540 kB

tree /sys  |tail -1
18557 directories, 48510 files
		71396   4115    45      0       0       0;        767340 kB

umount -f /sys
		71397   4116    45      0       0       0;        767340 kB

As we can see there is no change in Lowmem stats without patch when we
mount or unmount sysfs. Where as with backing store patch we can save approx. 
30 MB of lowmem in when sysfs files are not in use. 

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
