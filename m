Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbTJFSCG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbTJFSCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:02:05 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:27072 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264044AbTJFSBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:01:42 -0400
Date: Mon, 6 Oct 2003 14:01:39 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: s390 test6 patches: descriptions.
Message-ID: <20031006140139.C16665@devserv.devel.redhat.com>
References: <mailman.1065432601.831.linux-kernel2news@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <mailman.1065432601.831.linux-kernel2news@redhat.com>; from schwidefsky@de.ibm.com on Mon, Oct 06, 2003 at 11:23:52AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My unified sysrq patch is missing.

Also, why is the tub driver not being updated? This is an issue
because passwords are visible on 3215 and there is NO WAY
around it, except TERM CONMODE 3270 and then using tub.
I seem to remember promises about New Super-Duper Improved
and Clean tub, but it's nowhere to be seen, so meanwhile it
should not be too hard to keep old tub operating. You don't
even have to do anything. Just use your maintainer powers to
refuse "cleaups" like the devstat removal unless they fix all
in-tree drivers for related breakage. Then contributors will
have to fix it.

-- Pete

diff -urN -X dontdiff linux-2.6.0-test6/arch/s390/kernel/s390_ksyms.c linux-2.6.0-test6-s390/arch/s390/kernel/s390_ksyms.c
--- linux-2.6.0-test6/arch/s390/kernel/s390_ksyms.c	2003-07-13 20:35:15.000000000 -0700
+++ linux-2.6.0-test6-s390/arch/s390/kernel/s390_ksyms.c	2003-10-06 10:43:51.000000000 -0700
@@ -13,6 +13,7 @@
 #include <asm/delay.h>
 #include <asm/pgalloc.h>
 #include <asm/setup.h>
+#include <asm/ctrlchar.h>
 #ifdef CONFIG_IP_MULTICAST
 #include <net/arp.h>
 #endif
@@ -72,3 +73,4 @@
 EXPORT_SYMBOL(console_device);
 EXPORT_SYMBOL_NOVERS(do_call_softirq);
 EXPORT_SYMBOL(sys_wait4);
+EXPORT_SYMBOL(ctrlchar_handle);
diff -urN -X dontdiff linux-2.6.0-test6/drivers/s390/char/con3215.c linux-2.6.0-test6-s390/drivers/s390/char/con3215.c
--- linux-2.6.0-test6/drivers/s390/char/con3215.c	2003-07-13 20:36:32.000000000 -0700
+++ linux-2.6.0-test6-s390/drivers/s390/char/con3215.c	2003-10-06 09:08:51.000000000 -0700
@@ -32,8 +32,7 @@
 #include <asm/delay.h>
 #include <asm/cpcmd.h>
 #include <asm/setup.h>
-
-#include "ctrlchar.h"
+#include <asm/ctrlchar.h>
 
 #define NR_3215		    1
 #define NR_3215_REQ	    (4*NR_3215)
@@ -437,7 +436,7 @@
 			if (count >= TTY_FLIPBUF_SIZE - tty->flip.count)
 				count = TTY_FLIPBUF_SIZE - tty->flip.count - 1;
 			EBCASC(raw->inbuf, count);
