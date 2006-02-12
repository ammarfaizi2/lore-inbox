Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWBLCUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWBLCUe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 21:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWBLCUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 21:20:34 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:57258 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750939AbWBLCUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 21:20:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=E1/slbX0eIpIRFYLRdnYCnP/k+8D1oHz7/rtzM6TJhzcSG9vzDdWP/rUL+TQPmkoKU+C0iMgCTwljGFHGD/4ID0G2digoAEockDs3ea1R7/KGENLHFgSWjb6Fl+wT9kz+npbkTCmCGZ5uC+AWppaAoHRWRbDhzJ6HzK/Cx/alQw=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] netfilter: fix build error due to missing has_bridge_parent macro
Date: Sun, 12 Feb 2006 03:20:36 +0100
User-Agent: KMail/1.9
Cc: Rusty Russell <rusty@rustcorp.com.au>, Marc Boucher <marc@mbsi.ca>,
       James Morris <jmorris@namei.org>, Harald Welte <laforge@netfilter.org>,
       Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
       Jesper Juhl <jesper.juhl@gmail.com>, coreteam@netfilter.org,
       netfilter@lists.netfilter.org, netfilter-devel@lists.netfilter.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602120320.37042.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just did an allyesconfig test build of 2.6.16-rc2-git10 and found a build
problem.

commit 5dce971acf2ae20c80d5e9d1f6bbf17376870911 removed the 
"has_bridge_parent" macro from net/bridge/br_netfilter.c, resulting in the 
following warning at compile time:

 net/bridge/br_netfilter.c: In function `br_nf_post_routing':
 net/bridge/br_netfilter.c:808: warning: implicit declaration of function `has_bridge_parent'

and this error at link time:

 net/built-in.o(.text+0xeae28): In function `br_nf_post_routing':
 net/bridge/br_netfilter.c:808: undefined reference to `has_bridge_parent'
 make: *** [.tmp_vmlinux1] Error 1

The patch below fixes the problem.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Patch is compile tested only but should be obviously correct.

 net/bridge/br_netfilter.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16-rc2-git10/net/bridge/br_netfilter.c~	2006-02-12 03:03:29.000000000 +0100
+++ linux-2.6.16-rc2-git10/net/bridge/br_netfilter.c	2006-02-12 03:03:29.000000000 +0100
@@ -805,7 +805,7 @@ static unsigned int br_nf_post_routing(u
 print_error:
 	if (skb->dev != NULL) {
 		printk("[%s]", skb->dev->name);
-		if (has_bridge_parent(skb->dev))
+		if (bridge_parent(skb->dev))
 			printk("[%s]", bridge_parent(skb->dev)->name);
 	}
 	printk(" head:%p, raw:%p, data:%p\n", skb->head, skb->mac.raw,



