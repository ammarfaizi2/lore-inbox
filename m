Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbTK0B2r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 20:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbTK0B2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 20:28:47 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:26334
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id S264414AbTK0B2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 20:28:45 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A34053@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'marcelo@conectiva.com.br'" <marcelo@conectiva.com.br>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial.c 2.4.23 uart_offset fix
Date: Wed, 26 Nov 2003 17:28:57 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

The serial driver has a default of 8 for the "board uart_offset" config that
is implemented at about line 3954 in a ternary expression.  It is well and
good for boards that use I/O port space, but fails in the ioremap call at
about line 3965 for boards that use memory space. The bug is that when
uart_offset is zero, it does not actually get changed to the default value,
so the ioremap call is passed a zero length.

The following patch replaces the ternary expression with an explicit check
for zero and assignment to the default value. This works for both I/O ports
and memory space.  --And it actually compiles a little smaller than the
existing code on x86! 

Please put this in at your convenience after the rc's are done. 

Thanks,
Ed

diff -urN -X dontdiff.txt linux-2.4.23-rc5/drivers/char/serial.c
linux-2.4.23-rc5-ml/drivers/char/serial.c
--- linux-2.4.23-rc5/drivers/char/serial.c	Wed Nov 26 16:23:45 2003
+++ linux-2.4.23-rc5-ml/drivers/char/serial.c	Wed Nov 26 16:38:13 2003
@@ -3950,8 +3950,11 @@
 
 	port =  pci_resource_start(dev, base_idx) + offset;
 
+	if (board->uart_offset == 0)
+		board->uart_offset = 8;
+
 	if ((board->flags & SPCI_FL_BASE_TABLE) == 0)
-		port += idx * (board->uart_offset ? board->uart_offset : 8);
+		port += idx * board->uart_offset;
 
 	if (IS_PCI_REGION_IOPORT(dev, base_idx)) {
 		req->port = port;

