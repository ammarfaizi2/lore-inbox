Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUCBGPT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 01:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbUCBGPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 01:15:19 -0500
Received: from freedom.icomedias.com ([62.99.232.79]:7174 "EHLO
	freedom.grz.icomedias.com") by vger.kernel.org with ESMTP
	id S261568AbUCBGPP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 01:15:15 -0500
Content-class: urn:content-classes:message
Subject: Re: Network error with Intel E1000 Adapter on update 2.4.25 ==> 2.6.3
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Tue, 2 Mar 2004 07:15:11 +0100
Message-ID: <FA095C015271B64E99B197937712FD020B01C1@freedom.grz.icomedias.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Network error with Intel E1000 Adapter on update 2.4.25 ==> 2.6.3
Thread-Index: AcP9LGy9DCYDtwk0RnOTuLLUfxW6jQCky7RgABbgo8A=
From: "Martin Bene" <martin.bene@icomedias.com>
To: "Feldman, Scott" <scott.feldman@intel.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

>> Board is an Asus PC-DL, Intel 875P Chipset, one Xeon 2.8Ghz 
>> CPU, Onboard e1000 Network interface. Any idea how I can get 
>> the onboard NIC to work?
>
>Martin, give 2.6.4-rc1 a try.  It removes a patch to e1000 that broke a
>lot of folks with 875/CSA.

Thanks for the hint. Results:

 - Network interface works, no more lockups.
 - ifconfig still doesn't show the interupt being used.
 - /proc/interrupts DOES show the right interrupt.

experimenting with the driver source shows that the interrupt displayed by ifconfig seems to depend on netdev->irq being set; this was removed during the netdev->irq ==> adapter->pdev->irq change. adding the following line corrects ifconfig display:

diff -urN e1000_old/e1000_main.c e1000/e1000_main.c
--- e1000_old/e1000_main.c      Mon Mar  1 09:16:29 2004
+++ e1000/e1000_main.c  Tue Mar  2 07:09:37 2004
@@ -452,6 +452,8 @@
	netdev->poll_controller = e1000_netpoll;
 #endif

+	netdev->irq = pdev->irq;
+
	netdev->mem_start = mmio_start;
	netdev->mem_end = mmio_start + mmio_len;
	netdev->base_addr = adapter->hw.io_base;

Bye, Martin
