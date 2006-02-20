Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbWBTShX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbWBTShX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbWBTShW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:37:22 -0500
Received: from stinky.trash.net ([213.144.137.162]:485 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id S1161111AbWBTShV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:37:21 -0500
Message-ID: <43FA0C02.8000909@trash.net>
Date: Mon, 20 Feb 2006 19:35:46 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: earny@net4u.de
CC: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       Kernel Netdev Mailing List <netdev@vger.kernel.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: 2.6.16-rc4 bridge/iptables Oops
References: <200602201651.50217.list-lkml@net4u.de>
In-Reply-To: <200602201651.50217.list-lkml@net4u.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------060303010101050302030409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060303010101050302030409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ernst Herzberg wrote:
> This machine oopses one to three (or more?) times a day. Occurs since upgrading 
> from -rc3 to -rc4 (and adding/reconfiguring raid).
> 
> It is reproducable, i have only to wait 10min to a couple of hours:-)
> 
> Opps copy/pasted from a serial console, long lines maybe truncated.
> dmesg is from the _previous_ boot/oops....
> 
> -------------------------------------------
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in: ebt_log ebt_ip ebtable_filter ebtables nfsd exportfs lockd sunrpc w83627hf hwmon_vid i2c_isa xt_tcpudp xt_state ipt_MASQUERADE iptable_e
> CPU:    0
> EIP:    0060:[<b033fbf3>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.16-rc4 #3)
> EIP is at xfrm_lookup+0x1f/0x47d
> eax: 00000000   ebx: b0452bb4   ecx: 00000000   edx: b0452bb4
> esi: b0452c90   edi: d6c9aa58   ebp: 80000000   esp: b0452b08
> ds: 007b   es: 007b   ss: 0068
> Process vtund (pid: 12035, threadinfo=b0452000 task=ef8cb030)
> Stack: <0>b0452000 d6c9aa58 b0452bc4 00000000 f153b56a b0452b84 d6c9aa58 f1546181
>        b03e5d20 00000000 b0452bb4 b0452bb0 b0452b84 b0452b94 f1546511 d804fd24
>        d6c9aa58 b0452b94 d6c9aa58 00000000 b0452b84 f15465a6 d6c9aa58 00000000
> Call Trace:
>  [<f153b56a>] ip_conntrack_tuple_taken+0x2c/0x3e [ip_conntrack]
>  [<f1546181>] ip_nat_used_tuple+0x1f/0x2b [ip_nat]
>  [<f1546511>] get_unique_tuple+0xca/0xe6 [ip_nat]
>  [<f15465a6>] ip_nat_setup_info+0x79/0x1fd [ip_nat]
>  [<b033ac28>] ip_xfrm_me_harder+0x5d/0x14b
>  [<f154b882>] ip_nat_out+0xb2/0xde [iptable_nat]
>  [<b034d154>] br_dev_queue_push_xmit+0x0/0x12a

This patch should fix it. Please test it and report if it helps.

--------------060303010101050302030409
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[NETFILTER]: Fix crash with bridge-netfilter in xfrm_lookup

Bridge-netfilter attaches a fake dst entry without dst->ops to bridged
packets, which makes xfrm_lookup crash. Skip the lookup since IPsec
isn't supposed to work on a pure bridge anyway.

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit 98a533612cd7cc51482972b84ac9845a46e81bc9
tree 4b509dae626aaff8cd2e6521425d81ca0bcda1d4
parent d64d19d938ca48d1a4470010f8d48ceac28f4317
author Patrick McHardy <kaber@trash.net> Mon, 20 Feb 2006 19:34:57 +0100
committer Patrick McHardy <kaber@trash.net> Mon, 20 Feb 2006 19:34:57 +0100

 net/ipv4/netfilter.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/net/ipv4/netfilter.c b/net/ipv4/netfilter.c
index ed42cdc..ae1e75d 100644
--- a/net/ipv4/netfilter.c
+++ b/net/ipv4/netfilter.c
@@ -87,6 +87,13 @@ int ip_xfrm_me_harder(struct sk_buff **p
 
 	if (IPCB(*pskb)->flags & IPSKB_XFRM_TRANSFORMED)
 		return 0;
+#ifdef CONFIG_BRIDGE_NETFILTER
+	/* bridge netfilter attaches a fake dst entry without dst->ops to bridged
+	 * packets, which makes xfrm_lookup crash. Skip the lookup since IPsec
+	 * isn't supposed to work on a pure bridge anyway. */
+	if ((*pskb)->dst->ops == NULL)
+		return 0;
+#endif
 	if (xfrm_decode_session(*pskb, &fl, AF_INET) < 0)
 		return -1;
 

--------------060303010101050302030409--
