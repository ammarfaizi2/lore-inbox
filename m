Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315268AbSDWREn>; Tue, 23 Apr 2002 13:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315272AbSDWREm>; Tue, 23 Apr 2002 13:04:42 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:23704 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S315268AbSDWREk>; Tue, 23 Apr 2002 13:04:40 -0400
Date: Tue, 23 Apr 2002 10:04:39 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Frank Louwers <frank@openminds.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
In-Reply-To: <20020423113935.A30329@openminds.be>
Message-ID: <Pine.LNX.4.44.0204230959020.25696-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2002, Frank Louwers wrote:

> We recently stummed across a rather annoying bug when 2 nics are on
> the same network.

the powers that be consider this a feature, for reasons i've never quite
understood.  your question comes up regularly, and typically the
suggestion is some convoluted filtering thing, and i've never been
sufficiently convinced the filter is worth the overhead.  (especially in
my case when i wanted two interfaces for performance reasons.)

last i investigated this problem the kernel actually sent arp responses
out *both* interfaces, and it was basically a race condition as to which
the recipient would use.

anyhow, below is a patch i created for 2.4.2... hopefully it still works.
apply this and also disable proxy arp in /proc/somewhere.

-dean

--- linux/net/ipv4/arp.c.badproxy	Mon Feb 12 17:28:48 2001
+++ linux/net/ipv4/arp.c	Tue Feb 13 20:06:37 2001
@@ -737,10 +737,12 @@
 		addr_type = rt->rt_type;

 		if (addr_type == RTN_LOCAL) {
+			if ((rt->rt_flags&RTCF_DIRECTSRC) || IN_DEV_PROXY_ARP(in_dev)) {
 			n = neigh_event_ns(&arp_tbl, sha, &sip, dev);
 			if (n) {
 				arp_send(ARPOP_REPLY,ETH_P_ARP,sip,dev,tip,sha,dev->dev_addr,sha);
 				neigh_release(n);
+			}
 			}
 			goto out;
 		} else if (IN_DEV_FORWARD(in_dev)) {

