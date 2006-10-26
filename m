Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965295AbWJZCVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965295AbWJZCVi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 22:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422739AbWJZCU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 22:20:59 -0400
Received: from isilmar.linta.de ([213.239.214.66]:37343 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S965293AbWJZCTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 22:19:12 -0400
Date: Wed, 25 Oct 2006 22:11:43 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net,
       andrew@sanpeople.com
Subject: [RFC PATCH 1/11] pcmcia: at91_cf update
Message-ID: <20061026021143.GB20473@dominikbrodowski.de>
Mail-Followup-To: linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net,
	andrew@sanpeople.com
References: <20061026021027.GA20473@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026021027.GA20473@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>
Date: Sat, 1 Jul 2006 13:39:55 -0700
Subject: [PATCH] pcmcia: at91_cf update

More correct AT91 CF wakeup logic ... only enable/disable the IRQ wakeup
capability, not the IRQ itself.  That way the we know that the IRQ will be
disabled correctly, in suspend/resume logic instead of ARM IRQ code.

Most of the pin multiplexing setup has moved to the devices.c setup code.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Andrew Victor <andrew@sanpeople.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/at91_cf.c |   25 +++++++------------------
 1 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index 7f5df9a..f8db6e3 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -241,12 +241,6 @@ static int __init at91_cf_probe(struct p
 	csa = at91_sys_read(AT91_EBI_CSA);
 	at91_sys_write(AT91_EBI_CSA, csa | AT91_EBI_CS4A_SMC_COMPACTFLASH);
 
-	/* force poweron defaults for these pins ... */
-	(void) at91_set_A_periph(AT91_PIN_PC9, 0);	/* A25/CFRNW */
-	(void) at91_set_A_periph(AT91_PIN_PC10, 0);	/* NCS4/CFCS */
-	(void) at91_set_A_periph(AT91_PIN_PC11, 0);	/* NCS5/CFCE1 */
-	(void) at91_set_A_periph(AT91_PIN_PC12, 0);	/* NCS6/CFCE2 */
-
 	/* nWAIT is _not_ a default setting */
 	(void) at91_set_A_periph(AT91_PIN_PC6, 1);	/*  nWAIT */
 
@@ -322,6 +316,7 @@ fail1:
 	if (board->irq_pin)
 		free_irq(board->irq_pin, cf);
 fail0a:
+	device_init_wakeup(&pdev->dev, 0);
 	free_irq(board->det_pin, cf);
 	device_init_wakeup(&pdev->dev, 0);
 fail0:
@@ -360,26 +355,20 @@ static int at91_cf_suspend(struct platfo
 	struct at91_cf_data	*board = cf->board;
 
 	pcmcia_socket_dev_suspend(&pdev->dev, mesg);
-	if (device_may_wakeup(&pdev->dev))
+	if (device_may_wakeup(&pdev->dev)) {
 		enable_irq_wake(board->det_pin);
-	else {
+		if (board->irq_pin)
+			enable_irq_wake(board->irq_pin);
+	} else {
 		disable_irq_wake(board->det_pin);
-		disable_irq(board->det_pin);
+		if (board->irq_pin)
+			disable_irq_wake(board->irq_pin);
 	}
-	if (board->irq_pin)
-		disable_irq(board->irq_pin);
 	return 0;
 }
 
 static int at91_cf_resume(struct platform_device *pdev)
 {
-	struct at91_cf_socket	*cf = platform_get_drvdata(pdev);
-	struct at91_cf_data	*board = cf->board;
-
-	if (board->irq_pin)
-		enable_irq(board->irq_pin);
-	if (!device_may_wakeup(&pdev->dev))
-		enable_irq(board->det_pin);
 	pcmcia_socket_dev_resume(&pdev->dev);
 	return 0;
 }
-- 
1.4.3

