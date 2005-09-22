Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbVIVNGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbVIVNGQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbVIVNGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:06:15 -0400
Received: from duempel.org ([81.209.165.42]:17384 "HELO duempel.org")
	by vger.kernel.org with SMTP id S1030302AbVIVNGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:06:14 -0400
Date: Thu, 22 Sep 2005 15:04:41 +0200
From: Max Kellermann <max@duempel.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Avuton Olrich <avuton@gmail.com>
Subject: [PATCH] repair nfsd/sunrpc in 2.6.14-rc2-mm1 (and other -mm versions)
Message-ID: <20050922130441.GA24005@roonstrasse.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Avuton Olrich <avuton@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrew,

nfsd is still broken in 2.6.14-rc2-mm1; the following procedure is
reproducable:

 rabbit:~# echo 2 >/proc/fs/nfsd/threads 

... /var/log/daemon.log says:

 Sep 22 13:52:55 rabbit kernel: NFSD: Using /var/lib/nfs/v4recovery as
 the NFSv4 state recovery directory
 Sep 22 13:52:55 rabbit kernel: NFSD: starting 90-second grace period
 Sep 22 13:52:55 rabbit portmap[3191]: connect from 127.0.0.1 to
 set(nfs): request from unprivileged port

Your -mm patches make the sunrpc client connect to the portmapper with
a non-privileged source port.  This is due to a change in
net/sunrpc/pmap_clnt.c, which manually resets the xprt->resvport
field.  My tiny patch removes this line.  I have no idea why the line
was added in the first place, does somebody know better?

Max


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nfsd-pmap-fix-privileged-port.patch"

--- linux-2.6.14-rc2-mm1/net/sunrpc/pmap_clnt.c.orig	2005-09-22 14:58:14.000000000 +0200
+++ linux-2.6.14-rc2-mm1/net/sunrpc/pmap_clnt.c	2005-09-22 14:58:16.000000000 +0200
@@ -208,7 +208,6 @@
 	if (IS_ERR(xprt))
 		return (struct rpc_clnt *)xprt;
 	xprt->addr.sin_port = htons(RPC_PMAP_PORT);
-	xprt->resvport = 0;
 
 	/* printk("pmap: create clnt\n"); */
 	clnt = rpc_new_client(xprt, hostname,

--OgqxwSJOaUobr8KG--
