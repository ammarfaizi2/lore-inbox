Return-Path: <linux-kernel-owner+w=401wt.eu-S965063AbWLODrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbWLODrs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 22:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWLODrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 22:47:48 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:52612 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965063AbWLODrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 22:47:47 -0500
Subject: [BUG -rt] scheduling in atomic.
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 22:47:43 -0500
Message-Id: <1166154463.19210.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I've hit this. I compiled the kernel as CONFIG_PREEMPT, and turned off
IRQ's as threads.

BUG: scheduling while atomic: swapper/0x00000001/1, CPU#3

Call Trace:
 [<ffffffff8026f9b0>] dump_trace+0xaa/0x404
 [<ffffffff8026fd46>] show_trace+0x3c/0x52
 [<ffffffff8026fd71>] dump_stack+0x15/0x17
 [<ffffffff8026562a>] __sched_text_start+0x8a/0xbb7
 [<ffffffff80266492>] schedule+0xd3/0xf3
 [<ffffffff802a11bd>] flush_cpu_workqueue+0x72/0xa4
 [<ffffffff802a125c>] flush_workqueue+0x6d/0x95
 [<ffffffff802a19a8>] schedule_on_each_cpu+0xe8/0xff
 [<ffffffff802dc927>] filevec_add_drain_all+0x12/0x14
 [<ffffffff80304701>] remove_proc_entry+0xaf/0x258
 [<ffffffff802c1782>] unregister_handler_proc+0x23/0x48
 [<ffffffff802bff91>] free_irq+0xda/0x114
 [<ffffffff803fe3fa>] i8042_probe+0x338/0x75c
 [<ffffffff803ba4b1>] platform_drv_probe+0x12/0x14
 [<ffffffff803b8b00>] really_probe+0x54/0xee
 [<ffffffff803b8c48>] driver_probe_device+0xae/0xba
 [<ffffffff803b8c5d>] __device_attach+0x9/0xb
 [<ffffffff803b7ef8>] bus_for_each_drv+0x47/0x7d
 [<ffffffff803b8cc4>] device_attach+0x65/0x79
 [<ffffffff803b7e89>] bus_attach_device+0x24/0x4c
 [<ffffffff803b6f7d>] device_add+0x38f/0x505
 [<ffffffff803ba7ca>] platform_device_add+0x11a/0x152
 [<ffffffff808e1d1f>] i8042_init+0x2b0/0x30d
 [<ffffffff8026ea53>] init+0x182/0x344
 [<ffffffff80261f08>] child_rip+0xa/0x12


Seems that we have this in remove_proc_entry:

	spin_lock(&proc_subdir_lock);
	for (p = &parent->subdir; *p; p=&(*p)->next ) {

		[...]

		proc_kill_inodes(de);

		[...]

	}
	spin_unlock(&proc_subdir_lock);

And in proc_kill_inodes:

static void proc_kill_inodes(struct proc_dir_entry *de)
{
	struct file *filp;
	struct super_block *sb = proc_mnt->mnt_sb;

	/*
	 * Actually it's a partial revoke().
	 */
	filevec_add_drain_all();

	[...]
}

and in filevec_add_drain_all:

int filevec_add_drain_all(void)
{
	return schedule_on_each_cpu(filevec_add_drain_per_cpu, NULL);
}


And schedule_on_each_cpu is easily schedulable.

So it seems that it schedules while holding a spin lock.

I don't know this code very well, and don't have time to look too deep
into it, but I figure that I would report it.

-- Steve




