Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWDFRyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWDFRyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 13:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWDFRyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 13:54:21 -0400
Received: from [198.99.130.12] ([198.99.130.12]:9910 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751294AbWDFRyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 13:54:21 -0400
Message-Id: <200604061655.k36GtRNa005151@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/2] UML memory hotplug cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Apr 2006 12:55:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change memory hotplug to use GFP_NOWAIT instead of GFP_ATOMIC, so that it
will grab memory without sleeping, but doesn't try to use the emergency pools.

A small list initialization suggested by Daniel Phillips - don't initialize
lists which are just about to be list_add-ed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.16.orig/arch/um/drivers/mconsole_kern.c	2006-04-06 12:10:41.000000000 -0400
+++ linux-2.6.16/arch/um/drivers/mconsole_kern.c	2006-04-06 12:21:07.000000000 -0400
@@ -87,7 +87,7 @@ static irqreturn_t mconsole_interrupt(in
 		if(req.cmd->context == MCONSOLE_INTR)
 			(*req.cmd->handler)(&req);
 		else {
-			new = kmalloc(sizeof(*new), GFP_ATOMIC);
+			new = kmalloc(sizeof(*new), GFP_NOWAIT);
 			if(new == NULL)
 				mconsole_reply(&req, "Out of memory", 1, 0);
 			else {
@@ -415,7 +415,6 @@ static int mem_config(char *str)
 
 			unplugged = page_address(page);
 			if(unplug_index == UNPLUGGED_PER_PAGE){
-				INIT_LIST_HEAD(&unplugged->list);
 				list_add(&unplugged->list, &unplugged_pages);
 				unplug_index = 0;
 			}
@@ -655,7 +654,6 @@ static void with_console(struct mc_reque
 	struct mconsole_entry entry;
 	unsigned long flags;
 
-	INIT_LIST_HEAD(&entry.list);
 	entry.request = *req;
 	list_add(&entry.list, &clients);
 	spin_lock_irqsave(&console_lock, flags);

