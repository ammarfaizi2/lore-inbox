Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbVKWGuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbVKWGuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 01:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbVKWGuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 01:50:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:29146 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030337AbVKWGuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 01:50:32 -0500
Subject: [PATCH] Fix crash in unregister_console()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 17:47:11 +1100
Message-Id: <1132728431.26560.293.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If unregister_console() is inadvertently called while no consoles are
registered, it will crash trying to dereference NULL pointer. It is
necessary to fix that because register_console() provides no indication
that it actually registered the console passed in. In fact, it may well
decide not to register it based on various things...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-serialfix/kernel/printk.c
===================================================================
--- linux-serialfix.orig/kernel/printk.c	2005-11-15 11:54:14.000000000 +1100
+++ linux-serialfix/kernel/printk.c	2005-11-23 17:47:11.000000000 +1100
@@ -956,7 +956,7 @@ int unregister_console(struct console *c
 	if (console_drivers == console) {
 		console_drivers=console->next;
 		res = 0;
-	} else {
+	} else if (console_drivers) {
 		for (a=console_drivers->next, b=console_drivers ;
 		     a; b=a, a=b->next) {
 			if (a == console) {


