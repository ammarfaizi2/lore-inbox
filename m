Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268399AbUIWLQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268399AbUIWLQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 07:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268404AbUIWLQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 07:16:53 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:55301 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S268399AbUIWLQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 07:16:51 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: xhejtman@mail.muni.cz (Lukas Hejtmanek)
Subject: Re: 2.6.9-rc2-mm2 fn_hash_insert oops
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
       netdev@oss.sgi.com
Organization: Core
In-Reply-To: <20040923103723.GA12145@mail.muni.cz>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CARaS-00071j-00@gondolin.me.apana.org.au>
Date: Thu, 23 Sep 2004 21:16:32 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> 
> However there is still the issue with endless loop in fn_hash_delete :(

Same problem, same fix.  Can someone think of a generic fix to
list_for_each_*?

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
===== net/ipv4/fib_hash.c 1.22 vs edited =====
--- 1.22/net/ipv4/fib_hash.c	2004-09-22 09:31:48 +10:00
+++ edited/net/ipv4/fib_hash.c	2004-09-23 21:16:04 +10:00
@@ -608,6 +608,7 @@
 	struct fn_hash *table = (struct fn_hash*)tb->tb_data;
 	struct fib_node *f;
 	struct fib_alias *fa, *fa_to_delete;
+	struct list_head *fa_head;
 	int z = r->rtm_dst_len;
 	struct fn_zone *fz;
 	u32 key;
@@ -633,7 +634,8 @@
 		return -ESRCH;
 
 	fa_to_delete = NULL;
-	list_for_each_entry(fa, fa->fa_list.prev, fa_list) {
+	fa_head = fa->fa_list.prev;
+	list_for_each_entry(fa, fa_head, fa_list) {
 		struct fib_info *fi = fa->fa_info;
 
 		if ((!r->rtm_type ||
