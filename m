Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbVIKBWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVIKBWk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 21:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932742AbVIKBWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 21:22:40 -0400
Received: from smtp05.auna.com ([62.81.186.15]:52646 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S932418AbVIKBWj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 21:22:39 -0400
Date: Sun, 11 Sep 2005 01:22:37 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.13-mm2
To: Patrick McHardy <kaber@trash.net>
Cc: Linux-Kernel Lista <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org
References: <20050908053042.6e05882f.akpm@osdl.org>
	<1126396015l.6300l.1l@werewolf.able.es>
	<20050910165659.5eea90d0.akpm@osdl.org> <4323753D.9030007@trash.net>
	<1126399776l.6300l.2l@werewolf.able.es>
	<1126400288l.6300l.3l@werewolf.able.es> <43238259.505@trash.net>
In-Reply-To: <43238259.505@trash.net> (from kaber@trash.net on Sun Sep 11
	03:03:21 2005)
X-Mailer: Balsa 2.3.4
Message-Id: <1126401757l.6556l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.208.222] Login:jamagallon@able.es Fecha:Sun, 11 Sep 2005 03:22:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.11, Patrick McHardy wrote:
> J.A. Magallon wrote:
> > And I also get this on syslog:
> > 
> > Sep 11 02:56:58 werewolf kernel: MASQUERADE: eth0 ate my IP address
> > Sep 11 02:56:58 werewolf kernel: MASQUERADE: eth0 ate my IP address
> 
> Thanks, I'm pretty sure its caused by this patch. The problem is that
> pump uses a regular UDP socket (some other dhcp clients use AF_PACKET
> sockets), and packet sent by it are also handled by iptables. The
> MASQUERADE rule can't find a local IP address and drops the packet.
> I'm not sure how to fix it yet, reverting the patch is not a good
> option.
> 
> 

> [NETFILTER]: Don't exclude local packets from MASQUERADING
> 
> Increases consistency in source-address selection.
> 
> Signed-off-by: Patrick McHardy <kaber@trash.net>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> ---
> commit 9baa5c67ff4ce57b6b9f68c90714a1bb876fccd7
> tree 27f2c48e12e1bb5e3e6d5f8320651c213892ed20
> parent fb13ab2849074244a51ae5147483610529a29ced
> author Patrick McHardy <kaber@trash.net> Sun, 14 Aug 2005 17:32:50 -0700
> committer David S. Miller <davem@sunset.davemloft.net> Mon, 29 Aug 2005 15:58:36 -0700
> 
>  net/ipv4/netfilter/ipt_MASQUERADE.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/netfilter/ipt_MASQUERADE.c b/net/ipv4/netfilter/ipt_MASQUERADE.c
> --- a/net/ipv4/netfilter/ipt_MASQUERADE.c
> +++ b/net/ipv4/netfilter/ipt_MASQUERADE.c
> @@ -86,11 +86,6 @@ masquerade_target(struct sk_buff **pskb,
>  
>  	IP_NF_ASSERT(hooknum == NF_IP_POST_ROUTING);
>  
> -	/* FIXME: For the moment, don't do local packets, breaks
> -	   testsuite for 2.3.49 --RR */
> -	if ((*pskb)->sk)
> -		return NF_ACCEPT;
> -
>  	ct = ip_conntrack_get(*pskb, &ctinfo);
>  	IP_NF_ASSERT(ct && (ctinfo == IP_CT_NEW || ctinfo == IP_CT_RELATED
>  	                    || ctinfo == IP_CT_RELATED + IP_CT_IS_REPLY));
> 

Thanks, reverting this made things work again.

Are you confident in fixing this shortly, or should I just drop pump ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.13-jam3 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))


