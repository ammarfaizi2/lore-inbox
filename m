Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266823AbUFYSAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266823AbUFYSAM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUFYSAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:00:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10921 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266823AbUFYR7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 13:59:51 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16604.26514.243458.631948@segfault.boston.redhat.com>
Date: Fri, 25 Jun 2004 13:57:38 -0400
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org
Subject: [patch] teach netconsole how to do syslog
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here's a patch which adds the option to send messages to a remote syslog,
enabled via the do_syslog= module parameter.  Currently logs everything at
info (as did the original netconsole module).  Patch is against 2.6.6,
though should apply to later.

Comments?

Jeff


--- linux-2.6.6/drivers/net/netconsole.c	2004-06-21 14:06:34.000000000 -0400
+++ linux-2.6.6-netdump/drivers/net/netconsole.c	2004-06-25 13:51:54.000000000 -0400
@@ -54,6 +54,10 @@ static char config[256];
 module_param_string(netconsole, config, 256, 0);
 MODULE_PARM_DESC(netconsole, " netconsole=[src-port]@[src-ip]/[dev],[tgt-port]@<tgt-ip>/[tgt-macaddr]\n");
 
+static int do_syslog;
+module_param(do_syslog, bool, 000);
+MODULE_PARM_DESC(do_syslog, " do_syslog=<yes|no>\n");
+
 static struct netpoll np = {
 	.name = "netconsole",
 	.dev_name = "eth0",
@@ -64,10 +68,36 @@ static struct netpoll np = {
 static int configured = 0;
 
 #define MAX_PRINT_CHUNK 1000
+#define SYSLOG_HEADER_LEN 4
+
+static int syslog_chars = SYSLOG_HEADER_LEN;
+static unsigned char syslog_line [MAX_PRINT_CHUNK + 10] = {
+	'<',
+	'5',
+	'>',
+	' ',
+	[4 ... MAX_PRINT_CHUNK+5] = '\0',
+};
+
+/*
+ * We feed kernel messages char by char, and send the UDP packet
+ * one linefeed. We buffer all characters received.
+ */
+static inline void feed_syslog_char(const unsigned char c)
+{
+	if (syslog_chars == MAX_PRINT_CHUNK)
+		syslog_chars--;
+	syslog_line[syslog_chars] = c;
+	syslog_chars++;
+	if (c == '\n') {
+		netpoll_send_udp(&np, syslog_line, syslog_chars);
+		syslog_chars = SYSLOG_HEADER_LEN;
+	}
+}
 
 static void write_msg(struct console *con, const char *msg, unsigned int len)
 {
-	int frag, left;
+	int frag, left, i;
 	unsigned long flags;
 
 	if (!np.dev)
@@ -75,11 +105,16 @@ static void write_msg(struct console *co
 
 	local_irq_save(flags);
 
-	for(left = len; left; ) {
-		frag = min(left, MAX_PRINT_CHUNK);
-		netpoll_send_udp(&np, msg, frag);
-		msg += frag;
-		left -= frag;
+	if (do_syslog) {
+		for (i = 0; i < len; i++)
+			feed_syslog_char(msg[i]);
+	} else {
+		for(left = len; left; ) {
+			frag = min(left, MAX_PRINT_CHUNK);
+			netpoll_send_udp(&np, msg, frag);
+			msg += frag;
+			left -= frag;
+		}
 	}
 
 	local_irq_restore(flags);
