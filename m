Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWCLN1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWCLN1m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 08:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWCLN1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 08:27:42 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:38099 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750830AbWCLN1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 08:27:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mkPGC2E9AW8D9grx9E02UrgO9QUltwmHkGHHnckh9zVbUmaWN1TvFf59EG4/GBvjVcJQMe/tWFQLfsTin3yUzLQq2EcU7e+cqeOY+Dq6o4NaRQ28SKAG5c3qiI6umhV7oKv7FqFrmH1o4q3/AmYn/5htPgrM/UN4h38gc5m1nYQ=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix memory leak in mm/slab.c::alloc_kmemlist()
Date: Sun, 12 Mar 2006 14:28:08 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603121428.08226.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Coverity checker found that we may leak memory in 
mm/slab.c::alloc_kmemlist()
This should fix the leak and coverity bug #589


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 mm/slab.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc6-orig/mm/slab.c	2006-03-12 14:19:17.000000000 +0100
+++ linux-2.6.16-rc6/mm/slab.c	2006-03-12 14:22:40.000000000 +0100
@@ -3366,8 +3366,10 @@ static int alloc_kmemlist(struct kmem_ca
 			continue;
 		}
 		if (!(l3 = kmalloc_node(sizeof(struct kmem_list3),
-					GFP_KERNEL, node)))
+					GFP_KERNEL, node))) {
+			kfree(new);
 			goto fail;
+		}
 
 		kmem_list3_init(l3);
 		l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +


