Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVFAPaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVFAPaS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVFAP3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:29:14 -0400
Received: from mail.macqel.be ([194.78.208.39]:39945 "EHLO mail.macqel.be")
	by vger.kernel.org with ESMTP id S261423AbVFAP1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:27:36 -0400
Message-Id: <200506011526.j51FQoO19323@mail.macqel.be>
Subject: Re: PATCH : ppp + big-endian = kernel crash
In-Reply-To: <20050529.201104.59476605.davem@davemloft.net> from "David S. Miller"
 at "May 29, 2005 08:11:04 pm"
To: "David S. Miller" <davem@davemloft.net>
Date: Wed, 1 Jun 2005 17:26:50 +0200 (CEST)
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
From: "Philippe De Muyter" <phdm@macqel.be>
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote :
> From: Andrew Morton <akpm@osdl.org>
> Date: Sun, 29 May 2005 19:52:45 -0700
> 
> > > All these patches to PPP and friends are merely papering over the
> > > larger problem.
> > 
> > It's not a thing we want to do in the general case, sure.  But it's
> > reasonable to identify those bits of net code which the nommu people care
> > about and look to see if there's some sane workaround to get them going.
> > 
> > Otherwise, things like PPP will simply unavailable to some architectures...
> 
> Some time ago there was a proposal that would allow appropriate
> handling of these sorts of things.
> 
> Accessors to packet headers would go through a macro, and this
> along with some other defines would allow an architecture to
> decide between two schemes:
> 
> 1) Use normal loads and stores, let trap handler take care of
>    unaligned cases.
> 2) Use something akin to get_unaligned(), no trap handler stuff.
> 
> Sure, to make things faster we can do something like this PPP
> patch, but it needs lots of work, first of all you need to
> replace this:
> 
> 	for ( ... )
> 		p[i-1] = p[i];
> 
> stuff with a proper memmove() call.
> 

Ok, here is a revised patch :

This patch avoids ppp-generated kernel crashes on machines where
unaligned accesses are forbidden.

Signed-off-by: Philippe De Muyter <phdm@macqel.be>

--- linux/drivers/net/ppp_async.c.orig	2005-06-01 10:46:58.000000000 +0200
+++ linux/drivers/net/ppp_async.c	2005-06-01 17:04:13.000000000 +0200
@@ -31,6 +31,7 @@
 #include <linux/spinlock.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
+#include <asm/string.h>
 
 #define PPP_VERSION	"2.4.2"
 
@@ -816,7 +817,15 @@ process_input_packet(struct asyncppp *ap
 	proto = p[0];
 	if (proto & 1) {
 		/* protocol is compressed */
-		skb_push(skb, 1)[0] = 0;
+		if ((unsigned long)skb->data & 1)
+			skb_push(skb, 1)[0] = 0;
+		else { /* Ditto, but realign the payload to 4-byte boundary */
+			short len = skb->len;
+
+			skb_put(skb, 3);
+			memmove(skb->data + 3, skb->data, len);
+			skb_pull(skb, 2)[0] = 0;
+		}
 	} else {
 		if (skb->len < 2)
 			goto err;
@@ -890,6 +899,12 @@ ppp_async_input(struct asyncppp *ap, con
 				if (skb == 0)
 					goto nomem;
 				/* Try to get the payload 4-byte aligned */
+				/* This should match the
+				** PPP_ALLSTATIONS/PPP_UI/compressed tests
+				** in process_input_packet,
+				** but we do not have enough chars here and
+				** now to test buf[1] and buf[2].
+				*/
 				if (buf[0] != PPP_ALLSTATIONS)
 					skb_reserve(skb, 2 + (buf[0] & 1));
 				ap->rpkt = skb;
