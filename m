Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbTFJNld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 09:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbTFJNld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 09:41:33 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:19916 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S262032AbTFJNlc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 09:41:32 -0400
Date: Tue, 10 Jun 2003 15:55:10 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com
Subject: [PATCHLET] 2.5.70 invalid icmp broadcast.
Message-ID: <Pine.LNX.4.51.0306101546040.28518@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed this a couple of weeks ago in the kernel log:
150.254.39.135 sent an invalid to a broadcast.

I decided to make the kernel be more verbose about it. Here is a patch
that would show:
150.254.39.135 sent an invalid ICMP type 11, code 0 error to a broadcast: 150.254.39.255 on eth1

Please apply.

Regards,
Maciej

diff -Nru linux-2.5.68.bak/net/ipv4/icmp.c linux-2.5.70/net/ipv4/icmp.c
--- linux-2.5.68.bak/net/ipv4/icmp.c	2003-05-17 14:56:11.000000000 +0200
+++ linux-2.5.70/net/ipv4/icmp.c	2003-06-09 13:21:37.000000000 +0200
@@ -663,8 +659,12 @@
 	    inet_addr_type(iph->daddr) == RTN_BROADCAST) {
 		if (net_ratelimit())
 			printk(KERN_WARNING "%u.%u.%u.%u sent an invalid ICMP "
-					    "error to a broadcast.\n",
-			       NIPQUAD(skb->nh.iph->saddr));
+					    "type %u, code %u "
+					    "error to a broadcast: %u.%u.%u.%u on %s\n",
+			       NIPQUAD(iph->saddr),
+			       icmph->type, icmph->code,
+			       NIPQUAD(iph->daddr),
+			       skb->dev->name);
 		goto out;
 	}

