Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVJMTrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVJMTrX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVJMTrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:47:23 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:7814 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932314AbVJMTrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:47:22 -0400
Date: Thu, 13 Oct 2005 23:47:05 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christian <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org, GregKH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Dallas's 1-wire bus compile error (again)
Message-ID: <20051013194705.GA27809@2ka.mipt.ru>
References: <434EA63F.10306@g-house.de> <20051013183353.GA32530@2ka.mipt.ru> <434EB375.4060104@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <434EB375.4060104@g-house.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 13 Oct 2005 23:47:06 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2005 at 09:20:21PM +0200, Christian (evil@g-house.de) wrote:
> Evgeniy Polyakov wrote:
> >
> >Hmm... Could you please provide error log.
> >Networking is only used for netlink notifications which are disabled 
> >if CONFIG_NET is not set, you can find empty declarations in
> >w1_netlink.c
> 
> Similar errors as in the mentioned thread, but here we go:
> 
> drivers/built-in.o: In function `w1_alloc_dev':
> : undefined reference to `netlink_kernel_create'
> drivers/built-in.o: In function `w1_alloc_dev':
> : undefined reference to `sock_release'
> drivers/built-in.o: In function `w1_free_dev':
> : undefined reference to `sock_release'
> make: *** [.tmp_vmlinux1] Error 1

It looks like you use old version - I've just compiled 
today's git tree with your config, and it does have an error, 
but in different place.
That bug was introduced during big w1 cleanup due to device driver
model.

Attached patch fixes that on x86_64 and i386 compilation.

Thank you, Christian.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -77,8 +77,7 @@ static void w1_master_release(struct dev
 
 	dev_dbg(dev, "%s: Releasing %s.\n", __func__, md->name);
 
-	if (md->nls && md->nls->sk_socket)
-		sock_release(md->nls->sk_socket);
+	dev_fini_netlink(md);
 	memset(md, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
 	kfree(md);
 }


-- 
	Evgeniy Polyakov
