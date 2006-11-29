Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967382AbWK2PGC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967382AbWK2PGC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 10:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967391AbWK2PGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 10:06:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:52456 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S967382AbWK2PGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 10:06:01 -0500
X-Authenticated: #14349625
Subject: [2.6.16-rc6-mm2 patch] make 8250_pnp serial driver work after
	suspend to ram
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 16:05:00 +0100
Message-Id: <1164812700.6169.13.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add suspend/resume methods to drivers/serial/8250_pnp.c.  Tested on a
P4/HT 16550A box, ttyS0 login survives across suspend to ram.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.19-rc6-mm2/drivers/serial/8250_pnp.c.org	2006-11-29 07:14:15.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/serial/8250_pnp.c	2006-11-29 10:55:17.000000000 +0100
@@ -464,11 +464,38 @@ static void __devexit serial_pnp_remove(
 		serial8250_unregister_port(line - 1);
 }
 
+#ifdef CONFIG_PM
+static int serial_pnp_suspend(struct pnp_dev *dev, pm_message_t state)
+{
+	long line = (long)pnp_get_drvdata(dev);
+
+	if (!line)
+		return -ENODEV;
+	serial8250_suspend_port(line - 1);
+	return 0;
+}
+
+static int serial_pnp_resume(struct pnp_dev *dev)
+{
+	long line = (long)pnp_get_drvdata(dev);
+
+	if (!line)
+		return -ENODEV;
+	serial8250_resume_port(line - 1);
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
 static struct pnp_driver serial_pnp_driver = {
 	.name		= "serial",
-	.id_table	= pnp_dev_table,
 	.probe		= serial_pnp_probe,
 	.remove		= __devexit_p(serial_pnp_remove),
+#ifdef CONFIG_PM
+	.suspend	= serial_pnp_suspend,
+	.resume		= serial_pnp_resume,
+#endif
+	.id_table	= pnp_dev_table,
 };
 
 static int __init serial8250_pnp_init(void)


