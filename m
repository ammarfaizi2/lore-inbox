Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271760AbTGROIn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271787AbTGROIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:08:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25477
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271760AbTGROGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:06:40 -0400
Date: Fri, 18 Jul 2003 15:21:00 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181421.h6IEL0Jm017774@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: serial proc gives info on keycounts which can sometiems be abused
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For 2.4.x we made the file r-------- but for 2.6 we can do a nicer job

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/serial/core.c linux-2.6.0-test1-ac2/drivers/serial/core.c
--- linux-2.6.0-test1/drivers/serial/core.c	2003-07-10 21:06:05.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/serial/core.c	2003-07-15 17:48:39.000000000 +0100
@@ -1667,23 +1667,25 @@
 		return ret + 1;
 	}
 
-	status = port->ops->get_mctrl(port);
-
-	ret += sprintf(buf + ret, " tx:%d rx:%d",
-			port->icount.tx, port->icount.rx);
-	if (port->icount.frame)
-		ret += sprintf(buf + ret, " fe:%d",
-			port->icount.frame);
-	if (port->icount.parity)
-		ret += sprintf(buf + ret, " pe:%d",
-			port->icount.parity);
-	if (port->icount.brk)
-		ret += sprintf(buf + ret, " brk:%d",
-			port->icount.brk);
-	if (port->icount.overrun)
-		ret += sprintf(buf + ret, " oe:%d",
-			port->icount.overrun);
-
+	if(capable(CAP_SYS_ADMIN))
+	{
+		status = port->ops->get_mctrl(port);
+
+		ret += sprintf(buf + ret, " tx:%d rx:%d",
+				port->icount.tx, port->icount.rx);
+		if (port->icount.frame)
+			ret += sprintf(buf + ret, " fe:%d",
+				port->icount.frame);
+		if (port->icount.parity)
+			ret += sprintf(buf + ret, " pe:%d",
+				port->icount.parity);
+		if (port->icount.brk)
+			ret += sprintf(buf + ret, " brk:%d",
+				port->icount.brk);
+		if (port->icount.overrun)
+			ret += sprintf(buf + ret, " oe:%d",
+				port->icount.overrun);
+	
 #define INFOBIT(bit,str) \
 	if (port->mctrl & (bit)) \
 		strncat(stat_buf, (str), sizeof(stat_buf) - \
@@ -1693,19 +1695,22 @@
 		strncat(stat_buf, (str), sizeof(stat_buf) - \
 		       strlen(stat_buf) - 2)
 
-	stat_buf[0] = '\0';
-	stat_buf[1] = '\0';
-	INFOBIT(TIOCM_RTS, "|RTS");
-	STATBIT(TIOCM_CTS, "|CTS");
-	INFOBIT(TIOCM_DTR, "|DTR");
-	STATBIT(TIOCM_DSR, "|DSR");
-	STATBIT(TIOCM_CAR, "|CD");
-	STATBIT(TIOCM_RNG, "|RI");
-	if (stat_buf[0])
-		stat_buf[0] = ' ';
-	strcat(stat_buf, "\n");
-
-	ret += sprintf(buf + ret, stat_buf);
+		stat_buf[0] = '\0';
+		stat_buf[1] = '\0';
+		INFOBIT(TIOCM_RTS, "|RTS");
+		STATBIT(TIOCM_CTS, "|CTS");
+		INFOBIT(TIOCM_DTR, "|DTR");
+		STATBIT(TIOCM_DSR, "|DSR");
+		STATBIT(TIOCM_CAR, "|CD");
+		STATBIT(TIOCM_RNG, "|RI");
+		if (stat_buf[0])
+			stat_buf[0] = ' ';
+		strcat(stat_buf, "\n");
+	
+		ret += sprintf(buf + ret, stat_buf);
+	}
+#undef STATBIT
+#undef INFOBIT
 	return ret;
 }
 
