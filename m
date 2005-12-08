Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932662AbVLHWfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbVLHWfz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbVLHWfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:35:55 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:20082 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932662AbVLHWfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:35:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=e8C1c/Svr7QycbnFllNoNXf+xvnQMVj5g/RvJUOHaSSBGTMNi9ENsu3OhtoWYNPJla7t8zhnOVY7MnvjYzQBhYuD+Yu+5CW9pUUukFFmLhUA84qaJPRGwvYiYCj2k71U36lHEZ4WdYM7WYjPqZqRLJLS6k3zrrpwlyy/W4Dr5Lo=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Decrease number of pointer derefs in nf_conntrack_core.c
Date: Thu, 8 Dec 2005 23:36:19 +0100
User-Agent: KMail/1.9
Cc: Netfilter Core Team <coreteam@netfilter.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200512082336.19695.jesper.juhl@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a small patch to decrease the number of pointer derefs in
net/netfilter/nf_conntrack_core.c

Benefits of the patch:
 - Fewer pointer dereferences should make the code slightly faster.
 - Size of generated code is smaller
 - improved readability

Please consider applying.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---


 net/netfilter/nf_conntrack_core.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

orig:
   text    data     bss     dec     hex filename
  12636      49     760   13445    3485 net/netfilter/nf_conntrack_core.o

patched:
   text    data     bss     dec     hex filename
  11825     183     632   12640    3160 net/netfilter/nf_conntrack_core.o

--- linux-2.6.15-rc5-git1-orig/net/netfilter/nf_conntrack_core.c	2005-12-04 18:48:58.000000000 +0100
+++ linux-2.6.15-rc5-git1/net/netfilter/nf_conntrack_core.c	2005-12-08 20:13:03.000000000 +0100
@@ -1129,6 +1129,7 @@ static inline int refresh_timer(struct n
 int nf_conntrack_expect_related(struct nf_conntrack_expect *expect)
 {
 	struct nf_conntrack_expect *i;
+	struct nf_conn *master = expect->master;
 	int ret;
 
 	DEBUGP("nf_conntrack_expect_related %p\n", related_to);
@@ -1149,9 +1150,9 @@ int nf_conntrack_expect_related(struct n
 		}
 	}
 	/* Will be over limit? */
-	if (expect->master->helper->max_expected && 
-	    expect->master->expecting >= expect->master->helper->max_expected)
-		evict_oldest_expect(expect->master);
+	if (master->helper->max_expected && 
+	    master->expecting >= master->helper->max_expected)
+		evict_oldest_expect(master);
 
 	nf_conntrack_expect_insert(expect);
 	nf_conntrack_expect_event(IPEXP_NEW, expect);


