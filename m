Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbUCPNTS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 08:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbUCPNTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:19:18 -0500
Received: from porch.xs4all.nl ([80.126.78.181]:46093 "EHLO porch.xs4all.nl")
	by vger.kernel.org with ESMTP id S261477AbUCPNTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:19:15 -0500
Date: Tue, 16 Mar 2004 14:19:12 +0100 (CET)
From: Mark de Vries <mark@asphyx.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: buffer layer error at fs/buffer.c:430
In-Reply-To: <20040316023713.26aee705.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0403161407150.934@fgevxr.nfculk.yna>
References: <Pine.LNX.4.58.0403160749100.32629@fgvyrggb>
 <20040316023713.26aee705.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2004, Andrew Morton wrote:

> Mark de Vries <mark@asphyx.net> wrote:
> >
> > Mar 15 18:10:14 article kernel: buffer layer error at fs/buffer.c:430
> > ...
> >  Mar 15 18:10:14 article kernel: block=8192, b_blocknr=18446744073709551615
> >  Mar 15 18:10:14 article kernel: b_state=0x00000000, b_size=1024
>
> This is an infuriating thing.  Do you actually have any 1k blocksize
> filesystems in that machine?

Yes, /dev/sda1 on / has a 1k blocksize, on all boxes I've seen the
error on (this is a ~470M partition) ('dumpe2fs -h' included below)

Today I upgraded the boxes to 2.6.5-rc1 and just noticed it's hapened
again on another box. The only difference between the old kernel and this
one is that preemtion is now off.

Mar 16 13:50:16 post0 kernel: buffer layer error at fs/buffer.c:430
Mar 16 13:50:16 post0 kernel: Call Trace:
Mar 16 13:50:16 post0 kernel:  [__buffer_error+41/48] __buffer_error+0x29/0x30
Mar 16 13:50:16 post0 kernel:  [__find_get_block_slow+182/288] __find_get_block_slow+0xb6/0x120
Mar 16 13:50:16 post0 kernel:  [__find_get_block+166/200] __find_get_block+0xa6/0xc8
Mar 16 13:50:16 post0 kernel:  [__getblk+29/56] __getblk+0x1d/0x38
Mar 16 13:50:16 post0 kernel:  [journal_get_descriptor_buffer+53/76] journal_get_descriptor_buffer+0x35/0x4c
Mar 16 13:50:16 post0 kernel:  [journal_commit_transaction+1605/3870] journal_commit_transaction+0x645/0xf1e
Mar 16 13:50:16 post0 kernel:  [handle_IRQ_event+49/88] handle_IRQ_event+0x31/0x58
Mar 16 13:50:16 post0 kernel:  [scheduler_tick+1475/1488] scheduler_tick+0x5c3/0x5d0
Mar 16 13:50:16 post0 kernel:  [do_softirq+108/204] do_softirq+0x6c/0xcc
Mar 16 13:50:16 post0 kernel:  [smp_apic_timer_interrupt+319/324] smp_apic_timer_interrupt+0x13f/0x144
Mar 16 13:50:16 post0 kernel:  [apic_timer_interrupt+26/32] apic_timer_interrupt+0x1a/0x20
Mar 16 13:50:16 post0 kernel:  [del_timer_sync+43/276] del_timer_sync+0x2b/0x114
Mar 16 13:50:16 post0 kernel:  [kjournald+196/536] kjournald+0xc4/0x218
Mar 16 13:50:16 post0 kernel:  [kjournald+0/536] kjournald+0x0/0x218
Mar 16 13:50:16 post0 kernel:  [autoremove_wake_function+0/60] autoremove_wake_function+0x0/0x3c
Mar 16 13:50:16 post0 kernel:  [autoremove_wake_function+0/60] autoremove_wake_function+0x0/0x3c
Mar 16 13:50:16 post0 kernel:  [commit_timeout+0/12] commit_timeout+0x0/0xc
Mar 16 13:50:16 post0 kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Mar 16 13:50:16 post0 kernel:
Mar 16 13:50:16 post0 kernel: block=8192, b_blocknr=18446744073709551615
Mar 16 13:50:16 post0 kernel: b_state=0x00000000, b_size=1024

# dumpe2fs -h /dev/sda1
dumpe2fs 1.35-WIP (31-Jan-2004)
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          8c9996f8-009b-47a3-87b3-bc0adc065b52
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal filetype needs_recovery sparse_super
Default mount options:    (none)
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              124928
Block count:              497983
Reserved block count:     24899
Free blocks:              444919
Free inodes:              118554
First block:              1
Block size:               1024
Fragment size:            1024
Blocks per group:         8192
Fragments per group:      8192
Inodes per group:         2048
Inode blocks per group:   256
Last mount time:          Tue Mar 16 11:06:18 2004
Last write time:          Tue Mar 16 11:06:18 2004
Mount count:              6
Maximum mount count:      31
Last checked:             Thu Feb 12 13:57:07 2004
Check interval:           15552000 (6 months)
Next check after:         Tue Aug 10 14:57:07 2004
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128
Journal inode:            8
Journal backup:           inode blocks

Hope this helps...

Regards,
Mark.

