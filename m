Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266129AbUFWGow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUFWGow (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 02:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUFWGow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 02:44:52 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:16267 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266129AbUFWGkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 02:40:47 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC/RFT] PS/2 mouse resync for KVM users
Date: Wed, 23 Jun 2004 01:40:43 -0500
User-Agent: KMail/1.6.2
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406230140.45383.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My last attempt to fix resync problem for KVM users whise devices don't send
0xAA 0x00 but resetting mouse into bare PS/2 mode when switching was clearly
bogus, so here is a new version. It tries to do:

- strict PS/2 protocol checking (controlled by psmouse.strict option, turned
  on by default in this patch)

- flag "suspect" packets - 1st bytes with overflow bits set and bytes that
  indicate that Left + Middle or Right + Middle  buttons are pressed at the
  same time which is unusial combination. Suspect packets, together with
  timeouts, are treated as "soft" errors.

- use rate limiting algorithm to detect whether reconnect request should be
  ussued. psmouse.resetafter now accepts 2 values:
	psmouse.resetafter=<limit>,<burst>
  <limit> controls hard error limit, if psmouse detects so many hard errors
  in row it will issue reconnect.
  <burst> controls how many errors (both hard and soft) is considered too
  much if they come within 1 second of each other when they are mixed with
  packets that are considered ok.
  Default values for now are 10,20.

Having {Left|Right} + Middle button combination considered "suspect" also
allows to force reconnect by holding these buttong and moving mouse quickly.

Please let me know if you are having problems using KVM and if the patch
makes any improvements.

Thanks.

-- 
Dmitry

diff -urN 2.6.7/drivers/input/mouse/psmouse-base.c linux-2.6.7/drivers/input/mouse/psmouse-base.c
--- 2.6.7/drivers/input/mouse/psmouse-base.c	2004-06-22 01:23:15.000000000 -0500
+++ linux-2.6.7/drivers/input/mouse/psmouse-base.c	2004-06-23 01:23:19.000000000 -0500
@@ -43,9 +43,14 @@
 module_param_named(smartscroll, psmouse_smartscroll, bool, 0);
 MODULE_PARM_DESC(smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
 
-static unsigned int psmouse_resetafter;
-module_param_named(resetafter, psmouse_resetafter, uint, 0);
-MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets (0 = never).");
+static unsigned int psmouse_strict = 1;
+module_param_named(strict, psmouse_strict, bool, 0);
+MODULE_PARM_DESC(strict, "Strict PS/2 protocol enforcement.");
+
+static unsigned int psmouse_resetafter[] = { 10, 20 };
+static unsigned int psmouse_resetafter_nargs;
+module_param_array_named(resetafter, psmouse_resetafter, uint, psmouse_resetafter_nargs, 0);
+MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets <limit, burst> (0 = never).");
 
 __obsolete_setup("psmouse_noext");
 __obsolete_setup("psmouse_resolution=");
@@ -65,11 +70,49 @@
 	struct input_dev *dev = &psmouse->dev;
 	unsigned char *packet = psmouse->packet;
 
+	if (psmouse->pktcnt == 1) {
+/*
+ * If go by the letter of PS/2 protcol 4th bit in 1st byte should always be set.
+ */
+		if (psmouse_strict && !(packet[0] & 0x08))
+			return PSMOUSE_BAD_DATA;
+
+/*
+ * Overflows should happen rarely.
+ */
+		if (packet[0] & 0xc0)
+			return PSMOUSE_SUSPECT_DATA;
+
+/*
+ * Having left or right button together with middle is somewhat unusual.
+ */
+		if ((packet[0] & 0x07) > 4)
+			return PSMOUSE_SUSPECT_DATA;
+	}
+
 	if (psmouse->pktcnt < 3 + (psmouse->type >= PSMOUSE_GENPS))
 		return PSMOUSE_GOOD_DATA;
 
 /*
- * Full packet accumulated, process it
+ * Full packet accumulated, do final validation
+ */
+	if (psmouse_strict) {
+/*
+ * Explorer PS/2 protocol specifies that 2 most significant bits in 4th
+ * byte should be 0
+ */
+		if (psmouse->type == PSMOUSE_IMEX && (packet[3] & 0xc0))
+			return PSMOUSE_BAD_DATA;
+/*
+ * Intellimouse PS/2 protocol specifies that z4 to z8 should be the same
+ */
+		if (psmouse->type == PSMOUSE_IMPS &&
+		    (packet[3] & 0xf8) != 0xf8 && (packet[3] & 0xf8) != 0x00)
+			return PSMOUSE_BAD_DATA;
+	}
+
+/*
+ * Now process the packet
  */
 
 	input_regs(dev, regs);
@@ -123,6 +166,26 @@
 	return PSMOUSE_FULL_PACKET;
 }
 
