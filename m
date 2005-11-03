Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932708AbVKCGTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbVKCGTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 01:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVKCGTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 01:19:52 -0500
Received: from mail2.ispwest.com ([216.52.245.18]:16652 "EHLO
	ispwest-email1.mdeinc.com") by vger.kernel.org with ESMTP
	id S1751134AbVKCGTv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 01:19:51 -0500
X-Modus-BlackList: 216.52.245.25=OK;kjak@ispwest.com=OK
X-Modus-Trusted: 216.52.245.25=YES
Message-ID: <5b1bc8f2a7f34523b323fc1b58ef4c26.kjak@ispwest.com>
X-EM-APIVersion: 2, 0, 1, 0
X-Priority: 3 (Normal)
Reply-To: "Kris Katterjohn" <kjak@users.sourceforge.net>
From: "Kris Katterjohn" <kjak@ispwest.com>
To: "Mitchell Blank Jr" <mitch@sfgoth.com>
CC: "Herbert Xu" <herbert@gondor.apana.org.au>, jschlst@samba.org,
       davem@davemloft.net, acme@ghostprotocols.net, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Merge __load_pointer() and load_pointer() in net/core/filter.c; kernel 2.6.14
Date: Wed, 2 Nov 2005 22:19:49 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Mitchell Blank Jr
> Cc:
> herbert@gondor.apana.org.au;jschlst@samba.org;davem@davemloft.net;
> acme@ghostprotocols.net;netdev@vger.kernel.org
> 
> > (I trimmed the cc: list a bit; no need for this to be on LKML in my opinion)
> > 
> > Kris Katterjohn wrote:
> > > Forgive me because this is one of my first attempts at anything related to the
> > > kernel, but...
> > > 
> > > 1) How would I go about benchmarking this?
> > 
> > The first thing to do is run "size net/core/filter.o" before and after and
> > see if your change makes the "text" section larger.
> > 
> > The risk of putting more stuff into the inlined function is just that
> > the rarely-executed path will end up duplicated in a bunch of places, bloating
> > the generated code.  It's hard to directly benchmark the effects of this but
> > it will generally make the fast-path code less compact in the L1 I-cache
> > which (if you do it enough) slows everything down.  Thats one reason why
> > kernel developers try to keep a close eye on bloat.
> > 
> > -Mitch
> 
> Before patch:
> 
>    text	   data	    bss	    dec	    hex	filename
>    2399	      0	      0	   2399	    95f	x/net/core/filter.o
> 
> After patch:
> 
>    text	   data	    bss	    dec	    hex	filename
>    2589	      0	      0	   2589	    a1d	y/net/core/filter.o
> 
> After patch without inlining the function:
> 
>    text	   data	    bss	    dec	    hex	filename
>    2127	      0	      0	   2127	    84f	y/net/core/filter.o
> 
> 
> So I guess use my patch and take "inline" off? What do you think?
> 
> 
> Thanks
>

Here's the new patch. It's the same as the first one, just with "inline" removed.

Maybe "static" should be removed, too? Oh well.

---


--- x/net/core/filter.c	2005-10-27 19:02:08.000000000 -0500
+++ y/net/core/filter.c	2005-11-03 00:05:42.000000000 -0600
@@ -13,6 +13,8 @@
  * 2 of the License, or (at your option) any later version.
  *
  * Andi Kleen - Fix a few bad bugs and races.
+ * Kris Katterjohn - Merged __load_pointer() into load_pointer() and
+ *                   cleaned it up a little bit - 2005-11-01
  */
 
 #include <linux/module.h>
@@ -35,31 +37,27 @@
 #include <asm/uaccess.h>
 #include <linux/filter.h>
 
-/* No hurry in this branch */
-static void *__load_pointer(struct sk_buff *skb, int k)
+static void *load_pointer(struct sk_buff *skb, int offset,
+                          unsigned int size, void *buffer)
 {
 	u8 *ptr = NULL;
 
-	if (k >= SKF_NET_OFF)
-		ptr = skb->nh.raw + k - SKF_NET_OFF;
-	else if (k >= SKF_LL_OFF)
-		ptr = skb->mac.raw + k - SKF_LL_OFF;
+	if (offset >= 0)
+		return skb_header_pointer(skb, offset, size, buffer);
+
+	if (offset >= SKF_AD_OFF)
+		return NULL;
+
+	if (offset >= SKF_NET_OFF)
+		ptr = skb->nh.raw + offset - SKF_NET_OFF;
+
+	else if (offset >= SKF_LL_OFF)
+		ptr = skb->mac.raw + offset - SKF_LL_OFF;
 
 	if (ptr >= skb->head && ptr < skb->tail)
 		return ptr;
-	return NULL;
-}
 
-static inline void *load_pointer(struct sk_buff *skb, int k,
-                                 unsigned int size, void *buffer)
-{
-	if (k >= 0)
-		return skb_header_pointer(skb, k, size, buffer);
-	else {
-		if (k >= SKF_AD_OFF)
-			return NULL;
-		return __load_pointer(skb, k);
-	}
+	return NULL;
 }
 
 /**


