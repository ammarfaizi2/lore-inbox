Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289298AbSAVN3O>; Tue, 22 Jan 2002 08:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289299AbSAVN3D>; Tue, 22 Jan 2002 08:29:03 -0500
Received: from mons.uio.no ([129.240.130.14]:11472 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S289298AbSAVN24>;
	Tue, 22 Jan 2002 08:28:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo
To: Rainer Krienke <krienke@uni-koblenz.de>
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Date: Tue, 22 Jan 2002 14:28:39 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com> <shszo36pt1h.fsf@charged.uio.no> <200201221308.g0MD8EY16176@bliss.uni-koblenz.de>
In-Reply-To: <200201221308.g0MD8EY16176@bliss.uni-koblenz.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16T0ye-0002K6-00@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22. January 2002 14:08, you wrote:

> So I still think that the reason for this is a check in the kernel, that
> prevents connections from ports > 1024.

Nope. It's the following hunk:

diff -ur -X dontdiff linux-2.4.9-18.3/net/sunrpc/pmap_clnt.c 
linux-2.4.9-18.3-p3/net/sunrpc/pmap_clnt.c
--- linux-2.4.9-18.3/net/sunrpc/pmap_clnt.c     Wed Jun 21 12:43:37 2000
+++ linux-2.4.9-18.3-p3/net/sunrpc/pmap_clnt.c  Mon Jan  7 12:59:54 2002
@@ -189,7 +189,7 @@
        struct rpc_clnt *clnt;

        /* printk("pmap: create xprt\n"); */
-       if (!(xprt = xprt_create_proto(proto, srvaddr, NULL)))
+       if (!(xprt = xprt_create_proto(proto, srvaddr, NULL, 0)))
                return NULL;
        xprt->addr.sin_port = htons(RPC_PMAP_PORT);


The above change implies that the portmapper can always be run from an 
insecure port.
It can if the purpose of the RPC call is trying to read off a port number for 
an RPC service. If the idea is to register a new service, however, then the 
portmapper demands that we use a secure port.

The fix would be to add an argument to the function pmap_create() in order to 
allow rpc_register() to specify that the call to xprt_create_proto() should 
set up the socket on a secure port.

Cheers,
   Trond
