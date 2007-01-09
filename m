Return-Path: <linux-kernel-owner+w=401wt.eu-S1751314AbXAIMFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbXAIMFJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 07:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbXAIMFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 07:05:08 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:37632 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751315AbXAIMFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 07:05:05 -0500
Message-ID: <368344298.09165@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 9 Jan 2007 20:05:30 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Torsten Kaiser <kernel@bardioc.dyndns.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.6.20-rc3-mm1] raid1 mount blocks for ever
Message-ID: <20070109120331.GA6108@mail.ustc.edu.cn>
Mail-Followup-To: Jens Axboe <jens.axboe@oracle.com>,
	Torsten Kaiser <kernel@bardioc.dyndns.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <368051775.16914@ustc.edu.cn> <200701061130.07467.kernel@bardioc.dyndns.org> <20070108085245.GR11203@kernel.dk> <200701081911.46495.kernel@bardioc.dyndns.org> <20070109091858.GI11203@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109091858.GI11203@kernel.dk>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 10:19:00AM +0100, Jens Axboe wrote:
> On Mon, Jan 08 2007, Torsten Kaiser wrote:
> > On Monday 08 January 2007 09:52, Jens Axboe wrote:
> > > --- a/block/ll_rw_blk.c
> > > +++ b/block/ll_rw_blk.c
> > > @@ -1542,7 +1542,7 @@ static inline void
> > > -	blk_unplug_current();
> > > +	blk_replug_current_nested();
> > 
> > Does not help. Dmesg follows:
> 
> [snip]
> 
> Strange, it works perfectly for me now. Not using -mm though, but the
> plug branch. And it did hang before. Fengguang, any change for you?

2.6.20-rc3-mm1 plus your patch works for me.

Lucky enough to found this before giving up:

        mount takes 39s, and umount takes 42s.

Jan  9 19:37:51 localhost kernel: [  478.217846] kjournald starting.  Commit interval 5 seconds
Jan  9 19:38:30 localhost kernel: [  517.120984] EXT3 FS on md2, internal journal
Jan  9 19:38:30 localhost kernel: [  517.121052] EXT3-fs: mounted filesystem with ordered data mode.

Under KDE, it fails to respond from time to time, some processes
randomly get stucked:
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      5702  0.0  0.0      0     0 ?        D<   19:40   0:00 [kjournald]
wfg       6115  0.0  1.3 149724 27264 tty1     D    19:44   0:00 amarokapp
wfg       6150  0.0  0.0  15524  1640 ?        D    19:50   0:00 /usr/bin/fetchmail -a

The initial mount calltrace is:

