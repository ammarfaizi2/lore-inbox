Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293182AbSCGWYI>; Thu, 7 Mar 2002 17:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292631AbSCGWX7>; Thu, 7 Mar 2002 17:23:59 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:25606 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S292466AbSCGWXv>; Thu, 7 Mar 2002 17:23:51 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76E3@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'linux-serial'" <linux-serial@vger.kernel.org>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Russell King'" <rmk@arm.linux.org.uk>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] serial.c procfs kudzu - discussion
Date: Thu, 7 Mar 2002 14:23:48 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch submitted for discussion:

This serial driver patch modifies function line_info() which assembles text 
to be read from /proc/tty/driver/serial. For example, the text line for the 
COM2 port, which is mapped to I/O space, is as follows:

    "1: uart:16550A port:2F8 irq:3 tx:0 rx:0"

The patch corrects handling of ports that are on memory mapped devices. 
The unpatched function generates a short text line for such ports because 
the I/O port address field is zero on memory mapped ports:

    "4: uart:16C950/954 port:0 irq:14"

This is the format used for nonexistent ports. Truly nonexistent ports 
always have a port type of "unknown port". kudzu depends on that. The bug 
causes the short format to be used for all memory mapped ports which have 
known types. The absence of the tx: and rx: fields in the short format 
causes kudzu to die during system initialization at the "Checking for new 
hardware" step:

    S05kudzu: Line 78: 237 Segmentation fault

This is caused by a null-pointer de-reference in kudzu's not-so-robust 
parser, when it lemmings off the end of the short line. 

This patch adds logic to check both the I/O port field and the I/O memory 
base address field to detect the presence of hardware. The patched driver 
generates the longer format text for memory mapped ports:

    "4: uart:16C950/954 port:C4800000 irq:14 tx:0 rx:0 "

Created on kernel files rev 2.4.19-pre2

Contributor: Ed Vance

ISSUES AND CONCERNS FOR DISCUSSION:

1. The patch depends on the I/O port address field and the I/O memory 
address field both being zero for unconfigured ports. Anybody know of any 
exception corner cases where a port gets partially configured and gives 
up with one of these fields left non-zero? 

2. The label on the displayed I/O memory address is "port:", just like 
an I/O port address. Should it display "iomem:" instead of "port:"?

3. A trailing space has been added to all text lines as a cushion for 
kudzu. Should this stay in?

4. Should a bug be turned in against kudzu for the weak parser? 


diff -urN -X dontdiff.txt linux-2.4.19-pre2/drivers/char/serial.c
patched/drivers/char/serial.c
--- linux-2.4.19-pre2/drivers/char/serial.c	Sat Mar  2 10:38:11 2002
+++ patched/drivers/char/serial.c	Wed Mar  6 14:31:44 2002
@@ -3260,10 +3260,12 @@
 
 	ret = sprintf(buf, "%d: uart:%s port:%lX irq:%d",
 		      state->line, uart_config[state->type].name, 
-		      state->port, state->irq);
+		      (state->port ? state->port : (long)state->iomem_base),
+		      state->irq);
 
-	if (!state->port || (state->type == PORT_UNKNOWN)) {
-		ret += sprintf(buf+ret, "\n");
+	if ((!state->port && !state->iomem_base) ||
+	    (state->type == PORT_UNKNOWN)) {
+		ret += sprintf(buf+ret, " \n");
 		return ret;
 	}
 

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------


