Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVCBXZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVCBXZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVCBXWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:22:10 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:39659 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261313AbVCBXUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:20:22 -0500
Date: Thu, 3 Mar 2005 08:20:13 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.11-rc5-mm1] serial: update vr41xx_siu
Message-Id: <20050303082013.52d91b3e.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates serial driver for VR41xx serial unit.
Some check are added to verify_port.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/drivers/serial/vr41xx_siu.c a/drivers/serial/vr41xx_siu.c
--- a-orig/drivers/serial/vr41xx_siu.c	Wed Mar  2 01:04:39 2005
+++ a/drivers/serial/vr41xx_siu.c	Wed Mar  2 07:40:25 2005
@@ -702,15 +702,17 @@
 static int siu_request_port(struct uart_port *port)
 {
 	unsigned long size;
+	struct resource *res;
 
 	size = siu_port_size(port);
-	if (request_mem_region(port->mapbase, size, siu_type_name(port)) == NULL)
+	res = request_mem_region(port->mapbase, size, siu_type_name(port));
+	if (res == NULL)
 		return -EBUSY;
 
 	if (port->flags & UPF_IOREMAP) {
 		port->membase = ioremap(port->mapbase, size);
 		if (port->membase == NULL) {
-			release_mem_region(port->mapbase, size);
+			release_resource(res);
 			return -ENOMEM;
 		}
 	}
@@ -729,6 +731,12 @@
 static int siu_verify_port(struct uart_port *port, struct serial_struct *serial)
 {
 	if (port->type != PORT_VR41XX_SIU && port->type != PORT_VR41XX_DSIU)
+		return -EINVAL;
+	if (port->irq != serial->irq)
+		return -EINVAL;
+	if (port->iotype != serial->io_type)
+		return -EINVAL;
+	if (port->mapbase != (unsigned long)serial->iomem_base)
 		return -EINVAL;
 
 	return 0;
