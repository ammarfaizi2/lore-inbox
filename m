Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTKJD4e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 22:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbTKJD4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 22:56:34 -0500
Received: from ozlabs.org ([203.10.76.45]:27538 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262731AbTKJD4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 22:56:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16303.3278.290375.640234@cargo.ozlabs.ibm.com>
Date: Mon, 10 Nov 2003 14:58:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, trini@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] PPC32: Fix alignment problem with __ex_table and __bug_table.
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

The __start___ex_table and __start___bug_table symbols could end up
pointing a few bytes before the actual __ex_table and __bug_table
sections, if the preceding section had an odd length.  This led to
oopses in some situations.  Patch from Sam Ravnborg.

diff -urN linux-2.5/arch/ppc/kernel/vmlinux.lds.S for-linus-ppc/arch/ppc/kernel/vmlinux.lds.S
--- linux-2.5/arch/ppc/kernel/vmlinux.lds.S	2003-09-24 10:55:53.000000000 +1000
+++ for-linus-ppc/arch/ppc/kernel/vmlinux.lds.S	2003-10-14 19:49:25.000000000 +1000
@@ -47,13 +47,17 @@
 
   .fixup   : { *(.fixup) }
 
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
-  __start___bug_table = .;
-  __bug_table : { *(__bug_table) }
-  __stop___bug_table = .;
+	__ex_table : {
+		__start___ex_table = .;
+		*(__ex_table)
+		__stop___ex_table = .;
+	}
+
+	__bug_table : {
+		__start___bug_table = .;
+		*(__bug_table)
+		__stop___bug_table = .;
+	}
 
   /* Read-write section, merged into data segment: */
   . = ALIGN(4096);
