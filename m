Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWGGAg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWGGAg7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWGGAeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:34:18 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:53443 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751118AbWGGAdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:33:50 -0400
Message-Id: <200607070033.k670Xt1w008752@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 19/19] UML - Make mconsole version requests happen in a process
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:55 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handling a host mconsole version request must be done in a process context
rather than interrupt context now that utsname information can be 
process-specific rather than global.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/drivers/mconsole_user.c
===================================================================
--- linux-2.6.16.orig/arch/um/drivers/mconsole_user.c
+++ linux-2.6.16/arch/um/drivers/mconsole_user.c
@@ -18,7 +18,12 @@
 #include "umid.h"
 
 static struct mconsole_command commands[] = {
-	{ "version", mconsole_version, MCONSOLE_INTR },
+	/* With uts namespaces, uts information becomes process-specific, so
+	 * we need a process context.  If we try handling this in interrupt
+	 * context, we may hit an exiting process without a valid uts
+	 * namespace.
+	 */
+	{ "version", mconsole_version, MCONSOLE_PROC },
 	{ "halt", mconsole_halt, MCONSOLE_PROC },
 	{ "reboot", mconsole_reboot, MCONSOLE_PROC },
 	{ "config", mconsole_config, MCONSOLE_PROC },

