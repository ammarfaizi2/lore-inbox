Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUC2IwA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 03:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbUC2IwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 03:52:00 -0500
Received: from smtp-out.girce.epro.fr ([195.6.195.146]:22669 "EHLO
	srvsec1.girce.epro.fr") by vger.kernel.org with ESMTP
	id S262766AbUC2Iv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 03:51:57 -0500
Message-ID: <156701c4156b$0be816a0$3cc8a8c0@epro.dom>
From: "Colin Leroy" <colin@colino.net>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix oops at pmac_zilog rmmod'ing
Date: Mon, 29 Mar 2004 10:51:37 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_1564_01C4157B.CF51ECF0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_1564_01C4157B.CF51ECF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

rmmod'ing pmac_zilog currently oopses because uart_unregister_driver(),
which nullifies drv->tty_driver, is called before uart_remove_one_port(),
which uses said drv->tty_driver.

The comment at top of uart_unregister_driver() specifically says we have
to have removed all our ports
via uart_remove_one_port() before.

HTH,
-- 
Colin
  This message represents the official view of the voices
  in my head.

------=_NextPart_000_1564_01C4157B.CF51ECF0
Content-Type: application/octet-stream;
	name="pmac_zilog_fix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pmac_zilog_fix.patch"

--- drivers/serial/pmac_zilog.c.orig	2004-03-29 10:41:22.000000000 +0200=0A=
+++ drivers/serial/pmac_zilog.c	2004-03-29 10:42:07.000000000 +0200=0A=
@@ -1875,9 +1875,6 @@=0A=
 	/* Get rid of macio-driver (detach from macio) */=0A=
 	macio_unregister_driver(&pmz_driver);=0A=
 =0A=
-	/* Unregister UART driver */=0A=
-	uart_unregister_driver(&pmz_uart_reg);=0A=
-=0A=
 	for (i =3D 0; i < pmz_ports_count; i++) {=0A=
 		struct uart_pmac_port *uport =3D &pmz_ports[i];=0A=
 		if (uport->node !=3D NULL) {=0A=
@@ -1885,6 +1882,8 @@=0A=
 			pmz_dispose_port(uport);=0A=
 		}=0A=
 	}=0A=
+	/* Unregister UART driver */=0A=
+	uart_unregister_driver(&pmz_uart_reg);=0A=
 }=0A=
 =0A=
 #ifdef CONFIG_SERIAL_PMACZILOG_CONSOLE=0A=

------=_NextPart_000_1564_01C4157B.CF51ECF0--

