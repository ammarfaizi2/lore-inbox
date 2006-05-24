Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbWEXRiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbWEXRiv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWEXRiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:38:51 -0400
Received: from hera.kernel.org ([140.211.167.34]:34436 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932607AbWEXRit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:38:49 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: sky2 hw csum failure [was Re: sky2 large MTU problems]
Date: Wed, 24 May 2006 10:38:20 -0700
Organization: OSDL
Message-ID: <20060524103820.2e213a0b@localhost.localdomain>
References: <6278d2220605240228v576dd66atdad4855b308e64bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1148492299 28273 10.8.0.54 (24 May 2006 17:38:19 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 24 May 2006 17:38:19 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2006 10:28:52 +0100
"Daniel J Blueman" <daniel.blueman@gmail.com> wrote:

> Having done some more stress testing with sky2 1.4 (in 2.6.17-rc4) and
> the latest patch, I have found problems when streaming lots of data
> out of the sky2 interface (eg via samba serving a large file to GigE
> client). Ultimately, the interface will stop sending.
> 
> Before this happens, I see lots of:
> 
> kernel: lan0: hw csum failure.
> kernel:  [__skb_checksum_complete+86/96] __skb_checksum_complete+0x56/0x60
> kernel:  [tcp_error+300/512] tcp_error+0x12c/0x200
> kernel:  [poison_obj+41/96] poison_obj+0x29/0x60
> kernel:  [tcp_error+0/512] tcp_error+0x0/0x200
> kernel:  [ip_conntrack_in+157/1072] ip_conntrack_in+0x9d/0x430
> kernel:  [kfree_skbmem+8/128] kfree_skbmem+0x8/0x80
> kernel:  [arp_process+102/1408] arp_process+0x66/0x580
> kernel:  [check_poison_obj+36/416] check_poison_obj+0x24/0x1a0
> kernel:  [arp_process+102/1408] arp_process+0x66/0x580
> kernel:  [nf_iterate+99/144] nf_iterate+0x63/0x90
> kernel:  [ip_rcv_finish+0/608] ip_rcv_finish+0x0/0x260
> kernel:  [nf_hook_slow+89/240] nf_hook_slow+0x59/0xf0
> kernel:  [ip_rcv_finish+0/608] ip_rcv_finish+0x0/0x260
> kernel:  [ip_rcv+386/1104] ip_rcv+0x182/0x450
> kernel:  [ip_rcv_finish+0/608] ip_rcv_finish+0x0/0x260
> kernel:  [packet_rcv_spkt+216/320] packet_rcv_spkt+0xd8/0x140
> kernel:  [netif_receive_skb+476/784] netif_receive_skb+0x1dc/0x310
> kernel:  [sky2_poll+879/2096] sky2_poll+0x36f/0x830
> kernel:  [_spin_lock_irqsave+9/16] _spin_lock_irqsave+0x9/0x10
> kernel:  [run_timer_softirq+290/416] run_timer_softirq+0x122/0x1a0
> kernel:  [net_rx_action+108/256] net_rx_action+0x6c/0x100
> kernel:  [__do_softirq+66/160] __do_softirq+0x42/0xa0
> kernel:  [do_softirq+78/96] do_softirq+0x4e/0x60
> kernel:  =======================
> kernel:  [do_IRQ+90/160] do_IRQ+0x5a/0xa0
> kernel:  [remove_vma+69/80] remove_vma+0x45/0x50
> kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
> kernel:  [get_offset_pmtmr+151/3584] get_offset_pmtmr+0x97/0xe00
> kernel:  [do_gettimeofday+26/208] do_gettimeofday+0x1a/0xd0
> kernel:  [sys_gettimeofday+26/144] sys_gettimeofday+0x1a/0x90
> kernel:  [syscall_call+7/11] syscall_call+0x7/0xb


What ever the netfilter chain is, it is trimming or altering the packet
without clearing or altering the hardware checksum. It is not a driver
problem, we saw these in VLAN's and ebtables already.


> One of these was preceeded by:
> 
> kernel: sky2 lan0: rx error, status 0x977d977d length 0

The receive FIFO got overrun. You must not be running hardware flow
control.

> 
> This was happening with the default MTU of 1500, not just at MTU size
> 9000 (but it was changed down from 9000). Hardware is Yukon-EC (0xb6)
> rev 1.
> 
> I'll do some more stress testing tonight without the MTU patch and
> without the MTU being raised to 9000 initially and see what happens.
> 
> Thanks for all your great work so far!

