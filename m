Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVFWB2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVFWB2U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVFWB2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:28:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41882 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261841AbVFWB1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:27:47 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17082.4106.825017.811757@segfault.boston.redhat.com>
Date: Wed, 22 Jun 2005 21:27:38 -0400
To: mpm@selenic.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: [patch 1/3] netpoll: set poll_owner to -1 before unlocking in netpoll_poll_unlock
In-Reply-To: <17082.4037.875432.648439@segfault.boston.redhat.com>
References: <17082.4037.875432.648439@segfault.boston.redhat.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This trivial patch moves the assignment of poll_owner to -1 inside of the
lock.  This fixes a potential SMP race in the code.

-Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---

--- linux-2.6.12/include/linux/netpoll.h.orig	2005-06-22 18:47:12.917261688 -0400
+++ linux-2.6.12/include/linux/netpoll.h	2005-06-22 18:47:15.799783018 -0400
@@ -53,8 +53,8 @@ static inline void netpoll_poll_lock(str
 static inline void netpoll_poll_unlock(struct net_device *dev)
 {
 	if (dev->np) {
-		spin_unlock(&dev->np->poll_lock);
 		dev->np->poll_owner = -1;
+		spin_unlock(&dev->np->poll_lock);
 	}
 }
 
