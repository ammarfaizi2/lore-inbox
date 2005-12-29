Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbVL2DPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbVL2DPu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 22:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVL2DPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 22:15:50 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:11564 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964990AbVL2DPt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 22:15:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c8oGlga9KB3XnEok+a0z7X8hkMXqJfcdDP+uyZXk+hf74BVnQY0oC/Hnernhm6sz5rhiy7iUZz2bwTareSORwA8yIUubuNlEVJ91kqDl1EWnIbwoxGcJIIQJ/l2caX1Oq/f2mBAgrw8EiyGPj74UcFpYEA5wxYUm9SZMfLCleGE=
Message-ID: <21d7e9970512281915s29cf5ac5p33995791c716fc0f@mail.gmail.com>
Date: Thu, 29 Dec 2005 14:15:48 +1100
From: Dave Airlie <airlied@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: spinlock BUG on b44 netconsole
In-Reply-To: <21d7e9970512281915q5f58e32bj456b29af52e2e8fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <21d7e9970512281915q5f58e32bj456b29af52e2e8fe@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a b44 and am using netconsole to debug some DRM issues, I've
been seeing this with varying kernel from Fedora and vanilla (latest
is 2.6.15-rc6)...

BUG: spinlock trylock failure on UP on CPU#0, eglgears/3974
 lock: f5d4a94c, .magic: dead4ead, .owner: eglgears/3974, .owner_cpu: 0
 [<c01f14cc>] _raw_spin_trylock+0x3c/0x40
 [<c032b650>] _spin_trylock+0x10/0x40
 [<c02d7bf3>] qdisc_restart+0x43/0x230
 [<c02c945e>] dev_queue_xmit+0x7e/0x2d0
 [<c02e667b>] ip_output+0x17b/0x2e0
 [<c02e6320>] ip_finish_output2+0x0/0x1e0
 [<c02e6a84>] ip_queue_xmit+0x2a4/0x500
 [<c02e5c80>] dst_output+0x0/0x20
 [<c01c7368>] avc_has_perm_noaudit+0x48/0x150
 [<f8b4a346>] tcp_in_window+0x276/0x540 [ip_conntrack]
 [<c02fd763>] tcp_v4_send_check+0x43/0xf0
 [<c02f7c77>] tcp_transmit_skb+0x3f7/0x760
 [<c02f8f21>] tcp_write_xmit+0x121/0x3a0
 [<c02f91c7>] __tcp_push_pending_frames+0x27/0x90
 [<c02f617e>] tcp_rcv_established+0x2ee/0x820
 [<c02fe8f4>] tcp_v4_do_rcv+0x94/0xe0
 [<c02ff217>] tcp_v4_rcv+0x8d7/0x8f0
 [<c02e29e0>] ip_local_deliver_finish+0x0/0x220
 [<c02e3140>] ip_rcv_finish+0x0/0x320
 [<c02e2873>] ip_local_deliver+0x123/0x290
 [<c02e29e0>] ip_local_deliver_finish+0x0/0x220
 [<c02e2f23>] ip_rcv+0x323/0x540
 [<c02e3140>] ip_rcv_finish+0x0/0x320
 [<c03274db>] packet_rcv_spkt+0xfb/0x280
 [<c028a21a>] sd_rw_intr+0x7a/0x3e0
 [<c02e2c00>] ip_rcv+0x0/0x540
 [<c02c9bc0>] netif_receive_skb+0x1a0/0x290
 [<c02c371a>] __alloc_skb+0x4a/0x150
 [<f881e138>] b44_rx+0x1c8/0x300 [b44]
 [<f881e2c8>] b44_poll+0x58/0x180 [b44]
 [<c02c9e3d>] net_rx_action+0x9d/0x1b0
 [<c0120482>] __do_softirq+0x42/0xa0
 [<c0104afe>] do_softirq+0x4e/0x60
 =======================
 [<c01205a5>] irq_exit+0x35/0x40
 [<c01049ba>] do_IRQ+0x5a/0xa0
 [<c01033ce>] common_interrupt+0x1a/0x20
 [<c032b8bb>] _spin_unlock_irq+0xb/0x20
 [<f881e82d>] b44_start_xmit+0x25d/0x440 [b44]
 [<c02d611f>] find_skb+0x2f/0xf0
 [<c02d6297>] netpoll_send_skb+0xb7/0x140
 [<f8ae805c>] write_msg+0x5c/0x90 [netconsole]
 [<f8ae8000>] write_msg+0x0/0x90 [netconsole]
 [<c011b303>] __call_console_drivers+0x43/0x60
 [<c011b447>] call_console_drivers+0x97/0x1a0
 [<c011ba39>] release_console_sem+0x29/0xc0
 [<c011b8a2>] vprintk+0x1f2/0x2d0
 [<c032b8b5>] _spin_unlock_irq+0x5/0x20
 [<c0117679>] __wake_up_common+0x39/0x70
 [<c011b6ab>] printk+0x1b/0x20
 [<f8d3c282>] drm_ioctl+0x152/0x214 [drm]
 [<c017496a>] do_ioctl+0x8a/0xa0
 [<c0174b30>] vfs_ioctl+0x60/0x200
 [<c0174d42>] sys_ioctl+0x72/0x90
 [<c0103201>] syscall_call+0x7/0xb
Dead loop on netdevice eth0, fix it urgently!

Any ideas? btw, it could the drm experiments I'm doing causing it but
I don't see any evidence of that in the traces...

Dave.
