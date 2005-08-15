Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbVHOVDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVHOVDE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbVHOVDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:03:04 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:2444 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S964962AbVHOVDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:03:02 -0400
Date: Mon, 15 Aug 2005 14:02:19 -0700 (PDT)
From: Naveen Gupta <ngupta@google.com>
To: wim@iguana.be, david@2gen.com, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, ngupta@google.com
Subject: [-mm PATCH] set correct bit in reload register of Watchdog Timer
 for Intel 6300 chipset
Message-ID: <Pine.LNX.4.56.0508151359410.26489@krishna.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch writes into bit 8 of the reload register to perform the
correct 'Reload Sequence' instead of writing into bit 4 of Watchdog for
Intel 6300ESB chipset.

Signed-off-by: Naveen Gupta <ngupta@google.com>

Index: linux-2.6.12/drivers/char/watchdog/i6300esb.c
===================================================================
--- linux-2.6.12.orig/drivers/char/watchdog/i6300esb.c	2005-08-15 11:21:35.000000000 -0700
+++ linux-2.6.12/drivers/char/watchdog/i6300esb.c	2005-08-15 11:28:07.000000000 -0700
@@ -109,7 +109,7 @@
 	spin_lock(&esb_lock);
 	/* First, reset timers as suggested by the docs */
 	esb_unlock_registers();
-	writew(0x10, ESB_RELOAD_REG);
+	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
 	/* Then disable the WDT */
 	pci_write_config_byte(esb_pci, ESB_LOCK_REG, 0x0);
 	pci_read_config_byte(esb_pci, ESB_LOCK_REG, &val);
@@ -123,7 +123,7 @@
 {
 	spin_lock(&esb_lock);
 	esb_unlock_registers();
-	writew(0x10, ESB_RELOAD_REG);
+	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
         /* FIXME: Do we need to flush anything here? */
 	spin_unlock(&esb_lock);
 }
@@ -153,7 +153,7 @@
 
         /* Reload */
 	esb_unlock_registers();
-	writew(0x10, ESB_RELOAD_REG);
+	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
 
 	/* FIXME: Do we need to flush everything out? */
 
Index: linux-2.6.12/drivers/char/watchdog/i6300esb.h
===================================================================
--- linux-2.6.12.orig/drivers/char/watchdog/i6300esb.h	2005-08-15 11:19:01.000000000 -0700
+++ linux-2.6.12/drivers/char/watchdog/i6300esb.h	2005-08-15 11:26:58.000000000 -0700
@@ -54,6 +54,8 @@
 #define ESB_WDT_FREQ    ( 0x01 << 2 )   /* Decrement frequency               */
 #define ESB_WDT_INTTYPE ( 0x11 << 0 )   /* Interrupt type on timer1 timeout  */
 
+/* Reload register bits */
+#define ESB_WDT_RELOAD ( 0x01 << 8 )    /* prevent timeout                   */
 
 /*
  * Some magic constants
