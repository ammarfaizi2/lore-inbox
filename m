Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135977AbREJBWU>; Wed, 9 May 2001 21:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135978AbREJBWK>; Wed, 9 May 2001 21:22:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6797 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135977AbREJBV7>;
	Wed, 9 May 2001 21:21:59 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15097.60691.888764.916294@pizda.ninka.net>
Date: Wed, 9 May 2001 18:21:23 -0700 (PDT)
To: "Svenning Soerensen" <svenning@post5.tele.dk>
Cc: <linux-kernel@vger.kernel.org>, <linux-ipsec@freeswan.org>
Subject: RE: Problem with PMTU discovery on ICMP packets
In-Reply-To: <016e01c0d68b$51da19a0$1400a8c0@sss.intermate.com>
In-Reply-To: <15092.31381.395563.889405@pizda.ninka.net>
	<016e01c0d68b$51da19a0$1400a8c0@sss.intermate.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Svenning Soerensen writes:
 > I've done a bit more testing. The behaviour doesn't change across reboots.
 > Instead, it seems to be the case that:
 > If the packet fits within the MTU of the outgoing interface, DF is set.
 > If the packet doesn't fit, and thus gets fragmented, DF is clear on all
 > fragments.
 > Does this make sense?

Yes.  I've put the following patch into my tree.
Thanks for doing the detective work.

--- net/ipv4/icmp.c.~1~	Sun Apr 29 21:40:40 2001
+++ net/ipv4/icmp.c	Wed May  9 18:20:58 2001
@@ -3,7 +3,7 @@
  *	
  *		Alan Cox, <alan@redhat.com>
  *
- *	Version: $Id: icmp.c,v 1.75 2001/04/30 04:40:40 davem Exp $
+ *	Version: $Id: icmp.c,v 1.76 2001/05/10 01:20:58 davem Exp $
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -1006,6 +1006,7 @@
 	icmp_socket->sk->allocation=GFP_ATOMIC;
 	icmp_socket->sk->sndbuf = SK_WMEM_MAX*2;
 	icmp_socket->sk->protinfo.af_inet.ttl = MAXTTL;
+	icmp_socket->sk->protinfo.af_inet.pmtudisc = IP_PMTUDISC_DONT;
 
 	/* Unhash it so that IP input processing does not even
 	 * see it, we do not wish this socket to see incoming
