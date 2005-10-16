Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbVJPUcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVJPUcx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 16:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVJPUcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 16:32:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19209 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751305AbVJPUcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 16:32:53 -0400
Date: Sun, 16 Oct 2005 21:32:46 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Neela.Kolli@engenio.com
Subject: Re: [PATCH 2/2] Convert megaraid to use pci_driver shutdown method
Message-ID: <20051016203246.GE14413@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	Neela.Kolli@engenio.com
References: <20051016203135.GD14413@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051016203135.GD14413@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert megaraid to use pci_driver's shutdown method rather than
the generic device_driver shutdown method.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -76,7 +76,7 @@ static void megaraid_exit(void);
 
 static int megaraid_probe_one(struct pci_dev*, const struct pci_device_id *);
 static void megaraid_detach_one(struct pci_dev *);
-static void megaraid_mbox_shutdown(struct device *);
+static void megaraid_mbox_shutdown(struct pci_dev *);
 
 static int megaraid_io_attach(adapter_t *);
 static void megaraid_io_detach(adapter_t *);
@@ -369,9 +369,7 @@ static struct pci_driver megaraid_pci_dr
 	.id_table	= pci_id_table_g,
 	.probe		= megaraid_probe_one,
 	.remove		= __devexit_p(megaraid_detach_one),
-	.driver		= {
-		.shutdown	= megaraid_mbox_shutdown,
-	}
+	.shutdown	= megaraid_mbox_shutdown,
 };
 
 
@@ -673,9 +671,9 @@ megaraid_detach_one(struct pci_dev *pdev
  * Shutdown notification, perform flush cache
  */
 static void
-megaraid_mbox_shutdown(struct device *device)
+megaraid_mbox_shutdown(struct pci_dev *pdev)
 {
-	adapter_t		*adapter = pci_get_drvdata(to_pci_dev(device));
+	adapter_t		*adapter = pci_get_drvdata(pdev);
 	static int		counter;
 
 	if (!adapter) {

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