+static int psmouse_check_resync(struct psmouse *psmouse)
+{
+	int now = jiffies;
+
+	psmouse->err_toks += now - psmouse->last_error;
+	psmouse->last_error = now;
+	if (psmouse->err_toks > psmouse->err_limit_burst * PSMOUSE_ERRLIMIT_JIFFIES)
+		psmouse->err_toks = psmouse->err_limit_burst * PSMOUSE_ERRLIMIT_JIFFIES;
+	if ((psmouse->err_limit_burst && psmouse->err_toks < PSMOUSE_ERRLIMIT_JIFFIES) ||
+	    (psmouse->err_limit_hard && psmouse->out_of_sync == psmouse->err_limit_hard)) {
+		psmouse->state = PSMOUSE_IGNORE;
+		printk(KERN_NOTICE "psmouse.c: %s on %s reports too many errors, issuing reconnect request\n",
+			psmouse->name, psmouse->serio->phys);
+		serio_reconnect(psmouse->serio);
+		return 1;
+	}
+	psmouse->err_toks -= PSMOUSE_ERRLIMIT_JIFFIES;
+	return 0;
+}
+
 /*
  * psmouse_interrupt() handles incoming characters, either gathering them into
  * packets or passing them to the command routine as command output.
@@ -178,6 +241,8 @@
 		printk(KERN_WARNING "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
 		       psmouse->name, psmouse->phys, psmouse->pktcnt);
 		psmouse->pktcnt = 0;
+		if (psmouse_check_resync(psmouse))
+			goto out;
 	}
 
 	psmouse->last = jiffies;
@@ -210,12 +275,13 @@
 			printk(KERN_WARNING "psmouse.c: %s at %s lost sync at byte %d\n",
 				psmouse->name, psmouse->phys, psmouse->pktcnt);
 			psmouse->pktcnt = 0;
+			psmouse->out_of_sync++;
+			psmouse_check_resync(psmouse);
 
-			if (++psmouse->out_of_sync == psmouse_resetafter) {
-				psmouse->state = PSMOUSE_IGNORE;
-				printk(KERN_NOTICE "psmouse.c: issuing reconnect request\n");
-				serio_reconnect(psmouse->serio);
-			}
+			break;
+
+		case PSMOUSE_SUSPECT_DATA:
+			psmouse_check_resync(psmouse);
 			break;
 
 		case PSMOUSE_FULL_PACKET:
@@ -707,6 +773,9 @@
 	psmouse->dev.id.product = psmouse->type;
 	psmouse->dev.id.version = psmouse->model;
 
+	psmouse->err_limit_hard = psmouse_resetafter[0];
+	psmouse->err_limit_burst = psmouse_resetafter[1];
+
 	input_register_device(&psmouse->dev);
 
 	printk(KERN_INFO "input: %s on %s\n", psmouse->devname, serio->phys);
diff -urN 2.6.7/drivers/input/mouse/psmouse.h linux-2.6.7/drivers/input/mouse/psmouse.h
--- 2.6.7/drivers/input/mouse/psmouse.h	2004-06-22 01:23:15.000000000 -0500
+++ linux-2.6.7/drivers/input/mouse/psmouse.h	2004-06-23 01:23:19.000000000 -0500
@@ -22,9 +22,12 @@
 #define PSMOUSE_ACTIVATED	1
 #define PSMOUSE_IGNORE		2
 
+#define PSMOUSE_ERRLIMIT_JIFFIES	(1 * HZ)
+
 /* psmouse protocol handler return codes */
 typedef enum {
 	PSMOUSE_BAD_DATA,
+	PSMOUSE_SUSPECT_DATA,
 	PSMOUSE_GOOD_DATA,
 	PSMOUSE_FULL_PACKET
 } psmouse_ret_t;
@@ -52,7 +55,6 @@
 	unsigned char type;
 	unsigned char model;
 	unsigned long last;
-	unsigned long out_of_sync;
 	unsigned char state;
 	char acking;
 	volatile char ack;
@@ -60,6 +62,13 @@
 	char devname[64];
 	char phys[32];
 
+	/* resync handling */
+	unsigned long err_limit_hard;
+	unsigned long err_limit_burst;
+	unsigned long out_of_sync;
+	unsigned long err_toks;
+	unsigned long last_error;
+
 	psmouse_ret_t (*protocol_handler)(struct psmouse *psmouse, struct pt_regs *regs); 
 	int (*reconnect)(struct psmouse *psmouse);
 	void (*disconnect)(struct psmouse *psmouse);
