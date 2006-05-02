Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWEBOTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWEBOTc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWEBOTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:19:32 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:21978 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964835AbWEBOTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:19:31 -0400
Date: Tue, 2 May 2006 16:24:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       coreteam@netfilter.org, "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [netfilter-core] Re: [lockup] 2.6.17-rc3: netfilter/sctp: lockup in	sctp_new(), do_basic_checks()
Message-ID: <20060502142414.GA452@elte.hu>
References: <20060502113454.GA28601@elte.hu> <20060502134053.GA30917@elte.hu> <4457648C.6020100@trash.net> <20060502140102.GA31743@elte.hu> <4457654A.9040200@trash.net> <20060502141621.GA32284@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502141621.GA32284@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> but this makes do_basic_checks() not fail, and the clearly bogus 
> packet is passed further down. The reason i have put it inside the 
> loop is to be able to return 1 for the early checks. How about the fix 
> below? It should be cleaner and it will also return 1 if the initial 
> offset is oversized.

that should be:

----
From: Ingo Molnar <mingo@elte.hu>

fix infinite loop in the SCTP-netfilter code: check SCTP chunk size to 
guarantee progress of for_each_sctp_chunk(). (all other uses of 
for_each_sctp_chunk() are preceded by do_basic_checks(), so this fix 
should be complete.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 net/ipv4/netfilter/ip_conntrack_proto_sctp.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

Index: linux/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
===================================================================
--- linux.orig/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
+++ linux/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
@@ -224,6 +224,13 @@ static int do_basic_checks(struct ip_con
 	DEBUGP(__FUNCTION__);
 	DEBUGP("\n");
 
+	/*
+	 * Dont trust the initial offset:
+	 */
+	offset = skb->nh.iph->ihl * 4 + sizeof(sctp_sctphdr_t);
+	if (offset >= skb->len)
+		return 1;
+
 	flag = 0;
 
 	for_each_sctp_chunk (skb, sch, _sch, offset, count) {
@@ -235,12 +242,15 @@ static int do_basic_checks(struct ip_con
 			flag = 1;
 		}
 
-		/* Cookie Ack/Echo chunks not the first OR 
-		   Init / Init Ack / Shutdown compl chunks not the only chunks */
-		if ((sch->type == SCTP_CID_COOKIE_ACK 
+		/*
+		 * Cookie Ack/Echo chunks not the first OR
+		 * Init / Init Ack / Shutdown compl chunks not the only chunks
+		 * OR zero-length.
+		 */
+		if (((sch->type == SCTP_CID_COOKIE_ACK
 			|| sch->type == SCTP_CID_COOKIE_ECHO
 			|| flag)
-		     && count !=0 ) {
+		     && count != 0) || !sch->length) {
 			DEBUGP("Basic checks failed\n");
 			return 1;
 		}

