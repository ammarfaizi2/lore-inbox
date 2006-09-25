Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWIYPnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWIYPnx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 11:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWIYPnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 11:43:53 -0400
Received: from mail.fieldses.org ([66.93.2.214]:5357 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S1750976AbWIYPnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 11:43:52 -0400
Date: Mon, 25 Sep 2006 11:43:16 -0400
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Banks <gnb@melbourne.sgi.com>
Subject: Re: [NFS] [PATCH 008 of 11] knfsd: Prepare knfsd for support of rsize/wsize of up to 1MB, over TCP.
Message-ID: <20060925154316.GA17465@fieldses.org>
References: <20060824162917.3600.patches@notabene> <1060824063711.5008@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060824063711.5008@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 04:37:11PM +1000, NeilBrown wrote:
> The limit over UDP remains at 32K.  Also, make some of
> the apparently arbitrary sizing constants clearer.
> 
> The biggest change here involves replacing NFSSVC_MAXBLKSIZE
> by a function of the rqstp.  This allows it to be different
> for different protocols (udp/tcp) and also allows it
> to depend on the servers declared sv_bufsiz.
> 
> Note that we don't actually increase sv_bufsz for nfs yet.
> That comes next.

This patch has some problems.  (Apologies for being so slow to look at
them!)

We're reporting svc_max_payload(rqstp) as the server's maximum
read/write block size:

> @@ -538,15 +539,16 @@ nfsd3_proc_fsinfo(struct svc_rqst * rqst
>  					   struct nfsd3_fsinfores *resp)
>  {
>  	int	nfserr;
> +	u32	max_blocksize = svc_max_payload(rqstp);
>  
>  	dprintk("nfsd: FSINFO(3)   %s\n",
>  				SVCFH_fmt(&argp->fh));
>  
> -	resp->f_rtmax  = NFSSVC_MAXBLKSIZE;
> -	resp->f_rtpref = NFSSVC_MAXBLKSIZE;
> +	resp->f_rtmax  = max_blocksize;
> +	resp->f_rtpref = max_blocksize;
>  	resp->f_rtmult = PAGE_SIZE;
> -	resp->f_wtmax  = NFSSVC_MAXBLKSIZE;
> -	resp->f_wtpref = NFSSVC_MAXBLKSIZE;
> +	resp->f_wtmax  = max_blocksize;
> +	resp->f_wtpref = max_blocksize;
>  	resp->f_wtmult = PAGE_SIZE;
>  	resp->f_dtpref = PAGE_SIZE;
>  	resp->f_maxfilesize = ~(u32) 0;

But svc_max_payload() usually returns sv_bufsz in the TCP case:

> +u32 svc_max_payload(const struct svc_rqst *rqstp)
> +{
> +	int max = RPCSVC_MAXPAYLOAD_TCP;
> +
> +	if (rqstp->rq_sock->sk_sock->type == SOCK_DGRAM)
> +		max = RPCSVC_MAXPAYLOAD_UDP;
> +	if (rqstp->rq_server->sv_bufsz < max)
> +		max = rqstp->rq_server->sv_bufsz;
> +	return max;
> +}


That's the *total* size of the buffer for holding requests and replies.

If a client actually tries to send a write of that size, the entire
request will of course exceed sv_bufsz, so we'll drop it.  (We've seen
this happen with the Solaris v4 client.)

> -#define NFSD_BUFSIZE		(1024 + NFSSVC_MAXBLKSIZE)
> +/*
> + * Largest number of bytes we need to allocate for an NFS
> + * call or reply.  Used to control buffer sizes.  We use
> + * the length of v3 WRITE, READDIR and READDIR replies
> + * which are an RPC header, up to 26 XDR units of reply
> + * data, and some page data.
> + *
> + * Note that accuracy here doesn't matter too much as the
> + * size is rounded up to a page size when allocating space.
> + */

Is the rounding up *always* going to increase the size?  And if not,
then why doesn't accuracy matter?

> +#define NFSD_BUFSIZE		((RPC_MAX_HEADER_WITH_AUTH+26)*XDR_UNIT + NFSSVC_MAXBLKSIZE)

I think this results in 80 less bytes less than before, I think.

No doubt we have lots of wiggle room here, but I'd rather we didn't
decrease that size without seeing a careful analysis.

--b.
