Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWHDFoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWHDFoc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWHDFoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:44:08 -0400
Received: from cantor2.suse.de ([195.135.220.15]:57263 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030319AbWHDFn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:43:58 -0400
Date: Thu, 3 Aug 2006 22:39:20 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, netdev@vger.kernel.org,
       David Miller <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 09/23] : Update frag_list in pskb_trim
Message-ID: <20060804053920.GJ769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="update-frag_list-in-pskb_trim.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Herbert Xu <herbert@gondor.apana.org.au>

[NET]: Update frag_list in pskb_trim

When pskb_trim has to defer to ___pksb_trim to trim the frag_list part of
the packet, the frag_list is not updated to reflect the trimming.  This
will usually work fine until you hit something that uses the packet length
or tail from the frag_list.

Examples include esp_output and ip_fragment.

Another problem caused by this is that you can end up with a linear packet
with a frag_list attached.

It is possible to get away with this if we audit everything to make sure
that they always consult skb->len before going down onto frag_list.  In
fact we can do the samething for the paged part as well to avoid copying
the data area of the skb.  For now though, let's do the conservative fix
and update frag_list.

Many thanks to Marco Berizzi for helping me to track down this bug.

This 4-year old bug took 3 months to track down.  Marco was very patient
indeed :)

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/linux/skbuff.h |   24 +++++------
 net/core/skbuff.c      |  106 ++++++++++++++++++++++++++++++++++---------------
 2 files changed, 86 insertions(+), 44 deletions(-)

