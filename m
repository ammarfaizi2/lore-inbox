Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTEVX0q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 19:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTEVX0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 19:26:46 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:8080 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263407AbTEVX0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 19:26:41 -0400
Date: Thu, 22 May 2003 19:39:45 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Subject: Re: Patch to add SysRq handling to 3270 console
Message-ID: <20030522193945.A18444@devserv.devel.redhat.com>
References: <20030522225014$1daf@gated-at.bofh.it> <200305222316.h4MNGk8H004738@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305222316.h4MNGk8H004738@post.webmailer.de>; from arnd@arndb.de on Fri, May 23, 2003 at 01:12:20AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Arnd Bergmann <arnd@arndb.de>
> Date: Fri, 23 May 2003 01:12:20 +0200

> [...] Do you have a tested backport for 2.4.2x? If
> so, we could merge it for the z990 code drop.

It's attached to RH bug #91338. I append it to this mail.
I use 2.4.21-rc2-ac2, because pure Marcelo tree does not have
a recent s390 codebase. He has the old "char *ctrlchar_handle()"
still, and the patch won't apply.

-- Pete

diff -urN -X dontdiff linux-2.4.21-rc2-ac2/arch/s390/kernel/s390_ksyms.c linux-2.4.21-rc2-ac2-s390/arch/s390/kernel/s390_ksyms.c
--- linux-2.4.21-rc2-ac2/arch/s390/kernel/s390_ksyms.c	2003-05-16 18:07:35.000000000 -0700
+++ linux-2.4.21-rc2-ac2-s390/arch/s390/kernel/s390_ksyms.c	2003-05-22 13:55:52.000000000 -0700
@@ -10,6 +10,7 @@
 #include <asm/delay.h>
 #include <asm/setup.h>
 #include <asm/softirq.h>
+#include <asm/ctrlchar.h>
 #if CONFIG_IP_MULTICAST
 #include <net/arp.h>
 #endif
@@ -62,3 +63,5 @@
 EXPORT_SYMBOL(console_device);
 EXPORT_SYMBOL(pfix_table);
 EXPORT_SYMBOL_NOVERS(do_call_softirq);
+EXPORT_SYMBOL(ctrlchar_init);
+EXPORT_SYMBOL(ctrlchar_handle);
diff -urN -X dontdiff linux-2.4.21-rc2-ac2/arch/s390x/kernel/s390_ksyms.c linux-2.4.21-rc2-ac2-s390/arch/s390x/kernel/s390_ksyms.c
--- linux-2.4.21-rc2-ac2/arch/s390x/kernel/s390_ksyms.c	2003-05-21 18:11:37.000000000 -0700
+++ linux-2.4.21-rc2-ac2-s390/arch/s390x/kernel/s390_ksyms.c	2003-05-22 16:31:25.000000000 -0700
@@ -13,6 +13,7 @@
 #include <asm/pgalloc.h>
 #include <asm/setup.h>
 #include <asm/softirq.h>
+#include <asm/ctrlchar.h>
 #if CONFIG_IP_MULTICAST
 #include <net/arp.h>
 #endif
@@ -86,3 +87,5 @@
 EXPORT_SYMBOL(console_device);
 EXPORT_SYMBOL(pfix_table);
 EXPORT_SYMBOL_NOVERS(do_call_softirq);
+EXPORT_SYMBOL(ctrlchar_init);
+EXPORT_SYMBOL(ctrlchar_handle);
diff -urN -X dontdiff linux-2.4.21-rc2-ac2/drivers/s390/char/con3215.c linux-2.4.21-rc2-ac2-s390/drivers/s390/char/con3215.c
--- linux-2.4.21-rc2-ac2/drivers/s390/char/con3215.c	2003-05-21 18:11:57.000000000 -0700
+++ linux-2.4.21-rc2-ac2-s390/drivers/s390/char/con3215.c	2003-05-22 13:52:07.000000000 -0700
@@ -31,8 +31,7 @@
 #include <asm/cpcmd.h>
 #include <asm/irq.h>
 #include <asm/setup.h>
-
-#include "ctrlchar.h"
+#include <asm/ctrlchar.h>
 
 #define NR_3215		    1
 #define NR_3215_REQ	    (4*NR_3215)
@@ -474,7 +473,7 @@
 			if (count >= TTY_FLIPBUF_SIZE - tty->flip.count)
 				count = TTY_FLIPBUF_SIZE - tty->flip.count - 1;
 			EBCASC(raw->inbuf, count);
