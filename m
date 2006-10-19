Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946454AbWJSU1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946454AbWJSU1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946460AbWJSU0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:26:51 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:31388 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1946456AbWJSU0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:26:47 -0400
Message-id: <1124097211503417126@wsc.cz>
Subject: [PATCH 5/7] Char: isicom, move to tty_register_device
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Thu, 19 Oct 2006 22:26:59 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, move to tty_register_device

Instead of registering all devices in register_tty_driver, register devices in
probe function and register only port_count devices.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 780d1e45bab78cb6cc6c79037bfe0986bc999332
tree db4ce54aba8eff0bfbed4afe41bbffbbe33204a8
parent a2d2f722e0d805a57d7835e715c520ca7a7580a7
author Jiri Slaby <jirislaby@gmail.com> Thu, 19 Oct 2006 19:39:23 +0200
committer Jiri Slaby <jirislaby@gmail.com> Thu, 19 Oct 2006 19:39:23 +0200

 drivers/char/isicom.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 1b9ef44..f07226a 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -195,6 +195,7 @@ struct	isi_board {
 	signed char		count;
 	spinlock_t		card_lock; /* Card wide lock 11/5/00 -sameer */
 	unsigned long		flags;
+	unsigned int		index;
 };
 
 struct	isi_port {
@@ -1780,6 +1781,7 @@ static int __devinit isicom_probe(struct
 			break;
 		}
 
+	board->index = index;
 	board->base = ioaddr;
 	board->irq = pciirq;
 	card++;
@@ -1810,6 +1812,10 @@ static int __devinit isicom_probe(struct
 	if (retval < 0)
 		goto errunri;
 
+	for (index = 0; index < board->port_count; index++)
+		tty_register_device(isicom_normal, board->index * 16 + index,
+				&pdev->dev);
+
 	return 0;
 
 errunri:
@@ -1824,6 +1830,10 @@ err:
 static void __devexit isicom_remove(struct pci_dev *pdev)
 {
 	struct isi_board *board = pci_get_drvdata(pdev);
+	unsigned int i;
+
+	for (i = 0; i < board->port_count; i++)
+		tty_unregister_device(isicom_normal, board->index * 16 + i);
 
 	free_irq(board->irq, board);
 	release_region(board->base, 16);
@@ -1873,7 +1883,8 @@ static int __init isicom_init(void)
 	isicom_normal->init_termios		= tty_std_termios;
 	isicom_normal->init_termios.c_cflag	= B9600 | CS8 | CREAD | HUPCL |
 		CLOCAL;
-	isicom_normal->flags			= TTY_DRIVER_REAL_RAW;
+	isicom_normal->flags			= TTY_DRIVER_REAL_RAW |
+		TTY_DRIVER_DYNAMIC_DEV;
 	tty_set_operations(isicom_normal, &isicom_ops);
 
 	retval = tty_register_driver(isicom_normal);
