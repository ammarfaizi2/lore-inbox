Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312486AbSCTMNV>; Wed, 20 Mar 2002 07:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312487AbSCTMNL>; Wed, 20 Mar 2002 07:13:11 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:8714 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S312486AbSCTMNC>; Wed, 20 Mar 2002 07:13:02 -0500
Message-Id: <200203201207.g2KC7uX04413@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Rusty Russell (trivial 2.5 patches)" <trivial@rustcorp.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>
Subject: [PATCH] SAK messages
Date: Wed, 20 Mar 2002 14:07:26 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use SAK from time to time when I have problems with hung processes.

Sometimes it is difficult to figure out what was being killed and why.

For example, Midnight Commander contains a bug: it holds fd#3 open to
the tty. It prevented me from daemonizing processes (like X) - they
died upon SAK. 

This little patch makes SAK tell whom and why it kills. Tested.
--
vda


--- linux-2.4.18/drivers/char/tty_io.c.orig	Fri Jan 25 15:49:44 2002
+++ new/drivers/char/tty_io.c	Tue Mar 19 08:28:27 2002
@@ -1847,6 +1847,9 @@
 	for_each_task(p) {
 		if ((p->tty == tty) ||
 		    ((session > 0) && (p->session == session))) {
+			printk(KERN_NOTICE "SAK: killed process %d"
+			    " (%s): p->session==tty->session\n",
+			    p->pid, p->comm);
 			send_sig(SIGKILL, p, 1);
 			continue;
 		}
@@ -1857,6 +1860,9 @@
 				filp = fcheck_files(p->files, i);
 				if (filp && (filp->f_op == &tty_fops) &&
 				    (filp->private_data == tty)) {
+					printk(KERN_NOTICE "SAK: killed process %d"
+					    " (%s): fd#%d opened to the tty\n",
+					    p->pid, p->comm, i);
 					send_sig(SIGKILL, p, 1);
 					break;
 				}
