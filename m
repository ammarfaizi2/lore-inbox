Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVFOVaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVFOVaX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVFOV3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:29:20 -0400
Received: from mail.dif.dk ([193.138.115.101]:984 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261585AbVFOV06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:26:58 -0400
Date: Wed, 15 Jun 2005 23:32:22 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "David S. Miller" <davem@davemloft.net>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       James Morris <jmorris@redhat.com>, Ross Biro <ross.biro@gmail.com>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [-mm PATCH][4/4] net: signed vs unsigned cleanup in net/ipv4/raw.c
Message-ID: <Pine.LNX.4.62.0506152316060.3842@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the type of the third parameter 'length' of the 
raw_send_hdrinc() function from 'int' to 'size_t'.
This makes sense since this function is only ever called from one 
location, and the value passed as the third parameter in that location is 
itself of type size_t, so this makes the recieving functions parameter 
type match. Also, inside raw_send_hdrinc() the 'length' variable is 
used in comparisons with unsigned values and passed as parameter to 
functions expecting unsigned values (it's used in a single comparison with 
a signed value, but that one can never actually be negative so the patch 
also casts that one to size_t to stop gcc worrying, and it is passed in a 
single instance to memcpy_fromiovecend() which expects a signed int, but 
as far as I can see that's not a problem since the value of 'length' 
shouldn't ever exceed the value of a signed int).


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 net/ipv4/raw.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.12-rc6-mm1/net/ipv4/raw.c.with_patch-3	2005-06-15 23:17:23.000000000 +0200
+++ linux-2.6.12-rc6-mm1/net/ipv4/raw.c	2005-06-15 23:26:48.000000000 +0200
@@ -259,7 +259,7 @@ int raw_rcv(struct sock *sk, struct sk_b
 	return 0;
 }
 
-static int raw_send_hdrinc(struct sock *sk, void *from, int length,
+static int raw_send_hdrinc(struct sock *sk, void *from, size_t length,
 			struct rtable *rt, 
 			unsigned int flags)
 {
@@ -298,7 +298,7 @@ static int raw_send_hdrinc(struct sock *
 		goto error_fault;
 
 	/* We don't modify invalid header */
-	if (length >= sizeof(*iph) && iph->ihl * 4 <= length) {
+	if (length >= sizeof(*iph) && (size_t)(iph->ihl * 4) <= length) {
 		if (!iph->saddr)
 			iph->saddr = rt->rt_src;
 		iph->check   = 0;



