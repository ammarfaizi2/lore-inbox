Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWBVQFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWBVQFY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWBVQFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:05:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43470 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932255AbWBVQFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:05:23 -0500
Message-ID: <43FC8C00.5020600@ce.jp.nec.com>
Date: Wed, 22 Feb 2006 11:06:24 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>, Alasdair Kergon <agk@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>, Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org,
       device-mapper development <dm-devel@redhat.com>
Subject: [PATCH 0/3] sysfs representation of stacked devices (dm/md) (rev.2)
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a revised set of pathces which provides common
representation of dependencies between stacked devices (dm and md)
in sysfs.

Variants of bd_claim/bd_release are added to accept a kobject
and create symlinks between the claimed bdev and the holder.

dm/md will give a child of its gendisk kobject to bd_claim.
For example, if dm-0 maps to sda, we have the following symlinks;
   /sys/block/dm-0/slaves/sda --> /sys/block/sda
   /sys/block/sda/holders/dm-0 --> /sys/block/dm-0

Comments are welcome.

A few points I would appreciate comments/reviews from maintainers:
  About sysfs
    - I confirmed sysfs_remove_symlink() and kobject_del() don't
      allocate memory in 2.6.15 and it seems true on the git head.
      I would like to make sure it's true in future versions of kernel
      because they are called during device-mapper's table swapping
      where I/O to free memory could deadlock on the dm device.
      What is the recommended way to do that?
      Or can I just expect these functions will not allocate memory
      in future versions of kernel?
  About dm
    - To get a reference to mapped_device, table_load() do
      dm_get() before populating table. It will dm_put() when
      the table is being discarded or the table is being activated.
  About md
    - Rather than carrying mddev pointer around, bd_claim is now
      made twice. First is not changed at lock_rdev().
      The second is at bind_rdev_to_array() where kobject is passed
      and symlinks are created.

-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.
