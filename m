Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWEDAbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWEDAbU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 20:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWEDAbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 20:31:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45960 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750787AbWEDAbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 20:31:20 -0400
Date: Wed, 3 May 2006 20:31:16 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: spinlock recursion bug (2.6.17rc3)
Message-ID: <20060504003116.GA3350@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was moving a 1.2G file over an NFS mount, and wondered why
it had stalled making no progress.  Then my X session locked up
completely, however I was able to ssh in.
running free showed that it was *really* low on memory, yet
there was a ton of stuff in buffers/caches.

It sat there spinning for about 10 minutes making no progress at all
In desperation, I tried throwing away those caches with..

echo 3 > /proc/sys/vm/drop_caches

And then got this over serial console before the box locked up completely.

BUG: spinlock cpu recursion on CPU#1, rhythmbox/31182
 lock: ffffffff80547e80, .magic: dead4ead, .owner: bash/32124, .owner_cpu: 1

Call Trace: <ffffffff80213a52>{spin_bug+176} <ffffffff802cb822>{bdev_test+0}
       <ffffffff80207827>{_raw_spin_lock+88} <ffffffff8025db4d>{ifind+35}
       <ffffffff802d0928>{iget5_locked+112} <ffffffff802ca848>{bdev_set+0}
       <ffffffff802cb67e>{blkdev_open+0} <ffffffff802cafbc>{bdget+63}
       <ffffffff802cb53e>{bd_acquire+71} <ffffffff802cb691>{blkdev_open+19}
       <ffffffff8021ed42>{__dentry_open+217} <ffffffff80227e8f>{do_filp_open+42}       <ffffffff8020c255>{cache_alloc_debugcheck_after+307}
       <ffffffff802163e2>{get_unused_fd+249} <ffffffff8021a394>{do_sys_open+68}
       <ffffffff80261bc1>{tracesys+209}

On reboot, I tried to repeat the same operation, and it worked just fine.
Hrmph.

		Dave

-- 
http://www.codemonkey.org.uk
