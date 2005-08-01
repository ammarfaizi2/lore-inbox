Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVHAQGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVHAQGp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 12:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVHAQGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 12:06:45 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:47279 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261824AbVHAQFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 12:05:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:x-message-flag:x-operating-system:x-editor:x-disclaimer:user-agent;
        b=lXIiIDcKteh4s5KNgU6iCR2bn54nkuvlrxUY9VGv1pfx3ymIEQXgFYXKq/Irb0i38hzLIchHqBYxKmW1Zm0V78AZ/FPkzOZNdG7ztoz8hnx1iZNDEx4tKbmShQXaCKGYjFKyFOQv7Vi+JZppH6ADduZRlccD0vx/N3QbRym2T2M=
Date: Mon, 1 Aug 2005 18:05:38 +0200
From: Mattia Dongili <malattia@gmail.com>
To: Patrick McHardy <kaber@trash.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: BUG: atomic counter underflow at ip_conntrack_event_cache_init+0x91/0xb0 (with patch)
Message-ID: <20050801160537.GA3850@inferi.kami.home>
Mail-Followup-To: Patrick McHardy <kaber@trash.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	"David S. Miller" <davem@davemloft.net>
References: <20050801141327.GA3909@inferi.kami.home> <42EE3169.6070604@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EE3169.6070604@trash.net>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.13-rc4-mm1-3 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 04:27:53PM +0200, Patrick McHardy wrote:
> Mattia Dongili wrote:
> > Hello,
> > 
> > got this one while trying out 2.6.13-rc4-mm1 (not there in -r2-mm1),
> > from a quick look it seems to me that ip_conntrack_{get,put} are not
> > simmetric in updating the use count, thus simply adding this line might
> > help (it does actually, but I'm not aware if there could be any drawback):
> > 
> > --- include/linux/netfilter_ipv4/ip_conntrack.h.clean	2005-08-01 15:09:49.000000000 +0200
> > +++ include/linux/netfilter_ipv4/ip_conntrack.h	2005-08-01 15:08:52.000000000 +0200
> > @@ -298,6 +298,7 @@ static inline struct ip_conntrack *
> >  ip_conntrack_get(const struct sk_buff *skb, enum ip_conntrack_info *ctinfo)
> >  {
> >  	*ctinfo = skb->nfctinfo;
> > +	nf_conntrack_get(skb->nfct);
> >  	return (struct ip_conntrack *)skb->nfct;
> >  }
> 
> This creates lots of refcnt leaks, which is probably why it makes the
> underflow go away :) Please try this patch instead.

this doesn't fix it actually, see dmesg below:
...
ip_tables: (C) 2000-2002 Netfilter core team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.3 (2044 buckets, 16352 max) - 252 bytes per conntrack
e100: eth0: e100_watchdog: link up, 10Mbps, half-duplex
BUG: atomic counter underflow at:
 [<d0c6d38a>] ip_ct_iterate_cleanup+0xfa/0x100 [ip_conntrack]
 [<d0c681d3>] masq_inet_event+0x33/0x40 [ipt_MASQUERADE]
 [<d0c681e0>] device_cmp+0x0/0x40 [ipt_MASQUERADE]
 [<c012733d>] notifier_call_chain+0x2d/0x50
 [<c02bea43>] inet_del_ifa+0x93/0x1d0
 [<c02bf6af>] devinet_ioctl+0x4af/0x5a0
 [<c02c1946>] inet_ioctl+0x66/0xb0
 [<c0278be9>] sock_ioctl+0xc9/0x230
 [<c016df2e>] do_ioctl+0x8e/0xa0
 [<c02d5e08>] do_page_fault+0x188/0x613
 [<c016e0f5>] vfs_ioctl+0x65/0x1f0
 [<c016e2c5>] sys_ioctl+0x45/0x70
 [<c0103185>] syscall_call+0x7/0xb
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
BUG: atomic counter underflow at:
 [<d0c6af61>] ip_conntrack_event_cache_init+0x91/0xb0 [ip_conntrack]
 [<d0c6c2f7>] ip_conntrack_in+0xd7/0x2f0 [ip_conntrack]
 [<c029e420>] dst_output+0x0/0x30
 [<c028ef38>] nf_iterate+0x78/0x90
 [<c029e420>] dst_output+0x0/0x30
 [<c029e420>] dst_output+0x0/0x30
 [<c028f42e>] nf_hook_slow+0x7e/0x150
 [<c029e420>] dst_output+0x0/0x30
 [<c029c313>] ip_queue_xmit+0x403/0x570
 [<c029e420>] dst_output+0x0/0x30
 [<c02487e2>] submit_bio+0x62/0x100
 [<c0180ab3>] mpage_bio_submit+0x23/0x40
 [<c0180dec>] do_mpage_readpage+0x1fc/0x3b0
 [<c02b1c05>] tcp_v4_send_check+0x55/0x100
 [<c02ab818>] tcp_transmit_skb+0x478/0x720
 [<c02ae331>] tcp_connect+0x2c1/0x370
 [<c02b0bbe>] tcp_v4_connect+0x45e/0xb70
 [<c0143708>] cache_alloc_refill+0x178/0x230
 [<c02c141b>] inet_stream_connect+0x8b/0x1b0
 [<c0279783>] sys_connect+0x83/0xb0
 [<c0278169>] sock_map_fd+0xf9/0x130
 [<c02790f9>] __sock_create+0xd9/0x260
 [<c01d4396>] copy_from_user+0x46/0x80
 [<c027a211>] sys_socketcall+0xb1/0x260
 [<c01598d1>] sys_close+0x61/0xa0
 [<c02d5c80>] do_page_fault+0x0/0x613
 [<c0103185>] syscall_call+0x7/0xb
