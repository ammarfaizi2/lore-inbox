Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267254AbUI0TZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267254AbUI0TZb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 15:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267180AbUI0TZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 15:25:31 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:6715 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267254AbUI0TZE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 15:25:04 -0400
Subject: 2.6.9-rc2-mm4 e100 enable_irq unbalanced from
From: Paul Fulghum <paulkf@microgate.com>
To: scott.feldman@intel.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1096313095.2601.20.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 27 Sep 2004 14:24:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The e100 module is generating a warning:

Sep 27 13:30:29 deimos kernel: e100: Intel(R) PRO/100 Network Driver, 3.1.4-NAPI
Sep 27 13:30:29 deimos kernel: e100: Copyright(c) 1999-2004 Intel Corporation
Sep 27 13:30:29 deimos kernel: e100: eth0: e100_probe: addr 0xfecfc000, irq 16, MAC addr 00:90:27:3A:C5:E3
Sep 27 13:30:29 deimos kernel: enable_irq(16) unbalanced from ec83ff33
Sep 27 13:30:29 deimos kernel:  [<c010923f>] enable_irq+0xcf/0xe0
Sep 27 13:30:29 deimos kernel:  [<ec83ff33>] e100_up+0xf3/0x1f0 [e100]
Sep 27 13:30:29 deimos kernel:  [<ec83ff33>] e100_up+0xf3/0x1f0 [e100]
Sep 27 13:30:29 deimos kernel:  [<ec83f410>] e100_intr+0x0/0x140 [e100]
Sep 27 13:30:29 deimos kernel:  [<ec841131>] e100_open+0x31/0x80 [e100]
Sep 27 13:30:29 deimos kernel:  [<c0318d4c>] dev_open+0x8c/0xa0
Sep 27 13:30:29 deimos kernel:  [<c031cc74>] dev_mc_upload+0x24/0x40
Sep 27 13:30:29 deimos kernel:  [<c031a4ea>] dev_change_flags+0x12a/0x150
Sep 27 13:30:29 deimos kernel:  [<c0318c0d>] dev_load+0x2d/0x80
Sep 27 13:30:29 deimos kernel:  [<c0355b37>] devinet_ioctl+0x277/0x730

e100_up calls disable_irq, request_irq, then enable_irq
as shown below.

static int e100_up(struct nic *nic)
{
	...
	disable_irq(nic->pdev->irq);
	...
	if((err = request_irq(nic->pdev->irq, e100_intr, SA_SHIRQ,
		nic->netdev->name, nic->netdev)))
		goto err_no_irq;
	e100_enable_irq(nic);
	enable_irq(nic->pdev->irq);
	netif_wake_queue(nic->netdev);
	return 0;
	...
}

On this machine, the e100 is the only device on that IRQ.

request_irq calls setup_irq which clears the irq descriptor
depth member to 0 and enables the interrupt because this
is the first device to use that interrupt. 
This results in the warning on the next enable_irq().

I'm not sure why the driver is calling disable_irq
IRQ before calling request_irq. You can't get that
interrupt until you call request_irq, and once you
call request_irq you can (at least when this is
the first device on that IRQ) even before the
call to enable_irq.

I suspect the correct thing is to remove
disable_irq/enable_irq from e100_up.
I don't see any purpose for these calls in e100_up.

-- 
Paul Fulghum
paulkf@microgate.com

