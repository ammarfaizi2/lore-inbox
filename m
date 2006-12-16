Return-Path: <linux-kernel-owner+w=401wt.eu-S1030667AbWLPGtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030667AbWLPGtV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 01:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030664AbWLPGtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 01:49:21 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:56544 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030667AbWLPGtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 01:49:20 -0500
X-Greylist: delayed 1365 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 01:49:20 EST
Date: Fri, 15 Dec 2006 23:26:33 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Doubled stack dumps during locking testsuite
Message-ID: <20061216062633.GY21070@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

I built a parisc kernel with CONFIG_DEBUG_LOCKING_API_SELFTESTS enabled
recently, and got some interesting results:

                    double unlock:  ok  |  ok  |failed|WARNING at /home/willy/merge-2.6/kernel/mutex-debug.c:83 debug_mutex_unlock()
Backtrace:
 [<0000000040144b38>] printk+0x40/0x50
 [<000000004028d5f4>] init_class_Z+0xa4/0xc0
 [<0000000040144b38>] printk+0x40/0x50
 [<0000000040171fbc>] register_cpu_notifier+0x5c/0x78
 [<0000000040340212>] lpfc_sli_issue_mbox_wait+0x138/0x1c8
 [<0000000040204d01>] sg_grt_trans+0x150/0x168
 [<0000000040285700>] kobject_uevent+0x8/0x20
 [<0000000040304d65>] scsi_error_handler+0x9f4/0xa48
 [<0000000040207450>] dump_write+0x40/0x58
 [<000000004044c67c>] packet_getsockopt+0x144/0x150
 [<000000004044b05c>] packet_ioctl+0x1a4/0x1b0
 [<00000000404466d4>] unix_ioctl+0x154/0x168
 [<000000004042d5dc>] ipv4_sysctl_forward_strategy+0x12c/0x138
 [<000000004042d558>] ipv4_sysctl_forward_strategy+0xa8/0x138
 [<000000004042c1d4>] ip_mc_msfget+0x16c/0x1d0
 [<00000000404230a8>] ipv4_doint_and_flush_strategy+0x110/0x138

WARNING at /home/willy/merge-2.6/kernel/mutex-debug.c:86 debug_mutex_unlock()
Backtrace:
 [<0000000040144b38>] printk+0x40/0x50
 [<000000004028d5f4>] init_class_Z+0xa4/0xc0
 [<0000000040144b38>] printk+0x40/0x50
 [<0000000040171fbc>] register_cpu_notifier+0x5c/0x78
 [<0000000040340212>] lpfc_sli_issue_mbox_wait+0x138/0x1c8
 [<0000000040204d01>] sg_grt_trans+0x150/0x168
 [<0000000040285700>] kobject_uevent+0x8/0x20
 [<0000000040304d65>] scsi_error_handler+0x9f4/0xa48
 [<0000000040207450>] dump_write+0x40/0x58
 [<000000004044c67c>] packet_getsockopt+0x144/0x150
 [<000000004044b05c>] packet_ioctl+0x1a4/0x1b0
 [<00000000404466d4>] unix_ioctl+0x154/0x168
 [<000000004042d5dc>] ipv4_sysctl_forward_strategy+0x12c/0x138
 [<000000004042d558>] ipv4_sysctl_forward_strategy+0xa8/0x138
 [<000000004042c1d4>] ip_mc_msfget+0x16c/0x1d0
 [<00000000404230a8>] ipv4_doint_and_flush_strategy+0x110/0x138

failed|failed|failed|

Now, lines 83 to 86 of mutex-debug.c are:

        DEBUG_LOCKS_WARN_ON(lock->owner != current_thread_info());
        DEBUG_LOCKS_WARN_ON(lock->magic != lock);
        DEBUG_LOCKS_WARN_ON(!lock->wait_list.prev && !lock->wait_list.next);
        DEBUG_LOCKS_WARN_ON(lock->owner != current_thread_info());

Do we really need to test the same thing twice and produce the same
stack dump?

Moreover, do we want to get stack dumps while running the locking
testsuite in the first place?  From various comments, it looks
like it's supposed to be turned off, but it looks like the sense of
debug_locks_silent is inverted in the definition of DEBUG_LOCKS_WARN_ON:

        if (unlikely(c)) {                                              \
                if (debug_locks_silent || debug_locks_off())            \
                        WARN_ON(1);                                     \

Surely that should be:

		if (!debug_locks_silent && debug_locks_off())
			WARN_ON(1);

