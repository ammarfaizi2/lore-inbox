Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130180AbRBVExk>; Wed, 21 Feb 2001 23:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130028AbRBVExb>; Wed, 21 Feb 2001 23:53:31 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:6404 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129604AbRBVExT>; Wed, 21 Feb 2001 23:53:19 -0500
Date: Wed, 21 Feb 2001 20:53:18 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ARP out the wrong interface
In-Reply-To: <Pine.LNX.4.10.10102091030390.17807-100000@sphinx.mythic-beasts.com>
Message-ID: <Pine.LNX.4.33.0102212050480.22754-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2001, Matthew Kirkwood wrote:

> On Thu, 8 Feb 2001, dean gaudet wrote:
>
> > responses come back from both eth0 and eth1, listing each of their
> > respective MAC addresses...  it's essentially a race condition at this
> > point as to whether i'll get the right MAC address.  ("right" means
> > the MAC for server:eth1).
>
> 2.2.18 and 2.4 apparently have a patch called "arpfilter"
> integrated which should allow you to:
>
> # sysctl -w net.ipv4.conf.all.arpfilter=1
>
> to get much stricter behaviour regarding ARP replies.

hmm, so i'm working with a 2.4.1-ac20-TUX-P5 kernel and i can't find
"arpfilter" or "arp.*filter" in any of the files, so it doesn't appear to
have made it into 2.4.  i've been using the patch attached below and it's
solving the problem for me for now.  (it could be entirely wrong, but it's
letting me at least get some other work done :)

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

