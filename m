Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135490AbREEBqi>; Fri, 4 May 2001 21:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135805AbREEBq3>; Fri, 4 May 2001 21:46:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63375 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135490AbREEBqS>;
	Fri, 4 May 2001 21:46:18 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15091.23396.515412.928664@pizda.ninka.net>
Date: Fri, 4 May 2001 18:46:12 -0700 (PDT)
To: Pekka Savola <pekkas@netcore.fi>
Cc: "Maciej 'Agaran' Pijanka" <agaran@agaran.6bone.pl>,
        NetDevel List <netdev@oss.sgi.com>, <kuznet@ms2.inr.ac.ru>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] (was Re: 2.4.4 & IPv6 oopses)
In-Reply-To: <Pine.LNX.4.33.0105041709450.31252-100000@netcore.fi>
In-Reply-To: <Pine.LNX.4.21.0105041357150.17065-100000@kepler.agaran.6bone.pl>
	<Pine.LNX.4.33.0105041709450.31252-100000@netcore.fi>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pekka Savola writes:
 > struct in6_addr *saddr = NULL;
 > [...]
 >         if (skb && ipv6_chk_addr(&skb->nh.ipv6h->saddr, dev))
 >                 saddr = &skb->nh.ipv6h->saddr;
 > [...]
 > 	ndisc_send_ns(dev, neigh, target, target, saddr);
 > [...]
 > This check apparently fails? and saddr is left null.

Yes, it can fail, and this is normal.  The problem is in
ndisc_send_ns().

 > in ndisc_send_ns, NULL saddr is checked:
 > 
 > send_llinfo = dev->addr_len && ipv6_addr_type(saddr) != IPV6_ADDR_ANY;
 > 
 > which make a null ptr dereference.  send_llinfo check was added recently
 > to fix RFC incompliancy a week or so ago.

A few lines later we setup saddr properly if it is NULL, what we need
to do is either:

1) Move that "if (saddr == NULL)" code block up above the send_llinfo
   check.

   I think this would break the thing the send_llinfo check
   was meant to fix, but I can't be sure.

2) Just check for NULL saddr in the send_llinfo check and if NULL
   then send_llinfo is set to zero.

For now, I've put solution #2 into my tree, patch attached below.

--- linux/net/ipv6/ndisc.c.~1~	Thu May  3 00:01:10 2001
+++ linux/net/ipv6/ndisc.c	Fri May  4 18:44:54 2001
@@ -382,7 +382,7 @@
 	int send_llinfo;
 
 	len = sizeof(struct icmp6hdr) + sizeof(struct in6_addr);
-	send_llinfo = dev->addr_len && ipv6_addr_type(saddr) != IPV6_ADDR_ANY;
+	send_llinfo = dev->addr_len && saddr && ipv6_addr_type(saddr) != IPV6_ADDR_ANY;
 	if (send_llinfo)
 		len += NDISC_OPT_SPACE(dev->addr_len);
 




