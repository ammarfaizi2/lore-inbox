Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275811AbRJBDoc>; Mon, 1 Oct 2001 23:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275798AbRJBDoY>; Mon, 1 Oct 2001 23:44:24 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:59144 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S275811AbRJBDoO>; Mon, 1 Oct 2001 23:44:14 -0400
Date: Mon, 1 Oct 2001 23:44:37 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Stateful Magic Sysrq Key
Message-ID: <20011001234437.A10994@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following patch is a reworked patch which originated from Amazon.
It makes the sysrq key stateful, giving it the following behaviours:

A) If the magic key is pressed and held, every other key pressed will be
handled by the sysrq system. (This is the current behaviour).
B) If the magic key is pressed and released, the next key pressed will
be handled by the sysrq system.
C) If the magic key is pressed twice in series, it is passed through.

In addition, the patch allows registraiton of the the keycode which the
magic key lives on, through a proc entry.


This patch was developed to handle crappy KVM-alikes, which did one key
at a time, and had no SysRq key. However, it gives a good solution to a
common problem. Many keyboards are made cheaply, and do not support
having large numbers of keys pressed simultaneously, making the current
SysRq code almost useless on them.


There are two versions of the patch attached. One is for
linux-2.4.11-pre2, the other is for linux-2.4.10-ac3

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Description: patch-2.4.11-pre2-stateful_sysrq
Content-Disposition: attachment; filename="patch-2.4.11-pre2-stateful_sysrq.patch"

--- linux-2.4.11-pre2-stateful_sysrq/kernel/sysctl.c.stateful_sysrq	Mon Oct  1 23:13:44 2001
+++ linux-2.4.11-pre2-stateful_sysrq/kernel/sysctl.c	Mon Oct  1 23:23:58 2001
@@ -46,7 +46,7 @@
 extern int sysctl_overcommit_memory;
 extern int max_threads;
 extern int nr_queued_signals, max_queued_signals;
-extern int sysrq_enabled;
+extern struct sysrq_ctls_struct sysrq_ctls;
 extern int core_uses_pid;
 extern int cad_pid;
 
@@ -233,7 +233,9 @@
 	 0644, NULL, &proc_dointvec},
 #endif
 #ifdef CONFIG_MAGIC_SYSRQ
