Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWF1SJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWF1SJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWF1SJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:09:16 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:56144 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750707AbWF1SJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:09:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uI71Svk8gL75w289jupX798juX3qEe0oz14nJ2POeiI3Y2wIg3FjYT88V+H0ZuX/kM9bs4mAg5vt6n0EDMVDukHOeIvsi0Fm38thdUv5LrNgOI9S00E/zat+89ngXEWKDiK/mFpl14et7HV7pZpePH4pWBj6I4STyUVBTbVu0Oo=
Message-ID: <a44ae5cd0606281109u5cc25038n67b086f0d4f6426e@mail.gmail.com>
Date: Wed, 28 Jun 2006 11:09:14 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-mm3 -- BUG: trying to register non-static key!
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060628153403.GA32131@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0606271447j58ad9cdchc4728c010245df5b@mail.gmail.com>
	 <20060628153403.GA32131@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After rebuilding with your patch, the stack trace shows up,
but now there is a warning of a possible circular locking dependency:

[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
S13gdm/2088 is trying to acquire lock:
 (&dev->queue_lock){-+..}, at: [<c11a1fbc>] dev_queue_xmit+0x120/0x248

but task is already holding lock:
 (&dev->_xmit_lock){-+..}, at: [<c11a201f>] dev_queue_xmit+0x183/0x248

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&dev->_xmit_lock){-+..}:
       [<c102cbca>] lock_acquire+0x60/0x80
       [<c11fcafd>] _spin_lock_bh+0x28/0x37
       [<c11acd1e>] dev_activate+0xce/0x100
       [<c11a844b>] linkwatch_run_queue+0x10b/0x138
       [<c11a849c>] linkwatch_event+0x24/0x2b
       [<c1024198>] run_workqueue+0x86/0xcb
       [<c1024711>] worker_thread+0xe1/0x114
       [<c1026ca7>] kthread+0xb0/0xdc
       [<c1001005>] kernel_thread_helper+0x5/0xb

-> #0 (&dev->queue_lock){-+..}:
       [<c102cbca>] lock_acquire+0x60/0x80
       [<c11fcac6>] _spin_lock+0x23/0x32
       [<c11a1fbc>] dev_queue_xmit+0x120/0x248
       [<f886779e>] hostap_data_start_xmit+0x610/0x61a [hostap]
       [<c11a0641>] dev_hard_start_xmit+0x206/0x212
       [<c11a203b>] dev_queue_xmit+0x19f/0x248
       [<f8c48cb3>] mld_sendpack+0x1a0/0x24d [ipv6]
       [<f8c4984c>] mld_ifc_timer_expire+0x1b2/0x1d9 [ipv6]
       [<c101d8da>] run_timer_softirq+0xf2/0x14a
       [<c101a4aa>] __do_softirq+0x55/0xb0
       [<c1004a64>] do_softirq+0x58/0xbd

other info that might help us debug this:

1 lock held by S13gdm/2088:
 #0:  (&dev->_xmit_lock){-+..}, at: [<c11a201f>] dev_queue_xmit+0x183/0x248

stack backtrace:
 [<c1003502>] show_trace_log_lvl+0x54/0xfd
 [<c1003b6a>] show_trace+0xd/0x10
 [<c1003c0e>] dump_stack+0x19/0x1b
 [<c102bf9c>] print_circular_bug_tail+0x59/0x64
 [<c102c770>] __lock_acquire+0x7c9/0x95e
 [<c102cbca>] lock_acquire+0x60/0x80
 [<c11fcac6>] _spin_lock+0x23/0x32
 [<c11a1fbc>] dev_queue_xmit+0x120/0x248
 [<f886779e>] hostap_data_start_xmit+0x610/0x61a [hostap]
 [<c11a0641>] dev_hard_start_xmit+0x206/0x212
 [<c11a203b>] dev_queue_xmit+0x19f/0x248
 [<f8c48cb3>] mld_sendpack+0x1a0/0x24d [ipv6]
 [<f8c4984c>] mld_ifc_timer_expire+0x1b2/0x1d9 [ipv6]
 [<c101d8da>] run_timer_softirq+0xf2/0x14a
 [<c101a4aa>] __do_softirq+0x55/0xb0
 [<c1004a64>] do_softirq+0x58/0xbd
 [<c101a544>] irq_exit+0x3f/0x4b
 [<c1004b69>] do_IRQ+0xa0/0xaf
 [<c1002fd9>] common_interrupt+0x25/0x2c
[drm] Initialized drm 1.0.1 20051102
