Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276298AbRJCOFO>; Wed, 3 Oct 2001 10:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276301AbRJCOFF>; Wed, 3 Oct 2001 10:05:05 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:22533 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S276298AbRJCOEz>; Wed, 3 Oct 2001 10:04:55 -0400
Date: Wed, 3 Oct 2001 10:05:22 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Stateful Magic Sysrq Key + Sticky Tag
Message-ID: <20011003100522.A4848@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20011002084807.3579.qmail@web20505.mail.yahoo.com> <20011002101845.A1630@mueller.datastacks.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011002101845.A1630@mueller.datastacks.com>; from crutcher@datastacks.com on Tue, Oct 02, 2001 at 10:18:45AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This is the previous stateful sysrq patch, plus a 'sysrq-sticky' proc
entry, which defaults to off, that controls whether the stateful mode
will be used or not.

This reworked patch is against 2.4.11-pre2.

++ 02/10/01 10:18 -0400 - Crutcher Dunnavant:
> ++ 02/10/01 10:48 +0200 - willy tarreau:
> > > I'd suggest either making this behaviour optional,
> > or making it
> > > so that hitting alt-sysrq twice, without any other
> > keys being
> > > pressed makes the next key stick.
> > 
> > I agree with you that there's a risk. Mike Harris had
> > written a
> > patch for 2.2 which did something similar, but
> > slightly better 
> > IMO since it avoids risks of mis-press, handles
> > correctly
> > broken keyboards and keeps compatible with the
> > existing 
> > method. Basically, it allows the user to press Alt,
> > then SysRQ,
> > release SysRQ then press the desired key, and later
> > release
> > Alt. In fact, it only resets the "magic-key-mode" flag
> > after Alt
> > has been released, and doesn't bother when SysRq is
> > released.
> 
> But this would require that alt be pressed. This is not acceptable on
> exactly the sort of boards which require this patch.
> 
> I will look at adding a 'sysrq-sticky' entry to proc, which will do the
> obvious thing. I think that this should address everyone's concerns.
> 
> -- 
> Crutcher        <crutcher@datastacks.com>
> GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
>     R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Description: patch-2.4.11-pre2-stateful_sticky_sysrq
Content-Disposition: attachment; filename="patch-2.4.11-pre2-stateful_sysrq.final.2"

diff -ur linux-2.4.11-pre2/drivers/char/keyboard.c linux-2.4.11-pre2-stateful_sysrq/drivers/char/keyboard.c
--- linux-2.4.11-pre2/drivers/char/keyboard.c	Tue Sep 18 16:39:51 2001
+++ linux-2.4.11-pre2-stateful_sysrq/drivers/char/keyboard.c	Wed Oct  3 00:15:08 2001
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
@@ -246,15 +259,76 @@
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
+				if (up_flag) {
+					if (sysrq_ctls.sticky) {
+						sysrq_state = UP_AND_WAITING;
+					} else {
+						sysrq_state = UP_AND_CLEAR;
+					}
+				} else {
+					sysrq_state = DOWN_AND_WAITING;
+				}
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
 
diff -ur linux-2.4.11-pre2/drivers/char/sysrq.c linux-2.4.11-pre2-stateful_sysrq/drivers/char/sysrq.c
--- linux-2.4.11-pre2/drivers/char/sysrq.c	Mon Oct  1 23:13:36 2001
+++ linux-2.4.11-pre2-stateful_sysrq/drivers/char/sysrq.c	Wed Oct  3 09:55:42 2001
@@ -32,12 +32,24 @@
 
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
+
+	/* The keycode for the magic key, referred to as sysrq */
+	keycode: SYSRQ_KEY,
 
+	/* is the sysrq key 'sticky'? */
+	sticky: 0,
+};
+ 
 /* Machine specific power off function */
 void (*sysrq_power_off)(void);
 
