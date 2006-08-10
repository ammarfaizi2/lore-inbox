Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161352AbWHJPiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161352AbWHJPiQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161355AbWHJPiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:38:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63433 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161352AbWHJPiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:38:15 -0400
Date: Thu, 10 Aug 2006 08:38:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2   [oops: shrink_dcache_for_umount_subtree ?]
Message-Id: <20060810083806.a50c70ed.akpm@osdl.org>
In-Reply-To: <44DB3819.3050902@reub.net>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<44DB3819.3050902@reub.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006 01:43:53 +1200
Reuben Farrelly <reuben-lkml@reub.net> wrote:

> 
> 
> On 6/08/2006 10:08 p.m., Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> > 
> > - 2.6.18-rc3-mm1 gets mysterious udev timeouts during boot and crashes in
> >   NFS.  This kernel reverts the patches which were causing that.
> 
> Just hit this one upon shutdown (no traces logged before then):
> 
> INIT: Sending processes the TERM signal
> INITStopping clamd: [FAILED]
> Starting killall:  Stopping clamd: [FAILED]
> [  OK  ]
> Sending all processes the TERM signal...
> Sending all processes the KILL signal...
> Saving random seed:
> Syncing hardware clock to system time
> Turning off swap:
> Unmounting file systems:  umount2: Device or resource busy
> umount: /var/www/html: device is busy
> umount2: Device or resource busy
> umount: /var/www/html: device is busy
> BUG: Dentry ffff81003d0f34f0{i=3,n=.reiserfs_priv} still in use (1) [unmount of 
> reiserfs sdc8]
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at fs/dcache.c:611
> invalid opcode: 0000 [1] SMP
> last sysfs file: 
> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/bInterfaceProtocol
> CPU 0
> Modules linked in: ipv6 ip_gre binfmt_misc i2c_i801 iTCO_wdt serio_raw
> Pid: 22715, comm: umount Not tainted 2.6.18-rc3-mm2 #1
> RIP: 0010:[<ffffffff802ce943>]  [<ffffffff802ce943>] 
> shrink_dcache_for_umount_subtree+0x1a3/0x2a7
> RSP: 0018:ffff81002ec6fd98  EFLAGS: 00010292
> RAX: 0000000000000062 RBX: ffff81003d0f34f0 RCX: 0000000000000003
> RDX: 0000000000000008 RSI: ffff810035224740 RDI: ffff810035224040
> RBP: ffff81002ec6fdb8 R08: 0000000000000001 R09: 0000000000000001
> R10: ffffffff80216800 R11: 0000000000000000 R12: ffff81003d0f34f0
> R13: ffff8100025b2ce8 R14: ffff81002f936d30 R15: 0000000000000000
> FS:  00002b532ecdd4b0(0000) GS:ffffffff808b5000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00002b532ecd0000 CR3: 000000003273e000 CR4: 00000000000006e0
> Process umount (pid: 22715, threadinfo ffff81002ec6e000, task ffff810035224040)
> Stack:  ffff81003d29c980 ffff81003d29c588 ffffffff80595640 ffff81002ec6fea8
>   ffff81002ec6fdd8 ffffffff802ceea9 ffffffff805955e0 ffff81003d29c588
>   ffff81002ec6fe08 ffffffff802c6944 ffff81002f936d30 ffff81003e99e2c0
> Call Trace:
>   [<ffffffff802ceea9>] shrink_dcache_for_umount+0x37/0x6e
>   [<ffffffff802c6944>] generic_shutdown_super+0x24/0x151
>   [<ffffffff802c6a97>] kill_block_super+0x26/0x3b
>   [<ffffffff802c6b65>] deactivate_super+0x4c/0x67
>   [<ffffffff8022d061>] mntput_no_expire+0x58/0x92
>   [<ffffffff80232562>] path_release_on_umount+0x1d/0x2b
>   [<ffffffff802d1182>] sys_umount+0x252/0x29b
>   [<ffffffff8025f45e>] system_call+0x7e/0x83

yup, thanks.  We're expecting that
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/hot-fixes/reiserfs-make-sure-all-dentries-refs-are-released-before-calling-kill_block_super-try-2.patch
will fix this.

