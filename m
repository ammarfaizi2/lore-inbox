Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267972AbUHPWMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267972AbUHPWMj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267975AbUHPWMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:12:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14980 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267972AbUHPWM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:12:28 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16673.12499.75952.657087@segfault.boston.redhat.com>
Date: Mon, 16 Aug 2004 18:10:27 -0400
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org
Subject: [patch] netpoll: revert netif_queue_stopped changeset
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matt,

Here's the first of the broken out patch set.  This puts the check for
netif_queue_stopped back into netpoll_send_skb.  Network drivers are not
designed to have their hard_start_xmit routines called when the queue is
stopped.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

--- linux-2.6.7/net/core/netpoll.c.orig	2004-08-16 11:57:46.890322256 -0400
+++ linux-2.6.7/net/core/netpoll.c	2004-08-16 12:17:34.477781520 -0400
@@ -168,6 +168,18 @@ repeat:
 	spin_lock(&np->dev->xmit_lock);
 	np->dev->xmit_lock_owner = smp_processor_id();
 
+	/*
+	 * network drivers do not expect to be called if the queue is
+	 * stopped.
+	 */
+	if (netif_queue_stopped(np->dev)) {
+		np->dev->xmit_lock_owner = -1;
+		spin_unlock(&np->dev->xmit_lock);
+
+		netpoll_poll(np);
+		goto repeat;
+	}
+
 	status = np->dev->hard_start_xmit(skb, np->dev);
 	np->dev->xmit_lock_owner = -1;
 	spin_unlock(&np->dev->xmit_lock);
