Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270230AbRHMO7M>; Mon, 13 Aug 2001 10:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270240AbRHMO7C>; Mon, 13 Aug 2001 10:59:02 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:60937 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S270230AbRHMO6w>;
	Mon, 13 Aug 2001 10:58:52 -0400
Date: Mon, 13 Aug 2001 16:59:03 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.4.8-ac2] sonypi driver updates (PPK keys)
Message-ID: <20010813165903.I24523@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch allows the sonypi driver to recognize the PPK keys
found on some Sony Vaio laptops (at least on PCG-104k).

All credits for this addition go to Daniel Caujolle-Bert.

Alan, please apply.

Stelian.

diff -uNr --exclude-from=dontdiff linux-2.4.8-ac2.orig/drivers/char/sonypi.c linux-2.4.8-ac2/drivers/char/sonypi.c
--- linux-2.4.8-ac2.orig/drivers/char/sonypi.c	Mon Aug 13 16:09:51 2001
+++ linux-2.4.8-ac2/drivers/char/sonypi.c	Mon Aug 13 16:11:59 2001
@@ -303,6 +303,13 @@
 	v1 = inb_p(sonypi_device.ioport1);
 	v2 = inb_p(sonypi_device.ioport2);
 
+	if ((v2 & SONYPI_NORMAL_PKEY_EV) == SONYPI_NORMAL_PKEY_EV) {
+		for (i = 0; sonypi_pkeyev[i].event; i++)
+			if (sonypi_pkeyev[i].data == v1) {
+				event = sonypi_pkeyev[i].event;
+				goto found;
+			}
+	}
 	if ((v2 & sonypi_jogger_ev) == sonypi_jogger_ev) {
 		for (i = 0; sonypi_joggerev[i].event; i++)
 			if (sonypi_joggerev[i].data == v1) {
@@ -586,7 +593,7 @@
 
 	for (i = 0; irq_list[i].irq; i++) {
 		if (!request_irq(irq_list[i].irq, sonypi_irq, 
-				 SA_INTERRUPT, "sonypi", sonypi_irq)) {
+				 SA_SHIRQ, "sonypi", sonypi_irq)) {
 			sonypi_device.irq = irq_list[i].irq;
 			sonypi_device.bits = irq_list[i].bits;
 			break;
diff -uNr --exclude-from=dontdiff linux-2.4.8-ac2.orig/drivers/char/sonypi.h linux-2.4.8-ac2/drivers/char/sonypi.h
--- linux-2.4.8-ac2.orig/drivers/char/sonypi.h	Mon Aug 13 16:09:51 2001
+++ linux-2.4.8-ac2/drivers/char/sonypi.h	Mon Aug 13 16:07:19 2001
@@ -35,7 +35,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	1
-#define SONYPI_DRIVER_MINORVERSION	4
+#define SONYPI_DRIVER_MINORVERSION	5
 
 #include <linux/types.h>
 #include <linux/pci.h>
@@ -138,6 +138,7 @@
 #define SONYPI_NORMAL_FNKEY_EV	0x20
 #define SONYPI_R505_FNKEY_EV	0x08
 #define SONYPI_BLUETOOTH_EV	0x30
+#define SONYPI_NORMAL_PKEY_EV	0x40
 
 struct sonypi_event {
 	u8	data;
@@ -186,6 +187,14 @@
 	{ 0x33, SONYPI_EVENT_FNKEY_F },
 	{ 0x34, SONYPI_EVENT_FNKEY_S },
 	{ 0x35, SONYPI_EVENT_FNKEY_B },
+	{ 0x00, 0x00 }
+};
+
+/* The set of possible program key events */
+static struct sonypi_event sonypi_pkeyev[] = {
+	{ 0x01, SONYPI_EVENT_PKEY_P1 },
+	{ 0x02, SONYPI_EVENT_PKEY_P2 },
+	{ 0x04, SONYPI_EVENT_PKEY_P3 },
 	{ 0x00, 0x00 }
 };
 
diff -uNr --exclude-from=dontdiff linux-2.4.8-ac2.orig/include/linux/sonypi.h linux-2.4.8-ac2/include/linux/sonypi.h
--- linux-2.4.8-ac2.orig/include/linux/sonypi.h	Wed Jul  4 23:41:33 2001
+++ linux-2.4.8-ac2/include/linux/sonypi.h	Mon Aug 13 16:06:52 2001
@@ -67,6 +67,10 @@
 #define SONYPI_EVENT_FNKEY_S			29
 #define SONYPI_EVENT_FNKEY_B			30
 #define SONYPI_EVENT_BLUETOOTH_PRESSED		31
+#define SONYPI_EVENT_PKEY_P1                    32
+#define SONYPI_EVENT_PKEY_P2                    33
+#define SONYPI_EVENT_PKEY_P3                    34
+
 
 /* brightness etc. ioctls */
 #define SONYPI_IOCGBRT	_IOR('v', 0, __u8)
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
