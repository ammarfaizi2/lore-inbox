Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbULOOHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbULOOHh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 09:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbULOOHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 09:07:34 -0500
Received: from mx01.cybersurf.com ([209.197.145.104]:39066 "EHLO
	mx01.cybersurf.com") by vger.kernel.org with ESMTP id S262350AbULOOHS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 09:07:18 -0500
Subject: Re: [2.6 patch] net/netlink/af_netlink.c: possible cleanups
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041215004604.GH23151@stusta.de>
References: <20041215004604.GH23151@stusta.de>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1103119623.1077.71.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 15 Dec 2004 09:07:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think this should be left alone for now; what we need to do is
deprecate NETLINK_DEV incase someone is still using it.
Else we could get rid of it totaly including what Adrian is deleting
below. Any users of NETLINK_DEV? Maybe deleting the feature will get
someone whining? ;->

cheers,
jamal

On Tue, 2004-12-14 at 19:46, Adrian Bunk wrote:
> The patch below contains the following possible cleanups:
> - make the needlessly global function netlink_getsockbypid static
> - remove the EXPORT_SYMBOL'ed but unused functions netlink_attach and 
>   netlink_detach
> 
> Please review whether these changes are correct or whether they conflict 
> with pending patches.
> 
> 
> diffstat output:
>  include/linux/netlink.h  |    3 ---
>  net/netlink/af_netlink.c |   28 +---------------------------
>  2 files changed, 1 insertion(+), 30 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.10-rc3-mm1-full/include/linux/netlink.h.old	2004-12-14 21:43:16.000000000 +0100
> +++ linux-2.6.10-rc3-mm1-full/include/linux/netlink.h	2004-12-14 21:44:27.000000000 +0100
> @@ -116,8 +116,6 @@
>  #define NETLINK_CREDS(skb)	(&NETLINK_CB((skb)).creds)
>  
> 
> -extern int netlink_attach(int unit, int (*function)(int,struct sk_buff *skb));
> -extern void netlink_detach(int unit);
>  extern int netlink_post(int unit, struct sk_buff *skb);
>  extern struct sock *netlink_kernel_create(int unit, void (*input)(struct sock *sk, int len));
>  extern void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err);
> @@ -129,7 +127,6 @@
>  extern int netlink_unregister_notifier(struct notifier_block *nb);
>  
>  /* finegrained unicast helpers: */
> -struct sock *netlink_getsockbypid(struct sock *ssk, u32 pid);
>  struct sock *netlink_getsockbyfilp(struct file *filp);
>  int netlink_attachskb(struct sock *sk, struct sk_buff *skb, int nonblock, long timeo);
>  void netlink_detachskb(struct sock *sk, struct sk_buff *skb);
> --- linux-2.6.10-rc3-mm1-full/net/netlink/af_netlink.c.old	2004-12-14 21:43:31.000000000 +0100
> +++ linux-2.6.10-rc3-mm1-full/net/netlink/af_netlink.c	2004-12-14 21:44:34.000000000 +0100
> @@ -546,7 +546,7 @@
>  	}
>  }
>  
> -struct sock *netlink_getsockbypid(struct sock *ssk, u32 pid)
> +static struct sock *netlink_getsockbypid(struct sock *ssk, u32 pid)
>  {
>  	int protocol = ssk->sk_protocol;
>  	struct sock *sock;
> @@ -1210,30 +1210,6 @@
>   *	Backward compatibility.
>   */	
>   
> -int netlink_attach(int unit, int (*function)(int, struct sk_buff *skb))
> -{
> -	struct sock *sk = netlink_kernel_create(unit, NULL);
> -	if (sk == NULL)
> -		return -ENOBUFS;
> -	nlk_sk(sk)->handler = function;
> -	write_lock_bh(&nl_emu_lock);
> -	netlink_kernel[unit] = sk->sk_socket;
> -	write_unlock_bh(&nl_emu_lock);
> -	return 0;
> -}
> -
> -void netlink_detach(int unit)
> -{
> -	struct socket *sock;
> -
> -	write_lock_bh(&nl_emu_lock);
> -	sock = netlink_kernel[unit];
> -	netlink_kernel[unit] = NULL;
> -	write_unlock_bh(&nl_emu_lock);
> -
> -	sock_release(sock);
> -}
> -
>  int netlink_post(int unit, struct sk_buff *skb)
>  {
>  	struct socket *sock;
> @@ -1522,7 +1498,5 @@
>  EXPORT_SYMBOL(netlink_unregister_notifier);
>  
>  #if defined(CONFIG_NETLINK_DEV) || defined(CONFIG_NETLINK_DEV_MODULE)
> -EXPORT_SYMBOL(netlink_attach);
> -EXPORT_SYMBOL(netlink_detach);
>  EXPORT_SYMBOL(netlink_post);
>  #endif
> 
> 
> 