@@ -231,7 +243,7 @@
 static void sysrq_handle_mountro(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
 	emergency_sync_scheduled = EMERG_REMOUNT;
-	wakeup_bdflush(0);
+	wakeup_bdflush();
 }
 static struct sysrq_key_op sysrq_mountro_op = {
 	handler:	sysrq_handle_mountro,
@@ -433,7 +445,7 @@
 
 void handle_sysrq(int key, struct pt_regs *pt_regs,
 		  struct kbd_struct *kbd, struct tty_struct *tty) {
-	if (!sysrq_enabled)
+	if (!sysrq_ctls.enabled)
 		return;
 
 	__sysrq_lock_table();
@@ -453,7 +465,7 @@
 	int orig_log_level;
 	int i, j;
 	
-	if (!sysrq_enabled)
+	if (!sysrq_ctls.enabled)
 		return;
 
 	orig_log_level = console_loglevel;
diff -ur linux-2.4.11-pre2/include/linux/sysctl.h linux-2.4.11-pre2-stateful_sysrq/include/linux/sysctl.h
--- linux-2.4.11-pre2/include/linux/sysctl.h	Mon Oct  1 23:13:44 2001
+++ linux-2.4.11-pre2-stateful_sysrq/include/linux/sysctl.h	Wed Oct  3 00:17:13 2001
@@ -106,7 +106,7 @@
 	KERN_MSGMAX=35,         /* int: Maximum size of a messege */
 	KERN_MSGMNB=36,         /* int: Maximum message queue size */
 	KERN_MSGPOOL=37,        /* int: Maximum system message pool size */
-	KERN_SYSRQ=38,		/* int: Sysreq enable */
+	KERN_SYSRQ=38,		/* struct: Sysreq enable, keycode, sticky */
 	KERN_MAX_THREADS=39,	/* int: Maximum nr of threads in the system */
  	KERN_RANDOM=40,		/* Random driver */
  	KERN_SHMALL=41,		/* int: Maximum size of shared memory */
diff -ur linux-2.4.11-pre2/include/linux/sysrq.h linux-2.4.11-pre2-stateful_sysrq/include/linux/sysrq.h
--- linux-2.4.11-pre2/include/linux/sysrq.h	Mon Oct  1 23:13:44 2001
+++ linux-2.4.11-pre2-stateful_sysrq/include/linux/sysrq.h	Wed Oct  3 00:15:26 2001
@@ -26,6 +26,13 @@
 
 #ifdef CONFIG_MAGIC_SYSRQ
 
+/*  sysrq_ctls - controls aspects of the SYSRQ magic key hack*/
+struct sysrq_ctls_struct {
+	int enabled;
+	int keycode;
+	int sticky;
+};
+
 /* Generic SysRq interface -- you may call it from any device driver, supplying
  * ASCII code of the key, pointer to registers and kbd/tty structs (if they
  * are available -- else NULL's).
diff -ur linux-2.4.11-pre2/kernel/sysctl.c linux-2.4.11-pre2-stateful_sysrq/kernel/sysctl.c
--- linux-2.4.11-pre2/kernel/sysctl.c	Mon Oct  1 23:13:44 2001
+++ linux-2.4.11-pre2-stateful_sysrq/kernel/sysctl.c	Wed Oct  3 00:18:43 2001
@@ -46,7 +46,7 @@
 extern int sysctl_overcommit_memory;
 extern int max_threads;
 extern int nr_queued_signals, max_queued_signals;
-extern int sysrq_enabled;
+extern struct sysrq_ctls_struct sysrq_ctls;
 extern int core_uses_pid;
 extern int cad_pid;
 
@@ -233,7 +233,11 @@
 	 0644, NULL, &proc_dointvec},
 #endif
 #ifdef CONFIG_MAGIC_SYSRQ
-	{KERN_SYSRQ, "sysrq", &sysrq_enabled, sizeof (int),
+	{KERN_SYSRQ, "sysrq", &sysrq_ctls.enabled, sizeof (int),
+	 0644, NULL, &proc_dointvec},
+	{KERN_SYSRQ, "sysrq-key", &sysrq_ctls.keycode, sizeof (sysrq_ctls.keycode),
+	 0644, NULL, &proc_dointvec},
+	{KERN_SYSRQ, "sysrq-sticky", &sysrq_ctls.sticky, sizeof (sysrq_ctls.sticky),
 	 0644, NULL, &proc_dointvec},
 #endif	 
 	{KERN_CADPID, "cad_pid", &cad_pid, sizeof (int),

--J2SCkAp4GZ/dPZZf--
