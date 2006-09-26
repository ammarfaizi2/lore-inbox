Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWIZM7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWIZM7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 08:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWIZM7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 08:59:18 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:5953 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751319AbWIZM7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 08:59:17 -0400
Message-ID: <45192410.6070801@oracle.com>
Date: Tue, 26 Sep 2006 08:58:56 -0400
From: Chuck Lever <chuck.lever@oracle.com>
Reply-To: chuck.lever@oracle.com
Organization: Oracle USA
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Eric Sesterhenn <snakebyte@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Possible dereference in fs/nfsd/nfs4callback.c
References: <1159266659.5413.3.camel@alice>
In-Reply-To: <1159266659.5413.3.camel@alice>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sesterhenn wrote:
> hi,
> 
> the following commit introduced a possible NULL pointer dereference
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ae5c79476f36512d1100e162606bb5691f2cce5a
> 
> we set cb->cb_client to NULL and pass it to rpc_shutdown_client() which dereferences it.

What was I thinking/smoking?  ;-)

> The easy fix below.
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 
> --- linux-2.6.18-git5/fs/nfsd/nfs4callback.c.orig	2006-09-26 12:24:23.000000000 +0200
> +++ linux-2.6.18-git5/fs/nfsd/nfs4callback.c	2006-09-26 12:24:40.000000000 +0200
> @@ -450,7 +450,8 @@ out_rpciod:
>  	rpciod_down();
>  	cb->cb_client = NULL;
>  out_clnt:
> -	rpc_shutdown_client(cb->cb_client);
> +	if (cb->cb_client)
> +		rpc_shutdown_client(cb->cb_client);
>  out_err:
>  	dprintk("NFSD: warning: no callback path to client %.*s\n",
>  		(int)clp->cl_name.len, clp->cl_name.data);

Actually I see another problem here.

rpc_create() doesn't return NULL, it returns an ERR_PTR.  So the return 
code check in the code just before this is also bogus.

I'll send a complete fix through Trond.
