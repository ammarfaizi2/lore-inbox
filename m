Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269329AbUI3Q0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269329AbUI3Q0z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 12:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269337AbUI3Q0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 12:26:54 -0400
Received: from fmr12.intel.com ([134.134.136.15]:58753 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S269329AbUI3Q0q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 12:26:46 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Fix for spurious interrupts on e100 resume
Date: Thu, 30 Sep 2004 09:26:01 -0700
Message-ID: <468F3FDA28AA87429AD807992E22D07E02B55EF6@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Fix for spurious interrupts on e100 resume
Thread-Index: AcSZ5PQrnfhDIkGtSj+nfuuE+ARb5QNJJR7Q
From: "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Ronciak, John" <john.ronciak@intel.com>
Cc: "Feldman, Scott" <scott.feldman@intel.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Jeremy Fitzhardinge" <jeremy@goop.org>
X-OriginalArrivalTime: 30 Sep 2004 16:26:04.0020 (UTC) FILETIME=[2E38C340:01C4A70A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew:

I propose that we remove this patch from the -mm tree. We will work on a
clean solution and send a patch soon. Please see further discussion on
this under the subject "2.6.9-rc2-mm4 e100 enable_irq unbalanced from"

Ganesh.

-----Original Message-----
From: Jeremy Fitzhardinge [mailto:jeremy@goop.org] 
Sent: Monday, September 13, 2004 3:53 PM
To: Ronciak, John
Cc: Venkatesan, Ganesh; Feldman, Scott; Andrew Morton; linux-kernel
Subject: Re: [PATCH] Fix for spurious interrupts on e100 resume

On Thu, 2004-09-09 at 15:36 -0700, Jeremy Fitzhardinge wrote:
> I've been having problems with spurious interrupts being raised when
the
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
--- local-2.6/drivers/net/e100.c~e100-restore-irq	2004-09-13
13:38:27.000000000 -0700
+++ local-2.6-jeremy/drivers/net/e100.c	2004-09-13 13:38:28.075416972
-0700
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

