Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261849AbSJDOmU>; Fri, 4 Oct 2002 10:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261867AbSJDOkX>; Fri, 4 Oct 2002 10:40:23 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:27570 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S261849AbSJDOh0> convert rfc822-to-8bit; Fri, 4 Oct 2002 10:37:26 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.40 s390 (27/27): control characters.
Date: Fri, 4 Oct 2002 16:40:51 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210041636.58833.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace IMMEDIATE_BH bottom half by tasklets in helper functions for
console control characters. Fix a race condition and make it look nicer.

diff -urN linux-2.5.40/drivers/s390/char/con3215.c linux-2.5.40-s390/drivers/s390/char/con3215.c
--- linux-2.5.40/drivers/s390/char/con3215.c	Fri Oct  4 16:16:50 2002
+++ linux-2.5.40-s390/drivers/s390/char/con3215.c	Fri Oct  4 16:17:01 2002
@@ -455,7 +455,7 @@
                 if ((raw = req->info) == NULL)
                         return;              /* That shouldn't happen ... */
 		if (req->type == RAW3215_READ && raw->tty != NULL) {
-			char *cchar;
+			unsigned int cchar;
 
 			tty = raw->tty;
                         count = 160 - req->residual;
@@ -467,14 +467,19 @@
 			if (count >= TTY_FLIPBUF_SIZE - tty->flip.count)
 				count = TTY_FLIPBUF_SIZE - tty->flip.count - 1;
 			EBCASC(raw->inbuf, count);
-			if ((cchar = ctrlchar_handle(raw->inbuf, count, tty))) {
-				if (cchar == (char *)-1)
-					goto in_out;
+			cchar = ctrlchar_handle(raw->inbuf, count, tty);
+			switch (cchar & CTRLCHAR_MASK) {
+			case CTRLCHAR_SYSRQ:
+				break;
+
+			case CTRLCHAR_CTRL:
 				tty->flip.count++;
 				*tty->flip.flag_buf_ptr++ = TTY_NORMAL;
-				*tty->flip.char_buf_ptr++ = *cchar;
+				*tty->flip.char_buf_ptr++ = cchar;
 				tty_flip_buffer_push(raw->tty);
-			} else {
+				break;
+
+			case CTRLCHAR_NONE:
 				memcpy(tty->flip.char_buf_ptr,
 				       raw->inbuf, count);
 				if (count < 2 ||
@@ -491,12 +496,13 @@
 				tty->flip.flag_buf_ptr += count;
 				tty->flip.count += count;
 				tty_flip_buffer_push(raw->tty);
+				break;
 			}
 		} else if (req->type == RAW3215_WRITE) {
 			raw->count -= req->len;
                         raw->written -= req->len;
 		} 
-in_out:
+
 		raw->flags &= ~RAW3215_WORKING;
 		raw3215_free_req(req);
 		/* check for empty wait */
@@ -1095,8 +1101,6 @@
 		raw3215_freelist = req;
 	}
 
-	ctrlchar_init();
-
 #ifdef CONFIG_TN3215_CONSOLE
         raw3215[0] = raw = (raw3215_info *)
                 alloc_bootmem_low(sizeof(raw3215_info));
diff -urN linux-2.5.40/drivers/s390/char/ctrlchar.c linux-2.5.40-s390/drivers/s390/char/ctrlchar.c
--- linux-2.5.40/drivers/s390/char/ctrlchar.c	Fri Oct  4 16:14:52 2002
+++ linux-2.5.40-s390/drivers/s390/char/ctrlchar.c	Fri Oct  4 16:17:01 2002
@@ -8,39 +8,27 @@
  */
 
 #include <linux/config.h>
-#include <linux/types.h>
-#include <linux/tty.h>
-#include <linux/interrupt.h>
-
+#include <linux/stddef.h>
 #include <linux/sysrq.h>
+#include <linux/ctype.h>
 
-#include <asm/io.h>
-#include <asm/uaccess.h>
-#include <asm/delay.h>
-#include <asm/cpcmd.h>
-#include <asm/irq.h>
+#include "ctrlchar.h"
 
 #ifdef CONFIG_MAGIC_SYSRQ
 static int ctrlchar_sysrq_key;
-static struct tq_struct ctrlchar_tq;
 
 static void
-ctrlchar_handle_sysrq(struct tty_struct *tty) {
+ctrlchar_handle_sysrq(void *tty)
+{
 	handle_sysrq(ctrlchar_sysrq_key, NULL, tty);
 }
-#endif
-
-void ctrlchar_init(void) {
-#ifdef CONFIG_MAGIC_SYSRQ
-	static int init_done = 0;
 
-	if (init_done++)
-		return;
-	INIT_LIST_HEAD(&ctrlchar_tq.list);
-	ctrlchar_tq.sync = 0;
-	ctrlchar_tq.routine = (void (*)(void *)) ctrlchar_handle_sysrq;
+static struct tq_struct ctrlchar_tq = {
+	.list = LIST_HEAD_INIT(ctrlchar_tq.list),
+	.routine = ctrlchar_handle_sysrq,
+};
 #endif
-}
+
 
 /**
  * Check for special chars at start of input.
@@ -48,49 +36,42 @@
  * @param buf Console input buffer.
  * @param len Length of valid data in buffer.
  * @param tty The tty struct for this console.
- * @return NULL, if nothing matched, (char *)-1, if buffer contents
- *         should be ignored, otherwise pointer to char to be inserted.
+ * @return CTRLCHAR_NONE, if nothing matched,
+ *         CTRLCHAR_SYSRQ, if sysrq was encountered
+ *         otherwise char to be inserted logically or'ed
+ *         with CTRLCHAR_CTRL
  */
-char *ctrlchar_handle(const char *buf, int len, struct tty_struct *tty) {
-
-	static char ret;
-
+unsigned int
+ctrlchar_handle(const char *buf, int len, struct tty_struct *tty)
+{
 	if ((len < 2) || (len > 3))
-		return NULL;
+		return CTRLCHAR_NONE;
+
 	/* hat is 0xb1 in codepage 037 (US etc.) and thus */
 	/* converted to 0x5e in ascii ('^') */
 	if ((buf[0] != '^') && (buf[0] != '\252'))
-		return NULL;
-	switch (buf[1]) {
+		return CTRLCHAR_NONE;
+
 #ifdef CONFIG_MAGIC_SYSRQ
-		case '-':
-			if (len == 3) {
-				ctrlchar_sysrq_key = buf[2];
-				ctrlchar_tq.data = tty;
-				queue_task(&ctrlchar_tq, &tq_immediate);
-				mark_bh(IMMEDIATE_BH);
-				return (char *)-1;
-			}
-			break;
+	/* racy */
+	if (len == 3 && buf[1] == '-') {
+		ctrlchar_sysrq_key = buf[2];
+		ctrlchar_tq.data = tty;
+		schedule_task(&ctrlchar_tq);
+		return CTRLCHAR_SYSRQ;
+	}
 #endif
-		case 'c':
-			if (len == 2) {
-				ret = INTR_CHAR(tty);
-				return &ret;
-			}
-			break;
-		case 'd':
-			if (len == 2) {
-				ret = EOF_CHAR(tty);
-				return &ret;
-			}
-			break;
-		case 'z':
-			if (len == 2) {
-				ret = SUSP_CHAR(tty);
-				return &ret;
-			}
-			break;
+
+	if (len != 2)
+		return CTRLCHAR_NONE;
+
+	switch (tolower(buf[1])) {
+	case 'c':
+		return INTR_CHAR(tty) | CTRLCHAR_CTRL;
+	case 'd':
+		return EOF_CHAR(tty)  | CTRLCHAR_CTRL;
+	case 'z':
+		return SUSP_CHAR(tty) | CTRLCHAR_CTRL;
 	}
-	return NULL;
+	return CTRLCHAR_NONE;
 }
diff -urN linux-2.5.40/drivers/s390/char/ctrlchar.h linux-2.5.40-s390/drivers/s390/char/ctrlchar.h
--- linux-2.5.40/drivers/s390/char/ctrlchar.h	Tue Oct  1 09:07:44 2002
+++ linux-2.5.40-s390/drivers/s390/char/ctrlchar.h	Fri Oct  4 16:17:01 2002
@@ -7,9 +7,14 @@
  *
  */
 
-#include <linux/config.h>
-#include <linux/types.h>
 #include <linux/tty.h>
 
-extern void ctrlchar_init(void);
-extern char *ctrlchar_handle(const char *buf, int len, struct tty_struct *tty);
+extern unsigned int
+ctrlchar_handle(const char *buf, int len, struct tty_struct *tty);
+
+
+#define CTRLCHAR_NONE  (1 << 8)
+#define CTRLCHAR_CTRL  (2 << 8)
+#define CTRLCHAR_SYSRQ (3 << 8)
+
+#define CTRLCHAR_MASK (~0xffu)
diff -urN linux-2.5.40/drivers/s390/char/hwc_tty.c linux-2.5.40-s390/drivers/s390/char/hwc_tty.c
--- linux-2.5.40/drivers/s390/char/hwc_tty.c	Tue Oct  1 09:06:30 2002
+++ linux-2.5.40-s390/drivers/s390/char/hwc_tty.c	Fri Oct  4 16:17:01 2002
@@ -188,15 +188,19 @@
 	struct tty_struct *tty = hwc_tty_data.tty;
 
 	if (tty != NULL) {
-		char *cchar;
-		if ((cchar = ctrlchar_handle (buf, count, tty))) {
-			if (cchar == (char *) -1)
-				return;
+		unsigned int cchar = ctrlchar_handle(buf, count, tty);
+
+		switch (cchar & CTRLCHAR_MASK) {
+		case CTRLCHAR_SYSRQ:
+			return;
+
+		case CTRLCHAR_CTRL:
 			tty->flip.count++;
 			*tty->flip.flag_buf_ptr++ = TTY_NORMAL;
-			*tty->flip.char_buf_ptr++ = *cchar;
-		} else {
+			*tty->flip.char_buf_ptr++ = cchar;
+			break;
 
+		case CTRLCHAR_NONE:
 			memcpy (tty->flip.char_buf_ptr, buf, count);
 			if (count < 2 || (
 					 strncmp (buf + count - 2, "^n", 2) ||
@@ -209,6 +213,7 @@
 			tty->flip.char_buf_ptr += count;
 			tty->flip.flag_buf_ptr += count;
 			tty->flip.count += count;
+			break;
 		}
 		tty_flip_buffer_push (tty);
 		hwc_tty_wake_up ();
@@ -221,8 +226,6 @@
 	if (!CONSOLE_IS_HWC)
 		return;
 
-	ctrlchar_init ();
-
 	memset (&hwc_tty_driver, 0, sizeof (struct tty_driver));
 	memset (&hwc_tty_data, 0, sizeof (hwc_tty_data_struct));
 	hwc_tty_driver.magic = TTY_DRIVER_MAGIC;

