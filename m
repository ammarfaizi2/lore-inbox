Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbUK3CVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbUK3CVk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUK3CUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:20:25 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:7385 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261955AbUK3CR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 21:17:57 -0500
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org,
       Ian.Pratt@cl.cam.ac.uk
Subject: [7/7] Xen VMM #3: handle fragemented skbs correctly in icmp_filter
In-reply-to: Your message of "Tue, 30 Nov 2004 02:03:45 GMT."
             <E1CYxMo-0005GB-00@mta1.cl.cam.ac.uk> 
Date: Tue, 30 Nov 2004 02:17:56 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CYxaW-0005Pf-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[NB: This patch has already been accepted by Dave Miller. I'm
only resending it such that the set is complete.]

Simple bug fix to icmp_filter -- handle fragemented skbs correctly.

Signed-off-by: ian.pratt@cl.cam.ac.uk

---
diff -Nurp pristine-linux-2.6.10-rc2/net/ipv4/raw.c tmp-linux-2.6.10-rc2-xen.patch/net/ipv4/raw.c
--- pristine-linux-2.6.10-rc2/net/ipv4/raw.c	2004-11-30 01:20:26.000000000 +0000
+++ tmp-linux-2.6.10-rc2-xen.patch/net/ipv4/raw.c	2004-11-30 00:41:24.000000000 +0000
@@ -130,6 +130,9 @@ static __inline__ int icmp_filter(struct
 {
 	int type;
 
+	if (!pskb_may_pull(skb, sizeof(struct icmphdr)))
+		return 1;
+
 	type = skb->h.icmph->type;
 	if (type < 32) {
 		__u32 data = raw4_sk(sk)->filter.data;
