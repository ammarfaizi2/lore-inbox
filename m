Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVAZBSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVAZBSu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 20:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVAYXka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:40:30 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:6099 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262246AbVAYXQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:16:57 -0500
Subject: [PATCH] fix broken cross compiles
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       sam@ravnborg.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 17:16:23 -0600
Message-Id: <1106694984.6434.54.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:

kbuild: Use -isystem `gcc -print-file-name=include`

broke our parisc crosscompile (and presumably everyone else's).

The reason is that you have a := in the NOSTDINC_FLAGS rule, which is
evaluated in situ (i.e. before we've had a chance to set CROSSCOMPILE on
CC) so the gcc include path is actually the native one not the
crosscompiler one.  On parisc this causes us to be unable to handle
_builtin_va functions, but I bet there are a heap of other problems.

The fix is below

James

===== Makefile 1.561 vs edited =====
--- 1.561/Makefile	2005-01-21 19:45:34 -06:00
+++ edited/Makefile	2005-01-25 17:13:51 -06:00
@@ -331,7 +331,7 @@
 PERL		= perl
 CHECK		= sparse
 
-NOSTDINC_FLAGS := -nostdinc -isystem $(shell $(CC) -print-file-name=include)
+NOSTDINC_FLAGS  = -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__
 CHECKFLAGS     += $(NOSTDINC_FLAGS)
 MODFLAGS	= -DMODULE


