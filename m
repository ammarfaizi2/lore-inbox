Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVDCV4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVDCV4h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 17:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVDCV4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 17:56:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:4588 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261445AbVDCV42 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 17:56:28 -0400
Date: Sun, 3 Apr 2005 14:56:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mathieu =?ISO-8859-1?B?QulyYXJk?= <Mathieu.Berard@crans.org>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.6.12-rc1-mm4 crash while mounting a reiserfs3 filesystem
Message-Id: <20050403145606.51ffeb72.akpm@osdl.org>
In-Reply-To: <42500F5E.9090604@crans.org>
References: <42500F5E.9090604@crans.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Bérard <Mathieu.Berard@crans.org> wrote:
>
> Hi,
> I get a 100% reproductible oops while booting linux 2.6.12-rc1-mm4.
> (Everyting run smoothly using 2.6.11-mm1)
> It seems to be related with mounting a reiserfs3 filesystem.

It looks more like an IDE bug.

> ReiserFS: hdg1: checking transaction log (hdg1)
> Unable to handle kernel paging request at virtual address 0a373138
>   printing eip:
> df6d1211
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT
> Modules linked in: ext2 mbcache w83627hf i2c_sensor i2c_isa ppp_generic 
> slhc w83627hf_wdt msr cpuid
> rtc
> CPU:    0
> EIP:    0060:[<df6d1211>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.12-rc1-mm4)
> EIP is at 0xdf6d1211
> eax: c9393266   ebx: df6d1c84   ecx: d84eab1e   edx: c155ccf8
> esi: c039242c   edi: c039239c   ebp: 700d580a   esp: df6d1c80
> ds: 007b   es: 007b   ss: 0068
> Process mount (pid: 1132, threadinfo=df6d1000 task=df711a50)
> Stack: c039242c c0229945 c039239c df6d1000 df6d1000 c039242c c155ccf8 
> c0223051
>         00000088 00001388 c159ae28 df6d1000 c039242c c155ccf8 c039239c 
> c022333e
>         df6d1d1c ffffffff c153d6e0 c155bd78 00000000 df6d1d1c c14007f0 
> c0212260
> Call Trace:
>   [<c0229945>] flagged_taskfile+0x125/0x380
>   [<c0223051>] start_request+0x1f1/0x2a0
>   [<c022333e>] ide_do_request+0x20e/0x3c0
>   [<c0212260>] __generic_unplug_device+0x20/0x30
>   [<c0212281>] generic_unplug_device+0x11/0x30
>   [<c02122ac>] blk_backing_dev_unplug+0xc/0x10
>   [<c0156336>] sync_buffer+0x26/0x40
>   [<c02a0b22>] __wait_on_bit+0x42/0x70
>   [<c0156310>] sync_buffer+0x0/0x40
>   [<c0156310>] sync_buffer+0x0/0x40
>   [<c02a0bcd>] out_of_line_wait_on_bit+0x7d/0x90
>   [<c012bf80>] wake_bit_function+0x0/0x60
>   [<c01563c9>] __wait_on_buffer+0x29/0x30
>   [<c01b0dd7>] _update_journal_header_block+0xf7/0x140
>   [<c01b290d>] journal_read+0x31d/0x470
>   [<c01b3241>] journal_init+0x4e1/0x650
>   [<c011748b>] printk+0x1b/0x20
>   [<c01a3ced>] reiserfs_fill_super+0x34d/0x770
>   [<c01c9470>] snprintf+0x20/0x30
>   [<c0189ab6>] disk_name+0x96/0xf0
>   [<c015bf75>] get_sb_bdev+0xe5/0x130
>   [<c0163945>] link_path_walk+0x65/0x140
>   [<c01a4168>] get_super_block+0x18/0x20
>   [<c01a39a0>] reiserfs_fill_super+0x0/0x770
>   [<c015c194>] do_kern_mount+0x44/0xf020 30 20 30 20 30 20 30 20 30 20 
> 30 20 30 20 30 20 <1>general p

It appears that we might have jumped from flagged_taskfile into something
at 0xdf6d1211, which is rather odd.

You have two different low-level IDE drivers configured.  Which one is
driving that filesystem?  VIA or Promise?