--- linux-2.6.17.7.orig/include/linux/skbuff.h
+++ linux-2.6.17.7/include/linux/skbuff.h
@@ -967,15 +967,16 @@ static inline void skb_reserve(struct sk
 #define NET_SKB_PAD	16
 #endif
 
-extern int ___pskb_trim(struct sk_buff *skb, unsigned int len, int realloc);
+extern int ___pskb_trim(struct sk_buff *skb, unsigned int len);
 
 static inline void __skb_trim(struct sk_buff *skb, unsigned int len)
 {
-	if (!skb->data_len) {
-		skb->len  = len;
-		skb->tail = skb->data + len;
-	} else
-		___pskb_trim(skb, len, 0);
+	if (unlikely(skb->data_len)) {
+		WARN_ON(1);
+		return;
+	}
+	skb->len  = len;
+	skb->tail = skb->data + len;
 }
 
 /**
@@ -985,6 +986,7 @@ static inline void __skb_trim(struct sk_
  *
  *	Cut the length of a buffer down by removing data from the tail. If
  *	the buffer is already under the length specified it is not modified.
+ *	The skb must be linear.
  */
 static inline void skb_trim(struct sk_buff *skb, unsigned int len)
 {
@@ -995,12 +997,10 @@ static inline void skb_trim(struct sk_bu
 
 static inline int __pskb_trim(struct sk_buff *skb, unsigned int len)
 {
-	if (!skb->data_len) {
-		skb->len  = len;
-		skb->tail = skb->data+len;
-		return 0;
-	}
-	return ___pskb_trim(skb, len, 1);
+	if (skb->data_len)
+		return ___pskb_trim(skb, len);
+	__skb_trim(skb, len);
+	return 0;
 }
 
 static inline int pskb_trim(struct sk_buff *skb, unsigned int len)
--- linux-2.6.17.7.orig/net/core/skbuff.c
+++ linux-2.6.17.7/net/core/skbuff.c
@@ -251,11 +251,11 @@ nodata:
 }
 
 
-static void skb_drop_fraglist(struct sk_buff *skb)
+static void skb_drop_list(struct sk_buff **listp)
 {
-	struct sk_buff *list = skb_shinfo(skb)->frag_list;
+	struct sk_buff *list = *listp;
 
-	skb_shinfo(skb)->frag_list = NULL;
+	*listp = NULL;
 
 	do {
 		struct sk_buff *this = list;
@@ -264,6 +264,11 @@ static void skb_drop_fraglist(struct sk_
 	} while (list);
 }
 
+static inline void skb_drop_fraglist(struct sk_buff *skb)
+{
+	skb_drop_list(&skb_shinfo(skb)->frag_list);
+}
+
 static void skb_clone_fraglist(struct sk_buff *skb)
 {
 	struct sk_buff *list;
@@ -802,49 +807,86 @@ struct sk_buff *skb_pad(struct sk_buff *
 	return nskb;
 }	
  
-/* Trims skb to length len. It can change skb pointers, if "realloc" is 1.
- * If realloc==0 and trimming is impossible without change of data,
- * it is BUG().
+/* Trims skb to length len. It can change skb pointers.
  */
 
-int ___pskb_trim(struct sk_buff *skb, unsigned int len, int realloc)
+int ___pskb_trim(struct sk_buff *skb, unsigned int len)
 {
+	struct sk_buff **fragp;
+	struct sk_buff *frag;
 	int offset = skb_headlen(skb);
 	int nfrags = skb_shinfo(skb)->nr_frags;
 	int i;
+	int err;
 
-	for (i = 0; i < nfrags; i++) {
+	if (skb_cloned(skb) &&
+	    unlikely((err = pskb_expand_head(skb, 0, 0, GFP_ATOMIC))))
+		return err;
+
+	i = 0;
+	if (offset >= len)
+		goto drop_pages;
+
+	for (; i < nfrags; i++) {
 		int end = offset + skb_shinfo(skb)->frags[i].size;
-		if (end > len) {
-			if (skb_cloned(skb)) {
-				BUG_ON(!realloc);
-				if (pskb_expand_head(skb, 0, 0, GFP_ATOMIC))
-					return -ENOMEM;
-			}
-			if (len <= offset) {
-				put_page(skb_shinfo(skb)->frags[i].page);
-				skb_shinfo(skb)->nr_frags--;
-			} else {
-				skb_shinfo(skb)->frags[i].size = len - offset;
-			}
+
+		if (end < len) {
+			offset = end;
+			continue;
+		}
+
+		skb_shinfo(skb)->frags[i++].size = len - offset;
+
+drop_pages:
+		skb_shinfo(skb)->nr_frags = i;
+
+		for (; i < nfrags; i++)
+			put_page(skb_shinfo(skb)->frags[i].page);
+
+		if (skb_shinfo(skb)->frag_list)
+			skb_drop_fraglist(skb);
+		goto done;
+	}
+
+	for (fragp = &skb_shinfo(skb)->frag_list; (frag = *fragp);
+	     fragp = &frag->next) {
+		int end = offset + frag->len;
+
+		if (skb_shared(frag)) {
+			struct sk_buff *nfrag;
+
+			nfrag = skb_clone(frag, GFP_ATOMIC);
+			if (unlikely(!nfrag))
+				return -ENOMEM;
+
+			nfrag->next = frag->next;
+			kfree_skb(frag);
+			frag = nfrag;
+			*fragp = frag;
 		}
-		offset = end;
+
+		if (end < len) {
+			offset = end;
+			continue;
+		}
+
+		if (end > len &&
+		    unlikely((err = pskb_trim(frag, len - offset))))
+			return err;
+
+		if (frag->next)
+			skb_drop_list(&frag->next);
+		break;
 	}
 
-	if (offset < len) {
+done:
+	if (len > skb_headlen(skb)) {
 		skb->data_len -= skb->len - len;
 		skb->len       = len;
 	} else {
-		if (len <= skb_headlen(skb)) {
-			skb->len      = len;
-			skb->data_len = 0;
-			skb->tail     = skb->data + len;
-			if (skb_shinfo(skb)->frag_list && !skb_cloned(skb))
-				skb_drop_fraglist(skb);
-		} else {
-			skb->data_len -= skb->len - len;
-			skb->len       = len;
-		}
+		skb->len       = len;
+		skb->data_len  = 0;
+		skb->tail      = skb->data + len;
 	}
 
 	return 0;

--
