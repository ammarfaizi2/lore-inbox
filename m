Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318349AbSIBSzR>; Mon, 2 Sep 2002 14:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318346AbSIBSzR>; Mon, 2 Sep 2002 14:55:17 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:45440 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S317984AbSIBSzN>;
	Mon, 2 Sep 2002 14:55:13 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200209021858.WAA00388@sex.inr.ac.ru>
Subject: Re: TCP Segmentation Offloading (TSO)
To: scott.feldman@intel.com (Feldman Scott)
Date: Mon, 2 Sep 2002 22:58:15 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       haveblue@us.ibm.com, Manand@us.ibm.com, davem@redhat.com,
       christopher.leech@intel.com
In-Reply-To: <288F9BF66CD9D5118DF400508B68C4460283E564@orsmsx113.jf.intel.com> from "Feldman, Scott" at Sep 2, 2 10:45:08 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> [1] Kudos to 

Hmm... wait awhile with celebrating, the implementation in tcp is still
at level of a toy. Well, and it happens to crash, the patch is enclosed.

Alexey


--- linux/net/ipv4/tcp_output.c.orig	Sat Aug 31 17:43:36 2002
+++ linux/net/ipv4/tcp_output.c	Mon Sep  2 22:48:16 2002
@@ -477,6 +477,56 @@
 	return 0;
 }
 
+/* This is similar to __pskb_pull_head() (it will go to core/skbuff.c
+ * eventually). The difference is that pulled data not copied, but
+ * immediately discarded.
+ */
+unsigned char * __pskb_trim_head(struct sk_buff *skb, int len)
+{
+	int i, k, eat;
+
+	eat = len;
+	k = 0;
+	for (i=0; i<skb_shinfo(skb)->nr_frags; i++) {
+		if (skb_shinfo(skb)->frags[i].size <= eat) {
+			put_page(skb_shinfo(skb)->frags[i].page);
+			eat -= skb_shinfo(skb)->frags[i].size;
+		} else {
+			skb_shinfo(skb)->frags[k] = skb_shinfo(skb)->frags[i];
+			if (eat) {
+				skb_shinfo(skb)->frags[k].page_offset += eat;
+				skb_shinfo(skb)->frags[k].size -= eat;
+				eat = 0;
+			}
+			k++;
+		}
+	}
+	skb_shinfo(skb)->nr_frags = k;
+
+	skb->tail = skb->data;
+	skb->data_len -= len;
+	skb->len = skb->data_len;
+	return skb->tail;
+}
+
+static int tcp_trim_head(struct sock *sk, struct sk_buff *skb, u32 len)
+{
+	if (skb_cloned(skb) &&
+	    pskb_expand_head(skb, 0, 0, GFP_ATOMIC))
+		return -ENOMEM;
+
+	if (len <= skb_headlen(skb)) {
+		__skb_pull(skb, len);
+	} else {
+		if (__pskb_trim_head(skb, len-skb_headlen(skb)) == NULL)
+			return -ENOMEM;
+	}
+
+	TCP_SKB_CB(skb)->seq += len;
+	skb->ip_summed = CHECKSUM_HW;
+	return 0;
+}
+
 /* This function synchronize snd mss to current pmtu/exthdr set.
 
    tp->user_mss is mss set by user by TCP_MAXSEG. It does NOT counts
@@ -836,8 +886,6 @@
 		return -EAGAIN;
 
 	if (before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
-		struct sk_buff *skb2;
-
 		if (before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))
 			BUG();
 
@@ -847,13 +895,8 @@
 			tp->mss_cache = tp->mss_cache_std;
 		}
 
-		if(tcp_fragment(sk, skb, tp->snd_una - TCP_SKB_CB(skb)->seq))
+		if (tcp_trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)->seq))
 			return -ENOMEM;
-
-		skb2 = skb->next;
-		__skb_unlink(skb, skb->list);
-		tcp_free_skb(sk, skb);
-		skb = skb2;
 	}
 
 	/* If receiver has shrunk his window, and skb is out of
