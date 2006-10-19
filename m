Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946455AbWJSU0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946455AbWJSU0s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946457AbWJSU0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:26:48 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:28060 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1946454AbWJSU0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:26:46 -0400
Message-id: <243631749332825758@wsc.cz>
Subject: [PATCH 1/7] Char: isicom, expand function
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Thu, 19 Oct 2006 22:26:57 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, expand function

Simple functions (those, that calls reuest_irq, request_region et al) may be
expanded directly in code. It makes probe function more readable and
transparent.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 71d53f8a4e470e305f9cb9ea5a25ebda21c0cd31
tree 76e93e62a471cee2a9e841944743115aa9bfc90b
parent 3202b22139e878e0e4366c82fe166b51f0b920eb
author Jiri Slaby <jirislaby@gmail.com> Thu, 19 Oct 2006 19:18:21 +0200
committer Jiri Slaby <jirislaby@gmail.com> Thu, 19 Oct 2006 19:18:21 +0200

 drivers/char/isicom.c |  151 ++++++++++++++-----------------------------------
 1 files changed, 44 insertions(+), 107 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index e9e9bf3..c9563c2 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -1519,37 +1519,6 @@ static void isicom_flush_buffer(struct t
  * Driver init and deinit functions
  */
 
-static int __devinit isicom_register_ioregion(struct pci_dev *pdev,
-	const unsigned int index)
-{
-	struct isi_board *board = pci_get_drvdata(pdev);
-
-	if (!board->base)
-		return -EINVAL;
-
-	if (!request_region(board->base, 16, ISICOM_NAME)) {
-		dev_dbg(&pdev->dev, "I/O Region 0x%lx-0x%lx is busy. Card%d "
-			"will be disabled.\n", board->base, board->base + 15,
-			index + 1);
-		return -EBUSY;
- 	}
-
-	return 0;
-}
-
-static void isicom_unregister_ioregion(struct pci_dev *pdev)
-{
-	struct isi_board *board = pci_get_drvdata(pdev);
-
-	if (!board->base)
-		return;
-
-	release_region(board->base, 16);
-	dev_dbg(&pdev->dev, "I/O Region 0x%lx-0x%lx released.\n",
-		board->base, board->base + 15);
-	board->base = 0;
-}
-
 static const struct tty_operations isicom_ops = {
 	.open			= isicom_open,
 	.close			= isicom_close,
@@ -1570,70 +1539,6 @@ static const struct tty_operations isico
 	.tiocmset		= isicom_tiocmset,
 };
 
-static int __devinit isicom_register_tty_driver(void)
-{
-	int error = -ENOMEM;
-
-	/* tty driver structure initialization */
-	isicom_normal = alloc_tty_driver(PORT_COUNT);
-	if (!isicom_normal)
-		goto end;
-
-	isicom_normal->owner			= THIS_MODULE;
-	isicom_normal->name 			= "ttyM";
-	isicom_normal->major			= ISICOM_NMAJOR;
-	isicom_normal->minor_start		= 0;
-	isicom_normal->type			= TTY_DRIVER_TYPE_SERIAL;
-	isicom_normal->subtype			= SERIAL_TYPE_NORMAL;
-	isicom_normal->init_termios		= tty_std_termios;
-	isicom_normal->init_termios.c_cflag	= B9600 | CS8 | CREAD | HUPCL |
-		CLOCAL;
-	isicom_normal->flags			= TTY_DRIVER_REAL_RAW;
-	tty_set_operations(isicom_normal, &isicom_ops);
-
-	if ((error = tty_register_driver(isicom_normal))) {
-		pr_dbg("Couldn't register the dialin driver, error=%d\n",
-			error);
-		put_tty_driver(isicom_normal);
-	}
-end:
-	return error;
-}
-
-static void isicom_unregister_tty_driver(void)
-{
-	int error;
-
-	if ((error = tty_unregister_driver(isicom_normal)))
-		pr_dbg("couldn't unregister normal driver, error=%d.\n", error);
-
-	put_tty_driver(isicom_normal);
-}
-
-static int __devinit isicom_register_isr(struct pci_dev *pdev,
-	const unsigned int index)
-{
-	struct isi_board *board = pci_get_drvdata(pdev);
-	unsigned long irqflags = IRQF_DISABLED;
-	int retval = -EINVAL;
-
-	if (!board->base)
-		goto end;
-
-	if (board->isa == NO)
-		irqflags |= IRQF_SHARED;
-
-	retval = request_irq(board->irq, isicom_interrupt, irqflags,
-		ISICOM_NAME, board);
-	if (retval < 0)
-		dev_warn(&pdev->dev, "Could not install handler at Irq %d. "
-			"Card%d will be disabled.\n", board->irq, index + 1);
- 	else
-		retval = 0;
-end:
-	return retval;
-}
-
 static int __devinit reset_card(struct pci_dev *pdev,
 	const unsigned int card, unsigned int *signature)
 {
@@ -1912,13 +1817,21 @@ static int __devinit isicom_probe(struct
 
 	pci_set_drvdata(pdev, board);
 
-	retval = isicom_register_ioregion(pdev, index);
-	if (retval < 0)
+	if (!request_region(board->base, 16, ISICOM_NAME)) {
+		dev_err(&pdev->dev, "I/O Region 0x%lx-0x%lx is busy. Card%d "
+			"will be disabled.\n", board->base, board->base + 15,
+			index + 1);
+		retval = -EBUSY;
 		goto err;
+ 	}
 
-	retval = isicom_register_isr(pdev, index);
-	if (retval < 0)
+	retval = request_irq(board->irq, isicom_interrupt,
+			IRQF_SHARED | IRQF_DISABLED, ISICOM_NAME, board);
+	if (retval < 0) {
+		dev_err(&pdev->dev, "Could not install handler at Irq %d. "
+			"Card%d will be disabled.\n", board->irq, index + 1);
 		goto errunrr;
+	}
 
 	retval = reset_card(pdev, index, &signature);
 	if (retval < 0)
@@ -1933,7 +1846,7 @@ static int __devinit isicom_probe(struct
 errunri:
 	free_irq(board->irq, board);
 errunrr:
-	isicom_unregister_ioregion(pdev);
+	release_region(board->base, 16);
 err:
 	board->base = 0;
 	return retval;
@@ -1944,7 +1857,7 @@ static void __devexit isicom_remove(stru
 	struct isi_board *board = pci_get_drvdata(pdev);
 
 	free_irq(board->irq, board);
-	isicom_unregister_ioregion(pdev);
+	release_region(board->base, 16);
 }
 
 static int __devinit isicom_setup(void)
@@ -1990,14 +1903,35 @@ static int __devinit isicom_setup(void)
 				"Disabling Card%d...\n", irq[idx], idx + 1);
 	}
 
-	retval = isicom_register_tty_driver();
-	if (retval < 0)
+	/* tty driver structure initialization */
+	isicom_normal = alloc_tty_driver(PORT_COUNT);
+	if (!isicom_normal) {
+		retval = -ENOMEM;
 		goto error;
+	}
+
+	isicom_normal->owner			= THIS_MODULE;
+	isicom_normal->name 			= "ttyM";
+	isicom_normal->major			= ISICOM_NMAJOR;
+	isicom_normal->minor_start		= 0;
+	isicom_normal->type			= TTY_DRIVER_TYPE_SERIAL;
+	isicom_normal->subtype			= SERIAL_TYPE_NORMAL;
+	isicom_normal->init_termios		= tty_std_termios;
+	isicom_normal->init_termios.c_cflag	= B9600 | CS8 | CREAD | HUPCL |
+		CLOCAL;
+	isicom_normal->flags			= TTY_DRIVER_REAL_RAW;
+	tty_set_operations(isicom_normal, &isicom_ops);
+
+	retval = tty_register_driver(isicom_normal);
+	if (retval) {
+		pr_dbg("Couldn't register the dialin driver\n");
+		goto err_puttty;
+	}
 
 	retval = pci_register_driver(&isicom_driver);
 	if (retval < 0) {
 		printk(KERN_ERR "ISICOM: Unable to register pci driver.\n");
-		goto errtty;
+		goto err_unrtty;
 	}
 
 	init_timer(&tx);
@@ -2008,8 +1942,10 @@ static int __devinit isicom_setup(void)
 	add_timer(&tx);
 
 	return 0;
-errtty:
-	isicom_unregister_tty_driver();
+err_unrtty:
+	tty_unregister_driver(isicom_normal);
+err_puttty:
+	put_tty_driver(isicom_normal);
 error:
 	return retval;
 }
@@ -2024,7 +1960,8 @@ static void __exit isicom_exit(void)
 		msleep(10);
 
 	pci_unregister_driver(&isicom_driver);
-	isicom_unregister_tty_driver();
+	tty_unregister_driver(isicom_normal);
+	put_tty_driver(isicom_normal);
 }
 
 module_init(isicom_setup);
