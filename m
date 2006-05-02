Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWEBNqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWEBNqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWEBNqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:46:04 -0400
Received: from stinky.trash.net ([213.144.137.162]:54166 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S964818AbWEBNqB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:46:01 -0400
Message-ID: <44576296.6080006@trash.net>
Date: Tue, 02 May 2006 15:45:58 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       coreteam@netfilter.org, "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [netfilter-core] [lockup] 2.6.17-rc3: netfilter/sctp: lockup
 in	sctp_new(), do_basic_checks()
References: <20060502113454.GA28601@elte.hu>
In-Reply-To: <20060502113454.GA28601@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------090804050401020903070503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090804050401020903070503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> running an "isic" stresstest on and against a testbox [which, amongst 
> other things, generates random incoming and outgoing packets] on 
> 2.6.17-rc3 (and 2.6.17-rc3-mm1) over gigabit results in a reproducible 
> lockup, after 5-10 minutes of runtime:
> 
> BUG: soft lockup detected on CPU#0!
>  [<c0104e7f>] show_trace+0xd/0xf
>  [<c0104e96>] dump_stack+0x15/0x17
>  [<c015ad02>] softlockup_tick+0xc5/0xd9
>  [<c0134c02>] run_local_timers+0x22/0x24
>  [<c0134fb7>] update_process_times+0x40/0x65
>  [<c011aa56>] smp_apic_timer_interrupt+0x58/0x60
>  [<c010492b>] apic_timer_interrupt+0x27/0x2c
>  [<c0f00df9>] sctp_new+0x8b/0x235
>  [...]
> 
> this is with FRAME_POINTERS enabled, so it's an exact stacktrace.
> 
> the lockup is at:
> 
> (gdb) list *0xc0f00df9
> 0xc0f00df9 is in sctp_new 
> (net/ipv4/netfilter/ip_conntrack_proto_sctp.c:444).
> 439
> 440             sh = skb_header_pointer(skb, iph->ihl * 4, sizeof(_sctph), &_sctph);
> 441             if (sh == NULL)
> 442                     return 0;
> 443
> 444             if (do_basic_checks(conntrack, skb, map) != 0)
> 445                     return 0;
> 446
> 447             /* If an OOTB packet has any of these chunks discard (Sec 8.4) */
> 448             if ((test_bit (SCTP_CID_ABORT, (void *)map))
> 
> most likely somewhere within do_basic_checks(). [whose stack entry is 
> obscured by the irq entry, so it's not in the stackdump.] I have SCTP 
> turned on:

Yes, it seems like it doesn't make any forward progress in
for_each_sctp_chunk() because the chunk length is zero. Can
you try this patch please?


--------------090804050401020903070503
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

--------------090804050401020903070503--
