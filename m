Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUGMAjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUGMAjk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbUGMAjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:39:40 -0400
Received: from havoc.gtf.org ([216.162.42.101]:7040 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264297AbUGMAjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:39:36 -0400
Date: Mon, 12 Jul 2004 20:39:35 -0400
From: David Eger <eger@havoc.gtf.org>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pmac_zilog: initialize port spinlock on all init paths
Message-ID: <20040713003935.GA1050@havoc.gtf.org>
References: <20040712075113.GB19875@havoc.gtf.org> <20040712082104.GA22366@havoc.gtf.org> <20040712220935.GA20049@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712220935.GA20049@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ben,

This patch fixes the Zilog driver so it doesn't freak on my TiBook.

( of course, it still spews diahrea of 'IN from bad port XXXXXXXX'
  but then, I don't have the hardware.... still, seems weird that OF
  would report that I do have said hardware :-/ )

Please look it over and send it on.

-dte

pmac_zilog: initialize the serial ports' spinlocks even if console over 
   serial is not enabled; disable this driver by default for ppc

This lock not being initialized was Oopsing my TiBook :-P

Signed-off-by: David Eger <eger@havoc.gtf.org>

diff -Nru a/arch/ppc/defconfig b/arch/ppc/defconfig
--- a/arch/ppc/defconfig	2004-07-13 02:30:37 +02:00
+++ b/arch/ppc/defconfig	2004-07-13 02:30:37 +02:00
@@ -689,7 +689,7 @@
 # Input Device Drivers
 #
 CONFIG_INPUT_KEYBOARD=y
-CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_KEYBOARD_SUNKBD is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
@@ -724,8 +724,8 @@
 #
 # Non-8250 serial port support
 #
-CONFIG_SERIAL_CORE=y
-CONFIG_SERIAL_PMACZILOG=y
+# CONFIG_SERIAL_CORE is not set
+# CONFIG_SERIAL_PMACZILOG is not set
 # CONFIG_SERIAL_PMACZILOG_CONSOLE is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
diff -Nru a/drivers/serial/pmac_zilog.c b/drivers/serial/pmac_zilog.c
--- a/drivers/serial/pmac_zilog.c	2004-07-13 02:30:37 +02:00
+++ b/drivers/serial/pmac_zilog.c	2004-07-13 02:30:37 +02:00
@@ -1490,6 +1490,7 @@
 	uap->port.ops = &pmz_pops;
 	uap->port.type = PORT_PMAC_ZILOG;
 	uap->port.flags = 0;
+	spin_lock_init(&uap->port.lock);
 
 	/* Setup some valid baud rate information in the register
 	 * shadows so we don't write crap there before baud rate is
@@ -1985,8 +1986,6 @@
 	/* Probe ports */
 	pmz_probe();
 
-#ifdef CONFIG_SERIAL_PMACZILOG_CONSOLE
-#endif
 	/* TODO: Autoprobe console based on OF */
 	/* pmz_console.index = i; */
 	register_console(&pmz_console);
