Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932868AbWCVWqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932868AbWCVWqq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWCVWq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:46:26 -0500
Received: from mail.gmx.de ([213.165.64.20]:44928 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964834AbWCVWqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:46:07 -0500
X-Authenticated: #704063
Subject: [Patch] Pointer dereference in net/irda/ircomm/ircomm_tty.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 22 Mar 2006 23:46:05 +0100
Message-Id: <1143067566.26895.8.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes coverity bugs #855 and #854. In both cases tty
is dereferenced before getting checked for NULL.
Compile tested only.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.16/net/irda/ircomm/ircomm_tty.c.orig	2006-03-22 23:40:50.000000000 +0100
+++ linux-2.6.16/net/irda/ircomm/ircomm_tty.c	2006-03-22 23:42:40.000000000 +0100
@@ -493,7 +493,7 @@ static int ircomm_tty_open(struct tty_st
  */
 static void ircomm_tty_close(struct tty_struct *tty, struct file *filp)
 {
-	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+	struct ircomm_tty_cb *self;
 	unsigned long flags;
 
 	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
@@ -501,6 +501,8 @@ static void ircomm_tty_close(struct tty_
 	if (!tty)
 		return;
 
+	self = (struct ircomm_tty_cb *) tty->driver_data;
+	
 	IRDA_ASSERT(self != NULL, return;);
 	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
 
@@ -1006,17 +1008,19 @@ static void ircomm_tty_shutdown(struct i
  */
 static void ircomm_tty_hangup(struct tty_struct *tty)
 {
-	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+	struct ircomm_tty_cb *self;
 	unsigned long	flags;
 
 	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
 
-	IRDA_ASSERT(self != NULL, return;);
-	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
-
 	if (!tty)
 		return;
 
+	self = (struct ircomm_tty_cb *) tty->driver_data;
+
+	IRDA_ASSERT(self != NULL, return;);
+	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
+
 	/* ircomm_tty_flush_buffer(tty); */
 	ircomm_tty_shutdown(self);
 


