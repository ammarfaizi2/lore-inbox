Return-Path: <linux-kernel-owner+w=401wt.eu-S965152AbXAJWiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbXAJWiK (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbXAJWiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:38:10 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36079 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965152AbXAJWiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:38:09 -0500
Date: Thu, 11 Jan 2007 09:37:31 +1100
From: David Chinner <dgc@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: [REGRESSION] 2.6.19/2.6.20-rc3 buffered write slowdown
Message-ID: <20070110223731.GC44411608@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Discussion thread:

http://oss.sgi.com/archives/xfs/2007-01/msg00052.html

Short story is that buffered writes slowed down by 20-30%
between 2.6.18 and 2.6.19 and became a lot more erratic.
Writing a single file to a single filesystem doesn't appear
to have major problems, but when writing a file per filesystem
and using 3 filesystems performance is much worse on 2.6.19
and is only slightly better on 2.6.20-rc3.

It doesn't appear to be fragmentation (I wrote quite a few
800GB files when testing this and they all had "perfect"
extent layouts (i.e. extents the size of allocation groups
and in sequential AGs). It's not the block devices, either,
as doing the same I/O to the block device gives the same
results.

My test case is effectively:

#!/bin/bash

mkfs.xfs -f -l version=2 -d sunit=512,swidth=2048 /dev/dm-0
mkfs.xfs -f -l version=2 -d sunit=512,swidth=2048 /dev/dm-1
mkfs.xfs -f -l version=2 -d sunit=512,swidth=2048 /dev/dm-2

mount /dev/dm-0 /mnt/dm0
mount /dev/dm-1 /mnt/dm1
mount /dev/dm-2 /mnt/dm2

dd if=/dev/zero of=/mnt/dm0/test bs=1024k count=800k &
dd if=/dev/zero of=/mnt/dm1/test bs=1024k count=800k &
dd if=/dev/zero of=/mnt/dm2/test bs=1024k count=800k &
wait

unmount /mnt/dm0
unmount /mnt/dm1
unmount /mnt/dm2

#EOF

Overall, on 2.6.18 this gave an average of about 240MB/s per
filesystem with minimum write rates of about 190MB/s per fs
(when writing near the inner edge of the disks).

On 2.6.20-rc3, this gave and average of ~200MB/s per fs
with minimum write rates of about 110MB/s per fs which
occurrred randomly throughout the test.

The performance and smoothness is fully restored on 2.6.20-rc3
by setting dirty_ratio down to 10 (from the default 40), so
something in the VM is not working as well as it used to....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
