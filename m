Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbUJ0TcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbUJ0TcS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbUJ0SvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:51:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:36757 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262617AbUJ0Skb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:40:31 -0400
Subject: [resend patch] HVSI hangup oops
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1098884177.3486.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 27 Oct 2004 13:36:18 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, I've tested this with the current BK tree as you requested.

Testing revealed that the HVSI driver could oops if carrier
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