-	{KERN_SYSRQ, "sysrq", &sysrq_enabled, sizeof (int),
+	{KERN_SYSRQ, "sysrq", &sysrq_ctls.enabled, sizeof (int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_SYSRQ, "sysrq-key", &sysrq_ctls.keycode, sizeof (sysrq_ctls.keycode),
 	 0644, NULL, &proc_dointvec},
 #endif	 
 	{KERN_CADPID, "cad_pid", &cad_pid, sizeof (int),
--- linux-2.4.11-pre2-stateful_sysrq/include/linux/sysctl.h.stateful_sysrq	Mon Oct  1 23:13:44 2001
+++ linux-2.4.11-pre2-stateful_sysrq/include/linux/sysctl.h	Mon Oct  1 23:23:58 2001
@@ -106,7 +106,7 @@
 	KERN_MSGMAX=35,         /* int: Maximum size of a messege */
 	KERN_MSGMNB=36,         /* int: Maximum message queue size */
 	KERN_MSGPOOL=37,        /* int: Maximum system message pool size */
-	KERN_SYSRQ=38,		/* int: Sysreq enable */
+	KERN_SYSRQ=38,		/* struct: Sysreq enable, Sysreq keycode */
 	KERN_MAX_THREADS=39,	/* int: Maximum nr of threads in the system */
  	KERN_RANDOM=40,		/* Random driver */
  	KERN_SHMALL=41,		/* int: Maximum size of shared memory */
--- linux-2.4.11-pre2-stateful_sysrq/include/linux/sysrq.h.stateful_sysrq	Mon Oct  1 23:13:44 2001
+++ linux-2.4.11-pre2-stateful_sysrq/include/linux/sysrq.h	Mon Oct  1 23:23:58 2001
@@ -26,6 +26,12 @@
 
 #ifdef CONFIG_MAGIC_SYSRQ
 
+/*  sysrq_ctls - controls aspects of the SYSRQ magic key hack*/
+struct sysrq_ctls_struct {
+	int enabled;
+	int keycode;
+};
+
 /* Generic SysRq interface -- you may call it from any device driver, supplying
  * ASCII code of the key, pointer to registers and kbd/tty structs (if they
  * are available -- else NULL's).
--- linux-2.4.11-pre2-stateful_sysrq/drivers/char/keyboard.c.stateful_sysrq	Tue Sep 18 16:39:51 2001
+++ linux-2.4.11-pre2-stateful_sysrq/drivers/char/keyboard.c	Mon Oct  1 23:23:58 2001
@@ -21,6 +21,12 @@
  *
  * 27-05-97: Added support for the Magic SysRq Key (Martin Mares)
  * 30-07-98: Dead keys redone, aeb@cwi.nl.
+ *
+ * 28-09-2001: Crutcher Dunnavant <crutcher+kernel@datastacks.com>
+ * Add stateful sysrq features, based upon work from:
+ *   Mathew Mills <mmills@amazon.com>
+ *   Norman Murray <nmurray@redhat.com>
+ *  
  */
 
 #include <linux/config.h>
@@ -157,7 +163,14 @@
 struct pt_regs * kbd_pt_regs;
 
 #ifdef CONFIG_MAGIC_SYSRQ
-static int sysrq_pressed;
+static enum {
+	UP_AND_CLEAR,
+	DOWN_AND_WAITING,
+	DOWN_AND_DONE,
+	UP_AND_WAITING,
+	DOWN_AND_PASS
+} sysrq_state;
+extern struct sysrq_ctls_struct sysrq_ctls;
 #endif
 
 static struct pm_dev *pm_kbd;
@@ -246,15 +259,69 @@
 	} else
 		rep = test_and_set_bit(keycode, key_down);
 
-#ifdef CONFIG_MAGIC_SYSRQ		/* Handle the SysRq Hack */
-	if (keycode == SYSRQ_KEY) {
-		sysrq_pressed = !up_flag;
-		goto out;
-	} else if (sysrq_pressed) {
-		if (!up_flag) {
-			handle_sysrq(kbd_sysrq_xlate[keycode], kbd_pt_regs, kbd, tty);
-			goto out;
+#ifdef CONFIG_MAGIC_SYSRQ               /* Handle the SysRq Hack */
+	/*
+	  Pressing magic + command key acts as a chorded command.
+	  Pressing and releasing magic without a command key acts sticky,
+	  using the next non-magic key as a command key
+	  Pressing magic twice without a command key passes the magic key
+	  through.
+	 */
+
+        if (sysrq_ctls.enabled) {
+		if (keycode == sysrq_ctls.keycode) switch(sysrq_state) {
+			case UP_AND_CLEAR:
+				sysrq_state = up_flag ? UP_AND_CLEAR :
+							DOWN_AND_WAITING;
+				/* consume the key event */
+				goto out;
+
+			case DOWN_AND_WAITING:
+				sysrq_state = up_flag ? UP_AND_WAITING :
+							DOWN_AND_WAITING;
+				/* consume the key event */
+				goto out;
+
+			case DOWN_AND_DONE:
+				sysrq_state = up_flag ? UP_AND_CLEAR :
+							DOWN_AND_DONE;
+				/* consume the key event */
+				goto out;
+
+			case DOWN_AND_PASS:
+			case UP_AND_WAITING:
+				sysrq_state = up_flag ? UP_AND_CLEAR :
+							DOWN_AND_PASS;
+				/* pass the key event through */
+				break;
+
+		} else switch(sysrq_state) {
+			case UP_AND_WAITING:
+			case DOWN_AND_WAITING:
+			case DOWN_AND_DONE:
+				if (!up_flag) {
+					handle_sysrq(kbd_sysrq_xlate[keycode],
+							kbd_pt_regs, kbd, tty);
+				}
+
+				if (sysrq_state == UP_AND_WAITING) {
+					sysrq_state = UP_AND_CLEAR;
+				} else {
+					sysrq_state = DOWN_AND_DONE;
+				}
+
+				/* consume the key event */
+				goto out;
+
+
+			case DOWN_AND_PASS:
+			case UP_AND_CLEAR:
+				/* pass the key event through */
+				break;
+
 		}
+        } else {
+		sysrq_state = UP_AND_CLEAR;
 	}
 #endif
 
--- linux-2.4.11-pre2-stateful_sysrq/drivers/char/sysrq.c.stateful_sysrq	Mon Oct  1 23:13:36 2001
+++ linux-2.4.11-pre2-stateful_sysrq/drivers/char/sysrq.c	Mon Oct  1 23:23:58 2001
@@ -32,12 +32,21 @@
 
 #include <asm/ptrace.h>
 
+/* for the SYSRQ_KEY definition */
+#include <asm/keyboard.h>
+
 extern void reset_vc(unsigned int);
 extern struct list_head super_blocks;
 
 /* Whether we react on sysrq keys or just ignore them */
-int sysrq_enabled = 1;
+struct sysrq_ctls_struct sysrq_ctls = {
+	/* Whether we react on sysrq keys or just ignore them */
+	enabled: 1,
 
+	/* The keycode for the magic key, referred to as sysrq */
+	keycode: SYSRQ_KEY,
+};
+ 
 /* Machine specific power off function */
 void (*sysrq_power_off)(void);
 
@@ -433,7 +442,7 @@
 
 void handle_sysrq(int key, struct pt_regs *pt_regs,
 		  struct kbd_struct *kbd, struct tty_struct *tty) {
-	if (!sysrq_enabled)
+	if (!sysrq_ctls.enabled)
 		return;
 
 	__sysrq_lock_table();
@@ -453,7 +462,7 @@
 	int orig_log_level;
 	int i, j;
 	
-	if (!sysrq_enabled)
+	if (!sysrq_ctls.enabled)
 		return;
 
 	orig_log_level = console_loglevel;

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Description: patch-2.4.10-ac3-stateful_sysrq
Content-Disposition: attachment; filename="patch-2.4.10-ac3-stateful_sysrq.patch"

--- linux-2.4.10-ac3-stateful_sysrq/kernel/sysctl.c.stateful_sysrq	Mon Oct  1 23:14:25 2001
+++ linux-2.4.10-ac3-stateful_sysrq/kernel/sysctl.c	Mon Oct  1 23:25:53 2001
@@ -49,7 +49,7 @@
 extern int sysctl_overcommit_memory;
 extern int max_threads;
 extern int nr_queued_signals, max_queued_signals;
-extern int sysrq_enabled;
+extern struct sysrq_ctls_struct sysrq_ctls;
 extern int core_uses_pid;
 extern int cad_pid;
 
@@ -236,7 +236,9 @@
 	 0644, NULL, &proc_dointvec},
 #endif
 #ifdef CONFIG_MAGIC_SYSRQ
-	{KERN_SYSRQ, "sysrq", &sysrq_enabled, sizeof (int),
+	{KERN_SYSRQ, "sysrq", &sysrq_ctls.enabled, sizeof (int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_SYSRQ, "sysrq-key", &sysrq_ctls.keycode, sizeof (sysrq_ctls.keycode),
 	 0644, NULL, &proc_dointvec},
 #endif	 
 	{KERN_CADPID, "cad_pid", &cad_pid, sizeof (int),
--- linux-2.4.10-ac3-stateful_sysrq/include/linux/sysctl.h.stateful_sysrq	Mon Oct  1 23:14:24 2001
+++ linux-2.4.10-ac3-stateful_sysrq/include/linux/sysctl.h	Mon Oct  1 23:25:53 2001
@@ -106,7 +106,7 @@
 	KERN_MSGMAX=35,         /* int: Maximum size of a messege */
 	KERN_MSGMNB=36,         /* int: Maximum message queue size */
 	KERN_MSGPOOL=37,        /* int: Maximum system message pool size */
-	KERN_SYSRQ=38,		/* int: Sysreq enable */
+	KERN_SYSRQ=38,		/* struct: Sysreq enable, Sysreq keycode */
 	KERN_MAX_THREADS=39,	/* int: Maximum nr of threads in the system */
  	KERN_RANDOM=40,		/* Random driver */
  	KERN_SHMALL=41,		/* int: Maximum size of shared memory */
--- linux-2.4.10-ac3-stateful_sysrq/include/linux/sysrq.h.stateful_sysrq	Mon Oct  1 23:14:24 2001
+++ linux-2.4.10-ac3-stateful_sysrq/include/linux/sysrq.h	Mon Oct  1 23:25:53 2001
@@ -26,6 +26,12 @@
 
 #ifdef CONFIG_MAGIC_SYSRQ
 
+/*  sysrq_ctls - controls aspects of the SYSRQ magic key hack*/
+struct sysrq_ctls_struct {
+	int enabled;
+	int keycode;
+};
+
 /* Generic SysRq interface -- you may call it from any device driver, supplying
  * ASCII code of the key, pointer to registers and kbd/tty structs (if they
  * are available -- else NULL's).
--- linux-2.4.10-ac3-stateful_sysrq/drivers/char/keyboard.c.stateful_sysrq	Mon Oct  1 23:14:06 2001
+++ linux-2.4.10-ac3-stateful_sysrq/drivers/char/keyboard.c	Mon Oct  1 23:25:53 2001
@@ -21,6 +21,12 @@
  *
  * 27-05-97: Added support for the Magic SysRq Key (Martin Mares)
  * 30-07-98: Dead keys redone, aeb@cwi.nl.
+ *
+ * 28-09-2001: Crutcher Dunnavant <crutcher+kernel@datastacks.com>
+ * Add stateful sysrq features, based upon work from:
+ *   Mathew Mills <mmills@amazon.com>
+ *   Norman Murray <nmurray@redhat.com>
+ *  
  */
 
 #include <linux/config.h>
@@ -159,7 +165,14 @@
 struct pt_regs * kbd_pt_regs;
 
 #ifdef CONFIG_MAGIC_SYSRQ
-static int sysrq_pressed;
+static enum {
+	UP_AND_CLEAR,
+	DOWN_AND_WAITING,
+	DOWN_AND_DONE,
+	UP_AND_WAITING,
+	DOWN_AND_PASS
+} sysrq_state;
+extern struct sysrq_ctls_struct sysrq_ctls;
 #endif
 
 static struct pm_dev *pm_kbd;
@@ -248,15 +261,69 @@
 	} else
 		rep = test_and_set_bit(keycode, key_down);
 
-#ifdef CONFIG_MAGIC_SYSRQ		/* Handle the SysRq Hack */
-	if (keycode == SYSRQ_KEY) {
-		sysrq_pressed = !up_flag;
-		goto out;
-	} else if (sysrq_pressed) {
-		if (!up_flag) {
-			handle_sysrq(kbd_sysrq_xlate[keycode], kbd_pt_regs, kbd, tty);
-			goto out;
+#ifdef CONFIG_MAGIC_SYSRQ               /* Handle the SysRq Hack */
+	/*
+	  Pressing magic + command key acts as a chorded command.
+	  Pressing and releasing magic without a command key acts sticky,
+	  using the next non-magic key as a command key
+	  Pressing magic twice without a command key passes the magic key
+	  through.
+	 */
+
+        if (sysrq_ctls.enabled) {
+		if (keycode == sysrq_ctls.keycode) switch(sysrq_state) {
+			case UP_AND_CLEAR:
+				sysrq_state = up_flag ? UP_AND_CLEAR :
+							DOWN_AND_WAITING;
+				/* consume the key event */
+				goto out;
+
+			case DOWN_AND_WAITING:
+				sysrq_state = up_flag ? UP_AND_WAITING :
+							DOWN_AND_WAITING;
+				/* consume the key event */
+				goto out;
+
+			case DOWN_AND_DONE:
+				sysrq_state = up_flag ? UP_AND_CLEAR :
+							DOWN_AND_DONE;
+				/* consume the key event */
+				goto out;
+
+			case DOWN_AND_PASS:
+			case UP_AND_WAITING:
+				sysrq_state = up_flag ? UP_AND_CLEAR :
+							DOWN_AND_PASS;
+				/* pass the key event through */
+				break;
+
+		} else switch(sysrq_state) {
+			case UP_AND_WAITING:
+			case DOWN_AND_WAITING:
+			case DOWN_AND_DONE:
+				if (!up_flag) {
+					handle_sysrq(kbd_sysrq_xlate[keycode],
+							kbd_pt_regs, kbd, tty);
+				}
+
+				if (sysrq_state == UP_AND_WAITING) {
+					sysrq_state = UP_AND_CLEAR;
+				} else {
+					sysrq_state = DOWN_AND_DONE;
+				}
+
+				/* consume the key event */
+				goto out;
+
+
+			case DOWN_AND_PASS:
+			case UP_AND_CLEAR:
+				/* pass the key event through */
+				break;
+
 		}
+        } else {
+		sysrq_state = UP_AND_CLEAR;
 	}
 #endif
 
--- linux-2.4.10-ac3-stateful_sysrq/drivers/char/sysrq.c.stateful_sysrq	Mon Oct  1 23:14:06 2001
+++ linux-2.4.10-ac3-stateful_sysrq/drivers/char/sysrq.c	Mon Oct  1 23:27:14 2001
@@ -32,12 +32,21 @@
 
 #include <asm/ptrace.h>
 
+/* for the SYSRQ_KEY definition */
+#include <asm/keyboard.h>
+
 extern void wakeup_bdflush(int);
 extern void reset_vc(unsigned int);
 extern struct list_head super_blocks;
 
 /* Whether we react on sysrq keys or just ignore them */
-int sysrq_enabled = 1;
+struct sysrq_ctls_struct sysrq_ctls = {
+	/* Whether we react on sysrq keys or just ignore them */
+	enabled: 1,
+  
+	/* The keycode for the magic key, referred to as sysrq */
+	keycode: SYSRQ_KEY,
+};
 
 /* Machine specific power off function */
 void (*sysrq_power_off)(void);
@@ -434,7 +443,7 @@
 
 void handle_sysrq(int key, struct pt_regs *pt_regs,
 		  struct kbd_struct *kbd, struct tty_struct *tty) {
-	if (!sysrq_enabled)
+	if (!sysrq_ctls.enabled)
 		return;
 
 	__sysrq_lock_table();
@@ -454,7 +463,7 @@
 	int orig_log_level;
 	int i, j;
 	
-	if (!sysrq_enabled)
+	if (!sysrq_ctls.enabled)
 		return;
 
 	orig_log_level = console_loglevel;

--4SFOXa2GPu3tIq4H--
