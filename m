Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267981AbUHPWUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267981AbUHPWUB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267982AbUHPWUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:20:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19847 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267981AbUHPWT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:19:56 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16673.12954.65216.791938@segfault.boston.redhat.com>
Date: Mon, 16 Aug 2004 18:18:02 -0400
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org
Subject: [patch] make netpoll budget a bit higher
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matt,

I've upped the poll budget to 16 and added a comment explaining why.  I
definitely ran into this problem when testing netdump.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

--- linux-2.6.7/net/core/netpoll.c.budget	2004-08-16 12:33:10.176533688 -0400
+++ linux-2.6.7/net/core/netpoll.c	2004-08-16 12:37:15.510237296 -0400
@@ -61,7 +61,13 @@ static int checksum_udp(struct sk_buff *
 
 void netpoll_poll(struct netpoll *np)
 {
-	int budget = 1;
+	/*
+	 * In cases where there is bi-directional communications, reading
+	 * only one message at a time can lead to packets being dropped by
+	 * the network adapter, forcing superfluous retries and possibly
+	 * timeouts.  Thus, we set our budget to a more reasonable value.
+	 */
+	int budget = 16;
 
 	if(!np->dev || !netif_running(np->dev) || !np->dev->poll_controller)
 		return;