-			cchar = ctrlchar_handle(raw->inbuf, count, tty);
+			cchar = ctrlchar_handle(raw->inbuf, count, tty, 1);
 			switch (cchar & CTRLCHAR_MASK) {
 			case CTRLCHAR_SYSRQ:
 				break;
diff -urN -X dontdiff linux-2.4.21-rc2-ac2/drivers/s390/char/ctrlchar.c linux-2.4.21-rc2-ac2-s390/drivers/s390/char/ctrlchar.c
--- linux-2.4.21-rc2-ac2/drivers/s390/char/ctrlchar.c	2003-05-21 18:11:57.000000000 -0700
+++ linux-2.4.21-rc2-ac2-s390/drivers/s390/char/ctrlchar.c	2003-05-22 13:52:07.000000000 -0700
@@ -13,7 +13,7 @@
 #include <linux/ctype.h>
 #include <linux/interrupt.h>
 
-#include "ctrlchar.h"
+#include <asm/ctrlchar.h>
 
 #ifdef CONFIG_MAGIC_SYSRQ
 static int ctrlchar_sysrq_key;
@@ -52,7 +52,8 @@
  *         with CTRLCHAR_CTRL
  */
 unsigned int
-ctrlchar_handle(const unsigned char *buf, int len, struct tty_struct *tty)
+ctrlchar_handle(const unsigned char *buf, int len, struct tty_struct *tty,
+    int is_console)
 {
 	if ((len < 2) || (len > 3))
 		return CTRLCHAR_NONE;
@@ -64,7 +65,7 @@
 
 #ifdef CONFIG_MAGIC_SYSRQ
 	/* racy */
-	if (len == 3 && buf[1] == '-') {
+	if (is_console && len == 3 && buf[1] == '-') {
 		ctrlchar_sysrq_key = buf[2];
 		ctrlchar_tq.data = tty;
 		queue_task(&ctrlchar_tq, &tq_immediate);
diff -urN -X dontdiff linux-2.4.21-rc2-ac2/drivers/s390/char/ctrlchar.h linux-2.4.21-rc2-ac2-s390/drivers/s390/char/ctrlchar.h
--- linux-2.4.21-rc2-ac2/drivers/s390/char/ctrlchar.h	2003-05-21 18:11:57.000000000 -0700
+++ linux-2.4.21-rc2-ac2-s390/drivers/s390/char/ctrlchar.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,21 +0,0 @@
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
-extern void ctrlchar_init(void);
-
-
-#define CTRLCHAR_NONE  (1 << 8)
-#define CTRLCHAR_CTRL  (2 << 8)
-#define CTRLCHAR_SYSRQ (3 << 8)
-
-#define CTRLCHAR_MASK (~0xffu)
diff -urN -X dontdiff linux-2.4.21-rc2-ac2/drivers/s390/char/sclp_tty.c linux-2.4.21-rc2-ac2-s390/drivers/s390/char/sclp_tty.c
--- linux-2.4.21-rc2-ac2/drivers/s390/char/sclp_tty.c	2003-05-21 18:11:57.000000000 -0700
+++ linux-2.4.21-rc2-ac2-s390/drivers/s390/char/sclp_tty.c	2003-05-22 13:52:07.000000000 -0700
@@ -17,8 +17,8 @@
 #include <linux/wait.h>
 #include <linux/slab.h>
 #include <asm/uaccess.h>
+#include <asm/ctrlchar.h>
 
-#include "ctrlchar.h"
 #include "sclp.h"
 #include "sclp_rw.h"
 #include "sclp_tty.h"
@@ -485,7 +485,7 @@
 	 */
 	if (sclp_tty == NULL)
 		return;
-	cchar = ctrlchar_handle(buf, count, sclp_tty);
+	cchar = ctrlchar_handle(buf, count, sclp_tty, 1);
 	switch (cchar & CTRLCHAR_MASK) {
 	case CTRLCHAR_SYSRQ:
 		break;
diff -urN -X dontdiff linux-2.4.21-rc2-ac2/drivers/s390/char/tubtty.c linux-2.4.21-rc2-ac2-s390/drivers/s390/char/tubtty.c
--- linux-2.4.21-rc2-ac2/drivers/s390/char/tubtty.c	2002-12-06 18:07:10.000000000 -0800
+++ linux-2.4.21-rc2-ac2-s390/drivers/s390/char/tubtty.c	2003-05-22 13:52:07.000000000 -0700
@@ -10,6 +10,7 @@
  *  Author:  Richard Hitt
  */
 #include <linux/config.h>
+#include <asm/ctrlchar.h>
 #include "tubio.h"
 
 /* Initialization & uninitialization for tubtty */
@@ -118,6 +119,8 @@
 	td->read_proc = tty3270_read_proc;
 	td->write_proc = tty3270_write_proc;
 
+	ctrlchar_init();
+
 	rc = tty_register_driver(td);
 	if (rc) {
 		printk(KERN_ERR "tty3270 registration failed with %d\n", rc);
@@ -875,23 +878,22 @@
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
diff -urN -X dontdiff linux-2.4.21-rc2-ac2/include/asm-s390/ctrlchar.h linux-2.4.21-rc2-ac2-s390/include/asm-s390/ctrlchar.h
--- linux-2.4.21-rc2-ac2/include/asm-s390/ctrlchar.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.4.21-rc2-ac2-s390/include/asm-s390/ctrlchar.h	2003-05-22 13:52:07.000000000 -0700
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
diff -urN -X dontdiff linux-2.4.21-rc2-ac2/include/asm-s390x/ctrlchar.h linux-2.4.21-rc2-ac2-s390/include/asm-s390x/ctrlchar.h
--- linux-2.4.21-rc2-ac2/include/asm-s390x/ctrlchar.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.4.21-rc2-ac2-s390/include/asm-s390x/ctrlchar.h	2003-05-22 16:31:25.000000000 -0700
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
