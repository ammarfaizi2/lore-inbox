Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbUB1C30 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 21:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbUB1C30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 21:29:26 -0500
Received: from dp.samba.org ([66.70.73.150]:7400 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263010AbUB1C3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 21:29:24 -0500
Date: Sat, 28 Feb 2004 13:25:37 +1100
From: Anton Blanchard <anton@samba.org>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, kenneth.w.chen@intel.com,
       olof@austin.ibm.com
Subject: [PATCH] performance problem with established hash
Message-ID: <20040228022537.GR5801@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

An HTTP stress test on latest 2.6 BK shows up a problem in tcp_r4_rcv:

15.0125  tcp_v4_rcv
 8.2719  e1000_xmit_frame
 3.2153  qdisc_restart
 3.1675  skb_release_data

15% in tcp_v4_rcv, ouch. It turns out almost all of this is walking the
established hash looking for stuff in time wait:

        /* Must check for a TIME_WAIT'er before going to listener hash. */
        sk_for_each(sk, node, &(head + tcp_ehash_size)->chain) {
                if (TCP_IPV4_TW_MATCH(sk, acookie, saddr, daddr, ports, dif))
                        goto hit;
        }

Looking at the logic for sizing the established hash, we clamp at 10
pages. That doesnt sound right:

        if (num_physpages >= (128 * 1024))
                goal = num_physpages >> (21 - PAGE_SHIFT);
        else
                goal = num_physpages >> (23 - PAGE_SHIFT);

        if (!thash_entries)
                goal = min(10UL, goal);
        else
                goal = (thash_entries * sizeof(struct tcp_ehash_bucket)) >> PAGE_SHIFT;

Sure enough things arent happy:

Older 2.6 kernel:
	TCP: Hash tables configured (established 262144 bind 65536)

Current 2.6 BK:
	TCP: Hash tables configured (established 4096 bind 4096)

It looks like the hash clamping patches wanted to clamp at 1 << 10, not
10. Patch below.

Anton

---

 foobar2-anton/net/ipv4/tcp.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN net/ipv4/tcp.c~ehashfix net/ipv4/tcp.c
--- foobar2/net/ipv4/tcp.c~ehashfix	2004-02-28 13:10:48.151071100 +1100
+++ foobar2-anton/net/ipv4/tcp.c	2004-02-28 13:11:41.434038779 +1100
@@ -2622,7 +2622,7 @@ void __init tcp_init(void)
 		goal = num_physpages >> (23 - PAGE_SHIFT);
 
 	if (!thash_entries)
-		goal = min(10UL, goal);
+		goal = min(1UL << 10, goal);
 	else
 		goal = (thash_entries * sizeof(struct tcp_ehash_bucket)) >> PAGE_SHIFT;
 	for (order = 0; (1UL << order) < goal; order++)

