Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbUJ0Ssz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbUJ0Ssz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUJ0Ssw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:48:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:15858 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262521AbUJ0SmS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:42:18 -0400
Subject: [resend patch] HVSI early boot console
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Content-Type: text/plain
Message-Id: <1098884287.3486.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 27 Oct 2004 13:38:08 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, I've retested this with the current BK tree as you requested.

This patch adds support for the udbg early console interfaces
when using an HVSI console. Please apply.

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

-- 
Hollis Blanchard
IBM Linux Technology Center

--- arch/ppc64/kernel/pSeries_lpar.c.orig	Tue Sep 21 23:40:30 2004
+++ arch/ppc64/kernel/pSeries_lpar.c	Thu Oct  7 10:52:23 2004
@@ -59,6 +59,74 @@
 
 int vtermno;	/* virtual terminal# for udbg  */
 
+#define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))
+static void udbg_hvsi_putc(unsigned char c)
+{
+	/* packet's seqno isn't used anyways */
+	uint8_t packet[] __ALIGNED__ = { 0xff, 5, 0, 0, c };
+	int rc;
+
+	if (c == '\n')
+		udbg_hvsi_putc('\r');
+
+	do {
+		rc = plpar_put_term_char(vtermno, sizeof(packet), packet);
+	} while (rc == H_Busy);
+}
+
+static long hvsi_udbg_buf_len;
+static uint8_t hvsi_udbg_buf[256];
+
+static int udbg_hvsi_getc_poll(void)
+{
+	unsigned char ch;
+	int rc, i;
+
+	if (hvsi_udbg_buf_len == 0) {
+		rc = plpar_get_term_char(vtermno, &hvsi_udbg_buf_len, hvsi_udbg_buf);
+		if (rc != H_Success || hvsi_udbg_buf[0] != 0xff) {
+			/* bad read or non-data packet */
+			hvsi_udbg_buf_len = 0;
+		} else {
+			/* remove the packet header */
+			for (i = 4; i < hvsi_udbg_buf_len; i++)
+				hvsi_udbg_buf[i-4] = hvsi_udbg_buf[i];
+			hvsi_udbg_buf_len -= 4;
+		}
+	}
+
+	if (hvsi_udbg_buf_len <= 0 || hvsi_udbg_buf_len > 256) {
+		/* no data ready */
+		hvsi_udbg_buf_len = 0;
+		return -1;
+	}
+
+	ch = hvsi_udbg_buf[0];
+	/* shift remaining data down */
+	for (i = 1; i < hvsi_udbg_buf_len; i++) {
+		hvsi_udbg_buf[i-1] = hvsi_udbg_buf[i];
+	}
+	hvsi_udbg_buf_len--;
+
+	return ch;
+}
+
+static unsigned char udbg_hvsi_getc(void)
+{
+	int ch;
+	for (;;) {
+		ch = udbg_hvsi_getc_poll();
+		if (ch == -1) {
+			/* This shouldn't be needed...but... */
+			volatile unsigned long delay;
+			for (delay=0; delay < 2000000; delay++)
+				;
+		} else {
+			return ch;
+		}
+	}
+}
+
 static void udbg_putcLP(unsigned char c)
 {
 	char buf[16];
@@ -167,11 +235,15 @@
 				ppc_md.udbg_getc_poll = udbg_getc_pollLP;
 				found = 1;
 			}
-		} else {
-			/* XXX implement udbg_putcLP_vtty for hvterm-protocol1 case */
-			printk(KERN_WARNING "%s doesn't speak hvterm1; "
-					"can't print udbg messages\n",
-			       stdout_node->full_name);
+		} else if (device_is_compatible(stdout_node, "hvterm-protocol")) {
+			termno = (u32 *)get_property(stdout_node, "reg", NULL);
+			if (termno) {
+				vtermno = termno[0];
+				ppc_md.udbg_putc = udbg_hvsi_putc;
+				ppc_md.udbg_getc = udbg_hvsi_getc;
+				ppc_md.udbg_getc_poll = udbg_hvsi_getc_poll;
+				found = 1;
+			}
 		}
 	} else if (strncmp(name, "serial", 6)) {
 		/* XXX fix ISA serial console */


