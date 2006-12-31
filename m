Return-Path: <linux-kernel-owner+w=401wt.eu-S933193AbWLaQhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933193AbWLaQhI (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 11:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933198AbWLaQhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 11:37:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:5701 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933197AbWLaQhG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 11:37:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PGDZWaWe7Y+A2Pq27p5GXMGxtXbX8X0CXz7Rc4d3s284RVNPPvlCxQkj8DPksvTWcr0V2sjB4Fb+FMj7Og3jEjyDmP74l+xGGlxW4zEF+d3HzsgENROoi73W8OuCE7rMWVGrTd6FIMW6LxBmQz0ckH3wZ5uSrwcU3/w4lvRL1GU=
Message-ID: <80ec54e90612310837y786fd764oc18bf37c8f0b2b8c@mail.gmail.com>
Date: Sun, 31 Dec 2006 17:37:05 +0100
From: "=?ISO-8859-1?Q?Daniel_Marjam=E4ki?=" <daniel.marjamaki@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH] net/core/flow.c: compare data with memcmp
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Marjamäki
This has been tested by me.
Signed-off-by: Daniel Marjamäki <daniel.marjamaki@gmail.com>
--- linux-2.6.20-rc2/net/core/flow.c	2006-12-27 09:59:56.000000000 +0100
+++ linux/net/core/flow.c	2006-12-31 18:26:06.000000000 +0100
@@ -144,29 +144,16 @@ typedef u32 flow_compare_t;

 extern void flowi_is_missized(void);

-/* I hear what you're saying, use memcmp.  But memcmp cannot make
- * important assumptions that we can here, such as alignment and
- * constant size.
- */
 static int flow_key_compare(struct flowi *key1, struct flowi *key2)
 {
-	flow_compare_t *k1, *k1_lim, *k2;
-	const int n_elem = sizeof(struct flowi) / sizeof(flow_compare_t);
-
 	if (sizeof(struct flowi) % sizeof(flow_compare_t))
 		flowi_is_missized();

-	k1 = (flow_compare_t *) key1;
-	k1_lim = k1 + n_elem;
-
-	k2 = (flow_compare_t *) key2;
-
-	do {
-		if (*k1++ != *k2++)
-			return 1;
-	} while (k1 < k1_lim);
+	/* Number of elements to compare */
+	const int n_elem = sizeof(struct flowi) / sizeof(flow_compare_t);

-	return 0;
+	/* Compare all elements in key1 and key2. */
+	return memcmp(key1, key2, n_elem * sizeof(flow_compare_t));
 }

 void *flow_cache_lookup(struct flowi *key, u16 family, u8 dir,
