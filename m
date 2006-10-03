Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWJCIDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWJCIDH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 04:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965272AbWJCIDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 04:03:07 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:39819 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964981AbWJCIDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 04:03:05 -0400
Date: Tue, 3 Oct 2006 18:02:02 +1000
From: Greg Banks <gnb@sgi.com>
To: Neil Brown <neilb@suse.de>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 008 of 11] knfsd: Prepare knfsd for support of	rsize/wsize of up to 1MB, over TCP.
Message-ID: <20061003080202.GM28796@sgi.com>
References: <20060824162917.3600.patches@notabene> <1060824063711.5008@suse.de> <20060925154316.GA17465@fieldses.org> <17697.48800.933642.581926@cse.unsw.edu.au> <20061003021304.GB12867@fieldses.org> <17697.63511.32591.797058@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17697.63511.32591.797058@cse.unsw.edu.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 03:41:43PM +1000, Neil Brown wrote:
> Comments on the below?

Looks ok, except...

> @@ -57,7 +57,8 @@ struct svc_serv {
>  	struct svc_stat *	sv_stats;	/* RPC statistics */
>  	spinlock_t		sv_lock;
>  	unsigned int		sv_nrthreads;	/* # of server threads */
> -	unsigned int		sv_bufsz;	/* datagram buffer size */
> +	unsigned int		sv_max_payload;	/* datagram payload size */
> +	unsigned int		sv_max_mesg;	/* bufsz + 1 page for overheads */

Presumably the comment should read "max_payload + 1 page..." ?

> @@ -414,9 +415,11 @@ svc_init_buffer(struct svc_rqst *rqstp, 
>  	int pages;
>  	int arghi;
>  	
> -	if (size > RPCSVC_MAXPAYLOAD)
> -		size = RPCSVC_MAXPAYLOAD;
> -	pages = 2 + (size+ PAGE_SIZE -1) / PAGE_SIZE;
> +	if (size > RPCSVC_MAXPAYLOAD + PAGE_SIZE)
> +		size = RPCSVC_MAXPAYLOAD + PAGE_SIZE;
> +	pages = size + PAGE_SIZE; /* extra page as we hold both request and reply.
> +				   * We assume one is at most one page
> +				   */

Isn't there a divide by PAGE_SIZE missing here?  Looks
like we'll be allocating a *lot* of pages ;-)

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
