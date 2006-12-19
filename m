Return-Path: <linux-kernel-owner+w=401wt.eu-S933002AbWLSVWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933002AbWLSVWy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933003AbWLSVWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:22:54 -0500
Received: from outmx013.isp.belgacom.be ([195.238.5.64]:57469 "EHLO
	outmx013.isp.belgacom.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933002AbWLSVWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:22:53 -0500
Date: Tue, 19 Dec 2006 22:22:40 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Ben Dooks <ben-linux@fluff.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Ben Dooks <ben@simtec.co.uk>,
       Dimitry Andric <dimitry.andric@tomtom.com>
Subject: Re: [PATCH] watchdog: fix clk_get() error check
Message-ID: <20061219212240.GC2943@infomag.infomag.iguana.be>
References: <20061219085144.GI4049@APFDCB5C> <20061219104335.GG11640@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219104335.GG11640@trinity.fluff.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

> On Tue, Dec 19, 2006 at 05:51:44PM +0900, Akinobu Mita wrote:
> > The return value of clk_get() should be checked by IS_ERR().
> 
> thanks for spotting this, but this will probably clash with
> a cleanup patch I sent a day or two ago to streamline the
> exit path in the driver.
> 
> see http://lkml.org/lkml/2006/12/18/65

It did, but I modified it slightly so that it worked with your
previous patch also. Can you test below patch?

Thanks,
Wim.

--- 2.6-mm.orig/drivers/char/watchdog/s3c2410_wdt.c
+++ 2.6-mm/drivers/char/watchdog/s3c2410_wdt.c
@@ -393,9 +393,9 @@
 	}
 
 	wdt_clock = clk_get(&pdev->dev, "watchdog");
-	if (wdt_clock == NULL) {
+	if (IS_ERR(wdt_clock)) {
 		printk(KERN_INFO PFX "failed to find watchdog clock source\n");
-		ret =  -ENOENT;
+		ret = PTR_ERR(wdt_clock);
 		goto err_irq;
 	}
 
