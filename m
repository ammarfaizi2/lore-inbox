Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265977AbUIIX5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUIIX5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUIIX5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:57:43 -0400
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.85]:33140 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S265977AbUIIX5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:57:19 -0400
Date: Thu, 09 Sep 2004 19:57:17 -0400
From: Nathan Bryant <nbryant@optonline.net>
Subject: Re: [PATCH] Fix for spurious interrupts on e100 resume
In-reply-to: <1094769368.4298.7.camel@localhost>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       scott.feldman@intel.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4140EDDD.8010808@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
References: <1094769368.4298.7.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:

> static void e100_hw_reset(struct nic *nic)
> {
>+	/* Mask off our interrupt line - it's unmasked after reset 
>+	   Do it early to prevent spurious interrupts. */
>+	e100_disable_irq(nic);
>+
> 	/* Put CU and RU into idle with a selective reset to get
> 	 * device off of PCI bus */
> 	writel(selective_reset, &nic->csr->port);
>@@ -605,9 +609,6 @@ static void e100_hw_reset(struct nic *ni
> 		writeb(cuc_load_base, &nic->csr->scb.cmd_lo);
> 		mdelay(20);
> 	}
>-
>-	/* Mask off our interrupt line - it's unmasked after reset */
>-	e100_disable_irq(nic);
> }
> 
> static int e100_self_test(struct nic *nic)
>
You sure this is right? The comment seems to imply that writing the 
reset command to the registers also clears the interrupt mask. So you 
might need to have the e100_disable_irq() both before and after the reset.
