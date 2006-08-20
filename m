Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751618AbWHTAnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbWHTAnn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 20:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWHTAnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 20:43:43 -0400
Received: from 1wt.eu ([62.212.114.60]:39184 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751345AbWHTAnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 20:43:42 -0400
Date: Sun, 20 Aug 2006 02:43:07 +0200
From: Willy Tarreau <w@1wt.eu>
To: Michael Buesch <mb@bu3sch.de>
Cc: Solar Designer <solar@openwall.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] getsockopt() early argument sanity checking
Message-ID: <20060820004307.GD27115@1wt.eu>
References: <20060819230532.GA16442@openwall.com> <20060819234806.GB27115@1wt.eu> <200608200205.20876.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608200205.20876.mb@bu3sch.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 02:05:20AM +0200, Michael Buesch wrote:
> On Sunday 20 August 2006 01:48, Willy Tarreau wrote:
> > On Sun, Aug 20, 2006 at 03:05:32AM +0400, Solar Designer wrote:
> > > Willy,
> > > 
> > > I propose the attached patch (extracted from 2.4.33-ow1) for inclusion
> > > into 2.4.34-pre.
> > > 
> > > (2.6 kernels could benefit from the same change, too, but at the moment
> > > I am dealing with proper submission of generic changes like this that
> > > are a part of 2.4.33-ow1.)
> > > 
> > > The patch makes getsockopt(2) sanity-check the value pointed to by
> > > the optlen argument early on.  This is a security hardening measure
> > > intended to prevent exploitation of certain potential vulnerabilities in
> > > socket type specific getsockopt() code on UP systems.
> > > 
> > > This change has been a part of -ow patches for some years.
> > 
> > looks valid to me, merged.
> 
> Not to me. It heavily violates codingstyle and screws brains
                ^^^^^^^
little exageration detected here.

> with the non-indented else branches.

while they surprized me first, they make the *patch* more readable
by clearly showing what has been inserted and where. However, I have
joined the lines for the merge.

> Learn about goto.

definitely not here. The if() expressions are all one-liners. Adding
a goto would mean two instructions, to which you add 2 braces. It will
not make the code more readable. Patch below is OK. If you have a hard
time understanding it, then it's because it's bedtime for you too :-)

Regards,
Willy


diff --git a/net/socket.c b/net/socket.c
index ac45b13..910ef88 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1307,11 +1307,17 @@ asmlinkage long sys_setsockopt(int fd, i
 asmlinkage long sys_getsockopt(int fd, int level, int optname, char *optval, int *optlen)
 {
 	int err;
+	int len;
 	struct socket *sock;
 
 	if ((sock = sockfd_lookup(fd, &err))!=NULL)
 	{
-		if (level == SOL_SOCKET)
+		/* XXX: insufficient for SMP, but should be redundant anyway */
+		if (get_user(len, optlen))
+			err = -EFAULT;
+		else if (len < 0)
+			err = -EINVAL;
+		else if (level == SOL_SOCKET)
 			err=sock_getsockopt(sock,level,optname,optval,optlen);
 		else
 			err=sock->ops->getsockopt(sock, level, optname, optval, optlen);
-- 
1.4.1

