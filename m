Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbVHOXbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbVHOXbn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbVHOXbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:31:43 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:24328 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S932592AbVHOXbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:31:43 -0400
Message-Id: <200508152325.j7FNP8Br009015@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/4] UML - Fix a crash under screen
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Aug 2005 19:25:08 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running UML inside a detached screen delivers SIGWINCH when UML is not 
expecting it.  This patch ignores them.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc6/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/kernel/skas/process.c	2005-08-13 09:02:43.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/kernel/skas/process.c	2005-08-13 09:03:15.000000000 -0400
@@ -61,7 +61,11 @@
 
                 CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
         } while((n >= 0) && WIFSTOPPED(status) &&
-                (WSTOPSIG(status) == SIGVTALRM));
+                ((WSTOPSIG(status) == SIGVTALRM) || 
+		 /* running UML inside a detached screen can cause 
+		  * SIGWINCHes 
+		  */
+		 (WSTOPSIG(status) == SIGWINCH)));
 
         if((n < 0) || !WIFSTOPPED(status) ||
            (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status) != SIGTRAP)){

