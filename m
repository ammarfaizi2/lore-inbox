Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277106AbRJHTxY>; Mon, 8 Oct 2001 15:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277112AbRJHTxP>; Mon, 8 Oct 2001 15:53:15 -0400
Received: from atlas15.dnp.fmph.uniba.sk ([158.195.25.215]:24964 "EHLO
	melkor.dnp.fmph.uniba.sk") by vger.kernel.org with ESMTP
	id <S277106AbRJHTw5>; Mon, 8 Oct 2001 15:52:57 -0400
Date: Mon, 8 Oct 2001 21:53:13 +0200
From: Radovan Garabik <garabik@melkor.dnp.fmph.uniba.sk>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] dead keys in unicode console mode
Message-ID: <20011008215313.A11879@melkor.dnp.fmph.uniba.sk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

FWIW, this little patch makes it possible to
use dead keys in unicode console mode.
It is against 2.4.10, but should apply cleanly in
broader range of kernel versions.

-- 
 -----------------------------------------------------------
| Radovan Garabik http://melkor.dnp.fmph.uniba.sk/~garabik/ |
| __..--^^^--..__    garabik @ melkor.dnp.fmph.uniba.sk     |
 -----------------------------------------------------------
Antivirus alert: file .signature infected by signature virus.
Hi! I'm a signature virus! Copy me into your signature file to help me spread!

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dead_keys.patch"

diff -Nurd linux.orig/drivers/char/keyboard.c linux/drivers/char/keyboard.c
--- linux.orig/drivers/char/keyboard.c	Tue Sep 18 22:39:51 2001
+++ linux/drivers/char/keyboard.c	Mon Oct  8 21:39:02 2001
@@ -151,7 +151,7 @@
 
 /* N.B. drivers/macintosh/mac_keyb.c needs to call put_queue */
 void put_queue(int);
-static unsigned char handle_diacr(unsigned char);
+static ushort handle_diacr(unsigned char);
 
 /* kbd_pt_regs - set by keyboard_interrupt(), used by show_ptregs() */
 struct pt_regs * kbd_pt_regs;
@@ -541,12 +541,24 @@
 
 static void do_self(unsigned char value, char up_flag)
 {
+        ushort v;
 	if (up_flag)
 		return;		/* no action, if this is a key release */
 
-	if (diacr)
-		value = handle_diacr(value);
-
+	if (diacr) {
+                v = handle_diacr(value);
+                if (kbd->kbdmode == VC_UNICODE) {
+                        to_utf8(v & 0xFFFF);
+                        return;
+                }
+            
+                /* 
+                 * this makes at least latin-1 compose chars work 
+                 * even when using unicode keymap in non-unicode mode
+		 */
+		value = v & 0xFF; 
+        
+        }
 	if (dead_key_next) {
 		dead_key_next = 0;
 		diacr = value;
@@ -582,18 +594,18 @@
 	if (up_flag)
 		return;
 
-	diacr = (diacr ? handle_diacr(value) : value);
+	diacr = (diacr ? (handle_diacr(value) & 0xFF) : value);
 }
 
 
 /*
  * We have a combining character DIACR here, followed by the character CH.
- * If the combination occurs in the table, return the corresponding value.
+ * If the combination occurs in the table, return the corresponding UCS2 value.
  * Otherwise, if CH is a space or equals DIACR, return DIACR.
  * Otherwise, conclude that DIACR was not combining after all,
  * queue it and return CH.
  */
-unsigned char handle_diacr(unsigned char ch)
+ushort handle_diacr(unsigned char ch)
 {
 	int d = diacr;
 	int i;
diff -Nurd linux.orig/include/linux/kd.h linux/include/linux/kd.h
--- linux.orig/include/linux/kd.h	Sun Sep 23 19:31:01 2001
+++ linux/include/linux/kd.h	Mon Oct  8 21:39:02 2001
@@ -115,7 +115,8 @@
 #define KDSKBSENT	0x4B49	/* sets one function key string entry */
 
 struct kbdiacr {
-        unsigned char diacr, base, result;
+        unsigned char diacr, base;
+        unsigned short int result; /* holds UCS2 value */
 };
 struct kbdiacrs {
         unsigned int kb_cnt;    /* number of entries in following array */

--x+6KMIRAuhnl3hBn--
