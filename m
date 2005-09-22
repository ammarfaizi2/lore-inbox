Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbVIVTnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbVIVTnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbVIVTnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:43:46 -0400
Received: from citi.umich.edu ([141.211.133.111]:42339 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1030187AbVIVTnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:43:45 -0400
Message-ID: <43330970.9030006@citi.umich.edu>
Date: Thu, 22 Sep 2005 15:43:44 -0400
From: Chuck Lever <cel@citi.umich.edu>
Reply-To: cel@citi.umich.edu
Organization: Network Appliance, Inc.
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [Fwd: [Fwd: [Fwd: Re: 2.6.13-mm2]]]
Content-Type: multipart/mixed;
 boundary="------------090705050709090504040504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090705050709090504040504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

attached please find the original message containing the pmap reserved 
port patch.

--------------090705050709090504040504
Content-Type: message/rfc822;
 name="[Fwd: [Fwd: Re: 2.6.13-mm2]]"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[Fwd: [Fwd: Re: 2.6.13-mm2]]"

Message-ID: <432F1D9A.4070607@citi.umich.edu>
Date: Mon, 19 Sep 2005 16:20:42 -0400
From: Chuck Lever <cel@citi.umich.edu>
Reply-To: cel@citi.umich.edu
Organization: Network Appliance, Inc.
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Subject: [Fwd: [Fwd: Re: 2.6.13-mm2]]
Content-Type: multipart/mixed;
 boundary="------------030208080309080708060102"

This is a multi-part message in MIME format.
--------------030208080309080708060102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

andrew-

please replace the one-liner that adds "xprt->resvport = 0;" to 
net/sunrpc/clnt.c with the attached patch.

i haven't heard confirmation from dominik on this, but trond and i 
suspect this is a reasonable replacement for the original patch.

--------------030208080309080708060102
Content-Type: text/x-patch;
 name="supplemental2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="supplemental2.diff"

[SUNRPC] rpcbind requires a privileged port to set portmap data

An earlier patch caused rpcbind to use an unprivileged port for both SET
and GET requests.  SET requests require a privileged port.

Test plan:
Start up the Linux NFS service.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 net/sunrpc/rpcb_clnt.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -60,7 +60,7 @@ static inline void rpcb_wake_rpcbind_wai
 	rpc_wake_up(&xprt->bindwait);
 }
 
