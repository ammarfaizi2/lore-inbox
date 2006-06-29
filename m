Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWF2Rwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWF2Rwg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWF2Rwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:52:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12221 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751113AbWF2Rwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:52:35 -0400
Date: Thu, 29 Jun 2006 10:52:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm4
Message-Id: <20060629105215.02587a67.akpm@osdl.org>
In-Reply-To: <44A3BD65.3070201@reub.net>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	<44A3BD65.3070201@reub.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 23:45:41 +1200
Reuben Farrelly <reuben-lkml@reub.net> wrote:

> 
> 
> On 29/06/2006 8:36 p.m., Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm4/
> > 
> > 
> > - The RAID patches have been dropped due to testing failures in -mm3.
> > 
> > - The SCSI Attached Storage tree (git-sas.patch) has been restored.
> 
> This at the end of shutdown:
> 
> Sending all processes the TERM signal...
> Sending all processes the KILL signal...
> Saving random seed:
> Syncing hardware clock to system time
> Turning off swap:
> Unmounting file systems:  ----------- [cut here ] --------- [please bite here ] 
> ---------
> Kernel BUG at fs/dcache.c:600
> invalid opcode: 0000 [1] SMP
> last sysfs file: /block/fd0/dev
> CPU 0
> Modules linked in: hidp rfcomm l2cap bluetooth ipv6 ip_gre binfmt_misc ide_cd 
> i2c_i801 cdrom serio_raw ide_disk
> Pid: 4216, comm: umount Not tainted 2.6.17-mm4 #1
> RIP: 0010:[<ffffffff802c4f91>]  [<ffffffff802c4f91>] 
> shrink_dcache_for_umount_subtree+0x151/0x260
> RSP: 0018:ffff810034bc7db8  EFLAGS: 00010202
> RAX: 0000000000000001 RBX: ffff81003e8ce928 RCX: ffff810001df1a00
> RDX: 00000000000000b8 RSI: ffffffff8025e9b1 RDI: ffff81002542eba8
> RBP: ffff810034bc7dd8 R08: 0000000000000000 R09: ffff81003dd1e970
> R10: ffff81003dd1e970 R11: ffff81003dd1e960 R12: ffff81003e8ce928
> R13: ffff81002542ebb8 R14: ffff81003f6466c0 R15: 0000000000000000
> FS:  00002b032cff3750(0000) GS:ffffffff80686000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00002b032cbc6000 CR3: 00000000284ac000 CR4: 00000000000006e0
> Process umount (pid: 4216, threadinfo ffff810034bc6000, task ffff810037f8d750)
> Stack:  ffff81003e1d5c00 ffff81003e1d5c00 ffffffff80584960 ffff810034bc7ec8
>   ffff810034bc7df8 ffffffff802c5324 00000000000001e0 ffff81003e1d5c00
>   ffff810034bc7e28 ffffffff802bdd64 ffff81003f6466c0 ffff810037d6bcc0
> Call Trace:
>   [<ffffffff802c5324>] shrink_dcache_for_umount+0x37/0x63
>   [<ffffffff802bdd64>] generic_shutdown_super+0x24/0x14f
>   [<ffffffff802bdeb5>] kill_block_super+0x26/0x3b
>   [<ffffffff802bdf7f>] deactivate_super+0x4a/0x6b
>   [<ffffffff8022e08f>] mntput_no_expire+0x56/0x8e
>   [<ffffffff802334f1>] path_release_on_umount+0x1d/0x2c
>   [<ffffffff802c72b1>] sys_umount+0x251/0x28c
>   [<ffffffff8022e0db>] fput+0x14/0x19
>   [<ffffffff80223ae8>] filp_close+0x68/0x76
>   [<ffffffff8026014a>] system_call+0x7e/0x83
> 

Thanks.  Probably
destroy-the-dentries-contributed-by-a-superblock-on-unmounting.patch went
wrong, possibly an interaction between
destroy-the-dentries-contributed-by-a-superblock-on-unmounting.patch and
ro-bind-mounts-*.patch.

If you have time, please:

- Confirm that it is reproducible.

- If it is, test http://www.zip.com.au/~akpm/linux/patches/stuff/rf.bz2. 
  That's a patch against 2.6.17.  It's basically -mm4, with
  ro-bind-mounts-*.patch removed (and with x86[_64] generic IRQ wired up). 
  If that fails in the same way, we know that
  destroy-the-dentries-contributed-by-a-superblock-on-unmounting.patch is
  the bad guy.

