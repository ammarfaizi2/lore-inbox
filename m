Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTJTFEW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 01:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbTJTFEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 01:04:00 -0400
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:56944 "EHLO
	water-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S262282AbTJTFDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 01:03:55 -0400
Date: Sun, 19 Oct 2003 22:03:52 -0700 (PDT)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@clyde
To: acme@conectiva.com.br
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [PATCH] Make LLC2 compile with PROC_FS=n
Message-ID: <Pine.GSO.4.58.0310171452540.13905@blinky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnaldo,

This patch allows the LLC2 code to link properly when CONFIG_PROC_FS=n.  The
problem was that the Makefile only built llc_proc.c when PROC_FS=y/m, but
af_llc.c called functions in that file in all cases.  The log details how I
fixed this.

I think this is the best fix, but of course there are a number of less intrusive
fixes, including (I think) one as simple as making llc_proc.c always compile.
This one does apply cleanly to linux-2.5 BK as of 0400 UTC 10/20/2003 and passes
allyesconfig and (allyesconfig - PROC_FS) compiles on i386.

Please let me know if I should supply you with further information.

Thanks,
Noah

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1340.1.34 -> 1.1340.1.35
#	    net/llc/af_llc.c	1.50    -> 1.51
#	  net/llc/llc_proc.c	1.17    -> 1.18
#	include/net/llc_proc.h	1.1     -> 1.3     net/llc/llc_proc.h (moved)
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/17	noah@caltech.edu	1.1340.1.35
# Move include/net/llc_proc.h to net/llc/llc_proc.h since it is a private
# header file.  Add static inline stub functions to that header and remove
# the extern stub functions from llc_proc.c  This fixes a link error and
# saves space.  Also mark two private structs in llc_proc.c static.
# --------------------------------------------
#
diff -Nru a/include/net/llc_proc.h b/include/net/llc_proc.h
--- a/include/net/llc_proc.h	Fri Oct 17 16:24:05 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,18 +0,0 @@
-#ifndef LLC_PROC_H
-#define LLC_PROC_H
-/*
- * Copyright (c) 1997 by Procom Technology, Inc.
- * 		 2002 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
- */
-
-extern int llc_proc_init(void);
-extern void llc_proc_exit(void);
-
-#endif /* LLC_PROC_H */
diff -Nru a/net/llc/af_llc.c b/net/llc/af_llc.c
--- a/net/llc/af_llc.c	Fri Oct 17 16:24:05 2003
+++ b/net/llc/af_llc.c	Fri Oct 17 16:24:05 2003
@@ -30,7 +30,7 @@
 #include <net/llc_sap.h>
 #include <net/llc_pdu.h>
 #include <net/llc_conn.h>
-#include <net/llc_proc.h>
+#include "llc_proc.h"

 /* remember: uninitialized global data is zeroed because its in .bss */
 static u16 llc_ui_sap_last_autoport = LLC_SAP_DYN_START;
diff -Nru a/net/llc/llc_proc.c b/net/llc/llc_proc.c
--- a/net/llc/llc_proc.c	Fri Oct 17 16:24:05 2003
+++ b/net/llc/llc_proc.c	Fri Oct 17 16:24:05 2003
@@ -14,7 +14,6 @@

 #include <linux/config.h>
 #include <linux/init.h>
-#ifdef CONFIG_PROC_FS
 #include <linux/kernel.h>
 #include <linux/proc_fs.h>
 #include <linux/errno.h>
@@ -193,14 +192,14 @@
 	return 0;
 }

-struct seq_operations llc_seq_socket_ops = {
+static struct seq_operations llc_seq_socket_ops = {
 	.start  = llc_seq_start,
 	.next   = llc_seq_next,
 	.stop   = llc_seq_stop,
 	.show   = llc_seq_socket_show,
 };

-struct seq_operations llc_seq_core_ops = {
+static struct seq_operations llc_seq_core_ops = {
 	.start  = llc_seq_start,
 	.next   = llc_seq_next,
 	.stop   = llc_seq_stop,
@@ -273,13 +272,3 @@
 	remove_proc_entry("core", llc_proc_dir);
 	remove_proc_entry("llc", proc_net);
 }
-#else /* CONFIG_PROC_FS */
-int __init llc_proc_init(void)
-{
-	return 0;
-}
-
-void llc_proc_exit(void)
-{
-}
-#endif /* CONFIG_PROC_FS */
diff -Nru a/net/llc/llc_proc.h b/net/llc/llc_proc.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/net/llc/llc_proc.h	Fri Oct 17 16:24:05 2003
@@ -0,0 +1,23 @@
+#ifndef LLC_PROC_H
+#define LLC_PROC_H
+/*
+ * Copyright (c) 1997 by Procom Technology, Inc.
+ * 		 2002 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+ *
+ * This program can be redistributed or modified under the terms of the
+ * GNU General Public License as published by the Free Software Foundation.
+ * This program is distributed without any warranty or implied warranty
+ * of merchantability or fitness for a particular purpose.
+ *
+ * See the GNU General Public License for more details.
+ */
+
+#ifdef CONFIG_PROC_FS
+extern int llc_proc_init(void);
+extern void llc_proc_exit(void);
+#else /* CONFIG_PROC_FS */
+static inline int llc_proc_init(void)  { return 0; }
+static inline void llc_proc_exit(void) {           }
+#endif /* CONFIG_PROC_FS */
+
+#endif /* LLC_PROC_H */

