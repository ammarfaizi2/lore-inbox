Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286821AbSAVPY0>; Tue, 22 Jan 2002 10:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287115AbSAVPYQ>; Tue, 22 Jan 2002 10:24:16 -0500
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:34434 "EHLO
	mailhost.uni-koblenz.de") by vger.kernel.org with ESMTP
	id <S286821AbSAVPYJ>; Tue, 22 Jan 2002 10:24:09 -0500
Message-Id: <200201221523.g0MFNst03011@bliss.uni-koblenz.de>
Content-Type: text/plain; charset=US-ASCII
From: Rainer Krienke <krienke@uni-koblenz.de>
Organization: Uni Koblenz
To: trond.myklebust@fys.uio.no
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Date: Tue, 22 Jan 2002 16:23:54 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com> <200201221308.g0MD8EY16176@bliss.uni-koblenz.de> <E16T0ye-0002K6-00@charged.uio.no>
In-Reply-To: <E16T0ye-0002K6-00@charged.uio.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 22. January 2002 14:28, Trond Myklebust wrote:
> On Tuesday 22. January 2002 14:08, you wrote:
> > So I still think that the reason for this is a check in the kernel, that
> > prevents connections from ports > 1024.
>
> Nope. It's the following hunk:
>
> diff -ur -X dontdiff linux-2.4.9-18.3/net/sunrpc/pmap_clnt.c
> linux-2.4.9-18.3-p3/net/sunrpc/pmap_clnt.c
> --- linux-2.4.9-18.3/net/sunrpc/pmap_clnt.c     Wed Jun 21 12:43:37 2000
> +++ linux-2.4.9-18.3-p3/net/sunrpc/pmap_clnt.c  Mon Jan  7 12:59:54 2002
> @@ -189,7 +189,7 @@
>         struct rpc_clnt *clnt;
>
>         /* printk("pmap: create xprt\n"); */
> -       if (!(xprt = xprt_create_proto(proto, srvaddr, NULL)))
> +       if (!(xprt = xprt_create_proto(proto, srvaddr, NULL, 0)))
>                 return NULL;
>         xprt->addr.sin_port = htons(RPC_PMAP_PORT);
>
>
> The above change implies that the portmapper can always be run from an
> insecure port.
> It can if the purpose of the RPC call is trying to read off a port number
> for an RPC service. If the idea is to register a new service, however, then
> the portmapper demands that we use a secure port.
>
> The fix would be to add an argument to the function pmap_create() in order
> to allow rpc_register() to specify that the call to xprt_create_proto()
> should set up the socket on a secure port.

Thanks for the hint. I fixed pmap_create() according to your proposal and now 
nfsd works again. 

One more question about something I'd like to understand: 
Petes fix limits the number of anonymous mounts to 1279. There was a shorter 
patch from Andi Kleen which basically just replaced the search for a secure 
port from 800 downwards (in xprt.c, xprt_bindresvport() ) by a bind operation 
to any port (not just a secure one). Raising the count of elements of 
unnamed_dev_in_use in fs/super.c to eg 4096 resulted in the opportunity to 
mount as many NFS directories.  Allthough this patch suffered from two NFS 
problems (the nfsd problem just discussed, as well as a problem when NFS 
mounting from another linux box) it showed a way to use  a very large number 
of NFS mounts.  

Can somebody explain the major difference between both solutions? Why did you 
Pete base your patch on 4 new major device numbers whereas Andis patch did 
not need them? Are there any major drawbacks involved not doing so?

Thanks Rainer
-- 
---------------------------------------------------------------------
Rainer Krienke                     krienke@uni-koblenz.de
Universitaet Koblenz, 		   http://www.uni-koblenz.de/~krienke
Rechenzentrum,                     Voice: +49 261 287 - 1312
Rheinau 1, 56075 Koblenz, Germany  Fax:   +49 261 287 - 1001312
---------------------------------------------------------------------
