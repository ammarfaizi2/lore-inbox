Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265054AbRGBNE2>; Mon, 2 Jul 2001 09:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265055AbRGBNET>; Mon, 2 Jul 2001 09:04:19 -0400
Received: from hera.cwi.nl ([192.16.191.8]:50058 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265054AbRGBNEI>;
	Mon, 2 Jul 2001 09:04:08 -0400
Date: Mon, 2 Jul 2001 15:03:33 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200107021303.PAA496134.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] more SAK stuff
Cc: andrewm@uow.edu.au, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        tytso@mit.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> (a) It does less, namely will not kill processes with uid 0.
>> Ted, any objections?

Alan:

> That breaks the security guarantee. Suppose I use a setuid app to confuse
> you into doing something ?

On second thoughts I agree. Here is the patch without test for p->uid.

Andries

diff -u --recursive --new-file ../linux-2.4.6-pre8/linux/drivers/char/keyboard.c ./linux/drivers/char/keyboard.c
--- ../linux-2.4.6-pre8/linux/drivers/char/keyboard.c	Mon Oct 16 21:58:51 2000
+++ ./linux/drivers/char/keyboard.c	Mon Jul  2 13:28:09 2001
@@ -506,6 +506,8 @@
 	 * them properly.
 	 */
 
+	if (!tty && ttytab && ttytab[0] && ttytab[0]->driver_data)
+		tty = ttytab[0];
 	do_SAK(tty);
 	reset_vc(fg_console);
 #if 0
diff -u --recursive --new-file ../linux-2.4.6-pre8/linux/drivers/char/tty_io.c ./linux/drivers/char/tty_io.c
--- ../linux-2.4.6-pre8/linux/drivers/char/tty_io.c	Sun Jul  1 15:19:26 2001
+++ ./linux/drivers/char/tty_io.c	Mon Jul  2 14:53:52 2001
@@ -1818,20 +1818,29 @@
  *
  * Nasty bug: do_SAK is being called in interrupt context.  This can
  * deadlock.  We punt it up to process context.  AKPM - 16Mar2001
+ *
+ * Treat all VTs as a single tty for the purposes of SAK.  A process with an
+ * open fd for one VT can do interesting things to all.  aeb, 2001-07-02
  */
-static void __do_SAK(void *arg)
+#ifdef CONFIG_VT
+static inline int tty_is_vt(struct tty_struct *tty)
 {
-#ifdef TTY_SOFT_SAK
-	tty_hangup(tty);
+	return tty ? (tty->driver.type == TTY_DRIVER_TYPE_CONSOLE) : 0;
+}
 #else
-	struct tty_struct *tty = arg;
+static inline int tty_is_vt(struct tty_struct *tty)
+{
+	return 0;
+}
+#endif
+
+static inline void tty_hard_SAK(struct tty_struct *tty)
+{
 	struct task_struct *p;
 	int session;
-	int		i;
-	struct file	*filp;
-	
-	if (!tty)
-		return;
+	int i;
+	struct file *filp;
+
 	session  = tty->session;
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
@@ -1839,7 +1848,9 @@
 		tty->driver.flush_buffer(tty);
 	read_lock(&tasklist_lock);
 	for_each_task(p) {
+		/* all VTs are considered a single tty here */
 		if ((p->tty == tty) ||
+		    (tty_is_vt(tty) && tty_is_vt(p->tty)) ||
 		    ((session > 0) && (p->session == session))) {
 			send_sig(SIGKILL, p, 1);
 			continue;
@@ -1850,7 +1861,9 @@
 			for (i=0; i < p->files->max_fds; i++) {
 				filp = fcheck_files(p->files, i);
 				if (filp && (filp->f_op == &tty_fops) &&
-				    (filp->private_data == tty)) {
+				    (filp->private_data == tty ||
+				     (tty_is_vt(tty) &&
+				      tty_is_vt(filp->private_data)))) {
 					send_sig(SIGKILL, p, 1);
 					break;
 				}
@@ -1860,6 +1873,17 @@
 		task_unlock(p);
 	}
 	read_unlock(&tasklist_lock);
+}
+
+static void __do_SAK(void *arg)
+{
+	struct tty_struct *tty = arg;
+	if (!tty)		/* impossible */
+		return;
+#ifdef TTY_SOFT_SAK
+	tty_hangup(tty);
+#else
+	tty_hard_SAK(tty);
 #endif
 }
 
@@ -1872,6 +1896,8 @@
  */
 void do_SAK(struct tty_struct *tty)
 {
+	if (!tty)
+		return;
 	PREPARE_TQUEUE(&tty->SAK_tq, __do_SAK, tty);
 	schedule_task(&tty->SAK_tq);
 }
