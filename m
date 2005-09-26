Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbVIZUgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVIZUgg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbVIZUgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:36:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932489AbVIZUgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:36:35 -0400
Date: Mon, 26 Sep 2005 13:36:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] sys_sendmsg() alignment bug fix
Message-Id: <20050926133634.657ef4a3.akpm@osdl.org>
In-Reply-To: <1127764921.6529.60.camel@tdi>
References: <1127764921.6529.60.camel@tdi>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Williamson <alex.williamson@hp.com> wrote:
>
>    The patch below adds an alignment attribute to the buffer used in
> sys_sendmsg().  This eliminates an unaligned access warning on ia64.
> 

Vaguely surprised that the compiler cannot be taught to do this.

> 
> diff -r db9b9552a2b4 net/socket.c
> --- a/net/socket.c	Sat Sep 24 23:56:08 2005
> +++ b/net/socket.c	Mon Sep 26 13:44:09 2005
> @@ -1700,7 +1700,9 @@
>  	struct socket *sock;
>  	char address[MAX_SOCK_ADDR];
>  	struct iovec iovstack[UIO_FASTIOV], *iov = iovstack;
> -	unsigned char ctl[sizeof(struct cmsghdr) + 20];	/* 20 is size of ipv6_pktinfo */
> +	unsigned char ctl[sizeof(struct cmsghdr) + 20]
> +	                  __attribute__ ((aligned (sizeof(__kernel_size_t))));
> +	                  /* 20 is size of ipv6_pktinfo */
>  	unsigned char *ctl_buf = ctl;
>  	struct msghdr msg_sys;
>  	int err, ctl_len, iov_size, total_len;

OK, thanks - I'll send this on to davem.  It seems odd to be using
__kernel_size_t rather than size_t, but that's what struct cmshdr does
(also oddly).

