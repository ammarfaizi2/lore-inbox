Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264652AbSJ3KaQ>; Wed, 30 Oct 2002 05:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264655AbSJ3KaQ>; Wed, 30 Oct 2002 05:30:16 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:55055 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S264652AbSJ3KaP>; Wed, 30 Oct 2002 05:30:15 -0500
Date: Wed, 30 Oct 2002 21:36:11 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "Nicolas S. Dade" <ndade@adsl-63-197-69-248.dsl.snfc21.pacbell.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUG in 2.2.22 skb_realloc_headroom()
In-Reply-To: <20021029211945.A17657@ipx.esperanza>
Message-ID: <Mutt.LNX.4.44.0210302117420.13753-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Nicolas S. Dade wrote:

> skb_realloc_headroom() panics when new headroom is smaller
> than existing headroom.

Would you please test out the patch below?

Thanks,

- James
-- 
James Morris
<jmorris@intercode.com.au>


diff -urN -X dontdiff linux-2.2.22.orig/net/core/skbuff.c linux-2.2.22.skbrealloc/net/core/skbuff.c
--- linux-2.2.22.orig/net/core/skbuff.c	Wed Sep 25 00:06:26 2002
+++ linux-2.2.22.skbrealloc/net/core/skbuff.c	Wed Oct 30 21:25:02 2002
@@ -316,13 +316,16 @@
 {
 	struct sk_buff *n;
 	unsigned long offset;
-	int headroom = skb_headroom(skb);
+	int delta = newheadroom - skb_headroom(skb);
+
+	if (delta <= 0)
+		delta = 0;
 
 	/*
 	 *	Allocate the copy buffer
 	 */
  	 
-	n=alloc_skb(skb->truesize+newheadroom-headroom, GFP_ATOMIC);
+	n=alloc_skb(skb->truesize + delta, GFP_ATOMIC);
 	if(n==NULL)
 		return NULL;
 


