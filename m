Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbVIVT2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbVIVT2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbVIVT2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:28:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964920AbVIVT2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:28:47 -0400
Date: Thu, 22 Sep 2005 12:27:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Max Kellermann <max@duempel.org>
Cc: linux-kernel@vger.kernel.org, avuton@gmail.com,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] repair nfsd/sunrpc in 2.6.14-rc2-mm1 (and other -mm
 versions)
Message-Id: <20050922122749.555e0068.akpm@osdl.org>
In-Reply-To: <20050922130441.GA24005@roonstrasse.net>
References: <20050922130441.GA24005@roonstrasse.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Kellermann <max@duempel.org> wrote:
>
> nfsd is still broken in 2.6.14-rc2-mm1; the following procedure is
>  reproducable:
> 
>   rabbit:~# echo 2 >/proc/fs/nfsd/threads 
> 
>  ... /var/log/daemon.log says:
> 
>   Sep 22 13:52:55 rabbit kernel: NFSD: Using /var/lib/nfs/v4recovery as
>   the NFSv4 state recovery directory
>   Sep 22 13:52:55 rabbit kernel: NFSD: starting 90-second grace period
>   Sep 22 13:52:55 rabbit portmap[3191]: connect from 127.0.0.1 to
>   set(nfs): request from unprivileged port
> 
>  Your -mm patches make the sunrpc client connect to the portmapper with
>  a non-privileged source port.  This is due to a change in
>  net/sunrpc/pmap_clnt.c, which manually resets the xprt->resvport
>  field.  My tiny patch removes this line.  I have no idea why the line
>  was added in the first place, does somebody know better?
> 

That change comes from Trond's git tree.  I don't know why the change was
made.

Trond, rsync://client.linux-nfs.org/pub/linux/nfs-2.6.git hasn't been
updated in quite some time, I think.  I still need to revert the oopsy
rpc_mkdir() change.  Am I using the right tree?

> 
> [nfsd-pmap-fix-privileged-port.patch  text/plain (522 bytes)]
>  --- linux-2.6.14-rc2-mm1/net/sunrpc/pmap_clnt.c.orig	2005-09-22 14:58:14.000000000 +0200
>  +++ linux-2.6.14-rc2-mm1/net/sunrpc/pmap_clnt.c	2005-09-22 14:58:16.000000000 +0200
>  @@ -208,7 +208,6 @@
>   	if (IS_ERR(xprt))
>   		return (struct rpc_clnt *)xprt;
>   	xprt->addr.sin_port = htons(RPC_PMAP_PORT);
>  -	xprt->resvport = 0;
>   
>   	/* printk("pmap: create clnt\n"); */
>   	clnt = rpc_new_client(xprt, hostname,

