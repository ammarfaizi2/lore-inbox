Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267389AbUI0VSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267389AbUI0VSN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 17:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbUI0VQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 17:16:37 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:31045 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267389AbUI0VNx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 17:13:53 -0400
Subject: Re: 2.6.9-rc2-mm4 e100 enable_irq unbalanced from
From: Paul Fulghum <paulkf@microgate.com>
To: scott.feldman@intel.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1096313095.2601.20.camel@deimos.microgate.com>
References: <1096313095.2601.20.camel@deimos.microgate.com>
Content-Type: text/plain
Message-Id: <1096319558.3859.5.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 27 Sep 2004 16:12:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 14:24, Paul Fulghum wrote:
> The e100 module is generating a warning:
> 
> Sep 27 13:30:29 deimos kernel: e100: Intel(R) PRO/100 Network Driver, 3.1.4-NAPI
> Sep 27 13:30:29 deimos kernel: e100: Copyright(c) 1999-2004 Intel Corporation
> Sep 27 13:30:29 deimos kernel: e100: eth0: e100_probe: addr 0xfecfc000, irq 16, MAC addr 00:90:27:3A:C5:E3
> Sep 27 13:30:29 deimos kernel: enable_irq(16) unbalanced from ec83ff33
> Sep 27 13:30:29 deimos kernel:  [<c010923f>] enable_irq+0xcf/0xe0
> Sep 27 13:30:29 deimos kernel:  [<ec83ff33>] e100_up+0xf3/0x1f0 [e100]

The following patch works for me and removes the warning.

The disable_irq/enable_irq is not needed because
the ISR can't be called before calling request_irq,
the hardware is initialized before calling request_irq,
and request_irq itself enables the interrupt if needed.

Comments?

-- 
Paul Fulghum
paulkf@microgate.com

--- a/drivers/net/e100.c	2004-09-27 09:57:35.000000000 -0500
+++ b/drivers/net/e100.c	2004-09-27 16:00:12.115482112 -0500
@@ -1675,9 +1675,6 @@
 
 	if((err = e100_rx_alloc_list(nic)))
 		return err;
-
-	disable_irq(nic->pdev->irq);
-
 	if((err = e100_alloc_cbs(nic)))
 		goto err_rx_clean_list;
 	if((err = e100_hw_init(nic)))
@@ -1689,7 +1686,6 @@
 		nic->netdev->name, nic->netdev)))
 		goto err_no_irq;
 	e100_enable_irq(nic);
-	enable_irq(nic->pdev->irq);
 	netif_wake_queue(nic->netdev);
 	return 0;
 
@@ -1700,7 +1696,6 @@
 err_rx_clean_list:
 	e100_rx_clean_list(nic);
 
-	enable_irq(nic->pdev->irq);
 	return err;
 }
 