Jan  9 19:33:11 localhost kernel: [  198.323105] mount         D 00000025899a9f02  5144  5566   5552                     (NOTLB)
Jan  9 19:33:11 localhost kernel: [  198.323305]  ffff810079f298c8 0000000000000046 0000000000000000 0000000000000286
Jan  9 19:33:11 localhost kernel: [  198.323454]  0000000000000000 0000000000000286 ffff810037eeae20 0000000000000020
Jan  9 19:33:11 localhost kernel: [  198.323604]  0000000000000008 ffff810079d13080 ffffffff813a74e0 0000000000001472
Jan  9 19:33:11 localhost kernel: [  198.323717] Call Trace:
Jan  9 19:33:11 localhost kernel: [  198.323796]  [<ffffffff81061b9a>] getnstimeofday+0x3a/0xa0
Jan  9 19:33:11 localhost kernel: [  198.323839]  [<ffffffff810699d8>] io_schedule+0x98/0xd0
Jan  9 19:33:11 localhost kernel: [  198.323881]  [<ffffffff810f1789>] sleep_on_buffer+0x9/0x10
Jan  9 19:33:11 localhost kernel: [  198.323923]  [<ffffffff81069c95>] __wait_on_bit+0x45/0x80
Jan  9 19:33:11 localhost kernel: [  198.323964]  [<ffffffff810f1780>] sleep_on_buffer+0x0/0x10
Jan  9 19:33:11 localhost kernel: [  198.324006]  [<ffffffff810f1780>] sleep_on_buffer+0x0/0x10
Jan  9 19:33:11 localhost kernel: [  198.324048]  [<ffffffff81069d48>] out_of_line_wait_on_bit+0x78/0x90
Jan  9 19:33:11 localhost kernel: [  198.324090]  [<ffffffff810a25f0>] wake_bit_function+0x0/0x40
Jan  9 19:33:11 localhost kernel: [  198.324132]  [<ffffffff8104f620>] __wait_on_buffer+0x20/0x30
Jan  9 19:33:11 localhost kernel: [  198.324174]  [<ffffffff8103ecfd>] sync_dirty_buffer+0xad/0xf0
Jan  9 19:33:11 localhost kernel: [  198.324216]  [<ffffffff811196ea>] ext3_commit_super+0x6a/0x80
Jan  9 19:33:11 localhost kernel: [  198.324258]  [<ffffffff8111a066>] ext3_setup_super+0x106/0x1c0
Jan  9 19:33:11 localhost kernel: [  198.324299]  [<ffffffff8103f61e>] d_instantiate+0x9e/0xb0
Jan  9 19:33:11 localhost kernel: [  198.324342]  [<ffffffff8111c104>] ext3_fill_super+0x12f4/0x1650
Jan  9 19:33:11 localhost kernel: [  198.324388]  [<ffffffff810de8c7>] get_sb_bdev+0x117/0x180
Jan  9 19:33:11 localhost kernel: [  198.324429]  [<ffffffff8111ae10>] ext3_fill_super+0x0/0x1650
Jan  9 19:33:11 localhost kernel: [  198.324472]  [<ffffffff811194d3>] ext3_get_sb+0x13/0x20
Jan  9 19:33:11 localhost kernel: [  198.324514]  [<ffffffff810de2d0>] vfs_kern_mount+0xc0/0x160
Jan  9 19:33:11 localhost kernel: [  198.324556]  [<ffffffff810de3da>] do_kern_mount+0x4a/0x70
Jan  9 19:33:11 localhost kernel: [  198.324599]  [<ffffffff810e914e>] do_mount+0x73e/0x7c0
Jan  9 19:33:11 localhost kernel: [  198.324641]  [<ffffffff8102ff70>] mntput_no_expire+0x20/0xb0
Jan  9 19:33:11 localhost kernel: [  198.324683]  [<ffffffff8100edc8>] link_path_walk+0xf8/0x110
Jan  9 19:33:11 localhost kernel: [  198.324726]  [<ffffffff8106bdf6>] _spin_unlock+0x26/0x30
Jan  9 19:33:11 localhost kernel: [  198.324767]  [<ffffffff8101c46f>] bad_range+0x1f/0x80
Jan  9 19:33:11 localhost kernel: [  198.324809]  [<ffffffff8100a4a7>] get_page_from_freelist+0x307/0x600
Jan  9 19:33:11 localhost kernel: [  198.324853]  [<ffffffff81025cce>] __user_walk_fd+0x5e/0x80
Jan  9 19:33:11 localhost kernel: [  198.324895]  [<ffffffff8100f935>] __alloc_pages+0x75/0x320
Jan  9 19:33:11 localhost kernel: [  198.324939]  [<ffffffff81016ab9>] alloc_pages_current+0xb9/0xd0
Jan  9 19:33:11 localhost kernel: [  198.324983]  [<ffffffff81051b14>] sys_mount+0x94/0xf0
Jan  9 19:33:11 localhost kernel: [  198.325024]  [<ffffffff8106b8b1>] trace_hardirqs_on_thunk+0x35/0x37
Jan  9 19:33:11 localhost kernel: [  198.325068]  [<ffffffff8106511e>] system_call+0x7e/0x83

