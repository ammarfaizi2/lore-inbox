Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWHTTTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWHTTTd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 15:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWHTTTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 15:19:33 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:15338 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1751161AbWHTTTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 15:19:32 -0400
Date: Sun, 20 Aug 2006 21:19:30 +0200
From: Petr Vandrovec <petr@vandrovec.name>
To: video4linux-list@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Possible deadlock in videobuf_dma_init_user
Message-ID: <20060820191930.GA21729@platan.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  my kernel is a bit unhappy with lock ordering between mm->mmap_sem 
and videobuf_queue->lock.
					Thanks,
						Petr Vandrovec


=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
mythbackend/8289 is trying to acquire lock:
 (&mm->mmap_sem){----}, at: [<ffffffff881d2ad5>] videobuf_dma_init_user+0xd5/0x190 [video_buf]

but task is already holding lock:
 (&q->lock#2){--..}, at: [<ffffffff81072905>] mutex_lock+0x25/0x30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&q->lock#2){--..}:
       [<ffffffff810bacbe>] lock_acquire+0x4e/0x70
       [<ffffffff81072746>] __mutex_lock_slowpath+0xd6/0x270
       [<ffffffff81072904>] mutex_lock+0x24/0x30
       [<ffffffff881d192b>] videobuf_mmap_mapper+0x1b/0x290 [video_buf]
       [<ffffffff881dc9bc>] bttv_mmap+0x5c/0x70 [bttv]
       [<ffffffff8100e927>] do_mmap_pgoff+0x4f7/0x7d0
       [<ffffffff810924eb>] sys32_mmap2+0xbb/0xf0
       [<ffffffff8106f69f>] cstar_do_call+0x1a/0x6f

-> #0 (&mm->mmap_sem){----}:
       [<ffffffff810bacbe>] lock_acquire+0x4e/0x70
       [<ffffffff810b74c8>] down_read+0x38/0x50
       [<ffffffff881d2ad4>] videobuf_dma_init_user+0xd4/0x190 [video_buf]
       [<ffffffff881d2eab>] videobuf_iolock+0xab/0x120 [video_buf]
       [<ffffffff881dc8b8>] bttv_prepare_buffer+0x158/0x1c0 [bttv]
       [<ffffffff881de8ce>] bttv_do_ioctl+0xbfe/0x20e0 [bttv]
       [<ffffffff88175f98>] video_usercopy+0x188/0x250 [videodev]
       [<ffffffff881dca7b>] bttv_ioctl+0x3b/0x50 [bttv]
       [<ffffffff881bd064>] native_ioctl+0x64/0x90 [compat_ioctl32]
       [<ffffffff881bebfc>] v4l_compat_ioctl32+0x1b6c/0x1c2c [compat_ioctl32]
       [<ffffffff8110906a>] compat_sys_ioctl+0xfa/0x330
       [<ffffffff8106f69f>] cstar_do_call+0x1a/0x6f

other info that might help us debug this:

1 lock held by mythbackend/8289:
 #0:  (&q->lock#2){--..}, at: [<ffffffff81072905>] mutex_lock+0x25/0x30

stack backtrace:

Call Trace:
 [<ffffffff8107bd05>] show_trace+0xb5/0x3a0
 [<ffffffff8107c005>] dump_stack+0x15/0x20
 [<ffffffff810b8ed2>] print_circular_bug_tail+0x72/0x80
 [<ffffffff810ba93e>] __lock_acquire+0x9ae/0xce0
 [<ffffffff810bacbf>] lock_acquire+0x4f/0x70
 [<ffffffff810b74c9>] down_read+0x39/0x50
 [<ffffffff881d2ad5>] :video_buf:videobuf_dma_init_user+0xd5/0x190
 [<ffffffff881d2eac>] :video_buf:videobuf_iolock+0xac/0x120
 [<ffffffff881dc8b9>] :bttv:bttv_prepare_buffer+0x159/0x1c0
 [<ffffffff881de8cf>] :bttv:bttv_do_ioctl+0xbff/0x20e0
 [<ffffffff88175f99>] :videodev:video_usercopy+0x189/0x250
 [<ffffffff881dca7c>] :bttv:bttv_ioctl+0x3c/0x50
 [<ffffffff881bd065>] :compat_ioctl32:native_ioctl+0x65/0x90
 [<ffffffff881bebfd>] :compat_ioctl32:v4l_compat_ioctl32+0x1b6d/0x1c2c
 [<ffffffff8110906b>] compat_sys_ioctl+0xfb/0x330
 [<ffffffff8106f6a0>] cstar_do_call+0x1b/0x6f
 [<00000000ffffe405>]


