Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264288AbUFKRlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbUFKRlu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 13:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbUFKRlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 13:41:07 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:15529 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S264272AbUFKRhZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 13:37:25 -0400
Date: Fri, 11 Jun 2004 19:37:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: tape driver changes.
Message-ID: <20040611173734.GH3279@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: tape driver changes.

From: Stefan Bader <shbader@de.ibm.com>

tape driver changes:
 - Create seperate debug areas for core and discipline modules.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/char/tape.h       |    8 ++++----
 drivers/s390/char/tape_34xx.c  |   20 ++++++++++++++++++--
 drivers/s390/char/tape_block.c |    2 ++
 drivers/s390/char/tape_char.c  |    2 ++
 drivers/s390/char/tape_core.c  |   18 ++++++++++--------
 drivers/s390/char/tape_proc.c  |    2 ++
 drivers/s390/char/tape_std.c   |    2 ++
 7 files changed, 40 insertions(+), 14 deletions(-)

diff -urN linux-2.6/drivers/s390/char/tape.h linux-2.6-s390/drivers/s390/char/tape.h
--- linux-2.6/drivers/s390/char/tape.h	Mon May 10 04:32:53 2004
+++ linux-2.6-s390/drivers/s390/char/tape.h	Fri Jun 11 19:09:59 2004
@@ -32,7 +32,7 @@
 #ifdef  DBF_LIKE_HELL
 #define DBF_LH(level, str, ...) \
 do { \
-	debug_sprintf_event(tape_dbf_area, level, str, ## __VA_ARGS__); \
+	debug_sprintf_event(TAPE_DBF_AREA, level, str, ## __VA_ARGS__); \
 } while (0)
 #else
 #define DBF_LH(level, str, ...) do {} while(0)
@@ -43,12 +43,12 @@
  */
 #define DBF_EVENT(d_level, d_str...) \
 do { \
-	debug_sprintf_event(tape_dbf_area, d_level, d_str); \
+	debug_sprintf_event(TAPE_DBF_AREA, d_level, d_str); \
 } while (0)
 
 #define DBF_EXCEPTION(d_level, d_str...) \
 do { \
-	debug_sprintf_exception(tape_dbf_area, d_level, d_str); \
+	debug_sprintf_exception(TAPE_DBF_AREA, d_level, d_str); \
 } while (0)
 
 #define TAPE_VERSION_MAJOR 2
@@ -313,7 +313,7 @@
 extern void tape_med_state_set(struct tape_device *, enum tape_medium_state);
 
 /* The debug area */
-extern debug_info_t *tape_dbf_area;
+extern debug_info_t *TAPE_DBF_AREA;
 
 /* functions for building ccws */
 static inline struct ccw1 *
diff -urN linux-2.6/drivers/s390/char/tape_34xx.c linux-2.6-s390/drivers/s390/char/tape_34xx.c
--- linux-2.6/drivers/s390/char/tape_34xx.c	Mon May 10 04:32:28 2004
+++ linux-2.6-s390/drivers/s390/char/tape_34xx.c	Fri Jun 11 19:09:59 2004
@@ -15,11 +15,19 @@
 #include <linux/bio.h>
 #include <linux/workqueue.h>
 
+#define TAPE_DBF_AREA	tape_34xx_dbf
+
 #include "tape.h"
 #include "tape_std.h"
 
 #define PRINTK_HEADER "TAPE_34XX: "
 
+/*
+ * Pointer to debug area.
+ */
+debug_info_t *TAPE_DBF_AREA = NULL;
+EXPORT_SYMBOL(TAPE_DBF_AREA);
+
 enum tape_34xx_type {
 	tape_3480,
 	tape_3490,
@@ -1343,7 +1351,13 @@
 {
 	int rc;
 
-	DBF_EVENT(3, "34xx init: $Revision: 1.20 $\n");
+	TAPE_DBF_AREA = debug_register ( "tape_34xx", 1, 2, 4*sizeof(long));
+	debug_register_view(TAPE_DBF_AREA, &debug_sprintf_view);
+#ifdef DBF_LIKE_HELL
+	debug_set_level(TAPE_DBF_AREA, 6);
+#endif
+
+	DBF_EVENT(3, "34xx init: $Revision: 1.21 $\n");
 	/* Register driver for 3480/3490 tapes. */
 	rc = ccw_driver_register(&tape_34xx_driver);
 	if (rc)
@@ -1357,12 +1371,14 @@
 tape_34xx_exit(void)
 {
 	ccw_driver_unregister(&tape_34xx_driver);
+
+	debug_unregister(TAPE_DBF_AREA);
 }
 
 MODULE_DEVICE_TABLE(ccw, tape_34xx_ids);
 MODULE_AUTHOR("(C) 2001-2002 IBM Deutschland Entwicklung GmbH");
 MODULE_DESCRIPTION("Linux on zSeries channel attached 3480 tape "
-		   "device driver ($Revision: 1.20 $)");
+		   "device driver ($Revision: 1.21 $)");
 MODULE_LICENSE("GPL");
 
 module_init(tape_34xx_init);
diff -urN linux-2.6/drivers/s390/char/tape_block.c linux-2.6-s390/drivers/s390/char/tape_block.c
--- linux-2.6/drivers/s390/char/tape_block.c	Mon May 10 04:33:05 2004
+++ linux-2.6-s390/drivers/s390/char/tape_block.c	Fri Jun 11 19:09:59 2004
@@ -19,6 +19,8 @@
 
 #include <asm/debug.h>
 
+#define TAPE_DBF_AREA	tape_core_dbf
+
 #include "tape.h"
 
 #define PRINTK_HEADER "TAPE_BLOCK: "
diff -urN linux-2.6/drivers/s390/char/tape_char.c linux-2.6-s390/drivers/s390/char/tape_char.c
--- linux-2.6/drivers/s390/char/tape_char.c	Mon May 10 04:33:10 2004
+++ linux-2.6-s390/drivers/s390/char/tape_char.c	Fri Jun 11 19:09:59 2004
@@ -18,6 +18,8 @@
 
 #include <asm/uaccess.h>
 
+#define TAPE_DBF_AREA	tape_core_dbf
+
 #include "tape.h"
 #include "tape_std.h"
 #include "tape_class.h"
diff -urN linux-2.6/drivers/s390/char/tape_core.c linux-2.6-s390/drivers/s390/char/tape_core.c
--- linux-2.6/drivers/s390/char/tape_core.c	Mon May 10 04:32:26 2004
+++ linux-2.6-s390/drivers/s390/char/tape_core.c	Fri Jun 11 19:09:59 2004
@@ -20,6 +20,8 @@
 
 #include <asm/types.h>	     // for variable types
 
+#define TAPE_DBF_AREA	tape_core_dbf
+
 #include "tape.h"
 #include "tape_std.h"
 
@@ -39,7 +41,8 @@
 /*
  * Pointer to debug area.
  */
-debug_info_t *tape_dbf_area = NULL;
+debug_info_t *TAPE_DBF_AREA = NULL;
+EXPORT_SYMBOL(TAPE_DBF_AREA);
 
 /*
  * Printable strings for tape enumerations.
@@ -1176,12 +1179,12 @@
 static int
 tape_init (void)
 {
-	tape_dbf_area = debug_register ( "tape", 1, 2, 4*sizeof(long));
-	debug_register_view(tape_dbf_area, &debug_sprintf_view);
+	TAPE_DBF_AREA = debug_register ( "tape", 1, 2, 4*sizeof(long));
+	debug_register_view(TAPE_DBF_AREA, &debug_sprintf_view);
 #ifdef DBF_LIKE_HELL
-	debug_set_level(tape_dbf_area, 6);
+	debug_set_level(TAPE_DBF_AREA, 6);
 #endif
-	DBF_EVENT(3, "tape init: ($Revision: 1.49 $)\n");
+	DBF_EVENT(3, "tape init: ($Revision: 1.50 $)\n");
 	tape_proc_init();
 	tapechar_init ();
 	tapeblock_init ();
@@ -1200,19 +1203,18 @@
 	tapechar_exit();
 	tapeblock_exit();
 	tape_proc_cleanup();
-	debug_unregister (tape_dbf_area);
+	debug_unregister (TAPE_DBF_AREA);
 }
 
 MODULE_AUTHOR("(C) 2001 IBM Deutschland Entwicklung GmbH by Carsten Otte and "
 	      "Michael Holzheu (cotte@de.ibm.com,holzheu@de.ibm.com)");
 MODULE_DESCRIPTION("Linux on zSeries channel attached "
-		   "tape device driver ($Revision: 1.49 $)");
+		   "tape device driver ($Revision: 1.50 $)");
 MODULE_LICENSE("GPL");
 
 module_init(tape_init);
 module_exit(tape_exit);
 
-EXPORT_SYMBOL(tape_dbf_area);
 EXPORT_SYMBOL(tape_generic_remove);
 EXPORT_SYMBOL(tape_generic_probe);
 EXPORT_SYMBOL(tape_generic_online);
diff -urN linux-2.6/drivers/s390/char/tape_proc.c linux-2.6-s390/drivers/s390/char/tape_proc.c
--- linux-2.6/drivers/s390/char/tape_proc.c	Mon May 10 04:32:28 2004
+++ linux-2.6-s390/drivers/s390/char/tape_proc.c	Fri Jun 11 19:09:59 2004
@@ -16,6 +16,8 @@
 #include <linux/vmalloc.h>
 #include <linux/seq_file.h>
 
+#define TAPE_DBF_AREA	tape_core_dbf
+
 #include "tape.h"
 
 #define PRINTK_HEADER "TAPE_PROC: "
diff -urN linux-2.6/drivers/s390/char/tape_std.c linux-2.6-s390/drivers/s390/char/tape_std.c
--- linux-2.6/drivers/s390/char/tape_std.c	Mon May 10 04:31:57 2004
+++ linux-2.6-s390/drivers/s390/char/tape_std.c	Fri Jun 11 19:09:59 2004
@@ -22,6 +22,8 @@
 #include <asm/ebcdic.h>
 #include <asm/tape390.h>
 
+#define TAPE_DBF_AREA	tape_core_dbf
+
 #include "tape.h"
 #include "tape_std.h"
 
