Return-Path: <linux-kernel-owner+w=401wt.eu-S964881AbWLMBmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWLMBmR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 20:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWLMBmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 20:42:17 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38899 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964881AbWLMBmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 20:42:16 -0500
Date: Tue, 12 Dec 2006 17:42:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 010 of 14] knfsd: SUNRPC: add a "generic" function to
 see if the peer uses a secure port
Message-Id: <20061212174207.6180df0f.akpm@osdl.org>
In-Reply-To: <1061212235927.21484@suse.de>
References: <20061213105528.21128.patches@notabene>
	<1061212235927.21484@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 10:59:27 +1100
NeilBrown <neilb@suse.de> wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
> The only reason svcsock.c looks at a sockaddr's port is to check whether
> the remote peer is connecting from a privileged port.  Refactor this check
> to hide processing that is specific to address format.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Cc: Aurelien Charbon <aurelien.charbon@ext.bull.net>
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./net/sunrpc/svcsock.c |   20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
> --- .prev/net/sunrpc/svcsock.c	2006-12-13 10:32:15.000000000 +1100
> +++ ./net/sunrpc/svcsock.c	2006-12-13 10:32:17.000000000 +1100
> @@ -926,6 +926,20 @@ svc_tcp_data_ready(struct sock *sk, int 
>  		wake_up_interruptible(sk->sk_sleep);
>  }
>  
> +static inline int svc_port_is_privileged(struct sockaddr *sin)
> +{
> +	switch (sin->sa_family) {
> +	case AF_INET:
> +		return ntohs(((struct sockaddr_in *)sin)->sin_port) < 1024;
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +	case AF_INET6:
> +		return ntohs(((struct sockaddr_in6 *)sin)->sin6_port) < 1024;
> +#endif
> +	default:
> +		return 0;
> +	}
> +}

I'm a bit surprised to see this test implemented in sunrpc - it's the sort
of thing which core networking should implement?

And should that "1024" be PROT_SOCK?
