Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268482AbTBWPKR>; Sun, 23 Feb 2003 10:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268485AbTBWPKQ>; Sun, 23 Feb 2003 10:10:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7953 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268482AbTBWPKN>; Sun, 23 Feb 2003 10:10:13 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] [1/6] Remove dummy cb_config() and cb_release()
Message-Id: <20020223151801@raistlin.arm.linux.org.uk>
Date: Sun, 23 Feb 2003 15:20:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears not to be in 2.5.62, but applies cleanly.

Subject: [1/6] Remove dummy cb_config() and cb_release()
cb_config() and cb_release() are just simple dummy functions that are
only used in the internals of the PCMCIA code.  We inline them where
used.

 drivers/pcmcia/cardbus.c     |   32 --------------------------------
 drivers/pcmcia/cs.c          |    7 ++-----
 drivers/pcmcia/cs_internal.h |    2 --
 3 files changed, 2 insertions, 39 deletions

diff -ur orig/drivers/pcmcia/cardbus.c linux/drivers/pcmcia/cardbus.c
--- orig/drivers/pcmcia/cardbus.c	Fri Jan 17 10:39:17 2003
+++ linux/drivers/pcmcia/cardbus.c	Sun Feb 23 12:17:52 2003
@@ -335,38 +335,6 @@
 
 /*=====================================================================
 
-    cb_config() has the job of allocating all system resources that
-    a Cardbus card requires.  Rather than using the CIS (which seems
-    to not always be present), it treats the card as an ordinary PCI
-    device, and probes the base address registers to determine each
-    function's IO and memory space needs.
-
-    It is called from the RequestIO card service.
-    
-======================================================================*/
-
-int cb_config(socket_info_t * s)
-{
-	return CS_SUCCESS;
-}
-
-/*======================================================================
-
-    cb_release() releases all the system resources (IO and memory
-    space, and interrupt) committed for a Cardbus card by a prior call
-    to cb_config().
-
-    It is called from the ReleaseIO() service.
-    
-======================================================================*/
-
-void cb_release(socket_info_t * s)
-{
-	DEBUG(0, "cs: cb_release(bus %d)\n", s->cap.cb_dev->subordinate->number);
-}
-
-/*=====================================================================
-
     cb_enable() has the job of configuring a socket for a Cardbus
     card, and initializing the card's PCI configuration registers.
 
diff -ur orig/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- orig/drivers/pcmcia/cs.c	Fri Feb 21 19:48:51 2003
+++ linux/drivers/pcmcia/cs.c	Sun Feb 23 12:03:16 2003
@@ -1562,7 +1562,6 @@
     
 #ifdef CONFIG_CARDBUS
     if (handle->state & CLIENT_CARDBUS) {
-	cb_release(s);
 	return CS_SUCCESS;
     }
 #endif
@@ -1804,10 +1803,8 @@
 
     if (handle->state & CLIENT_CARDBUS) {
 #ifdef CONFIG_CARDBUS
-	int ret = cb_config(s);
-	if (ret == CS_SUCCESS)
-	    handle->state |= CLIENT_IO_REQ;
-	return ret;
+	handle->state |= CLIENT_IO_REQ;
+	return CS_SUCCESS;
 #else
 	return CS_UNSUPPORTED_FUNCTION;
 #endif
diff -ur orig/drivers/pcmcia/cs_internal.h linux/drivers/pcmcia/cs_internal.h
--- orig/drivers/pcmcia/cs_internal.h	Wed Nov 13 16:53:30 2002
+++ linux/drivers/pcmcia/cs_internal.h	Sun Feb 23 11:39:32 2003
@@ -198,8 +198,6 @@
 /* In cardbus.c */
 int cb_alloc(socket_info_t *s);
 void cb_free(socket_info_t *s);
-int cb_config(socket_info_t *s);
-void cb_release(socket_info_t *s);
 void cb_enable(socket_info_t *s);
 void cb_disable(socket_info_t *s);
 int read_cb_mem(socket_info_t *s, u_char fn, int space,

