Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWEBN5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWEBN5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWEBN5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:57:32 -0400
Received: from stinky.trash.net ([213.144.137.162]:61335 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S964830AbWEBN5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:57:31 -0400
Message-ID: <4457654A.9040200@trash.net>
Date: Tue, 02 May 2006 15:57:30 +0200
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
References: <20060502113454.GA28601@elte.hu> <20060502134053.GA30917@elte.hu> <4457648C.6020100@trash.net> <20060502140102.GA31743@elte.hu>
In-Reply-To: <20060502140102.GA31743@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------020707080907060905000402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020707080907060905000402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
>>
>>I just came up with a similar fix :) I think I'm going to take my own 
>>patch though because its IMO slightly nicer. Thanks anyway.
> 
> 
> could you send your patch so that i can start using it instead of mine?

I did a couple of minutes ago. Here it is again in case my last mail
won't show up.

--------------020707080907060905000402
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[NETFILTER]: Fix endless loop in SCTP conntrack

When a chunk length is zero, for_each_sctp_chunk() doesn't make any forward
progress and loops forever. A chunk length of 0 is invalid, so just abort
in that case.

Reported by Ingo Molnar <mingo@elte.hu>.

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit 32491b3d62bc8c3ff2400deebd46972ebc7332af
tree 7249133ec32c18f4e6f989560e8d86b5e2e2cf0c
parent 462f3ddd384045c731b3268a1b9c91c834a5a68a
author Patrick McHardy <kaber@trash.net> Tue, 02 May 2006 15:44:30 +0200
committer Patrick McHardy <kaber@trash.net> Tue, 02 May 2006 15:44:30 +0200

 net/ipv4/netfilter/ip_conntrack_proto_sctp.c |    4 ++--
 net/netfilter/nf_conntrack_proto_sctp.c      |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/netfilter/ip_conntrack_proto_sctp.c b/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
index 5259abd..ebd4ecf 100644
--- a/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
+++ b/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
@@ -209,8 +209,8 @@ static int sctp_print_conntrack(struct s
 #define for_each_sctp_chunk(skb, sch, _sch, offset, count)		\
 for (offset = skb->nh.iph->ihl * 4 + sizeof(sctp_sctphdr_t), count = 0;	\
 	offset < skb->len &&						\
-	(sch = skb_header_pointer(skb, offset, sizeof(_sch), &_sch));	\
-	offset += (htons(sch->length) + 3) & ~3, count++)
+	(sch = skb_header_pointer(skb, offset, sizeof(_sch), &_sch)) &&  \
+	sch->length; offset += (htons(sch->length) + 3) & ~3, count++)
 
 /* Some validity checks to make sure the chunks are fine */
 static int do_basic_checks(struct ip_conntrack *conntrack,
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 9cccc32..2e34436 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -213,8 +213,8 @@ static int sctp_print_conntrack(struct s
 #define for_each_sctp_chunk(skb, sch, _sch, offset, dataoff, count)	\
 for (offset = dataoff + sizeof(sctp_sctphdr_t), count = 0;		\
 	offset < skb->len &&						\
-	(sch = skb_header_pointer(skb, offset, sizeof(_sch), &_sch));	\
-	offset += (htons(sch->length) + 3) & ~3, count++)
+	(sch = skb_header_pointer(skb, offset, sizeof(_sch), &_sch)) &&	\
+	sch->length; offset += (htons(sch->length) + 3) & ~3, count++)
 
 /* Some validity checks to make sure the chunks are fine */
 static int do_basic_checks(struct nf_conn *conntrack,

--------------020707080907060905000402--
