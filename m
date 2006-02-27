Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751835AbWB0WpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbWB0WpF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWB0WpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:45:03 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:38787 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932344AbWB0WbY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:24 -0500
Message-Id: <20060227223327.924820000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:08 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 08/39] [NET]: Revert skb_copy_datagram_iovec() recursion elimination.
Content-Disposition: inline; filename=revert-skb_copy_datagram_iovec-recursion-elimination.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Revert the following changeset:

bc8dfcb93970ad7139c976356bfc99d7e251deaf

Recursive SKB frag lists are really possible and disallowing
them breaks things.

Noticed by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Signed-off-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 net/core/datagram.c |   81 ++++++++++++++++++++++++++++++++++------------------
 1 files changed, 53 insertions(+), 28 deletions(-)

--- linux-2.6.15.4.orig/net/core/datagram.c
+++ linux-2.6.15.4/net/core/datagram.c
@@ -211,49 +211,74 @@ void skb_free_datagram(struct sock *sk, 
 int skb_copy_datagram_iovec(const struct sk_buff *skb, int offset,
 			    struct iovec *to, int len)
 {
-	int i, err, fraglen, end = 0;
-	struct sk_buff *next = skb_shinfo(skb)->frag_list;
+	int start = skb_headlen(skb);
+	int i, copy = start - offset;
 
-	if (!len)
-		return 0;
+	/* Copy header. */
+	if (copy > 0) {
+		if (copy > len)
+			copy = len;
+		if (memcpy_toiovec(to, skb->data + offset, copy))
+			goto fault;
+		if ((len -= copy) == 0)
+			return 0;
+		offset += copy;
+	}
 
-next_skb:
-	fraglen = skb_headlen(skb);
-	i = -1;
+	/* Copy paged appendix. Hmm... why does this look so complicated? */
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		int end;
 
-	while (1) {
-		int start = end;
+		BUG_TRAP(start <= offset + len);
 
-		if ((end += fraglen) > offset) {
-			int copy = end - offset, o = offset - start;
+		end = start + skb_shinfo(skb)->frags[i].size;
+		if ((copy = end - offset) > 0) {
+			int err;
+			u8  *vaddr;
+			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+			struct page *page = frag->page;
 
 			if (copy > len)
 				copy = len;
-			if (i == -1)
-				err = memcpy_toiovec(to, skb->data + o, copy);
-			else {
-				skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
-				struct page *page = frag->page;
-				void *p = kmap(page) + frag->page_offset + o;
-				err = memcpy_toiovec(to, p, copy);
-				kunmap(page);
-			}
+			vaddr = kmap(page);
+			err = memcpy_toiovec(to, vaddr + frag->page_offset +
+					     offset - start, copy);
+			kunmap(page);
 			if (err)
 				goto fault;
 			if (!(len -= copy))
 				return 0;
 			offset += copy;
 		}
-		if (++i >= skb_shinfo(skb)->nr_frags)
-			break;
-		fraglen = skb_shinfo(skb)->frags[i].size;
+		start = end;
 	}
-	if (next) {
-		skb = next;
-		BUG_ON(skb_shinfo(skb)->frag_list);
-		next = skb->next;
-		goto next_skb;
+
+	if (skb_shinfo(skb)->frag_list) {
+		struct sk_buff *list = skb_shinfo(skb)->frag_list;
+
+		for (; list; list = list->next) {
+			int end;
+
+			BUG_TRAP(start <= offset + len);
+
+			end = start + list->len;
+			if ((copy = end - offset) > 0) {
+				if (copy > len)
+					copy = len;
+				if (skb_copy_datagram_iovec(list,
+							    offset - start,
+							    to, copy))
+					goto fault;
+				if ((len -= copy) == 0)
+					return 0;
+				offset += copy;
+			}
+			start = end;
+		}
 	}
+	if (!len)
+		return 0;
+
 fault:
 	return -EFAULT;
 }

--
