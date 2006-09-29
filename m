Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWI2MMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWI2MMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 08:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWI2MMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 08:12:31 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:55665 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S932077AbWI2MMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 08:12:30 -0400
Subject: md deadlock (was Re: 2.6.18-mm2)
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0609280454n34d40c0la8786e1eba6dcdf3@mail.gmail.com>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <6bffcb0e0609280454n34d40c0la8786e1eba6dcdf3@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 14:12:03 +0200
Message-Id: <1159531923.28131.80.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-28 at 13:54 +0200, Michal Piotrowski wrote:
> Hi,
> 
> On 28/09/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/
> >
> >
> 
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> 2.6.18-mm2 #1
> -------------------------------------------------------
> nash/1264 is trying to acquire lock:
>  (&bdev_part_lock_key){--..}, at: [<c0310d4a>] mutex_lock+0x1c/0x1f
> 
> but task is already holding lock:
>  (&new->reconfig_mutex){--..}, at: [<c03108ff>]
> mutex_lock_interruptible+0x1c/0x1f
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (&new->reconfig_mutex){--..}:
>        [<c01390b8>] add_lock_to_list+0x5c/0x7a
>        [<c013b1dd>] __lock_acquire+0x9f3/0xaef
>        [<c013b643>] lock_acquire+0x71/0x91
>        [<c031068f>] __mutex_lock_interruptible_slowpath+0xd2/0x326
>        [<c03108ff>] mutex_lock_interruptible+0x1c/0x1f
>        [<c02ba4e3>] md_open+0x28/0x5d			-> mddev->reconfig_mutex
>        [<c0197853>] do_open+0x8b/0x377			-> bdev->bd_mutex (whole)
>        [<c0197cd5>] blkdev_open+0x1d/0x46
>        [<c0172f36>] __dentry_open+0x133/0x260
>        [<c01730d1>] nameidata_to_filp+0x1c/0x2e
>        [<c0173111>] do_filp_open+0x2e/0x35
>        [<c0173170>] do_sys_open+0x58/0xde
>        [<c0173222>] sys_open+0x16/0x18
>        [<c0103297>] syscall_call+0x7/0xb
>        [<ffffffff>] 0xffffffff
> 
> -> #1 (&bdev->bd_mutex){--..}:
>        [<c01390b8>] add_lock_to_list+0x5c/0x7a
>        [<c013b1dd>] __lock_acquire+0x9f3/0xaef
>        [<c013b643>] lock_acquire+0x71/0x91
>        [<c0310b0f>] __mutex_lock_slowpath+0xd2/0x2f1
>        [<c0310d4a>] mutex_lock+0x1c/0x1f
>        [<c0197824>] do_open+0x5c/0x377
>        [<c0197bab>] blkdev_get+0x6c/0x77
>        [<c01978d0>] do_open+0x108/0x377
>        [<c0197bab>] blkdev_get+0x6c/0x77
>        [<c0197eb1>] open_by_devnum+0x30/0x3c
>        [<c0147419>] swsusp_check+0x14/0xc5
>        [<c0145865>] software_resume+0x7e/0x100
>        [<c010049e>] init+0x121/0x29f
>        [<c0103f23>] kernel_thread_helper+0x7/0x10
>        [<c0109523>] save_stack_trace+0x17/0x30
>        [<c0138fb0>] save_trace+0x4f/0xfb
>        [<c01390b8>] add_lock_to_list+0x5c/0x7a
>        [<c013b1dd>] __lock_acquire+0x9f3/0xaef
>        [<c013b643>] lock_acquire+0x71/0x91
>        [<c0310b0f>] __mutex_lock_slowpath+0xd2/0x2f1
>        [<c0310d4a>] mutex_lock+0x1c/0x1f
>        [<c0197824>] do_open+0x5c/0x377			-> bdev->bd_mutex (whole)
>        [<c0197bab>] blkdev_get+0x6c/0x77
>        [<c01978d0>] do_open+0x108/0x377			-> bdev->bd_mutex (partition)
>        [<c0197bab>] blkdev_get+0x6c/0x77
>        [<c0197eb1>] open_by_devnum+0x30/0x3c
>        [<c0147419>] swsusp_check+0x14/0xc5
>        [<c0145865>] software_resume+0x7e/0x100
>        [<c010049e>] init+0x121/0x29f
>        [<c0103f23>] kernel_thread_helper+0x7/0x10
>        [<ffffffff>] 0xffffffff
> 
> -> #0 (&bdev_part_lock_key){--..}:
>        [<c013a7b6>] print_circular_bug_tail+0x30/0x64
>        [<c013b114>] __lock_acquire+0x92a/0xaef
>        [<c013b643>] lock_acquire+0x71/0x91
>        [<c0310b0f>] __mutex_lock_slowpath+0xd2/0x2f1
>        [<c0310d4a>] mutex_lock+0x1c/0x1f
>        [<c0197323>] bd_claim_by_disk+0x5f/0x18e		-> bdev->bd_mutex (partition)
>        [<c02b44ec>] bind_rdev_to_array+0x1f0/0x20e
>        [<c02b6453>] autostart_arrays+0x24b/0x322
>        [<c02b9158>] md_ioctl+0x91/0x13f4
>        [<c01ea5bc>] blkdev_driver_ioctl+0x49/0x5b
>        [<c01ead23>] blkdev_ioctl+0x755/0x7a2
>        [<c0196f9d>] block_ioctl+0x16/0x1b
>        [<c01801d2>] do_ioctl+0x22/0x67
>        [<c0180460>] vfs_ioctl+0x249/0x25c
>        [<c01804ba>] sys_ioctl+0x47/0x75
>        [<c0103297>] syscall_call+0x7/0xb
>        [<ffffffff>] 0xffffffff
> 
> other info that might help us debug this:
> 
> 1 lock held by nash/1264:
>  #0:  (&new->reconfig_mutex){--..}, at: [<c03108ff>]
> mutex_lock_interruptible+0x1c/0x1f
> stack backtrace:
>  [<c0104215>] dump_trace+0x64/0x1cd
>  [<c0104390>] show_trace_log_lvl+0x12/0x25
>  [<c01049e5>] show_trace+0xd/0x10
>  [<c0104aad>] dump_stack+0x19/0x1b
>  [<c013a7df>] print_circular_bug_tail+0x59/0x64
>  [<c013b114>] __lock_acquire+0x92a/0xaef
>  [<c013b643>] lock_acquire+0x71/0x91
>  [<c0310b0f>] __mutex_lock_slowpath+0xd2/0x2f1
>  [<c0310d4a>] mutex_lock+0x1c/0x1f
>  [<c0197323>] bd_claim_by_disk+0x5f/0x18e		-> bdev->bd_mutex (part)
>  [<c02b44ec>] bind_rdev_to_array+0x1f0/0x20e
                autorun_devices				-> mddev->reconfig_mutex
