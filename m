Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUCIQJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbUCIQJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:09:27 -0500
Received: from webmail0.estadao.com.br ([200.182.48.161]:57045 "EHLO
	webmail0.estadao.com.br") by vger.kernel.org with ESMTP
	id S262031AbUCIQJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:09:13 -0500
Subject: pcmcia/serial release of memory I/O twice
From: Jose Alonso <alonso@estadao.com.br>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1078848549.3230.18.camel@laptop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Tue, 09 Mar 2004 13:09:10 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using a pcmcia modem (linux-2.6.3) and when I unplug the
card the kernel warns:
"kernel: Trying to free nonexistent resource <000003e8-000003ef>"

The allocation of I/O address is done in:
module serial_cs:
  simple_config:
    pcmcia_request_io  ---> allocate I/O address
    setup_serial ... serial8250_request_port ---> doesn't allocate I/O
                      (UPF_RESOURCES is not set)

The release of I/O address is done in:
module serial_cs:
  serial_remove:
    unregister_serial ... serial8250_release_port ---> release I/O
    pcmcia_release_io ---> release again the I/O

I suggest the patch bellow:

--- drivers/serial/8250.c.ORIG	2004-02-18 00:57:14.000000000 -0300
+++ drivers/serial/8250.c	2004-02-27 13:31:41.000000000 -0300
@@ -1670,6 +1670,8 @@
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	unsigned long start, offset = 0, size = 0;
 
+	if (!(up->port.flags & UPF_RESOURCES))
+		return;
 	if (up->port.type == PORT_RSA) {
 		offset = UART_RSA_BASE << up->port.regshift;
 		size = 8;

-- 
     alonso

