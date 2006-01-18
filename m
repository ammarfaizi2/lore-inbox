Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWARA24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWARA24 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWARA2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:28:12 -0500
Received: from [151.97.230.9] ([151.97.230.9]:16867 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S964979AbWARA1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:27:41 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 3/9] uml: networking - clear transport-specific structure
Date: Wed, 18 Jan 2006 01:19:29 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060118001928.14622.13478.stgit@zion.home.lan>
In-Reply-To: <20060117235659.14622.18544.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Pre-clear transport-specific private structure before passing it down.

In fact, I just got a slab corruption and kernel panic on exit because kfree()
was called on a pointer which probably was never allocated, BUT hadn't been set
to NULL by the driver.

As the code is full of such errors, I've decided for now to go the safe way
(we're talking about drivers), and to do the simple thing. I'm also starting to
fix drivers, and already sent a patch for the daemon transport.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/net_kern.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 5b8c64e..98350bb 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -322,6 +322,11 @@ static int eth_configure(int n, void *in
 		return 1;
 	}
 
+	lp = dev->priv;
+	/* This points to the transport private data. It's still clear, but we
+	 * must memset it to 0 *now*. Let's help the drivers. */
+	memset(lp, 0, size);
+
 	/* sysfs register */
 	if (!driver_registered) {
 		platform_driver_register(&uml_net_driver);
@@ -364,7 +369,6 @@ static int eth_configure(int n, void *in
 		free_netdev(dev);
 		return 1;
 	}
-	lp = dev->priv;
 
 	/* lp.user is the first four bytes of the transport data, which
 	 * has already been initialized.  This structure assignment will