-static struct rpc_clnt *rpcb_create(char *hostname, struct sockaddr *srvaddr, int proto, int version)
+static struct rpc_clnt *rpcb_create(char *hostname, struct sockaddr *srvaddr, int proto, int version, int privileged)
 {
 	struct rpc_create_args args = {
 		.protocol	= proto,
@@ -70,10 +70,12 @@ static struct rpc_clnt *rpcb_create(char
 		.program	= &rpcb_program,
 		.version	= version,
 		.authflavor	= RPC_AUTH_NULL,
-		.behavior	= (RPC_CLNT_ONESHOT|RPC_CLNT_NOPING|RPC_CLNT_NONPRIVPORT),
+		.behavior	= (RPC_CLNT_ONESHOT|RPC_CLNT_NOPING),
 	};
 
 	((struct sockaddr_in *)srvaddr)->sin_port = htons(RPC_BIND_PORT);
+	if (!privileged)
+		args.behavior |= RPC_CLNT_NONPRIVPORT;
 	return rpc_create(&args);
 }
 
@@ -114,7 +116,7 @@ int rpcb_register(u32 prog, u32 vers, in
 	sin.sin_family = AF_INET;
 	sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
 	rpcb_clnt = rpcb_create("localhost", (struct sockaddr *) &sin,
-					IPPROTO_UDP, 2);
+					IPPROTO_UDP, 2, 1);
 	if (IS_ERR(rpcb_clnt))
 		return PTR_ERR(rpcb_clnt);
 
@@ -158,7 +160,7 @@ int rpcb_getport_external(struct sockadd
 			NIPQUAD(sin->sin_addr.s_addr), prog, vers, prot);
 
 	sprintf(hostname, "%u.%u.%u.%u", NIPQUAD(sin->sin_addr.s_addr));
-	rpcb_clnt = rpcb_create(hostname, (struct sockaddr *)sin, prot, 2);
+	rpcb_clnt = rpcb_create(hostname, (struct sockaddr *)sin, prot, 2, 0);
 	if (IS_ERR(rpcb_clnt))
 		return PTR_ERR(rpcb_clnt);
 
@@ -237,7 +239,7 @@ void rpcb_getport(struct rpc_task *task,
 	rpc_peeraddr(clnt, (void *) &addr, sizeof(addr));
 	rpc_peeraddr2str(clnt, RPC_DISPLAY_ADDR, map->r_addr, sizeof(map->r_addr));
 
-	rpcb_clnt = rpcb_create(clnt->cl_server, &addr, protocol, bind_version);
+	rpcb_clnt = rpcb_create(clnt->cl_server, &addr, protocol, bind_version, 0);
 	if (IS_ERR(rpcb_clnt)) {
 		rpc_exit(task, PTR_ERR(rpcb_clnt));
 		dprintk("RPC: %5u rpcb_getport rpcb_create failed, error %ld\n",

--------------030208080309080708060102
Content-Type: message/rfc822;
 name="[Fwd: Re: 2.6.13-mm2]"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[Fwd: Re: 2.6.13-mm2]"

Return-Path: <trond.myklebust@fys.uio.no>
X-Original-To: cel@citi.umich.edu
Delivered-To: cel@citi.umich.edu
Received: from pat.uio.no (pat.uio.no [129.240.130.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by citi.umich.edu (Postfix) with ESMTP id CC1C21BAF1
	for <cel@citi.umich.edu>; Wed, 14 Sep 2005 18:58:54 -0400 (EDT)
Received: from mail-mx3.uio.no ([129.240.10.44])
	by pat.uio.no with esmtp (Exim 4.43)
	id 1EFgDK-0002De-Gh
	for cel@citi.umich.edu; Thu, 15 Sep 2005 00:58:50 +0200
Received: from [213.13.107.171] (helo=[172.23.165.103])
	by mail-mx3.uio.no with esmtpsa (SSLv3:RC4-MD5:128)
	(Exim 4.43)
	id 1EFgD4-0005Og-Mj
	for cel@citi.umich.edu; Thu, 15 Sep 2005 00:58:35 +0200
Subject: [Fwd: Re: 2.6.13-mm2]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Charles Lever <cel@citi.umich.edu>
Content-Type: multipart/mixed; boundary="=-5qWlSkk8A2YHFtGgVwjb"
Date: Wed, 14 Sep 2005 23:58:13 +0100
Message-Id: <1126738693.8807.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.345, required 12,
	autolearn=disabled, RCVD_IN_NJABL_DUL 1.66,
	UIO_MAIL_IS_INTERNAL -5.00)


--=-5qWlSkk8A2YHFtGgVwjb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Looks like one of your patches...

--=-5qWlSkk8A2YHFtGgVwjb
Content-Disposition: inline
Content-Description: Vidaresendt melding - Re: 2.6.13-mm2
Content-Type: message/rfc822

Return-Path: <akpm@osdl.org>
Received: from mail-imap5.uio.no ([unix socket]) by mail-imap5.uio.no
	(Cyrus v2.2.10) with LMTPA; Sun, 11 Sep 2005 00:13:02 +0200
X-Sieve: CMU Sieve 2.2
Delivery-date: Sun, 11 Sep 2005 00:13:02 +0200
Received: from mail-mx5.uio.no ([129.240.10.46]) by mail-imap5.uio.no with
	esmtp (Exim 4.43) id 1EEDao-0001TU-4C for trond.myklebust@fys.uio.no; Sun,
	11 Sep 2005 00:13:02 +0200
Received: from smtp.osdl.org ([65.172.181.4]) by mail-mx5.uio.no with
	esmtps (TLSv1:DES-CBC3-SHA:168) (Exim 4.43) id 1EEDal-0005bV-5h for
	trond.myklebust@fys.uio.no; Sun, 11 Sep 2005 00:12:59 +0200
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
	smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8AMCpBo002683
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat,
	10 Sep 2005 15:12:52 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31]) by shell0.pdx.osdl.net
	(8.13.1/8.11.6) with SMTP id j8AMCoiR004374; Sat, 10 Sep 2005 15:12:51 -0700
Date: Sat, 10 Sep 2005 15:12:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.6.13-mm2
Message-Id: <20050910151225.612e3f7b.akpm@osdl.org>
In-Reply-To: <200509102043.25928.dominik.karall@gmx.net>
References: <20050908053042.6e05882f.akpm@osdl.org>
	 <200509102043.25928.dominik.karall@gmx.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
X-MailScanner-Information: This message has been scanned for viruses/spam.
	Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.055, required 12,
	autolearn=disabled, AWL 0.01, FORGED_RCVD_HELO 0.05)
Content-Transfer-Encoding: 7bit

Dominik Karall <dominik.karall@gmx.net> wrote:
>
> On Thursday 08 September 2005 14:30, Andrew Morton wrote:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13
>  >-mm2/
> 
>  I have problems using NFS with 2.6.13-mm2, it failes to start, but works with 
>  2.6.13-ck1 (so pure 2.6.13 should work too, as there are no nfs related 
>  changes in -ck, I think).
>  Following messages appear in /var/log/messages:
> 
>  Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
>  rpc.statd[15041]: Version 1.0.7 Starting
>  NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
>  NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
>  NFSD: starting 90-second grace period
>  portmap[15048]: connect from 127.0.0.1 to set(nfs): request from unprivileged 
>  port
>  nfsd[15046]: nfssvc: Permission denied
> 
> 
>  with 2.6.13-ck1:
> 
>  Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
>  rpc.statd[16126]: Version 1.0.7 Starting
>  NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
>  NFSD: starting 90-second grace period

OK.  We don't have many nfsd patches at all in 2.6.13-mm2.  But there are
quite a few sunrpc changes.  Plus I have a few random nfs patches which
should be merged up or dropped.

In short: dunno.  Relevant people cc'ed ;)

--=-5qWlSkk8A2YHFtGgVwjb--


--------------030208080309080708060102
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------030208080309080708060102--


--------------090705050709090504040504
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------090705050709090504040504--
