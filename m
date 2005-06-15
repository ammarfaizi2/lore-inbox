Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVFOVlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVFOVlu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVFOVlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:41:49 -0400
Received: from mail.dif.dk ([193.138.115.101]:28120 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261590AbVFOVev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:34:51 -0400
Date: Wed, 15 Jun 2005 23:40:12 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "David S. Miller" <davem@davemloft.net>
Cc: juhl-lkml@dif.dk, yoshfuji@linux-ipv6.org, kuznet@ms2.inr.ac.ru,
       jmorris@redhat.com, ross.biro@gmail.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH][4/4] net: signed vs unsigned cleanup in net/ipv4/raw.c
In-Reply-To: <20050615.142953.59469324.davem@davemloft.net>
Message-ID: <Pine.LNX.4.62.0506152338450.3842@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506152316060.3842@dragon.hyggekrogen.localhost>
 <20050615.142953.59469324.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2005, David S. Miller wrote:

> From: Jesper Juhl <juhl-lkml@dif.dk>
> Date: Wed, 15 Jun 2005 23:32:22 +0200 (CEST)
> 
> > -	if (length >= sizeof(*iph) && iph->ihl * 4 <= length) {
> > +	if (length >= sizeof(*iph) && (size_t)(iph->ihl * 4) <= length) {
> 
> Would changing the "4" into "4U" kill this warning just the same?
> 
It would.

> I think I'd prefer that.
> 
No problem. Here's a replacement patch nr. 4 : 


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 net/ipv4/raw.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.12-rc6-mm1/net/ipv4/raw.c.with_patch-3	2005-06-15 23:17:23.000000000 +0200
+++ linux-2.6.12-rc6-mm1/net/ipv4/raw.c	2005-06-15 23:37:11.000000000 +0200
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
+	if (length >= sizeof(*iph) && iph->ihl * 4U <= length) {
 		if (!iph->saddr)
 			iph->saddr = rt->rt_src;
 		iph->check   = 0;


