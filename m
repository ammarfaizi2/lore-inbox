Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbVDLLYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVDLLYO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVDLLW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:22:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:48587 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262313AbVDLKhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:37:22 -0400
Message-Id: <200504121031.j3CAV0P7005203@shell0.pdx.osdl.net>
Subject: [patch 023/198] irda_device() oops fix
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jt@hpl.hp.com,
       davem@davemloft.net
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jean Tourrilhes <jt@hpl.hp.com>

Acked-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/net/irda/irda_device.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff -puN net/irda/irda_device.c~irda_device-oops-fix net/irda/irda_device.c
--- 25/net/irda/irda_device.c~irda_device-oops-fix	2005-04-12 03:21:08.744807488 -0700
+++ 25-akpm/net/irda/irda_device.c	2005-04-12 03:21:08.747807032 -0700
@@ -125,8 +125,15 @@ void irda_device_set_media_busy(struct n
 
 	self = (struct irlap_cb *) dev->atalk_ptr;
 
-	IRDA_ASSERT(self != NULL, return;);
-	IRDA_ASSERT(self->magic == LAP_MAGIC, return;);
+	/* Some drivers may enable the receive interrupt before calling
+	 * irlap_open(), or they may disable the receive interrupt
+	 * after calling irlap_close().
+	 * The IrDA stack is protected from this in irlap_driver_rcv().
+	 * However, the driver calls directly the wrapper, that calls
+	 * us directly. Make sure we protect ourselves.
+	 * Jean II */
+	if (!self || self->magic != LAP_MAGIC)
+		return;
 
 	if (status) {
 		self->media_busy = TRUE;
_
