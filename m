Return-Path: <linux-kernel-owner+w=401wt.eu-S932710AbWLZQml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbWLZQml (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 11:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbWLZQml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 11:42:41 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:55731 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S932710AbWLZQmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 11:42:40 -0500
Date: Tue, 26 Dec 2006 19:43:17 +0300
From: Vitaly Wool <vitalywool@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 8250: make probing for TXEN bug a config option
Message-Id: <20061226194317.3fd3ec14.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

probing for UART_BUG_TXEN in 8250 driver leads to weird effects on some ARM boards (pnx4008 for instance). That is, the driver detects  UART_BUG_TXEN (though it apparently shouldn't) and it leads to symbol loss in console on input (i. e. you input 'a' and you get nothing, then you input 'b' and you get 'a', then you input 'c' and get 'b' and so on).

The patch below makes this very probing a configuration option turned on by default.

 drivers/serial/8250.c  |    5 ++++-
 drivers/serial/Kconfig |   10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 51f3c73..cf3eb31 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1645,6 +1645,7 @@ static int serial8250_startup(struct uar
 
 	serial8250_set_mctrl(&up->port, up->port.mctrl);
 
+#ifndef CONFIG_SERIAL_8250_DONT_TEST_BUG_TXEN
 	/*
 	 * Do a quick test to see if we receive an
 	 * interrupt when we enable the TX irq.
@@ -1660,7 +1661,9 @@ static int serial8250_startup(struct uar
 			pr_debug("ttyS%d - enabling bad tx status workarounds\n",
 				 port->line);
 		}
-	} else {
+	} else
+#endif
+	{
 		up->bugs &= ~UART_BUG_TXEN;
 	}
 
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 2978c09..7efcaf3 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -223,6 +223,16 @@ config SERIAL_8250_DETECT_IRQ
 
 	  If unsure, say N.
 
+config SERIAL_8250_DONT_TEST_BUG_TXEN
+	bool "Don't probe for TXEN bug"
+	depends on SERIAL_8250_EXTENDED
+	help
+	  Say Y here if you don't want the kernel to probe for TXEN bug
+	  on your serial port and try to workaround it. It might lead to
+	  character loss on some boards, though this is quite a rare case.
+
+	  If unsure, say N.
+
 config SERIAL_8250_RSA
 	bool "Support RSA serial ports"
 	depends on SERIAL_8250_EXTENDED
