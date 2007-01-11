Return-Path: <linux-kernel-owner+w=401wt.eu-S1751255AbXAIJ7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbXAIJ7V (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbXAIJ7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:59:21 -0500
Received: from stinky.trash.net ([213.144.137.162]:39537 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbXAIJ7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:59:20 -0500
Message-ID: <45A63D72.2060405@trash.net>
Date: Thu, 11 Jan 2007 14:36:50 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernhard Schmidt <berni@birkenwald.de>
CC: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [Bug] OOPS with nf_conntrack_ipv6, probably fragmented UDPv6
References: <459D322F.5010707@birkenwald.de>
In-Reply-To: <459D322F.5010707@birkenwald.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------090704020605000502070400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090704020605000502070400
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Bernhard Schmidt wrote:
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
>  iptable_nat nf_nat nf_conntrack_ipv4 ip_tables x_tables
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
>        c030bdb4 c0307a60 0000000a cceee800 cceee800 cd215bc0 cd1f3160
> 00000000
>        c021896b c0307a60 cd215bc0 cd215bc0 cceee800 cd1f3160 c025f1c6
> 00000000
> Call Trace:
>  [<c0212cc4>] __kfree_skb+0x84/0xe0
>  [<c021734b>] dev_hard_start_xmit+0x1bb/0x1d0
>  [<c021896b>] dev_queue_xmit+0x11b/0x1b0
>  [<c025f1c6>] ip6_output2+0x276/0x2b0
>  [<c025ed30>] ip6_output_finish+0x0/0xf0
>  [<c025fc0a>] ip6_output+0x90a/0x940
>  [<c013e9e5>] cache_alloc_refill+0x2c5/0x3f0
>  [<c0212eed>] pskb_expand_head+0xdd/0x130
>  [<c02608d5>] ip6_forward+0x465/0x4b0
>  [<c02618c6>] ip6_rcv_finish+0x16/0x30
>  [<ce81a056>] nf_ct_frag6_output+0x86/0xb0 [nf_conntrack_ipv6]

Does this patch help?


--------------090704020605000502070400
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[NETFILTER]: nf_conntrack_ipv6: fix crash when handling fragments

When IPv6 connection tracking splits up a defragmented packet into
its original fragments, the packets are taken from a list and are
passed to the network stack with skb->next still set. This causes
dev_hard_start_xmit to treat them as GSO fragments, resulting in
a use after free when connection tracking handles the next fragment.

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit f7c932bb23afe7873586fb9bad82718e3f16a3af
tree c2e18743b831f43fa7859d29ea9b2a622c58da99
parent fe6df90eb909a84593b6902e6e4f802687bc4564
author Patrick McHardy <kaber@trash.net> Tue, 09 Jan 2007 10:35:28 +0100
committer Patrick McHardy <kaber@trash.net> Tue, 09 Jan 2007 10:35:28 +0100

 net/ipv6/netfilter/nf_conntrack_reasm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 37e5fca..d9c1540 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -835,6 +835,8 @@ void nf_ct_frag6_output(unsigned int hoo
 		s->nfct_reasm = skb;
 
 		s2 = s->next;
+		s->next = NULL;
+
 		NF_HOOK_THRESH(PF_INET6, hooknum, s, in, out, okfn,
 			       NF_IP6_PRI_CONNTRACK_DEFRAG + 1);
 		s = s2;


--------------090704020605000502070400--
