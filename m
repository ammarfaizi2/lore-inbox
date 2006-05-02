Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWEBO3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWEBO3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWEBO3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:29:43 -0400
Received: from stinky.trash.net ([213.144.137.162]:1691 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id S964839AbWEBO3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:29:43 -0400
Message-ID: <44576CD5.60603@trash.net>
Date: Tue, 02 May 2006 16:29:41 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       coreteam@netfilter.org, "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [netfilter-core] Re: [lockup] 2.6.17-rc3: netfilter/sctp: lockup
 in	sctp_new(), do_basic_checks()
References: <20060502113454.GA28601@elte.hu> <20060502134053.GA30917@elte.hu> <4457648C.6020100@trash.net> <20060502140102.GA31743@elte.hu> <4457654A.9040200@trash.net> <20060502141621.GA32284@elte.hu>
In-Reply-To: <20060502141621.GA32284@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------050708050202010305070104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050708050202010305070104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * Patrick McHardy <kaber@trash.net> wrote:
> 
> 
>>I did a couple of minutes ago. Here it is again in case my last mail 
>>won't show up.
> 
> 
>>-	(sch = skb_header_pointer(skb, offset, sizeof(_sch), &_sch));	\
>>-	offset += (htons(sch->length) + 3) & ~3, count++)
>>+	(sch = skb_header_pointer(skb, offset, sizeof(_sch), &_sch)) &&  \
>>+	sch->length; offset += (htons(sch->length) + 3) & ~3, count++)
> 
> 
> but this makes do_basic_checks() not fail, and the clearly bogus packet 
> is passed further down. The reason i have put it inside the loop is to 
> be able to return 1 for the early checks. How about the fix below? It 
> should be cleaner and it will also return 1 if the initial offset is 
> oversized.

Right, that is better.


> Index: linux/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
> ===================================================================
> --- linux.orig/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
> +++ linux/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
> @@ -224,6 +224,13 @@ static int do_basic_checks(struct ip_con
>  	DEBUGP(__FUNCTION__);
>  	DEBUGP("\n");
>  
> +	/*
> +	 * Dont trust the initial offset:
> +	 */
> +	offset = skb->nh.iph->ihl * 4 + sizeof(sctp_sctphdr_t);
> +	if (offset >= skb->len)
> +		return 1;
> +

That part is unnecessary, the presence of one sctp_sctphdr_t
has already been verified by skb_header_pointer() in sctp_new().
How about this patch (based on your patch, but typos fixed and
also covers nf_conntrack)?


--------------050708050202010305070104
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[NETFILTER]: SCTP conntrack: fix infinite loop

fix infinite loop in the SCTP-netfilter code: check SCTP chunk size to
guarantee progress of for_each_sctp_chunk(). (all other uses of
for_each_sctp_chunk() are preceded by do_basic_checks(), so this fix
should be complete.)

Based on patch from Ingo Molnar <mingo@elte.hu>

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit c14803e9e8446122312523a6b6959e7312379b2e
tree 651d4f6f1cd07703d3ec6b9367c441312e969e9e
parent 462f3ddd384045c731b3268a1b9c91c834a5a68a
author Patrick McHardy <kaber@trash.net> Tue, 02 May 2006 16:28:26 +0200
committer Patrick McHardy <kaber@trash.net> Tue, 02 May 2006 16:28:26 +0200

 net/ipv4/netfilter/ip_conntrack_proto_sctp.c |   11 +++++++----
 net/netfilter/nf_conntrack_proto_sctp.c      |   11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/netfilter/ip_conntrack_proto_sctp.c b/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
index 5259abd..a563534 100644
--- a/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
+++ b/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
@@ -235,12 +235,15 @@ static int do_basic_checks(struct ip_con
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
+		      && count !=0) || !sch->length) {
 			DEBUGP("Basic checks failed\n");
 			return 1;
 		}
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 9cccc32..730f5d6 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -240,12 +240,15 @@ static int do_basic_checks(struct nf_con
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
+		      && count !=0) || !sch->length) {
 			DEBUGP("Basic checks failed\n");
 			return 1;
 		}

--------------050708050202010305070104--
