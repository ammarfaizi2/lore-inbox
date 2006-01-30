Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbWA3XcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbWA3XcZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 18:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbWA3XcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 18:32:25 -0500
Received: from ee.oulu.fi ([130.231.61.23]:45265 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S1030223AbWA3XcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 18:32:24 -0500
Date: Tue, 31 Jan 2006 01:16:59 +0200
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Knut Petersen <Knut_Petersen@t-online.de>, shemminger@osdl.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: skge bridge & hw csum failure (Was: Re: [BUG] sky2 broken for Yukon PCI-E Gigabit Ethernet Controller 11ab:4362 (rev 19))
Message-ID: <20060130231658.GA6952@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 11:22:42PM +1100, Herbert Xu wrote:
> OK, although we can't rule out sky2/netfilter from the enquiry, I've
> identified two bugs in ppp/pppoe that may be responsible for what you
> are seeing.  So please try the following patch and let us know if the
> problem still exists (or deteriorates/improves).
Borrowing this thread for a related problem, I'm getting lots of those on a
bridge device (this one running skge, rmmod skge; modprobe sk98lin actually
seemed to do it too, I've disabled rx checksums with ethtool for now). 
Kernel is a 2.6.15.1-ish Fedora one.

skge:

bridge-cd: hw csum failure.
 [<c02c8fd8>] __skb_checksum_complete+0x56/0x5c     [<f8a5f833>]
icmp_error+0xbf/0x1af [ip_conntrack]
 [<c012073a>] __wake_up+0x32/0x43     [<f8a5f774>] icmp_error+0x0/0x1af
[ip_conntrack]
 [<f8a5cb57>] ip_conntrack_in+0x95/0x2d6 [ip_conntrack]     [<c01393c7>]
__wake_up_bit+0x2e/0x33
 [<c016b6d9>] end_buffer_async_write+0xbf/0x12a     [<c02e26fd>]
nf_iterate+0x60/0x84
 [<f8a8208d>] br_nf_pre_routing_finish+0x0/0x320 [bridge]     [<c02e276e>]
nf_hook_slow+0x4d/0xf9
 [<f8a8208d>] br_nf_pre_routing_finish+0x0/0x320 [bridge]     [<f8a829ec>]
br_nf_pre_routing+0x2f5/0x431 [bridge]
 [<f8a8208d>] br_nf_pre_routing_finish+0x0/0x320 [bridge]     [<c02e26fd>]
nf_iterate+0x60/0x84
 [<f8a7e8f9>] br_handle_frame_finish+0x0/0xe9 [bridge]     [<c02e276e>]
nf_hook_slow+0x4d/0xf9
 [<f8a7e8f9>] br_handle_frame_finish+0x0/0xe9 [bridge]     [<f8a7eb46>]
br_handle_frame+0x164/0x23e [bridge]
 [<f8a7e8f9>] br_handle_frame_finish+0x0/0xe9 [bridge]     [<c02cbbe5>]
netif_receive_skb+0x1ac/0x325
 [<f88d5975>] skge_poll+0x3b6/0x4be [skge]     [<c012dca4>]
__mod_timer+0x85/0xa0
 [<c02cbf3e>] net_rx_action+0xb7/0x1bb     [<c012a2f2>]
__do_softirq+0x72/0xdc
 [<c0106393>] do_softirq+0x4b/0x4f
 =======================
 [<c0106275>] do_IRQ+0x55/0x86     [<c0119d81>]
smp_apic_timer_interrupt+0xc1/0xca
 [<c0104a8e>] common_interrupt+0x1a/0x20     [<c0102287>]
mwait_idle+0x2a/0x34
 [<c01020ef>] cpu_idle+0x6c/0xa7     [<c040187f>] start_kernel+0x173/0x1ca
 [<c0401304>] unknown_bootoption+0x0/0x1b6


and sk98lin 
bridge-cd: hw csum failure.
 [<c02c8fd8>] __skb_checksum_complete+0x56/0x5c     [<f8a5f833>]
icmp_error+0xbf/0x1af [ip_conntrack]
 [<c01393c7>] __wake_up_bit+0x2e/0x33     [<f8a5f774>] icmp_error+0x0/0x1af
[ip_conntrack]
 [<f8a5cb57>] ip_conntrack_in+0x95/0x2d6 [ip_conntrack]     [<c014d4a2>]
mempool_free+0x3a/0x73
 [<c016dfad>] end_bio_bh_io_sync+0x0/0x4f     [<c016dfad>]
end_bio_bh_io_sync+0x0/0x4f
 [<c02e26fd>] nf_iterate+0x60/0x84     [<f8a8208d>]
br_nf_pre_routing_finish+0x0/0x320 [bridge]
 [<c02e276e>] nf_hook_slow+0x4d/0xf9     [<f8a8208d>]
br_nf_pre_routing_finish+0x0/0x320 [bridge]
 [<f8a829ec>] br_nf_pre_routing+0x2f5/0x431 [bridge]     [<f8a8208d>]
br_nf_pre_routing_finish+0x0/0x320 [bridge]
 [<c02e26fd>] nf_iterate+0x60/0x84     [<f8a7e8f9>]
br_handle_frame_finish+0x0/0xe9 [bridge]
 [<c02e276e>] nf_hook_slow+0x4d/0xf9     [<f8a7e8f9>]
br_handle_frame_finish+0x0/0xe9 [bridge]
 [<f8a7eb46>] br_handle_frame+0x164/0x23e [bridge]     [<f8a7e8f9>]
br_handle_frame_finish+0x0/0xe9 [bridge]
 [<c02cbbe5>] netif_receive_skb+0x1ac/0x325     [<c02cbde1>]
process_backlog+0x83/0x129
 [<c02cbf3e>] net_rx_action+0xb7/0x1bb     [<c012a2f2>]
__do_softirq+0x72/0xdc
 [<c0106393>] do_softirq+0x4b/0x4f
 =======================
 [<c0106275>] do_IRQ+0x55/0x86     [<c0104a8e>] common_interrupt+0x1a/0x20
 [<c014a162>] page_waitqueue+0x5/0x32     [<c014a217>] unlock_page+0x1d/0x27
 [<c016c7e8>] __block_write_full_page+0x1e7/0x354     [<f8985176>]
ext3_get_block+0x0/0x90 [ext3]
 [<c016df49>] block_write_full_page+0xe3/0x109     [<f8985176>]
ext3_get_block+0x0/0x90 [ext3]
 [<f8985cea>] ext3_ordered_writepage+0xe5/0x183 [ext3]     [<f8985be5>]
bget_one+0x0/0x7 [ext3]
 [<c018cfdb>] mpage_writepages+0x222/0x3ee     [<f8985c05>]
ext3_ordered_writepage+0x0/0x183 [ext3]
 [<c0149c78>] __filemap_fdatawrite_range+0x66/0x72     [<c0149ca7>]
filemap_fdatawrite+0x23/0x27
 [<c016b2e9>] do_fsync+0x55/0xc8     [<c0104049>] syscall_call+0x7/0xb

iptables forward chain is just ACCEPT...
