Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281409AbRKEW5M>; Mon, 5 Nov 2001 17:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281410AbRKEW5D>; Mon, 5 Nov 2001 17:57:03 -0500
Received: from inetc.connecttech.com ([64.7.140.42]:18186 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id <S281409AbRKEW4v>; Mon, 5 Nov 2001 17:56:51 -0500
Message-ID: <054801c1664d$8bc8eb80$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: <linux-kernel@vger.kernel.org>
Subject: [Patch] Serial lockup fixed
Date: Mon, 5 Nov 2001 17:59:38 -0500
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After installing any serial-5.00 or later in kernels 2.2.18, 19 or 20,
rs_init is entered twice. This results in the serial timer being added
twice, which corrupts the timer list and causes an infinite loop. The
symptom is a complete hang on boot, usually just after the "Freeing
unused kernel memory" message.

Pre 18 the call path is do_basic_setup() -> device_setup() ->
chr_dev_setup() -> tty_init() -> rs_init().

In 2.4.x rs_init is entered with the module_init() (__initcall) magic.

The attached is for 2.2.20, and simply removes the tty_init() ->
rs_init() path. This mimics 2.4.x.

There might be an issue; do_initcalls() is slightly later in
do_basic_setup() than device_setup(), but the in between code looks
similar to 2.4.x kernels so I don't think it's a problem delaying the
serial init.

I'll post the slightly less elegant hack to the serial driver that
compensates for the broken kernels shortly.

Patch status is: Works For Me. Testers needed.

..Stu

----

diff -ru linux-2.2.20/drivers/char/tty_io.c
linux-2.2.20-serial-init-fix/drivers/char/tty_io.c
--- linux-2.2.20/drivers/char/tty_io.c Fri Nov  2 11:39:06 2001
+++ linux-2.2.20-serial-init-fix/drivers/char/tty_io.c Mon Nov  5 22:03:54
2001
@@ -2189,9 +2189,6 @@
 #ifdef CONFIG_ESPSERIAL  /* init ESP before rs, so rs doesn't see the port
*/
  espserial_init();
 #endif
-#ifdef CONFIG_SERIAL
- rs_init();
-#endif
 #ifdef CONFIG_COMPUTONE
  ip2_init();
 #endif