>  [<c02b6453>] autostart_arrays+0x24b/0x322
>  [<c02b9158>] md_ioctl+0x91/0x13f4
>  [<c01ea5bc>] blkdev_driver_ioctl+0x49/0x5b
>  [<c01ead23>] blkdev_ioctl+0x755/0x7a2
>  [<c0196f9d>] block_ioctl+0x16/0x1b
>  [<c01801d2>] do_ioctl+0x22/0x67
>  [<c0180460>] vfs_ioctl+0x249/0x25c
>  [<c01804ba>] sys_ioctl+0x47/0x75
>  [<c0103297>] syscall_call+0x7/0xb
> DWARF2 unwinder stuck at syscall_call+0x7/0xb
> 
> Leftover inexact backtrace:

Looks like a real deadlock here. It seems to me #2 is the easiest to
break.

static int md_open(struct inode *inode, struct file *file)
{
	/*
	 * Succeed if we can lock the mddev, which confirms that
	 * it isn't being stopped right now.
	 */
	mddev_t *mddev = inode->i_bdev->bd_disk->private_data;
	int err;

	if ((err = mddev_lock(mddev)))
		goto out;

	err = 0;
	mddev_get(mddev);
	mddev_unlock(mddev);

	check_disk_change(inode->i_bdev);
 out:
	return err;
}

mddev_get() is a simple atomic_inc(), and I fail to see how waiting for
the lock makes any difference.



