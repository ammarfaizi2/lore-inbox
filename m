Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbVIAWUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbVIAWUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbVIAWUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:20:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58006 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030453AbVIAWUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:20:23 -0400
Date: Thu, 1 Sep 2005 15:22:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marco Perosa <marco.perosa@poste.it>
Cc: linux-kernel@vger.kernel.org, Neil Horman <nhorman@redhat.com>
Subject: Re: 2.6.13-mm1 - MAKEDEV - /proc/devices
Message-Id: <20050901152237.23f62e71.akpm@osdl.org>
In-Reply-To: <20050901204555.10b32a42.marco.perosa@poste.it>
References: <20050901204555.10b32a42.marco.perosa@poste.it>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Perosa <marco.perosa@poste.it> wrote:
>
> Hi there,
> I've just tried the 2.6.13-mm1 kernel,

Thanks for doing that.

> and at the new boot i've noticed a strange stop in the init sequence.
> Not a freeze, the system will shutdown with ctrl+alt+canc (even though it give a timeout on /dev/initctl).
> After some tests i've figured out that the problem is in the init script /etc/init.d/makedev.
> In fact if i run a "MAKEDEV something" in the /dev directory, i obtain the same problem.
> When this happens, /proc/devices becomes also inacessible, and it's impossible to exec any other program that requires a new shell.
> ps shows them ('MAKEDEV something' and 'cat /proc/devices') as D+.
> 
> It all works fine removing the makedev script from the init sequence, i use udev so it's not a problem at all.
> Anyway, it should be good to figure out where's the problem, so, in the hoping that it will be useful, I enclose the config of my kernel and the kernel trace (the process is #2786).
> 

This:

Sep  1 20:14:30 localhost kernel: MAKEDEV       D F56A0000     0  2786   2758                     (NOTLB)
Sep  1 20:14:30 localhost kernel: f5553ea8 f54f8c50 c0671a20 f56a0000 c18dfa80 00000000 f5553ea4 c014cc2e 
Sep  1 20:14:30 localhost kernel:        c18df080 f56a0000 0000006b 0003d741 62301160 00000078 f54f8c50 f54f8d78 
Sep  1 20:14:30 localhost kernel:        f5552000 c0566020 00000246 f5553ee4 c04dc9d4 c0566028 f54f8c50 00000001 
Sep  1 20:14:30 localhost kernel: Call Trace:
Sep  1 20:14:30 localhost kernel:  [__down+132/320] __down+0x84/0x140
Sep  1 20:14:30 localhost kernel:  [__sched_text_start+10/16] __down_failed+0xa/0x10
Sep  1 20:14:30 localhost kernel:  [.text.lock.char_dev+11/121] .text.lock.char_dev+0xb/0x79
Sep  1 20:14:30 localhost kernel:  [devinfo_start+103/176] devinfo_start+0x67/0xb0
Sep  1 20:14:30 localhost kernel:  [traverse+112/432] traverse+0x70/0x1b0
Sep  1 20:14:30 localhost kernel:  [seq_lseek+168/288] seq_lseek+0xa8/0x120
Sep  1 20:14:30 localhost kernel:  [vfs_llseek+74/80] vfs_llseek+0x4a/0x50
Sep  1 20:14:30 localhost kernel:  [sys_llseek+83/176] sys_llseek+0x53/0xb0
Sep  1 20:14:30 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep  1 20:14:30 localhost kernel: ---------------------------
Sep  1 20:14:30 localhost kernel: | preempt count: 00000002 ]
Sep  1 20:14:30 localhost kernel: | 2 level deep critical section nesting:
Sep  1 20:14:30 localhost kernel: ----------------------------------------

I'd assume that convert-proc-devices-to-use-seq_file-interface.patch got
confused and failed to release chrdevs_lock.  That

	(info->cur_record >= info->num_records)

in devinfo_stop() looks fishy.

Over to you, Neil...
