Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVCIWFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVCIWFH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVCIWCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:02:55 -0500
Received: from fmr21.intel.com ([143.183.121.13]:40139 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262495AbVCIV7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:59:33 -0500
Message-Id: <200503092159.j29LxIg26267@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Subject: RE: Direct io on block device has performance regression on 2.6.x kernel
Date: Wed, 9 Mar 2005 13:59:17 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUk41c0T8r0hQONT7+Vrd+cGQzRygADEiRg
In-Reply-To: <20050309120458.7c25f5e3.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Wednesday, March 09, 2005 12:05 PM
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> > Let me answer the questions in reverse order.  We started with running
> > industry standard transaction processing database benchmark on 2.6 kernel,
> > on real hardware (4P smp, 64 GB memory, 450 disks) running industry
> > standard db application.  What we measured is that with best tuning done
> > to the system, 2.6 kernel has a huge performance regression relative to
> > its predecessor 2.4 kernel (a kernel from RHEL3, 2.4.21 based).
>
> That's news to me.  I thought we were doing OK with big database stuff.
> Surely lots of people have been testing such things.

There are different level of "big" stuff.  We used to work on 32-way numa
box, but other show stopper issues popping up before we get to the I/O stack.
The good thing came out of that work is the removal of global unplug lock.


> > And yes, it is all worth pursuing, the two patches on raw device recuperate
> > 1/3 of the total benchmark performance regression.
>
> On a real disk driver?  hm, I'm wrong then.
>

Yes, on real disk driver (qlogic fiber channel) and with real 15K rpm disks.


> Did you generate a kernel profile?

Top 40 kernel hot functions, percentage is normalized to kernel utilization.

_spin_unlock_irqrestore		23.54%
_spin_unlock_irq			19.27%
__blockdev_direct_IO		3.57%
follow_hugetlb_page		1.84%
e1000_clean				1.38%
kmem_cache_alloc			1.31%
put_page				1.29%
__generic_file_aio_read		1.18%
e1000_intr				1.07%
schedule				1.01%
dio_bio_complete			0.97%
mempool_alloc			0.96%
kmem_cache_free			0.90%
__end_that_request_first	0.88%
__copy_user				0.82%
kfree					0.77%
generic_make_request		0.73%
_spin_lock				0.73%
kref_put				0.73%
vfs_read				0.68%
update_atime			0.68%
scsi_dispatch_cmd			0.67%
fget_light				0.66%
put_io_context			0.60%
_spin_lock_irqsave		0.58%
scsi_finish_command		0.58%
generic_file_aio_write_nolock	0.57%
inode_times_differ		0.55%
break_fault				0.53%
__do_softirq			0.48%
aio_read_evt			0.48%
try_atomic_semop			0.44%
sys_pread64				0.43%
__bio_add_page			0.43%
__mod_timer				0.42%
bio_alloc				0.41%
scsi_decide_disposition		0.40%
e1000_clean_rx_irq		0.39%
find_vma				0.38%
dnotify_parent			0.38%


Profile with spin lock inlined, so that it is easier to see functions
that has the lock contention, again top 40 hot functions:

scsi_request_fn		7.54%
finish_task_switch	6.25%
__blockdev_direct_IO	4.97%
__make_request		3.87%
scsi_end_request		3.54%
dio_bio_end_io		2.70%
follow_hugetlb_page	2.39%
__wake_up			2.37%
aio_complete		1.82%
kmem_cache_alloc		1.68%
__mod_timer			1.63%
e1000_clean			1.57%
__generic_file_aio_read	1.42%
mempool_alloc		1.37%
put_page			1.35%
e1000_intr			1.31%
schedule			1.25%
dio_bio_complete		1.20%
scsi_device_unbusy	1.07%
kmem_cache_free		1.06%
__copy_user			1.04%
scsi_dispatch_cmd		1.04%
__end_that_request_first1.04%
generic_make_request	1.02%
kfree				0.94%
__aio_get_req		0.93%
sys_pread64			0.83%
get_request			0.79%
put_io_context		0.76%
dnotify_parent		0.73%
vfs_read			0.73%
update_atime		0.73%
finished_one_bio		0.63%
generic_file_aio_write_nolock	0.63%
scsi_put_command		0.62%
break_fault			0.62%
e1000_xmit_frame		0.62%
aio_read_evt		0.59%
scsi_io_completion	0.59%
inode_times_differ	0.58%



