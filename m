Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422862AbWJaIWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422862AbWJaIWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422863AbWJaIWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:22:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45459 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422858AbWJaIWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:22:54 -0500
Date: Tue, 31 Oct 2006 00:22:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 002 of 6] md: Change lifetime rules for 'md' devices.
Message-Id: <20061031002245.dfd1bb66.akpm@osdl.org>
In-Reply-To: <1061031060051.5046@suse.de>
References: <20061031164814.4884.patches@notabene>
	<1061031060051.5046@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006 17:00:51 +1100
NeilBrown <neilb@suse.de> wrote:

> Currently md devices are created when first opened and remain in existence
> until the module is unloaded.
> This isn't a major problem, but it somewhat ugly.
> 
> This patch changes the lifetime rules so that an md device will
> disappear on the last close if it has no state.

This kills the G5:


EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=4 
Modules linked in:
NIP: C0000000001A31B8 LR: C00000000018E5DC CTR: C0000000001A3404
REGS: c0000000017ff4a0 TRAP: 0300   Not tainted  (2.6.19-rc4-mm1)
MSR: 9000000000009032 <EE,ME,IR,DR>  CR: 84000048  XER: 00000000
DAR: 6B6B6B6B6B6B6BB3, DSISR: 0000000040000000
TASK = c00000000ff2b7f0[1899] 'nash' THREAD: c0000000017fc000 CPU: 1
GPR00: 0000000000000008 C0000000017FF720 C0000000006B26D0 6B6B6B6B6B6B6B7B 
GPR04: 0000000000000002 0000000000000001 0000000000000001 00000000000200D0 
GPR08: 0000000000050C00 C0000000001A3404 0000000000000000 C0000000001A318C 
GPR12: 0000000084000044 C000000000535680 00000000100FE350 00000000100FE7B8 
GPR16: 00000000FFFFFFFF 00000000FFFFFFFF 0000000000000000 0000000000000000 
GPR20: 0000000010005CD4 0000000010090000 0000000000000000 0000000010007E54 
GPR24: 0000000000000000 C000000000472C80 6B6B6B6B6B6B6B7B C000000001FD2530 
GPR28: C000000007B8C2F0 6B6B6B6B6B6B6B7B C00000000057DAE8 C0000000079A2550 
NIP [C0000000001A31B8] .kobject_uevent+0xac/0x55c
LR [C00000000018E5DC] .__elv_unregister_queue+0x20/0x44
Call Trace:
[C0000000017FF720] [C000000000562508] read_pipe_fops+0xd0/0xd8 (unreliable)
[C0000000017FF840] [C00000000018E5DC] .__elv_unregister_queue+0x20/0x44
[C0000000017FF8D0] [C000000000195548] .blk_unregister_queue+0x58/0x9c
[C0000000017FF960] [C00000000019683C] .unlink_gendisk+0x1c/0x50
[C0000000017FF9F0] [C000000000122840] .del_gendisk+0x98/0x22c
[C0000000017FFA90] [C00000000035B56C] .mddev_put+0xa0/0xe0
[C0000000017FFB20] [C000000000362178] .md_release+0x84/0x9c
[C0000000017FFBA0] [C0000000000FDDE0] .__blkdev_put+0x204/0x220
[C0000000017FFC50] [C0000000000C765C] .__fput+0x234/0x274
[C0000000017FFD00] [C0000000000C5264] .filp_close+0x6c/0xfc
[C0000000017FFD90] [C0000000000C53B8] .sys_close+0xc4/0x178
[C0000000017FFE30] [C00000000000872C] syscall_exit+0x0/0x40
Instruction dump:
4e800420 00000020 00000250 00000278 00000280 00000258 00000260 00000268 
00000270 3b200000 2fb90000 419e003c <e81a0038> 2fa00000 7c1d0378 409e0070 
 <7>eth0: no IPv6 routers present

It happens during initscripts.  The machine has no MD devices.  config is
at http://userweb.kernel.org/~akpm/config-g5.txt

Also, it'd be nice to enable CONFIG_MUST_CHECK and take a look at a few
things...

drivers/md/md.c: In function `bind_rdev_to_array':
drivers/md/md.c:1379: warning: ignoring return value of `kobject_add', declared with attribute warn_unused_result
drivers/md/md.c:1385: warning: ignoring return value of `sysfs_create_link', declared with attribute warn_unused_result
drivers/md/md.c: In function `md_probe':
drivers/md/md.c:2986: warning: ignoring return value of `kobject_register', declared with attribute warn_unused_result
drivers/md/md.c: In function `do_md_run':
drivers/md/md.c:3135: warning: ignoring return value of `sysfs_create_group', declared with attribute warn_unused_result
drivers/md/md.c:3150: warning: ignoring return value of `sysfs_create_link', declared with attribute warn_unused_result
drivers/md/md.c: In function `md_check_recovery':
drivers/md/md.c:5446: warning: ignoring return value of `sysfs_create_link', declared with attribute warn_unused_result


