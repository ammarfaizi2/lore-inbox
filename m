Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbTJHMok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 08:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbTJHMok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 08:44:40 -0400
Received: from hoggle.dreamhost.com ([66.33.197.5]:49332 "EHLO
	hoggle.dreamhost.com") by vger.kernel.org with ESMTP
	id S261443AbTJHMoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 08:44:37 -0400
Subject: [PATCH] kfree_skb() bug in 2.4.22
From: Tobias DiPasquale <toby@cbcg.net>
To: netdev@oss.sgi.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       coreteam@netfilter.org, netfilter@lists.netfilter.org, akpm@zip.com.au,
       jgarzik@pobox.com, davem@redhat.com, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, jmorris@intercode.com.au, yoshfuji@linux-ipv6.org
Content-Type: text/plain
Message-Id: <1065617075.1514.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 08 Oct 2003 08:44:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I was debugging one of my iptables/netfilter modules yesterday and I
came across this bug in kfree_skb(). One of my functions returns a
struct skbuff * on success and NULL on failure. When it failed, the code
calling said function attempted to free the struct skbuff *, which at
that point was NULL. This produced a kernel panic. I investigated the
problem and found that, not only should I be checking for a NULL pointer
when freeing the struct skbuff *, but the actual cause of the panic was
because kfree_skb() and kfree_skb_fast() do not check for skb==NULL,
either. They immediately attempt to dereference the users field of the
struct skbuff * in order to decrement that reference counter. 

I have come up with a patch that applies to both the 2.4.22 pristine
source tree and the 2.4.23-pre6 source tree that solves this issue (see
below). I tried to follow Documentation/SubmittingPatches to the letter;
please let me know if I failed this in some way. Thanks :)

P.S. I wasn't sure who exactly maintains this particular code; that's
why I just sent it to everyone listed in MAINTAINERS remotely associated
with include/linux/skbuff.h ;)


--- include/linux/skbuff.h.orig	2003-10-08 07:52:31.000000000 -0400
+++ include/linux/skbuff.h	2003-10-08 07:52:52.000000000 -0400
@@ -293,6 +293,8 @@
  
 static inline void kfree_skb(struct sk_buff *skb)
 {
+	if (!skb)
+		return;
 	if (atomic_read(&skb->users) == 1 || atomic_dec_and_test(&skb->users))
 		__kfree_skb(skb);
 }
@@ -300,6 +302,8 @@
 /* Use this if you didn't touch the skb state [for fast switching] */
 static inline void kfree_skb_fast(struct sk_buff *skb)
 {
+	if (!skb)
+		return;
 	if (atomic_read(&skb->users) == 1 || atomic_dec_and_test(&skb->users))
 		kfree_skbmem(skb);	
 }


