Return-Path: <linux-kernel-owner+w=401wt.eu-S1161159AbXAERLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbXAERLo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 12:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161163AbXAERLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 12:11:43 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:51019 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161159AbXAERLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 12:11:41 -0500
Message-id: <404263291482327299@wsc.cz>
In-reply-to: <16079316021425814645@wsc.cz>
Subject: [PATCH 5/7] Char: moxa, remove useless vairables
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri,  5 Jan 2007 18:11:50 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moxa, remove useless vairables

Remove temporary or once used variables, that can be defined locally to
save some bytes.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit d35a569e31595b9b8f70bfd1d3aae7f830d183fe
tree ef1ddd6847925a86aa7041a540646dc0dc543c62
parent 5ac07b4e2356931b4548316037b537f980bd8ab9
author Jiri Slaby <jirislaby@gmail.com> Wed, 03 Jan 2007 14:48:38 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 05 Jan 2007 17:38:54 +0059

 drivers/char/moxa.c |   35 ++++++++++++++---------------------
 1 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index 0c34bc5..8849d66 100644
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -146,8 +146,6 @@ struct moxa_port {
 	wait_queue_head_t close_wait;
 
 	struct timer_list emptyTimer;
-	struct mxser_mstatus GMStatus;
-	struct moxaq_str temp_queue;
 
 	char chkPort;
 	char lineCtrl;
@@ -1487,17 +1485,15 @@ int MoxaDriverIoctl(unsigned int cmd, unsigned long arg, int port)
 		return (0);
 	case MOXA_GET_IOQUEUE: {
 		struct moxaq_str __user *argm = argp;
-		struct moxa_port *p;
+		struct moxaq_str tmp;
 
 		for (i = 0; i < MAX_PORTS; i++, argm++) {
-			p = &moxa_ports[i];
-			memset(&p->temp_queue, 0, sizeof(p->temp_queue));
-			if (p->chkPort) {
-				p->temp_queue.inq = MoxaPortRxQueue(i);
-				p->temp_queue.outq = MoxaPortTxQueue(i);
+			memset(&tmp, 0, sizeof(tmp));
+			if (moxa_ports[i].chkPort) {
+				tmp.inq = MoxaPortRxQueue(i);
+				tmp.outq = MoxaPortTxQueue(i);
 			}
-			if (copy_to_user(argm, &p->temp_queue,
-						sizeof(p->temp_queue)))
+			if (copy_to_user(argm, &tmp, sizeof(tmp)))
 				return -EFAULT;
 		}
 		return (0);
@@ -1518,33 +1514,30 @@ int MoxaDriverIoctl(unsigned int cmd, unsigned long arg, int port)
 		return 0;
 	case MOXA_GETMSTATUS: {
 		struct mxser_mstatus __user *argm = argp;
+		struct mxser_mstatus tmp;
 		struct moxa_port *p;
 
 		for (i = 0; i < MAX_PORTS; i++, argm++) {
 			p = &moxa_ports[i];
-			p->GMStatus.ri = 0;
-			p->GMStatus.dcd = 0;
-			p->GMStatus.dsr = 0;
-			p->GMStatus.cts = 0;
+			memset(&tmp, 0, sizeof(tmp));
 			if (!p->chkPort) {
 				goto copy;
 			} else {
 				status = MoxaPortLineStatus(p->port);
 				if (status & 1)
-					p->GMStatus.cts = 1;
+					tmp.cts = 1;
 				if (status & 2)
-					p->GMStatus.dsr = 1;
+					tmp.dsr = 1;
 				if (status & 4)
-					p->GMStatus.dcd = 1;
+					tmp.dcd = 1;
 			}
 
 			if (!p->tty || !p->tty->termios)
-				p->GMStatus.cflag = p->cflag;
+				tmp.cflag = p->cflag;
 			else
-				p->GMStatus.cflag = p->tty->termios->c_cflag;
+				tmp.cflag = p->tty->termios->c_cflag;
 copy:
-			if (copy_to_user(argm, &p->GMStatus,
-						sizeof(p->GMStatus)))
+			if (copy_to_user(argm, &tmp, sizeof(tmp)))
 				return -EFAULT;
 		}
 		return 0;
