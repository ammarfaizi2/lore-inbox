Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270986AbUJUV4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270986AbUJUV4P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270998AbUJUVe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:34:28 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:18059 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270991AbUJUVb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:31:29 -0400
Subject: [patch] HVSI hangup oops
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, cabbey@us.ibm.com
Content-Type: text/plain
Message-Id: <1098376034.12020.34.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 21 Oct 2004 16:27:15 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, testing revealed that the HVSI driver could oops if carrier
detect dropped mid-data transfer. Please apply this fix.

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

-- 
Hollis Blanchard
IBM Linux Technology Center

--- drivers/char/hvsi.c.orig	2004-10-11 11:36:36.000000000 -0500
+++ drivers/char/hvsi.c	2004-10-11 13:24:13.000000000 -0500
@@ -927,11 +927,17 @@ static void hvsi_close(struct tty_struct
 static void hvsi_hangup(struct tty_struct *tty)
 {
 	struct hvsi_struct *hp = tty->driver_data;
+	unsigned long flags;
 
 	pr_debug("%s\n", __FUNCTION__);
 
+	spin_lock_irqsave(&hp->lock, flags);
+
 	hp->count = 0;
+	hp->n_outbuf = 0;
 	hp->tty = NULL;
+
+	spin_unlock_irqrestore(&hp->lock, flags);
 }
 
 /* called with hp->lock held */


