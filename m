Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263136AbVGAATk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbVGAATk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 20:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbVGAATk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 20:19:40 -0400
Received: from po2.wam.umd.edu ([128.8.10.164]:7579 "EHLO po2.wam.umd.edu")
	by vger.kernel.org with ESMTP id S263136AbVGAATh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 20:19:37 -0400
Date: Thu, 30 Jun 2005 20:19:34 -0400 (EDT)
From: Patrick Jenkins <patjenk@wam.umd.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] multipath routing algorithm, better patch
Message-ID: <Pine.GSO.4.61.0506302014160.7400@rac1.wam.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The last patch wont work, this should.

This patch assigns the multipath routing algorithm into the fib_info
struct's fib_mp_alg variable. Previously, the algorithm was always set to
IP_MP_ALG_NONE which was incorrect. This patch corrects the problem by
assigning the correct value when a fib_info is initialized.

This patch was tested against kernel 2.6.12.1 for all multipath routing
algorithms (none, round robin, interface round robin, random, weighted
random).

Please look this patch over and apply it to the kernel. I have been unable
to contact the creators of the multipath algorithm feature so this is why
I sent it to the lkml.

I am not a member of the list so please cc me in the reply.

Signed-off-by: Patrick Jenkins <patjenk@wam.umd.edu>

--- linux-2.6.12/net/ipv4/fib_semantics.c.orig  2005-06-30 
20:07:13.000000000 -0400
+++ linux-2.6.12/net/ipv4/fib_semantics.c       2005-06-30 
20:06:36.000000000 -0400
@@ -650,9 +650,22 @@ fib_create_info(const struct rtmsg *r, s
  #else
         const int nhs = 1;
  #endif
+
  #ifdef CONFIG_IP_ROUTE_MULTIPATH_CACHED
+
+#ifdef CONFIG_IP_ROUTE_MULTIPATH_RR
+       u32 mp_alg = IP_MP_ALG_RR;
+#elif CONFIG_IP_ROUTE_MULTIPATH_DRR
+       u32 mp_alg = IP_MP_ALG_DRR;
+#elif CONFIG_IP_ROUTE_MULTIPATH_RANDOM
+       u32 mp_alg = IP_MP_ALG_RANDOM;
+#elif CONFIG_IP_ROUTE_MULTIPATH_WRANDOM
+       u32 mp_alg = IP_MP_ALG_WRANDOM;
+#else
         u32 mp_alg = IP_MP_ALG_NONE;
-#endif
+#endif /* multipath algorithm determination */
+
+#endif /* CONFIG_IP_ROUTE_MULTIPATH_CACHED */

         /* Fast check to catch the most weird cases */
         if (fib_props[r->rtm_type].scope > r->rtm_scope)

