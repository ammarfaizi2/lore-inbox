Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264827AbTIIWr4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264828AbTIIWr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:47:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:31132 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264827AbTIIWrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:47:52 -0400
Date: Tue, 9 Sep 2003 15:47:34 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix modularization of Siemens line discipline
Message-Id: <20030909154734.65f2b4ac.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert SIEMENS R3964 tty line discipline on 2.6.0-test5 to use tty_ldisc owner
instead of explicit MOD_INC/DEC.

diff -Nru a/drivers/char/n_r3964.c b/drivers/char/n_r3964.c
--- a/drivers/char/n_r3964.c	Tue Sep  9 15:40:12 2003
+++ b/drivers/char/n_r3964.c	Tue Sep  9 15:40:12 2003
@@ -150,22 +150,18 @@
 static int  r3964_receive_room(struct tty_struct *tty);
 
 static struct tty_ldisc tty_ldisc_N_R3964 = {
-        TTY_LDISC_MAGIC,       /* magic */
-	"R3964",               /* name */
-        0,                     /* num */
-        0,                     /* flags */
-        r3964_open,            /* open */
-        r3964_close,           /* close */
-        0,                     /* flush_buffer */
-        0,                     /* chars_in_buffer */
-        r3964_read,            /* read */
-        r3964_write,           /* write */
-        r3964_ioctl,           /* ioctl */
-        r3964_set_termios,     /* set_termios */
-        r3964_poll,            /* poll */            
-        r3964_receive_buf,     /* receive_buf */
-        r3964_receive_room,    /* receive_room */
-        0                      /* write_wakeup */
+	.owner	 = THIS_MODULE,
+	.magic	= TTY_LDISC_MAGIC, 
+	.name	= "R3964",
+	.open	= r3964_open,
+	.close	= r3964_close,
+	.read	= r3964_read,
+	.write	= r3964_write,
+	.ioctl	= r3964_ioctl,
+	.set_termios = r3964_set_termios,
+	.poll	= r3964_poll,            
+	.receive_buf = r3964_receive_buf,
+	.receive_room = r3964_receive_room,
 };
 
 
@@ -1070,8 +1066,6 @@
 {
    struct r3964_info *pInfo;
    
-   MOD_INC_USE_COUNT;
-
    TRACE_L("open");
    TRACE_L("tty=%x, PID=%d, disc_data=%x", 
           (int)tty, current->pid, (int)tty->disc_data);
@@ -1188,8 +1182,6 @@
     TRACE_M("r3964_close - tx_buf kfree %x",(int)pInfo->tx_buf);
     kfree(pInfo);
     TRACE_M("r3964_close - info kfree %x",(int)pInfo);
-
-    MOD_DEC_USE_COUNT;
 }
 
 static ssize_t r3964_read(struct tty_struct *tty, struct file *file,
