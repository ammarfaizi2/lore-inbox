Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267595AbTACRey>; Fri, 3 Jan 2003 12:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267597AbTACRey>; Fri, 3 Jan 2003 12:34:54 -0500
Received: from mailout5-0.nyroc.rr.com ([24.92.226.122]:26716 "EHLO
	mailout5-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S267595AbTACRew> convert rfc822-to-8bit; Fri, 3 Jan 2003 12:34:52 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Stephen Evanchik <evanchsa@clarkson.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.54] hermes: serialization fixes
Date: Fri, 3 Jan 2003 12:39:29 -0500
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301031239.29226.evanchsa@clarkson.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hermes MAC controller module wasn't serializing BAP seek calls. This 
caused an eventual Rx/Tx failure which equates tens of thousands of errors on 
the wireless interface. A simple spinlock is used to keep things in line.

Any comments are appreciated, I don't believe this is the best solution, but 
it is working well. Patches can be downloaded from here:

http://www.clarkson.edu/~evanchsa/software/kernel/patches/hermes.patch-2.4.20
http://www.clarkson.edu/~evanchsa/software/kernel/patches/hermes.patch-2.5.54



--- linux-2.5.54/drivers/net/wireless/hermes.h	2003-01-01 22:21:02.000000000 
-0500
+++ linux-2.5.54-devel/drivers/net/wireless/hermes.h	2003-01-03 
11:38:25.000000000 -0500
@@ -288,6 +288,9 @@
 
 	u16 inten; /* Which interrupts should be enabled? */
 
+	/* Lock to avoid tripping over ourselves */
+	spinlock_t baplock;
+
 #ifdef HERMES_DEBUG_BUFFER
 	struct hermes_debug_entry dbuf[HERMES_DEBUG_BUFSIZE];
 	unsigned long dbufp;
--- linux-2.5.54/drivers/net/wireless/hermes.c	2003-01-01 22:21:13.000000000 
-0500
+++ linux-2.5.54-devel/drivers/net/wireless/hermes.c	2003-01-03 
11:41:51.000000000 -0500
@@ -407,11 +407,18 @@
 {
 	int dreg = bap ? HERMES_DATA1 : HERMES_DATA0;
 	int err = 0;
+	unsigned long flags;
 
 	if ( (len < 0) || (len % 2) )
 		return -EINVAL;
 
+	/* Without this, system instability occurs */
+	spin_lock_irqsave((&hw->baplock), flags);
+
 	err = hermes_bap_seek(hw, bap, id, offset);
+
+	spin_unlock_irqrestore((&hw->baplock), flags);
+
 	if (err)
 		goto out;
 
@@ -433,11 +440,17 @@
 {
 	int dreg = bap ? HERMES_DATA1 : HERMES_DATA0;
 	int err = 0;
+	unsigned long flags;
 
 	if ( (len < 0) || (len % 2) )
 		return -EINVAL;
 
+	spin_lock_irqsave((&hw->baplock), flags);
+
 	err = hermes_bap_seek(hw, bap, id, offset);
+
+	spin_unlock_irqrestore((&hw->baplock), flags);
+
 	if (err)
 		goto out;
 	
@@ -463,6 +476,7 @@
 	int dreg = bap ? HERMES_DATA1 : HERMES_DATA0;
 	u16 rlength, rtype;
 	int nwords;
+	unsigned long flags;
 
 	if ( (bufsize < 0) || (bufsize % 2) )
 		return -EINVAL;
@@ -471,7 +485,12 @@
 	if (err)
 		goto out;
 
+	spin_lock_irqsave((&hw->baplock), flags);
+
 	err = hermes_bap_seek(hw, bap, rid, 0);
+
+	spin_unlock_irqrestore((&hw->baplock), flags);
+
 	if (err)
 		goto out;
 
@@ -505,8 +524,14 @@
 	int dreg = bap ? HERMES_DATA1 : HERMES_DATA0;
 	int err = 0;
 	int count;
+	unsigned long flags;
 	
+	spin_lock_irqsave((&hw->baplock), flags);
+
 	err = hermes_bap_seek(hw, bap, rid, 0);
+
+	spin_unlock_irqrestore((&hw->baplock), flags);
+
 	if (err)
 		goto out;
