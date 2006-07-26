Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWGZUse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWGZUse (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 16:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWGZUse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 16:48:34 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:10981 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750728AbWGZUsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 16:48:33 -0400
Subject: Re: RFC: kernel memory leak fix for af_unix datagram getpeersec
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Catherine Zhang <cxzhang@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jmorris@namei.org,
       davem@davemloft.net, catalin.marinas@gmail.com,
       michal.k.k.piotrowski@gmail.com, czhang.us@gmail.com
In-Reply-To: <20060726201916.GA32505@jiayuguan.watson.ibm.com>
References: <20060726201916.GA32505@jiayuguan.watson.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 26 Jul 2006 16:50:40 -0400
Message-Id: <1153947040.11769.208.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 16:19 -0400, Catherine Zhang wrote:
> diff -puN include/net/scm.h~af_unix-datagram-getpeersec-ml-fix include/net/scm.h
> --- linux-2.6.18-rc2/include/net/scm.h~af_unix-datagram-getpeersec-ml-fix	2006-07-22 21:28:21.000000000 -0400
> +++ linux-2.6.18-rc2-cxzhang/include/net/scm.h	2006-07-24 11:19:54.000000000 -0400
> @@ -3,6 +3,7 @@
>  
>  #include <linux/limits.h>
>  #include <linux/net.h>
> +#include <linux/security.h>
>  
>  /* Well, we should have at least one descriptor open
>   * to accept passed FDs 8)
> @@ -20,8 +21,7 @@ struct scm_cookie
>  	struct ucred		creds;		/* Skb credentials	*/
>  	struct scm_fp_list	*fp;		/* Passed files		*/
>  #ifdef CONFIG_SECURITY_NETWORK
> -	char			*secdata;	/* Security context	*/
> -	u32			seclen;		/* Security length	*/
> +	u32			sid;		/* Passed security ID 	*/

I think that "secid" is what has been chosen for security identifiers
outside of the core SELinux code to to avoid confusion with session
identifiers.  Lingering references to sid or ctxid are going to be
converted to secid.

> diff -puN net/unix/af_unix.c~af_unix-datagram-getpeersec-ml-fix net/unix/af_unix.c
> --- linux-2.6.18-rc2/net/unix/af_unix.c~af_unix-datagram-getpeersec-ml-fix	2006-07-22 23:01:26.000000000 -0400
> +++ linux-2.6.18-rc2-cxzhang/net/unix/af_unix.c	2006-07-22 23:14:15.000000000 -0400
> @@ -1323,8 +1299,9 @@ static int unix_dgram_sendmsg(struct kio
>  	memcpy(UNIXCREDS(skb), &siocb->scm->creds, sizeof(struct ucred));
>  	if (siocb->scm->fp)
>  		unix_attach_fds(siocb->scm, skb);
> -
> -	unix_get_peersec_dgram(skb);
> +#ifdef CONFIG_SECURITY_NETWORK
> +	memcpy(UNIXSID(skb), &siocb->scm->sid, sizeof(u32));
> +#endif /* CONFIG_SECURITY_NETWORK */

You want to retain the static inlines, and just update their contents,
not replace them with embedded #ifdefs.  And this could be a direct
assignment, right?

-- 
Stephen Smalley
National Security Agency

