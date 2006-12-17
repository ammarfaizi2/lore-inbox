Return-Path: <linux-kernel-owner+w=401wt.eu-S1752793AbWLQPPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbWLQPPu (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 10:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752798AbWLQPPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 10:15:50 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:46554 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbWLQPPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 10:15:49 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 009 of 14] knfsd: SUNRPC: teach svc_sendto() to deal with IPv6 addresses
Date: Sun, 17 Dec 2006 16:15:40 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <20061213105528.21128.patches@notabene> <1061212235922.21469@suse.de>
In-Reply-To: <1061212235922.21469@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612171615.41972.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 13. December 2006 00:59, NeilBrown wrote:
> diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
> --- .prev/net/sunrpc/svcsock.c	2006-12-13 10:31:39.000000000 +1100
> +++ ./net/sunrpc/svcsock.c	2006-12-13 10:32:15.000000000 +1100
> @@ -438,6 +439,47 @@ svc_wake_up(struct svc_serv *serv)
>  	}
>  }
>  
> +union svc_pktinfo_u {
> +	struct in_pktinfo pkti;
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +	struct in6_pktinfo pkti6;
> +#endif
> +};
> +
> +static void svc_set_cmsg_data(struct svc_rqst *rqstp, struct cmsghdr *cmh)
> +{
> +	switch (rqstp->rq_sock->sk_sk->sk_family) {
> +	case AF_INET:
> +		do {
> +			struct in_pktinfo *pki =
> +					(struct in_pktinfo *) CMSG_DATA(cmh);

			struct in_pktinfo *pki = CMSG_DATA(cmh);

Ugly casting not needed here, since CMSG_DATA should return "void *",
which can be casted to any pointer.

> +
> +			cmh->cmsg_level = SOL_IP;
> +			cmh->cmsg_type = IP_PKTINFO;
> +			pki->ipi_ifindex = 0;
> +			pki->ipi_spec_dst.s_addr = rqstp->rq_daddr.addr.s_addr;
> +			cmh->cmsg_len = CMSG_LEN(sizeof(*pki));
> +		} while (0);
> +		break;
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +	case AF_INET6:
> +		do {
> +			struct in6_pktinfo *pki =
> +					(struct in6_pktinfo *) CMSG_DATA(cmh);
> +

No casting needed, so:

			struct in6_pktinfo *pki = CMSG_DATA(cmh);


Regards

Ingo Oeser