-			cchar = ctrlchar_handle(raw->inbuf, count, tty);
+			cchar = ctrlchar_handle(raw->inbuf, count, tty, 1);
 			switch (cchar & CTRLCHAR_MASK) {
 			case CTRLCHAR_SYSRQ:
 				break;
diff -urN -X dontdiff linux-2.6.0-test6/drivers/s390/char/ctrlchar.c linux-2.6.0-test6-s390/drivers/s390/char/ctrlchar.c
--- linux-2.6.0-test6/drivers/s390/char/ctrlchar.c	2003-07-13 20:39:23.000000000 -0700
+++ linux-2.6.0-test6-s390/drivers/s390/char/ctrlchar.c	2003-10-06 09:59:59.000000000 -0700
@@ -13,9 +13,12 @@
 #include <linux/sysrq.h>
 #include <linux/ctype.h>
 
-#include "ctrlchar.h"
+#include <asm/ctrlchar.h>
 
 #ifdef CONFIG_MAGIC_SYSRQ
+#include <linux/workqueue.h>
+#include <linux/tty.h>
+
 static int ctrlchar_sysrq_key;
 
 static void
@@ -40,7 +43,8 @@
  *         with CTRLCHAR_CTRL
  */
 unsigned int
-ctrlchar_handle(const unsigned char *buf, int len, struct tty_struct *tty)
+ctrlchar_handle(const unsigned char *buf, int len, struct tty_struct *tty,
+    int is_console)
 {
 	if ((len < 2) || (len > 3))
 		return CTRLCHAR_NONE;
@@ -52,7 +56,7 @@
 
 #ifdef CONFIG_MAGIC_SYSRQ
 	/* racy */
-	if (len == 3 && buf[1] == '-') {
+	if (is_console && len == 3 && buf[1] == '-') {
 		ctrlchar_sysrq_key = buf[2];
 		ctrlchar_work.data = tty;
 		schedule_work(&ctrlchar_work);
diff -urN -X dontdiff linux-2.6.0-test6/drivers/s390/char/ctrlchar.h linux-2.6.0-test6-s390/drivers/s390/char/ctrlchar.h
--- linux-2.6.0-test6/drivers/s390/char/ctrlchar.h	2003-07-13 20:38:44.000000000 -0700
+++ linux-2.6.0-test6-s390/drivers/s390/char/ctrlchar.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,20 +0,0 @@
-/*
- *  drivers/s390/char/ctrlchar.c
- *  Unified handling of special chars.
- *
- *    Copyright (C) 2001 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Fritz Elfert <felfert@millenux.com> <elfert@de.ibm.com>
- *
- */
-
-#include <linux/tty.h>
-
-extern unsigned int
-ctrlchar_handle(const unsigned char *buf, int len, struct tty_struct *tty);
-
-
-#define CTRLCHAR_NONE  (1 << 8)
-#define CTRLCHAR_CTRL  (2 << 8)
-#define CTRLCHAR_SYSRQ (3 << 8)
-
-#define CTRLCHAR_MASK (~0xffu)
diff -urN -X dontdiff linux-2.6.0-test6/drivers/s390/char/sclp_tty.c linux-2.6.0-test6-s390/drivers/s390/char/sclp_tty.c
--- linux-2.6.0-test6/drivers/s390/char/sclp_tty.c	2003-10-01 15:17:51.000000000 -0700
+++ linux-2.6.0-test6-s390/drivers/s390/char/sclp_tty.c	2003-10-06 09:08:51.000000000 -0700
@@ -19,8 +19,8 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
+#include <asm/ctrlchar.h>
 
-#include "ctrlchar.h"
 #include "sclp.h"
 #include "sclp_rw.h"
 #include "sclp_tty.h"
@@ -483,7 +483,7 @@
 	 */
 	if (sclp_tty == NULL)
 		return;
-	cchar = ctrlchar_handle(buf, count, sclp_tty);
+	cchar = ctrlchar_handle(buf, count, sclp_tty, 1);
 	switch (cchar & CTRLCHAR_MASK) {
 	case CTRLCHAR_SYSRQ:
 		break;
diff -urN -X dontdiff linux-2.6.0-test6/drivers/s390/char/tubtty.c linux-2.6.0-test6-s390/drivers/s390/char/tubtty.c
--- linux-2.6.0-test6/drivers/s390/char/tubtty.c	2003-07-13 20:37:17.000000000 -0700
+++ linux-2.6.0-test6-s390/drivers/s390/char/tubtty.c	2003-10-06 10:28:07.000000000 -0700
@@ -10,6 +10,7 @@
  *  Author:  Richard Hitt
  */
 #include <linux/config.h>
+#include <asm/ctrlchar.h>
 #include "tubio.h"
 
 /* Initialization & uninitialization for tubtty */
@@ -812,23 +813,22 @@
 {
 	struct tty_struct *tty;
 	int func = -1;
+	int is_console = 0;
+	unsigned int cchar;
 
 	if ((tty = tubp->tty) == NULL)
 		return;
 	if (count < 0)
 		return;
-	if (count == 2 && (cp[0] == '^' || cp[0] == '\252')) {
-		switch(cp[1]) {
-		case 'c':  case 'C':
-			func = INTR_CHAR(tty);
-			break;
-		case 'd':  case 'D':
-			func = EOF_CHAR(tty);
-			break;
-		case 'z':  case 'Z':
-			func = SUSP_CHAR(tty);
-			break;
-		}
+#ifdef CONFIG_TN3270_CONSOLE
+	if (CONSOLE_IS_3270 && tub3270_con_tubp == tubp)
+		is_console = 1;
+#endif
+	cchar = ctrlchar_handle(cp, count, tty, is_console);
+	if ((cchar & CTRLCHAR_MASK) != CTRLCHAR_NONE) {
+		if ((cchar & CTRLCHAR_MASK) != CTRLCHAR_CTRL)
+			return;
+		func = cchar & 0xFF;
 	} else if (count == 2 && cp[0] == 0x1b) {        /* if ESC */
 		int inc = 0;
 		char buf[GEOM_INPLEN + 1];
diff -urN -X dontdiff linux-2.6.0-test6/include/asm-s390/ctrlchar.h linux-2.6.0-test6-s390/include/asm-s390/ctrlchar.h
--- linux-2.6.0-test6/include/asm-s390/ctrlchar.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.0-test6-s390/include/asm-s390/ctrlchar.h	2003-10-06 09:08:52.000000000 -0700
@@ -0,0 +1,20 @@
+/*
+ *  Implemented in drivers/s390/char/ctrlchar.c
+ *  Unified handling of special chars.
+ *
+ *    Copyright (C) 2001 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Fritz Elfert <felfert@millenux.com> <elfert@de.ibm.com>
+ *
+ */
+
+struct tty_struct;
+
+extern unsigned int ctrlchar_handle(const unsigned char *buf, int len,
+    struct tty_struct *tty, int is_console);
+extern void ctrlchar_init(void);
+
+#define CTRLCHAR_CTRL  (0 << 8)
+#define CTRLCHAR_NONE  (1 << 8)
+#define CTRLCHAR_SYSRQ (2 << 8)
+
+#define CTRLCHAR_MASK (~0xffu)
