Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269039AbUIMW71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269039AbUIMW71 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269030AbUIMW5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:57:55 -0400
Received: from gw.goop.org ([64.81.55.164]:8358 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S269026AbUIMW4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:56:23 -0400
Subject: Re: [PATCH] Fix for spurious interrupts on e100 resume
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: john.ronciak@intel.com
Cc: ganesh.venkatesan@intel.com, scott.feldman@intel.com,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1094769368.4298.7.camel@localhost>
References: <1094769368.4298.7.camel@localhost>
Content-Type: text/plain
Date: Mon, 13 Sep 2004 15:53:11 -0700
Message-Id: <1095115991.20501.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 15:36 -0700, Jeremy Fitzhardinge wrote:
> I've been having problems with spurious interrupts being raised when the
> e100 driver resets the chip during a resume:

OK, that patch didn't really work terribly well - the interrupt still
happens.  I've changed it to simply disable the interrupt during e100_up
(), which does seem to work properly.

	J



On resume, the e100 chip seems to raise an interrupt during chip reset.
Since there's no IRQ handler registered yet, the kernel complains that
"nobody cared" about the interrupt.  This change disables the IRQ during
e100_up(), while the hardware is being (re-)initialized.


 drivers/net/e100.c |    6 ++++++
 1 files changed, 6 insertions(+)

diff -puN drivers/net/e100.c~e100-restore-irq drivers/net/e100.c
--- local-2.6/drivers/net/e100.c~e100-restore-irq	2004-09-13 13:38:27.000000000 -0700
+++ local-2.6-jeremy/drivers/net/e100.c	2004-09-13 13:38:28.075416972 -0700
@@ -1678,6 +1678,9 @@ static int e100_up(struct nic *nic)
 
 	if((err = e100_rx_alloc_list(nic)))
 		return err;
+
+	disable_irq(nic->pdev->irq);
+
 	if((err = e100_alloc_cbs(nic)))
 		goto err_rx_clean_list;
 	if((err = e100_hw_init(nic)))
@@ -1689,6 +1692,7 @@ static int e100_up(struct nic *nic)
 		nic->netdev->name, nic->netdev)))
 		goto err_no_irq;
 	e100_enable_irq(nic);
+	enable_irq(nic->pdev->irq);
 	netif_wake_queue(nic->netdev);
 	return 0;
 
@@ -1698,6 +1702,8 @@ err_clean_cbs:
 	e100_clean_cbs(nic);
 err_rx_clean_list:
 	e100_rx_clean_list(nic);
+
+	enable_irq(nic->pdev->irq);
 	return err;
 }
 

_
Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