And here is the processes being blocked:
Jan  9 19:52:58 localhost kernel: [ 1384.882119] spamassassin  D 0000013ca8ba4528  3992  6171   6170                     (NOTLB)
Jan  9 19:52:58 localhost kernel: [ 1384.882125]  ffff81005c42fdd8 0000000000000046 0000000000000000 0000000200000001
Jan  9 19:52:58 localhost kernel: [ 1384.882128]  0000000000000000 ffff81007b49a988 ffff810073a4d630 0000000000000046
Jan  9 19:52:58 localhost kernel: [ 1384.882131]  0000000000000009 ffff81005c41a0c0 ffffffff813a74e0 0000000000000dc1
Jan  9 19:52:58 localhost kernel: [ 1384.882134] Call Trace:
Jan  9 19:52:58 localhost kernel: [ 1384.882141]  [<ffffffff81127b55>] log_wait_commit+0xe5/0x140
Jan  9 19:52:58 localhost kernel: [ 1384.882143]  [<ffffffff810a25b0>] autoremove_wake_function+0x0/0x40
Jan  9 19:52:58 localhost kernel: [ 1384.882147]  [<ffffffff81121b78>] journal_stop+0x1f8/0x230
Jan  9 19:52:58 localhost kernel: [ 1384.882151]  [<ffffffff81122874>] journal_force_commit+0x24/0x30
Jan  9 19:52:58 localhost kernel: [ 1384.882153]  [<ffffffff8111a586>] ext3_force_commit+0x26/0x30
Jan  9 19:52:58 localhost kernel: [ 1384.882156]  [<ffffffff8111036b>] ext3_sync_file+0x9b/0xe0
Jan  9 19:52:58 localhost kernel: [ 1384.882158]  [<ffffffff8106a5e5>] mutex_lock+0x25/0x30
Jan  9 19:52:58 localhost kernel: [ 1384.882161]  [<ffffffff81055844>] do_fsync+0x64/0xe0
Jan  9 19:52:58 localhost kernel: [ 1384.882164]  [<ffffffff810f0f91>] __do_fsync+0x31/0x50
Jan  9 19:52:58 localhost kernel: [ 1384.882167]  [<ffffffff810f0fbe>] sys_fdatasync+0xe/0x10
Jan  9 19:52:58 localhost kernel: [ 1384.882169]  [<ffffffff8106511e>] system_call+0x7e/0x83

Jan  9 19:57:27 localhost kernel: [ 1653.082457] amarokapp     D 00000173cc57562b  4776  6248      1          6259  6242 (NOTLB)
Jan  9 19:57:27 localhost kernel: [ 1653.082463]  ffff8100549bddd8 0000000000000046 0000000000000000 0000000200000001
Jan  9 19:57:27 localhost kernel: [ 1653.082466]  0000000000000000 ffff81007b49a988 ffff810073a4d708 0000000000000046
Jan  9 19:57:27 localhost kernel: [ 1653.082470]  0000000000000009 ffff8100549ba0c0 ffff81006175e0c0 0000000000000e03
Jan  9 19:57:27 localhost kernel: [ 1653.082473] Call Trace:
Jan  9 19:57:27 localhost kernel: [ 1653.082479]  [<ffffffff81127b55>] log_wait_commit+0xe5/0x140
Jan  9 19:57:27 localhost kernel: [ 1653.082482]  [<ffffffff810a25b0>] autoremove_wake_function+0x0/0x40
Jan  9 19:57:27 localhost kernel: [ 1653.082486]  [<ffffffff81121b78>] journal_stop+0x1f8/0x230
Jan  9 19:57:27 localhost kernel: [ 1653.082490]  [<ffffffff81122874>] journal_force_commit+0x24/0x30
Jan  9 19:57:27 localhost kernel: [ 1653.082492]  [<ffffffff8111a586>] ext3_force_commit+0x26/0x30
Jan  9 19:57:27 localhost kernel: [ 1653.082494]  [<ffffffff8111036b>] ext3_sync_file+0x9b/0xe0
Jan  9 19:57:27 localhost kernel: [ 1653.082497]  [<ffffffff8106a5e5>] mutex_lock+0x25/0x30
Jan  9 19:57:27 localhost kernel: [ 1653.082499]  [<ffffffff81055844>] do_fsync+0x64/0xe0
Jan  9 19:57:27 localhost kernel: [ 1653.082503]  [<ffffffff810f0f91>] __do_fsync+0x31/0x50
Jan  9 19:57:27 localhost kernel: [ 1653.082505]  [<ffffffff810f0fcb>] sys_fsync+0xb/0x10
Jan  9 19:57:27 localhost kernel: [ 1653.082507]  [<ffffffff8106511e>] system_call+0x7e/0x83

Regards,
Wu
