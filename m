Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWCGPGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWCGPGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 10:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWCGPGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 10:06:15 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:1232 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750772AbWCGPGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 10:06:14 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Dmitry Mishin <dim@openvz.org>
Subject: Re: {get|set}sockopt compat layer
Date: Tue, 7 Mar 2006 16:05:38 +0100
User-Agent: KMail/1.9.1
Cc: devel@openvz.org, dev@openvz.org, akpm@osdl.org,
       netfilter-devel@lists.netfilter.org, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
References: <200602201110.39092.dim@openvz.org> <200602211256.00846.arnd@arndb.de> <200603071707.19138.dim@openvz.org>
In-Reply-To: <200603071707.19138.dim@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200603071605.39177.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 15:07, Dmitry Mishin wrote:
> Sorry for such delay, was on vacancy. Here is a patch, introducing 
> compat_(get|set)sockopt handlers, as you proposed.

Looks pretty good to me, just a few nits I like to pick:

> --- ./include/linux/net.h.compat        2006-03-07 11:22:27.000000000 +0300
> +++ ./include/linux/net.h       2006-03-07 11:20:07.000000000 +0300
> @@ -149,6 +149,12 @@ struct proto_ops {
>                                       int optname, char __user *optval, int optlen);
>         int             (*getsockopt)(struct socket *sock, int level,
>                                       int optname, char __user *optval, int __user *optlen);
> +#ifdef CONFIG_COMPAT
> +       int             (*compat_setsockopt)(struct socket *sock, int level,
> +                                     int optname, char __user *optval, int optlen);
> +       int             (*compat_getsockopt)(struct socket *sock, int level,
> +                                     int optname, char __user *optval, int __user *optlen);
> +#endif
>         int             (*sendmsg)   (struct kiocb *iocb, struct socket *sock,
>                                       struct msghdr *m, size_t total_len);
>         int             (*recvmsg)   (struct kiocb *iocb, struct socket *sock,

For the compat_ioctl stuff, we don't have the function pointer inside an
#ifdef, the overhead is relatively small since there is only one of these
structures per module implementing a protocol, but it avoids having to
rebuild everything when changing CONFIG_COMPAT.

It's probably not a big issue either way, maybe davem has a stronger opinion
on it either way.

> --- ./include/linux/netfilter.h.compat  2006-03-06 12:06:34.000000000 +0300
> +++ ./include/linux/netfilter.h 2006-03-07 15:00:14.000000000 +0300
> @@ -2,6 +2,7 @@
>  #define __LINUX_NETFILTER_H
>  
>  #ifdef __KERNEL__
> +#include <linux/config.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/skbuff.h>

You don't need to add new <linux/config.h> includes any more, these are
automatic now.

> @@ -80,10 +81,18 @@ struct nf_sockopt_ops
>         int set_optmin;
>         int set_optmax;
>         int (*set)(struct sock *sk, int optval, void __user *user, unsigned int len);
> +#ifdef CONFIG_COMPAT
> +       int (*compat_set)(struct sock *sk, int optval,
> +                       void __user *user, unsigned int len);
> +#endif
>  
>         int get_optmin;
>         int get_optmax;
>         int (*get)(struct sock *sk, int optval, void __user *user, int *len);
> +#ifdef CONFIG_COMPAT
> +       int (*compat_get)(struct sock *sk, int optval,
> +                       void __user *user, int *len);
> +#endif
>  
>         /* Number of users inside set() or get(). */
>         unsigned int use;

see above, same for some more of these.

> @@ -816,6 +826,12 @@ extern int sock_common_recvmsg(struct ki
>                                struct msghdr *msg, size_t size, int flags);
>  extern int sock_common_setsockopt(struct socket *sock, int level, int optname,
>                                   char __user *optval, int optlen);
> +#ifdef CONFIG_COMPAT
> +extern int compat_sock_common_getsockopt(struct socket *sock, int level,
> +               int optname, char __user *optval, int __user *optlen);
> +extern int compat_sock_common_setsockopt(struct socket *sock, int level,
> +               int optname, char __user *optval, int optlen);
> +#endif
>  
>  extern void sk_common_release(struct sock *sk);
>  

Declarations don't belong inside #ifdef.

	Arnd <><
