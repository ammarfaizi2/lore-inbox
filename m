Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267655AbTACUqW>; Fri, 3 Jan 2003 15:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267657AbTACUqW>; Fri, 3 Jan 2003 15:46:22 -0500
Received: from mailout5-0.nyroc.rr.com ([24.92.226.122]:16492 "EHLO
	mailout5-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S267655AbTACUqV> convert rfc822-to-8bit; Fri, 3 Jan 2003 15:46:21 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Stephen Evanchik <evanchsa@clarkson.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.54] UPDATE hermes: serialization fixes
Date: Fri, 3 Jan 2003 15:50:55 -0500
User-Agent: KMail/1.4.1
Cc: hermes@gibson.dropbear.id.au
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301031550.55590.evanchsa@clarkson.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes "Error -110 writing Tx descriptor to BAP" bug as referenced in David Gibson's README.

As per a suggestion, I've moved the spin_lock/unlock to hermes_bap_seek(). I'm currently running with
this module and it's working nicely. 

As always, any comments are appreciated. Patches can be always downloaded from here:

http://www.clarkson.edu/~evanchsa/software/kernel/patches

Stephen Evanchik


--- linux-2.5.54/drivers/net/wireless/hermes.h	2003-01-01 22:21:02.000000000 -0500
+++ linux-2.5.54-devel/drivers/net/wireless/hermes.h	2003-01-03 15:32:33.000000000 -0500
@@ -288,6 +288,9 @@
 
 	u16 inten; /* Which interrupts should be enabled? */
 
+	/* Lock used in hermes_bap_seek */
+	spinlock_t baplock;
+
 #ifdef HERMES_DEBUG_BUFFER
 	struct hermes_debug_entry dbuf[HERMES_DEBUG_BUFSIZE];
 	unsigned long dbufp;
--- linux-2.5.54/drivers/net/wireless/hermes.c	2003-01-01 22:21:13.000000000 -0500
+++ linux-2.5.54-devel/drivers/net/wireless/hermes.c	2003-01-03 15:34:23.000000000 -0500
@@ -342,11 +342,15 @@
 	int oreg = bap ? HERMES_OFFSET1 : HERMES_OFFSET0;
 	int k;
 	u16 reg;
+	unsigned long flags;
 
 	/* Paranoia.. */
 	if ( (offset > HERMES_BAP_OFFSET_MAX) || (offset % 2) )
 		return -EINVAL;
 
+	/* Without it, network connection errors occur.. */
+	spin_lock_irqsave(&(hw->baplock), flags);
+
 	k = HERMES_BAP_BUSY_TIMEOUT;
 	reg = hermes_read_reg(hw, oreg);
 	while ((reg & HERMES_OFFSET_BUSY) && k) {
@@ -368,6 +372,8 @@
 	}
 #endif
 
+	spin_unlock_irqrestore(&(hw->baplock), flags);
+
 	if (reg & HERMES_OFFSET_BUSY)
 		return -ETIMEDOUT;
 

