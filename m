Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262901AbVGAXKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbVGAXKV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbVGAXKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:10:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44013 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262901AbVGAXIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:08:17 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17093.52442.181989.751996@segfault.boston.redhat.com>
Date: Fri, 1 Jul 2005 19:08:10 -0400
To: mpm@selenic.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [rfc | patch 3/6] netpoll: change poll_napi to take a net_device
In-Reply-To: <17093.52306.136742.190912@segfault.boston.redhat.com>
References: <17093.52306.136742.190912@segfault.boston.redhat.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry for munging the subject of the prior two patches)

The poll_napi routine is not specific to a netpoll.  It really should be
able to be called with a struct net_device.  Changing the routine to take a
struct net_device makes it easier to support the bonding driver, since we
will be implementing a netpoll_poll_dev routine, that will not have a
struct netpoll associated with it.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---

--- linux-2.6.12/net/core/netpoll.c.orig	2005-07-01 14:12:33.986337259 -0400
+++ linux-2.6.12/net/core/netpoll.c	2005-07-01 14:20:45.848186887 -0400
@@ -128,10 +128,9 @@ static int checksum_udp(struct sk_buff *
  * network adapter, forcing superfluous retries and possibly timeouts.
  * Thus, we set our budget to greater than 1.
  */
-static void poll_napi(struct netpoll *np)
+static void poll_napi(struct net_device *dev)
 {
-	struct netpoll_info *npinfo = np->dev->npinfo;
-	struct net_device *dev = np->dev;
+	struct netpoll_info *npinfo = dev->npinfo;
 	int budget = 16;
 
 	if (test_bit(__LINK_STATE_RX_SCHED, &dev->state) &&
@@ -156,7 +155,7 @@ void netpoll_poll(struct netpoll *np)
 	/* Process pending work on NIC */
 	np->dev->poll_controller(np->dev);
 	if (np->dev->poll)
-		poll_napi(np);
+		poll_napi(np->dev);
 
 	zap_completion_queue();
 }
