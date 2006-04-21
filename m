Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWDUEqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWDUEqr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWDUEom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:7042 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932246AbWDUEoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:15 -0400
Date: Thu, 20 Apr 2006 21:37:51 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Herbert Xu <herbert@gondor.apana.org.au>,
       David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 04/22] : Fix truesize underflow
Message-ID: <20060421043751.GE12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-bug.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Herbert Xu <herbert@gondor.apana.org.au>

[TCP]: Fix truesize underflow

There is a problem with the TSO packet trimming code.  The cause of
this lies in the tcp_fragment() function.

When we allocate a fragment for a completely non-linear packet the
truesize is calculated for a payload length of zero.  This means that
truesize could in fact be less than the real payload length.

When that happens the TSO packet trimming can cause truesize to become
negative.  This in turn can cause sk_forward_alloc to be -n * PAGE_SIZE
which would trigger the warning.

I've copied the code DaveM used in tso_fragment which should work here.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv4/tcp_output.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.16.9.orig/net/ipv4/tcp_output.c
+++ linux-2.6.16.9/net/ipv4/tcp_output.c
@@ -537,7 +537,9 @@ int tcp_fragment(struct sock *sk, struct
 	buff = sk_stream_alloc_skb(sk, nsize, GFP_ATOMIC);
 	if (buff == NULL)
 		return -ENOMEM; /* We'll just try again later. */
-	sk_charge_skb(sk, buff);
+
+	buff->truesize = skb->len - len;
+	skb->truesize -= buff->truesize;
 
 	/* Correct the sequence numbers. */
 	TCP_SKB_CB(buff)->seq = TCP_SKB_CB(skb)->seq + len;

--
