Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWHYWoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWHYWoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 18:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWHYWoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 18:44:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751545AbWHYWoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 18:44:18 -0400
Date: Fri, 25 Aug 2006 15:43:53 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IPV6 : segmentation offload not set correctly on TCP
 children
Message-ID: <20060825154353.3ecaf508@localhost.localdomain>
In-Reply-To: <20060821222634.GC21790@cip.informatik.uni-erlangen.de>
References: <20060821212243.GA1558@cip.informatik.uni-erlangen.de>
	<20060821150231.31a947d4@localhost.localdomain>
	<20060821222634.GC21790@cip.informatik.uni-erlangen.de>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

TCP over IPV6 would incorrectly inherit the GSO settings.
This would cause kernel to send Tcp Segmentation Offload packets for
IPV6 data to devices that can't handle it. It caused the sky2 driver
to lock http://bugzilla.kernel.org/show_bug.cgi?id=7050
and the e1000 would generate bogus packets. I can't blame the
hardware for gagging if the upper layers feed it garbage.

This was a new bug in 2.6.18 introduced with GSO support.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>


--- linux-2.6.orig/net/ipv6/tcp_ipv6.c	2006-08-03 09:09:16.000000000 -0700
+++ linux-2.6/net/ipv6/tcp_ipv6.c	2006-08-25 15:30:31.000000000 -0700
@@ -944,7 +944,7 @@
 	 * comment in that function for the gory details. -acme
 	 */
 
-	sk->sk_gso_type = SKB_GSO_TCPV6;
+	newsk->sk_gso_type = SKB_GSO_TCPV6;
 	__ip6_dst_store(newsk, dst, NULL);
 
 	newtcp6sk = (struct tcp6_sock *)newsk;
