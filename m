Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265467AbUATMX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 07:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265463AbUATMX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 07:23:59 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:52942 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S265441AbUATMX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 07:23:56 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>
Subject: [patch] 2.6.1-mm5 compile do not use shared extable code for ia64
Message-Id: <E1Aiuv7-0001cS-00@jaguar.mkp.net>
From: Jes Sorensen <jes@trained-monkey.org>
Date: Tue, 20 Jan 2004 07:23:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The new sort_extable and shares search_extable code doesn't work on
ia64. I have introduced two new #defines that archs can define to avoid
the common code being built. ARCH_HAS_SEARCH_EXTABLE and
ARCH_HAS_SORT_EXTABLE.

With this patch, 2.6.1-mm5 builds again on ia64.

Cheers,
Jes

--- orig/linux-2.6.1-mm5/lib/extable.c	Tue Jan 20 02:53:26 2004
+++ linux-2.6.1-mm5/lib/extable.c	Tue Jan 20 04:08:37 2004
@@ -18,6 +18,7 @@
 extern struct exception_table_entry __start___ex_table[];
 extern struct exception_table_entry __stop___ex_table[];
 
+#ifndef ARCH_HAS_SORT_EXTABLE
 /*
  * The exception table needs to be sorted so that the binary
  * search that we use to find entries in it works properly.
@@ -45,7 +46,9 @@
 		}
 	}
 }
+#endif
 
+#ifndef ARCH_HAS_SEARCH_EXTABLE
 /*
  * Search one exception table for an entry corresponding to the
  * given instruction address, and return the address of the entry,
@@ -75,3 +78,4 @@
         }
         return NULL;
 }
+#endif
--- orig/linux-2.6.1-mm5/include/asm-ia64/uaccess.h	Sun Jan 11 07:00:36 2004
+++ linux-2.6.1-mm5/include/asm-ia64/uaccess.h	Tue Jan 20 04:09:13 2004
@@ -281,6 +281,9 @@
 	__su_ret;						\
 })
 
+#define ARCH_HAS_SORT_EXTABLE
+#define ARCH_HAS_SEARCH_EXTABLE
+
 struct exception_table_entry {
 	int addr;	/* gp-relative address of insn this fixup is for */
 	int cont;	/* gp-relative continuation address; if bit 2 is set, r9 is set to 0 */
