Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWCMWCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWCMWCb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWCMWCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:02:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7359 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932489AbWCMWC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:02:29 -0500
Message-ID: <4415EC4B.4010003@ce.jp.nec.com>
Date: Mon, 13 Mar 2006 17:03:55 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Alasdair Kergon <agk@redhat.com>,
       Greg KH <gregkh@suse.de>, Neil Brown <neilb@suse.de>
CC: Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] dm/md dependency tree in sysfs (rev.4)
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is an updated version of "dm/md dependency tree in sysfs" patch.
For example, if dm-0 maps to sda, we'll have following symlinks;
   /sys/block/dm-0/slaves/sda --> /sys/block/sda
   /sys/block/sda/holders/dm-0 --> /sys/block/dm-0

Difference from the previous version is a fix for a problem
of calling possibly-sleeping function inside the fast path.
There were 3 such calls in my previous bd_claim patch:
   - kmalloc(GFP_KERNEL)
   - sysfs_create_symlink()
   - sysfs_remove_symlink()
The allocation code is moved outside of locks.
Symlink operations needs to be atomic, so they are moved out
of global bdev_lock and use bdev->bd_sem instead.

Comments are welcome.

I tested this on 2.6.16-rc6 and 2.6.16-rc6-mm1 with both
CONFIG_PREEMPT and CONFIG_DEBUG_SPINLOCK_SLEEP enabled
and saw no warnings in kernel log.

Patches included are:

  1. [PATCH 1/7] kobject_add_dir
     Adding kobject_add_dir() function which creates
     a subdirectory for a given kobject.

  2. [PATCH 2/7] add holders/slaves subdirectory to /sys/block
     Creating "slaves" and "holders" directories in /sys/block/<disk>,
     creating "holders" directory under /sys/block/<disk>/<partition>

  3. [PATCH 3/7] bd_claim_by_kobject
     Adding bd_claim_by_kobject() function which takes kobject as
     additional signature of holder device and creates sysfs symlinks
     between holder device and claimed device.
     bd_release_from_kobject() is a counter part of bd_claim_by_kobject.

  4. [PATCH 4/7] bd_claim_by_disk
     Variants which take gendisk instead of kobject
     and do kobject_{get,put}(&gendisk->kobj).

  5. [PATCH 5/7] md to use bd_claim_by_disk
     Use bd_claim_by_disk.

  6. [PATCH 6/7] dm to use bd_claim_by_disk
     Use bd_claim_by_disk.

  7. [PATCH 7/7] conver bd_sem to bd_mutex
     bd_sem is converted to bd_mutex in 2.6.16-rc6-mm1.
     The patch follows that conversion.

Patch 3 includes the fix mentioned above.

Patch 6 depends on dm-table-store-md.patch and dm-tidy-mdptr.patch
which were committed to -mm yesterday.

Patch 7 depends on sem2mutex-blockdev-2.patch in 2.6.16-rc6-mm1.

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

