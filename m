Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbUKSROO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbUKSROO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbUKSRLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:11:52 -0500
Received: from mail3.utc.com ([192.249.46.192]:41614 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S261491AbUKSRJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:09:08 -0500
Message-ID: <419E288E.8010408@cybsft.com>
Date: Fri, 19 Nov 2004 11:08:30 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
References: <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>	 <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>	 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>	 <20041118164612.GA17040@elte.hu> <419D13D3.8020409@stud.feec.vutbr.cz>	 <20041119100541.GA28243@elte.hu> <1100873472.4051.31.camel@localhost.localdomain>
In-Reply-To: <1100873472.4051.31.camel@localhost.localdomain>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070506050102070409010806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070506050102070409010806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Steven Rostedt wrote:
> I'm getting a bug print (really a warning) from enable_irq spawned from
> the e100 driver. The reason is that enable_irq is being called because
> the irq depth is zero.
> 
> Looking into this, it is because the e100 uses a shared interrupt.  On
> setup (see drivers/net/e100.c: e100_up) it disables the irq that it will
> use, and then calls request_irq which calls setup_irq which zeros out
> the depth of the irq if it is not shared.  So if the e100 is the first
> to be loaded, then you get this message. 
> 
> I know that for now this doesn't hurt anything, but besides annoying me
> in my print outs (I can't stop panicking when I see it ;-),  is this
> really a bug and thus a design flaw of the e100? How else can a shared
> irq initialize without turning off the irq before setting itself up?
> 
> Should it enable the irq before it requests it, and thus open the race
> of a spurious interrupt, or just disable all interrupts?
> 
> Thanks,
> 

Actually I think it shouldn't call either enable or disable because it 
is shared (or allowed to be shared). After creating a patch myself to 
fix this I realized that it had already been fixed in the newest version 
of the driver on sourceforge. Anyway if you are interested in this fix 
temporarily, here it is.

kr



--------------070506050102070409010806
Content-Type: text/x-patch;
 name="e100.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e100.patch"

--- linux-2.6.10-rc1-mm3.cln/drivers/net/e100.c.orig	2004-11-15 21:09:24.846227425 -0600
+++ linux-2.6.10-rc1-mm3.cln/drivers/net/e100.c	2004-11-15 21:10:10.870474989 -0600
@@ -1680,8 +1680,6 @@
 	if((err = e100_rx_alloc_list(nic)))
 		return err;
 
-	disable_irq(nic->pdev->irq);
-
 	if((err = e100_alloc_cbs(nic)))
 		goto err_rx_clean_list;
 	if((err = e100_hw_init(nic)))
@@ -1693,7 +1691,6 @@
 		nic->netdev->name, nic->netdev)))
 		goto err_no_irq;
 	e100_enable_irq(nic);
-	enable_irq(nic->pdev->irq);
 	netif_wake_queue(nic->netdev);
 	return 0;
 
@@ -1704,7 +1701,6 @@
 err_rx_clean_list:
 	e100_rx_clean_list(nic);
 
-	enable_irq(nic->pdev->irq);
 	return err;
 }
 

--------------070506050102070409010806--
