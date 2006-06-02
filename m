Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWFBFjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWFBFjm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 01:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWFBFjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 01:39:42 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:15315 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751133AbWFBFjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 01:39:41 -0400
Date: Fri, 2 Jun 2006 01:33:32 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: IRQ sharing: BUG: spinlock lockup on CPU#0
To: Keith Chew <keith.chew@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606020137_MC3-1-C164-9068@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20f65d530606011829n2ee1d76fg9d2c7bbc02a6a0aa@mail.gmail.com>

On Fri, 2 Jun 2006 13:29:18 +1200, Keith Chew wrote:

> I apologise in advance for posting the same console stack trace again,
> but I figured this problem needed a new topic as it is not related to
> IO APIC IRQ Assignment topic. If anyone can guide us to where to look
> for the problem, it will be much appreciated. We have 5 x PCs running
> 2.6.14.2 kernel, and 5 x PCs running 2.6.16.18. This crash happened on
> the 2.6.14.2 kernel.

If you could reproduce this on 2.6.16.x it would be much better.  And if
you don't have it set, add CONFIG_FRAME_POINTER so the stack traces will
be cleaner.

> Unable to handle kernel paging request at virtual address 23232327
> printing eip:
> c014b569
> *pde = 00000000
> Oops: 0002 [#1]

This is the real problem AFAICT.

> Modules linked in: ipt_LOG ipt_state iptable_filter ip_tables ip_conntrack_tf
> ip_conntrack_proto_sctp ip_conntrack_irc ip_conntrack_ftp ip_conntrack_amanda
> _conntrack rt2570 zd1211 autofs4 video button battery ac uhci_hcd bt878 tuner
> audio bttv video_buf i2c_algo_bit v4l2_common btcx_risc tveeprom videodev i2c
> 01 i2c_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_os
> nd_pcm snd_timer snd soundcore snd_page_alloc e100 mii dm_snapshot dm_zero dm
> rror ext3 jbd dm_mod

Your mailer is garbling long lines when it wraps them...

> CPU:    0
> EIP:    0060:[<c014b569>]    Not tainted VLI
> EFLAGS: 00010046   (2.6.14.2)
> EIP is at activate_page+0x59/0xd0
> eax: 23232323   ebx: c1400160   ecx: c1400178   edx: 23232323
> esi: c03b7300   edi: c03b73e0   ebp: 00000001   esp: d3769ae4
> ds: 007b   es: 007b   ss: 0068
> Process mencoder (pid: 23017, threadinfo=d3768000 task=d615d030)
> Stack: d3769b7c 00000000 c1400160 00000040 c1000000 c014b613 c1400160 c0150b1
>       c7fe9d68 0000000f 00000001 b771d000 00000001 00000000 00000001 e5d26ee
>       f724124c f7241200 c0150cbe f7241200 b775a000 00000000 00000001 0000000
> Call Trace:
>  [<c014b613>] mark_page_accessed+0x33/0x40
>  [<c0150b13>] __follow_page+0x153/0x160
>  [<c0150cbe>] get_user_pages+0x11e/0x380
>  [<f896e348>] videobuf_dma_init_user+0x118/0x190 [video_buf]
>  [<f896eac7>] videobuf_iolock+0x77/0x110 [video_buf]
>  [<f89a0909>] bttv_prepare_buffer+0x179/0x1c0 [bttv]
>  [<f89a2b9c>] bttv_do_ioctl+0xbdc/0x1850 [bttv]
>  [<c035d2eb>] _read_unlock+0xb/0x10
>  [<f8a553c4>] zd1205_xmit_frame+0x94/0x4a0 [zd1211]
>  [<c035d2ab>] _spin_lock+0xb/0x10
>  [<c0300c73>] qdisc_restart+0x23/0x200
>  [<c035d2cb>] _spin_unlock+0xb/0x10
>  [<c02f0312>] dev_queue_xmit+0x2a2/0x330
>  [<f8cae3c3>] tcp_in_window+0x303/0x510 [ip_conntrack]
>  [<c035d1bf>] _spin_lock_irqsave+0xf/0x20
>  [<c0124d28>] __mod_timer+0xa8/0xd0
>  [<c035d3cb>] _write_unlock_bh+0xb/0x20
>  [<f8cad773>] __ip_ct_refresh_acct+0x73/0xc0 [ip_conntrack]
>  [<f8caeaa3>] tcp_packet+0x1a3/0x580 [ip_conntrack]
>  [<c02ea2e1>] __alloc_skb+0x61/0x150
>  [<c026b0e8>] dma_pool_alloc+0x98/0x180
>  [<c0117597>] activate_task+0x67/0x80
>  [<c0117688>] try_to_wake_up+0x88/0xd0
>  [<c01176ed>] wake_up_process+0x1d/0x20
>  [<c035d31b>] _spin_unlock_irq+0xb/0x10
>  [<f8a466f3>] uhci_alloc_qh+0x23/0x60 [uhci_hcd]
>  [<c0117597>] activate_task+0x67/0x80
>  [<c0117688>] try_to_wake_up+0x88/0xd0
>  [<c0131b7f>] autoremove_wake_function+0x2f/0x60
>  [<c0118021>] __wake_up_common+0x41/0x80
>  [<c01e4756>] copy_from_user+0x66/0xa0
>  [<f897b427>] video_usercopy+0xf7/0x180 [videodev]
>  [<c0117688>] try_to_wake_up+0x88/0xd0
>  [<c0118021>] __wake_up_common+0x41/0x80
>  [<c011809e>] __wake_up+0x3e/0x60
>  [<f89a384f>] bttv_ioctl+0x3f/0x70 [bttv]
>  [<f89a1fc0>] bttv_do_ioctl+0x0/0x1850 [bttv]
>  [<c0177b48>] do_ioctl+0x58/0x80
>  [<c0177cd5>] vfs_ioctl+0x65/0x1f0
>  [<c01e46d6>] copy_to_user+0x66/0x80
>  [<c0177ee8>] sys_ioctl+0x88/0xa0
>  [<c01031af>] sysenter_past_esp+0x54/0x75
> Code: 74 06 8b 03 a8 40 74 1a 89 f8 8b 5c 24 08 8b 74 24 0c 8b 7c 24 10 83 c4
>  e9 b4 1d 21 00 8d 74 26 00 8d 4b 18 8b 43 18 8b 51 04 <89> 50 04 89 02 c7 41
>  00 02 20 00 c7 43 18 00 01 10 00 ff 8e

Looks like this code dump got garbled too.  The disassembly is nonsense right
at the line breaks.

Looking at what's there, it seems the page's lru list pointers are
junk; they contain 0x23232323.  But it's hard to tell with what you posted.

-- 
Chuck

