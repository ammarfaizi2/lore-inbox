Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUERLDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUERLDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 07:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUERLDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 07:03:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41436 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262175AbUERLDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 07:03:49 -0400
Date: Tue, 18 May 2004 13:03:43 +0200
From: Jens Axboe <axboe@suse.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: RPC request reserved 0 but used 96
Message-ID: <20040518110342.GE30348@suse.de>
References: <20040515083831.GR17326@suse.de> <20040515085819.GS17326@suse.de> <20040515103650.GB24600@suse.de> <20040518040613.GB10633@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040518040613.GB10633@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18 2004, J. Bruce Fields wrote:
> On Sat, May 15, 2004 at 12:36:51PM +0200, Jens Axboe wrote:
> > 2.6.6-BK with shares exported sync show the same behaviour. I get:
> > 
> > RPC request reserved 0 but used 32900
> > RPC request reserved 0 but used 32900
> > RPC request reserved 0 but used 96
> 
> Does this end the messages?
> 
> --Bruce Fields
> 
> svc_recv may call svc_sock_release before rqstp->rq_res is initialized.
> 
>  net/sunrpc/svcsock.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff -puN net/sunrpc/svcsock.c~svc_reserve_debugging net/sunrpc/svcsock.c
> --- linux-2.6.6/net/sunrpc/svcsock.c~svc_reserve_debugging	2004-05-17 23:46:51.000000000 -0400
> +++ linux-2.6.6-bfields/net/sunrpc/svcsock.c	2004-05-17 23:50:54.000000000 -0400
> @@ -1255,6 +1255,7 @@ svc_recv(struct svc_serv *serv, struct s
>  
>  	/* No data, incomplete (TCP) read, or accept() */
>  	if (len == 0 || len == -EAGAIN) {
> +		rqstp->rq_res.len = 0;
>  		svc_sock_release(rqstp);
>  		return -EAGAIN;
>  	}

Seems to have fixed it, at least I haven't seen any messages of this
sort since applying the patch and switching back to nfs over tcp.
Thanks!

-- 
Jens Axboe

