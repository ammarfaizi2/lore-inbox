Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264204AbRGBMR0>; Mon, 2 Jul 2001 08:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264279AbRGBMRR>; Mon, 2 Jul 2001 08:17:17 -0400
Received: from hera.cwi.nl ([192.16.191.8]:61691 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264169AbRGBMRM>;
	Mon, 2 Jul 2001 08:17:12 -0400
Date: Mon, 2 Jul 2001 14:16:36 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200107021216.OAA512638.aeb@vlet.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, andrewm@uow.edu.au, torvalds@transmeta.com,
        tytso@mit.edu
Subject: [PATCH] more SAK stuff
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus, Alan, Ted, Andrew, all:

(i) Andrew - why don't you add yourself to the CREDITS file?
(then I'll find your email address at the first instead of the second attempt)

(ii) Yesterday I complained about the fact that pressing SAK twice
crashes the kernel (because the close from the first time will set
	tty->driver_data = 0;
and then on the next press kbd has tty==0 and do_SAK() kills the system).
There is more bad stuff in this 2.4.3 patch:

-void do_SAK( struct tty_struct *tty)
+static void __do_SAK(void *arg)
 {
 #ifdef TTY_SOFT_SAK
        tty_hangup(tty);
 #else
+       struct tty_struct *tty = arg;

Clearly, if TTY_SOFT_SAK is defined this will not compile
(or, worse, will pick up some global variable tty).

The patch below has yesterdays fix of do_SAK(), and fixes this
compilation problem. I invented a separate inline routine here -
I do not like very long stretches of code inside #ifdef.

More interestingly, it changes the operation of SAK in two ways:

(a) It does less, namely will not kill processes with uid 0.
Ted, any objections?
For example, when syslog has several output streams, and one is
to /dev/tty10, then a SAK typed at /dev/tty10 should not kill syslog,
that is bad for security.

(b) It does more, namely will for the purposes of SAK consider all
VTs equivalent, so that a SAK typed on /dev/tty1 also kills processes
that have an open file descriptor on /dev/tty2.
That is good for security, since many keyboard or console ioctls just
require an open fd for some VT, and this process on tty2 can for example
change the keymap on tty1.

One of the motivations of this patch was that SAK should be able
to kill a "while [ 1 ]; do chvt 21; done", that is the reason
for the keyboard.c fragment.

Ted, please complain if anything is wrong with the way
filp->private_data is used.

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
+++ ./linux/drivers/char/tty_io.c	Mon Jul  2 13:27:19 2001
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
@@ -1839,7 +1848,12 @@
 		tty->driver.flush_buffer(tty);
 	read_lock(&tasklist_lock);
 	for_each_task(p) {
+		/* do not kill root processes */
+		if (p->uid == 0)
+			continue;
+		/* all VTs are considered a single tty here */
 		if ((p->tty == tty) ||
+		    (tty_is_vt(tty) && tty_is_vt(p->tty)) ||
 		    ((session > 0) && (p->session == session))) {
 			send_sig(SIGKILL, p, 1);
 			continue;
@@ -1850,7 +1864,9 @@
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
@@ -1860,6 +1876,17 @@
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
 
@@ -1872,6 +1899,8 @@
  */
 void do_SAK(struct tty_struct *tty)
 {
+	if (!tty)
+		return;
 	PREPARE_TQUEUE(&tty->SAK_tq, __do_SAK, tty);
 	schedule_task(&tty->SAK_tq);
 }