BUG: atomic counter underflow at:
 [<d0c6af61>] ip_conntrack_event_cache_init+0x91/0xb0 [ip_conntrack]
 [<d0c6c2f7>] ip_conntrack_in+0xd7/0x2f0 [ip_conntrack]
 [<c029e420>] dst_output+0x0/0x30
 [<c028ef38>] nf_iterate+0x78/0x90
 [<c029e420>] dst_output+0x0/0x30
 [<c029e420>] dst_output+0x0/0x30
 [<c028f42e>] nf_hook_slow+0x7e/0x150
 [<c029e420>] dst_output+0x0/0x30
 [<c029e420>] dst_output+0x0/0x30
 [<c029df93>] ip_push_pending_frames+0x423/0x490
 [<c029e420>] dst_output+0x0/0x30
 [<c02b91dc>] udp_push_pending_frames+0x16c/0x2b0
 [<c02b9722>] udp_sendmsg+0x3b2/0x730
 [<c02bbc77>] arp_bind_neighbour+0x67/0xa0
 [<c02946e9>] rt_intern_hash+0x2e9/0x3d0
 [<c0296b39>] ip_route_output_slow+0x2a9/0x870
 [<c02c16ed>] inet_sendmsg+0x4d/0x60
 [<c027846d>] sock_sendmsg+0xdd/0x100
 [<c012f060>] autoremove_wake_function+0x0/0x60
 [<c02799ec>] sys_sendto+0xdc/0x100
 [<c027978f>] sys_connect+0x8f/0xb0
 [<c014b43c>] handle_mm_fault+0xfc/0x250
 [<c0279a43>] sys_send+0x33/0x40
 [<c027a2a3>] sys_socketcall+0x143/0x260
 [<c02d5c80>] do_page_fault+0x0/0x613
 [<c0103185>] syscall_call+0x7/0xb
BUG: atomic counter underflow at:
 [<d0c6af61>] ip_conntrack_event_cache_init+0x91/0xb0 [ip_conntrack]
 [<d0c6c2f7>] ip_conntrack_in+0xd7/0x2f0 [ip_conntrack]
 [<c0298ff0>] ip_rcv_finish+0x0/0x300
 [<c028ef38>] nf_iterate+0x78/0x90
 [<c0298ff0>] ip_rcv_finish+0x0/0x300
 [<c0298ff0>] ip_rcv_finish+0x0/0x300
 [<c028f42e>] nf_hook_slow+0x7e/0x150
 [<c0298ff0>] ip_rcv_finish+0x0/0x300
 [<c0298ff0>] ip_rcv_finish+0x0/0x300
 [<c0298d62>] ip_rcv+0x4a2/0x590
 [<c0298ff0>] ip_rcv_finish+0x0/0x300
 [<c0206e00>] acpi_ut_value_exit+0x35/0x3f
 [<c0282b67>] netif_receive_skb+0x167/0x220
 [<d0c4c430>] e100_poll+0x750/0x800 [e100]
 [<c0282db4>] net_rx_action+0x74/0x120
 [<c011e8fb>] __do_softirq+0x7b/0x90
 [<c011e936>] do_softirq+0x26/0x30
 [<c011ea05>] irq_exit+0x35/0x40
 [<c0104bde>] do_IRQ+0x1e/0x30
 [<c010334a>] common_interrupt+0x1a/0x20
 [<c02154bf>] acpi_processor_idle+0x122/0x295
 [<c01010f0>] cpu_idle+0x50/0x60
 [<c036882a>] start_kernel+0x15a/0x180
 [<c03683c0>] unknown_bootoption+0x0/0x1e0

