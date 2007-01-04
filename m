Return-Path: <linux-kernel-owner+w=401wt.eu-S1030187AbXADW6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbXADW6R (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbXADW6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:58:16 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:33909 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030187AbXADW6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:58:14 -0500
Date: Thu, 4 Jan 2007 14:57:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bernhard Schmidt <berni@birkenwald.de>
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [Bug] OOPS with nf_conntrack_ipv6, probably fragmented UDPv6
Message-Id: <20070104145747.280d5928.akpm@osdl.org>
In-Reply-To: <459D322F.5010707@birkenwald.de>
References: <459D322F.5010707@birkenwald.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jan 2007 17:58:23 +0100
Bernhard Schmidt <berni@birkenwald.de> wrote:

> Hi,
> 
> I've hit another kernel oops with 2.6.20-rc3 on i386 platform. It is 
> reproducible, as soon as I load nf_conntrack_ipv6 and try to send 
> something large (scp or so) inside an OpenVPN tunnel on my client 
> (patched with UDPv6 transport) the router (another box) OOPSes.
> 
> tcpdump suggests the problem appears as soon as my client sends 
> fragmented UDPv6 packets towards the destination. It does not happen 
> when nf_conntrack_ipv6 is not loaded. This is the OOPS as dumped from 
> the serial console:
> 
> heimdall login: Oops: 0000 [#1]
> Modules linked in: sit sch_red sch_htb pppoe pppox ppp_generic slhc 
> xt_CLASSIFY ipt_TOS xt_length ipt_tos ipt_TCPMSS xt_tcpudp 
> ipt_MASQUERADE xt_state iptable_mangle iptable_filter
>   iptable_nat nf_nat nf_conntrack_ipv4 ip_tables x_tables 
> nf_conntrack_ipv6 nf_conntrack nfnetlink
> CPU:    0
> EIP:    0060:[<00000001>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.20-rc3 #2)
> EIP is at 0x1
> eax: cd215bc0   ebx: cd1f3160   ecx: cc59002a   edx: cd215bc0
> esi: cd215bc0   edi: cd215bc0   ebp: 00000000   esp: c030bd3c
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, ti=c030a000 task=c02e93a0 task.ti=c030a000)
> Stack: c0212cc4 00000004 cc83f160 cd2130c0 cd215bc0 cd2130c0 cd215bc0 
> c021734b
>         c030bdb4 c0307a60 0000000a cceee800 cceee800 cd215bc0 cd1f3160 
> 00000000
>         c021896b c0307a60 cd215bc0 cd215bc0 cceee800 cd1f3160 c025f1c6 
> 00000000
> Call Trace:
>   [<c0212cc4>] __kfree_skb+0x84/0xe0
>   [<c021734b>] dev_hard_start_xmit+0x1bb/0x1d0
>   [<c021896b>] dev_queue_xmit+0x11b/0x1b0
>   [<c025f1c6>] ip6_output2+0x276/0x2b0
>   [<c025ed30>] ip6_output_finish+0x0/0xf0
>   [<c025fc0a>] ip6_output+0x90a/0x940
>   [<c013e9e5>] cache_alloc_refill+0x2c5/0x3f0
>   [<c0212eed>] pskb_expand_head+0xdd/0x130
>   [<c02608d5>] ip6_forward+0x465/0x4b0
>   [<c02618c6>] ip6_rcv_finish+0x16/0x30
>   [<ce81a056>] nf_ct_frag6_output+0x86/0xb0 [nf_conntrack_ipv6]
>   [<c02618b0>] ip6_rcv_finish+0x0/0x30
>   [<ce81911b>] ipv6_defrag+0x3b/0x50 [nf_conntrack_ipv6]
>   [<c02618b0>] ip6_rcv_finish+0x0/0x30
>   [<c022c618>] nf_iterate+0x38/0x70
>   [<c02618b0>] ip6_rcv_finish+0x0/0x30
>   [<c022c75d>] nf_hook_slow+0x4d/0xc0
>   [<c02618b0>] ip6_rcv_finish+0x0/0x30
>   [<c0261ac0>] ipv6_rcv+0x1e0/0x250
>   [<c02618b0>] ip6_rcv_finish+0x0/0x30
>   [<c0217068>] netif_receive_skb+0x1a8/0x200
>   [<c021868e>] process_backlog+0x6e/0xe0
>   [<c0218752>] net_rx_action+0x52/0xd0
>   [<c0113885>] __do_softirq+0x35/0x80
>   [<c01138f2>] do_softirq+0x22/0x30
>   [<c010453e>] do_IRQ+0x5e/0x70
>   [<c0102b33>] common_interrupt+0x23/0x30
>   [<c0101820>] default_idle+0x0/0x40
>   [<c0101847>] default_idle+0x27/0x40
>   [<c0101017>] cpu_idle+0x37/0x50
>   [<c030c676>] start_kernel+0x266/0x270
>   [<c030c200>] unknown_bootoption+0x0/0x210
>   =======================
> Code:  Bad EIP value.
> EIP: [<00000001>] 0x1 SS:ESP 0068:c030bd3c
>   <0>Kernel panic - not syncing: Fatal exception in interrupt
>   <0>Rebooting in 20 seconds..<4>atkbd.c: Spurious ACK on 
> isa0060/serio0. Some program might be trying access hardware directly.
> 

At a guess I'd say that skb->nfct->destroy has value 0x00000001.  Not a
good function address.

Presumably it is suppsoed to be zero...
