Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937834AbWLGA0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937834AbWLGA0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 19:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937836AbWLGA0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 19:26:23 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:55345 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937834AbWLGA0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 19:26:22 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: workqueue deadlock
Date: Wed, 6 Dec 2006 17:26:14 -0700
User-Agent: KMail/1.9.5
Cc: Myron Stowe <myron.stowe@hp.com>, Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612061726.14587.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a workqueue-related deadlock.  This is on an ia64
box running SLES10, but it looks like the same problem should
be possible in current upstream on any architecture.

Here are the two tasks involved:

  events/4:
    schedule
    __down
    __lock_cpu_hotplug
    lock_cpu_hotplug
    flush_workqueue
    kblockd_flush
    blk_sync_queue
    cfq_shutdown_timer_wq
    cfq_exit_queue
    elevator_exit
    blk_cleanup_queue
    scsi_free_queue
    scsi_device_dev_release_usercontext
    run_workqueue

  loadkeys:
    schedule
    flush_cpu_workqueue
    flush_workqueue
    flush_scheduled_work
    release_dev
    tty_release

loadkeys is holding the cpu_hotplug lock (acquired in flush_workqueue())
and waiting in flush_cpu_workqueue() until the cpu_workqueue drains.

But events/4 is responsible for draining it, and it is blocked waiting
to acquire the cpu_hotplug lock.

In current upstream, the cpu_hotplug lock has been replaced with
workqueue_mutex, but it looks to me like the same deadlock is still
possible.

Is there some rule that workqueue functions shouldn't try to
flush a workqueue?  Or should flush_workqueue() be smarter by
releasing the workqueue_mutex once in a while?