While testing my patch I had the below error, is it related to the
refcount leak or might it be a different issue?

ctevent: skb->ct != ecache->ct !!!
 [<d0c6e4e8>] tcp_packet+0x278/0x5d0 [ip_conntrack]
 [<d0c6b697>] __ip_conntrack_find+0x17/0xb0 [ip_conntrack]
 [<d0c6b782>] ip_conntrack_find_get+0x52/0x60 [ip_conntrack]
 [<d0c6c33f>] ip_conntrack_in+0xef/0x2f0 [ip_conntrack]
 [<c029e420>] dst_output+0x0/0x30
 [<c028ef38>] nf_iterate+0x78/0x90
 [<c029e420>] dst_output+0x0/0x30
 [<c029e420>] dst_output+0x0/0x30
 [<c028f42e>] nf_hook_slow+0x7e/0x150
 [<c029e420>] dst_output+0x0/0x30
 [<c029c313>] ip_queue_xmit+0x403/0x570
 [<c029e420>] dst_output+0x0/0x30
 [<c022185a>] extract_buf+0xda/0x120
 [<c02b1c05>] tcp_v4_send_check+0x55/0x100
 [<c02ab818>] tcp_transmit_skb+0x478/0x720
 [<c02ac890>] tcp_write_xmit+0x150/0x3f0
 [<c02acb69>] __tcp_push_pending_frames+0x39/0xd0
 [<c02a1226>] tcp_sendmsg+0x346/0xb70
 [<c02c16ed>] inet_sendmsg+0x4d/0x60
 [<c0278886>] sock_aio_write+0xf6/0x120
 [<c015a381>] do_sync_write+0xd1/0x120
 [<c0150439>] page_add_file_rmap+0x59/0x70
 [<c014b43c>] handle_mm_fault+0xfc/0x250
 [<c012f060>] autoremove_wake_function+0x0/0x60
 [<c015a53d>] vfs_write+0x16d/0x180
 [<c015a621>] sys_write+0x51/0x80
 [<c0103185>] syscall_call+0x7/0xb
ctevent: skb->ct != ecache->ct !!!
 [<d0c6cfc6>] ip_ct_refresh_acct+0x146/0x150 [ip_conntrack]
 [<d0c6e45a>] tcp_packet+0x1ea/0x5d0 [ip_conntrack]
 [<d0c6b697>] __ip_conntrack_find+0x17/0xb0 [ip_conntrack]
 [<d0c6b782>] ip_conntrack_find_get+0x52/0x60 [ip_conntrack]
 [<d0c6c33f>] ip_conntrack_in+0xef/0x2f0 [ip_conntrack]
 [<c029e420>] dst_output+0x0/0x30
 [<c028ef38>] nf_iterate+0x78/0x90
 [<c029e420>] dst_output+0x0/0x30
 [<c029e420>] dst_output+0x0/0x30
 [<c028f42e>] nf_hook_slow+0x7e/0x150
 [<c029e420>] dst_output+0x0/0x30
 [<c029c313>] ip_queue_xmit+0x403/0x570
 [<c029e420>] dst_output+0x0/0x30
 [<c022185a>] extract_buf+0xda/0x120
 [<c02b1c05>] tcp_v4_send_check+0x55/0x100
 [<c02ab818>] tcp_transmit_skb+0x478/0x720
 [<c02ac890>] tcp_write_xmit+0x150/0x3f0
 [<c02acb69>] __tcp_push_pending_frames+0x39/0xd0
 [<c02a1226>] tcp_sendmsg+0x346/0xb70
 [<c02c16ed>] inet_sendmsg+0x4d/0x60
 [<c0278886>] sock_aio_write+0xf6/0x120
 [<c015a381>] do_sync_write+0xd1/0x120
 [<c0150439>] page_add_file_rmap+0x59/0x70
 [<c014b43c>] handle_mm_fault+0xfc/0x250
 [<c012f060>] autoremove_wake_function+0x0/0x60
 [<c015a53d>] vfs_write+0x16d/0x180
 [<c015a621>] sys_write+0x51/0x80
 [<c0103185>] syscall_call+0x7/0xb

-- 
mattia
:wq!
