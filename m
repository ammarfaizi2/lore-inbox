Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTFIQwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 12:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTFIQwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 12:52:19 -0400
Received: from pat.uio.no ([129.240.130.16]:8616 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264535AbTFIQwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 12:52:14 -0400
To: Bob Vickers <R.Vickers@cs.rhul.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Locking NFS files on kernels 2.4.19 and 2.4.20
References: <Pine.OSF.4.44.0306091347560.4682-100000@sartre.cs.rhbnc.ac.uk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 09 Jun 2003 19:05:01 +0200
In-Reply-To: <Pine.OSF.4.44.0306091347560.4682-100000@sartre.cs.rhbnc.ac.uk>
Message-ID: <shsd6hnrxky.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Bob Vickers <bobv@cs.rhul.ac.uk> writes:

     > I have recently upgraded some machines and have found that it
     > is no longer possible to lock files on NFS file systems. It is
     > definitely a client-side problem: upgraded clients could no
     > longer lock files on *any* NFS server (including Tru64 as well
     > as a variety of Linux servers).

Two questions:

  Are you running statd on the client and server?

if no, then you should...

  Does SuSE compile statd with or without the RESTRICTED_STATD flag?

If the latter, then you'll need an extra kernel patch in order to
allow the kernel NSM to use a reserved port. Something like the
appended scheme...

Cheers,
  Trond

--- linux/fs/lockd/mon.c.orig	2002-02-04 23:49:27.000000000 -0800
+++ linux/fs/lockd/mon.c	2003-06-09 10:02:57.000000000 -0700
@@ -105,12 +105,19 @@
 	struct rpc_xprt		*xprt;
 	struct rpc_clnt		*clnt = NULL;
 	struct sockaddr_in	sin;
+	uid_t saved_fsuid = current->fsuid;
+	kernel_cap_t saved_cap = current->cap_effective;
 
 	sin.sin_family = AF_INET;
 	sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
 	sin.sin_port = 0;
 
+	/* Create RPC socket as root user so we get a priv port */
+	current->fsuid = 0;
+	cap_raise (current->cap_effective, CAP_NET_BIND_SERVICE);
 	xprt = xprt_create_proto(IPPROTO_UDP, &sin, NULL);
+	current->fsuid = saved_fsuid;
+	current->cap_effective = saved_cap;
 	if (!xprt)
 		goto out;
 

