Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263641AbUEGPOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbUEGPOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 11:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbUEGPOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 11:14:46 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:20953 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263641AbUEGPOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 11:14:39 -0400
Date: Fri, 7 May 2004 16:13:17 +0100
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Paul Jakma <paul@clubi.ie>, Valdis.Kletnieks@vt.edu,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Message-ID: <20040507151317.GA15823@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjanv@redhat.com>, Paul Jakma <paul@clubi.ie>,
	Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20040505013135.7689e38d.akpm@osdl.org> <200405051312.30626.dominik.karall@gmx.net> <200405051822.i45IM2uT018573@turing-police.cc.vt.edu> <20040505215136.GA8070@wohnheim.fh-wedel.de> <200405061518.i46FIAY2016476@turing-police.cc.vt.edu> <1083858033.3844.6.camel@laptop.fenrus.com> <Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org> <20040507065105.GA10600@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040507065105.GA10600@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 08:51:05AM +0200, Arjan van de Ven wrote:
 > 
 > On Fri, May 07, 2004 at 01:37:54AM +0100, Paul Jakma wrote:
 > > On Thu, 6 May 2004, Arjan van de Ven wrote:
 > > 
 > > > Ok I don't want to start a flamewar but... Do we want to hold linux
 > > > back until all binary only module vendors have caught up ??
 > > 
 > > What about normal linux modules though? Eg, NFS (most likely):
 > > 
 > > 	https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=121804
 > 
 > NFSv4 has a > 1Kb stack user; Dave Jones has a fix pending for that...

Hmm, this one maybe?
 
		Dave

--- linux-2.6.5/net/sunrpc/auth_gss/auth_gss.c~	2004-05-05 13:34:31.000000000 +0100
+++ linux-2.6.5/net/sunrpc/auth_gss/auth_gss.c	2004-05-05 13:33:05.000000000 +0100
@@ -429,10 +429,8 @@ gss_pipe_upcall(struct file *filp, struc
 static ssize_t
 gss_pipe_downcall(struct file *filp, const char *src, size_t mlen)
 {
-	char buf[1024];
 	struct xdr_netobj obj = {
 		.len	= mlen,
-		.data	= buf,
 	};
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct rpc_inode *rpci = RPC_I(inode);
@@ -448,11 +446,19 @@ gss_pipe_downcall(struct file *filp, con
 	int err;
 	int gss_err;
 
-	if (mlen > sizeof(buf))
+	obj.data = kmalloc(1024, GFP_KERNEL);
+	if (!obj.data)
+		return -ENOMEM;
+
+	if (mlen > 1024) {
+		kfree (obj.data);
 		return -ENOSPC;
-	left = copy_from_user(buf, src, mlen);
-	if (left)
+	}
+	left = copy_from_user(obj.data, src, mlen);
+	if (left) {
+		kfree (obj.data);
 		return -EFAULT;
+	}
 	clnt = rpci->private;
 	atomic_inc(&clnt->cl_users);
 	auth = clnt->cl_auth;
@@ -477,12 +483,14 @@ gss_pipe_downcall(struct file *filp, con
 	} else
 		spin_unlock(&gss_auth->lock);
 	rpc_release_client(clnt);
+	kfree (obj.data);
 	return mlen;
 err:
 	if (ctx)
 		gss_destroy_ctx(ctx);
 	rpc_release_client(clnt);
 	dprintk("RPC: gss_pipe_downcall returning %d\n", err);
+	kfree (obj.data);
 	return err;
 }
 
