Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWHSXJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWHSXJx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 19:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWHSXJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 19:09:53 -0400
Received: from mother.openwall.net ([195.42.179.200]:27277 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S932557AbWHSXJw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 19:09:52 -0400
Date: Sun, 20 Aug 2006 03:05:32 +0400
From: Solar Designer <solar@openwall.com>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] getsockopt() early argument sanity checking
Message-ID: <20060819230532.GA16442@openwall.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Willy,

I propose the attached patch (extracted from 2.4.33-ow1) for inclusion
into 2.4.34-pre.

(2.6 kernels could benefit from the same change, too, but at the moment
I am dealing with proper submission of generic changes like this that
are a part of 2.4.33-ow1.)

The patch makes getsockopt(2) sanity-check the value pointed to by
the optlen argument early on.  This is a security hardening measure
intended to prevent exploitation of certain potential vulnerabilities in
socket type specific getsockopt() code on UP systems.

This change has been a part of -ow patches for some years.

Thanks,

-- 
Alexander Peslyak <solar at openwall.com>
GPG key ID: B35D3598  fp: 6429 0D7E F130 C13E C929  6447 73C3 A290 B35D 3598
http://www.openwall.com - bringing security into open computing environments

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.33-ow1-getsockopt-early-arg-sanity.diff"

diff -urpPX nopatch linux-2.4.33/net/socket.c linux/net/socket.c
--- linux-2.4.33/net/socket.c	Wed Jan 19 17:10:14 2005
+++ linux/net/socket.c	Sat Aug 12 08:51:47 2006
@@ -1307,10 +1307,18 @@ asmlinkage long sys_setsockopt(int fd, i
 asmlinkage long sys_getsockopt(int fd, int level, int optname, char *optval, int *optlen)
 {
 	int err;
+	int len;
 	struct socket *sock;
 
 	if ((sock = sockfd_lookup(fd, &err))!=NULL)
 	{
+		/* XXX: insufficient for SMP, but should be redundant anyway */
+		if (get_user(len, optlen))
+			err = -EFAULT;
+		else
+		if (len < 0)
+			err = -EINVAL;
+		else
 		if (level == SOL_SOCKET)
 			err=sock_getsockopt(sock,level,optname,optval,optlen);
 		else

--82I3+IH0IqGh5yIs--
