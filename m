Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263970AbTEOLrh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 07:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbTEOLrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 07:47:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50948 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263970AbTEOLrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 07:47:36 -0400
Date: Thu, 15 May 2003 13:00:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69-mm5: pccard oops while booting: resolved
Message-ID: <20030515130019.B30619@flint.arm.linux.org.uk>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com> <20030514191735.6fe0998c.akpm@digeo.com> <1052998601.726.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052998601.726.1.camel@teapot.felipe-alfaro.com>; from felipe_alfaro@linuxmail.org on Thu, May 15, 2003 at 01:36:41PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 01:36:41PM +0200, Felipe Alfaro Solana wrote:
> I applied the second half patch on top of 2.5.69-mm5 (the original
> 2.5.69-mm5 defined BUS_ID_SIZE as 20), but the "pccard" kernel task
> keeps crashing as before.
> 
> Anything else for me to try? :-)

I don't believe this problem is being caused by PCMCIA/Cardbus (until
someone proves me wrong.)

This came up a few weeks ago, and it looked like the device models
driver lists became corrupted somehow.  Unfortunately it wasn't proven
back then, and I haven't been able to reproduce this behaviour here.

We seem to be failing in pci_bus_match(), with pci_drv->id_table
containing an invalid address.  Could you apply this patch and see
what happens?  It'll be rather noisy during boot though.

The interesting one should be immediately prior to the oops.

--- orig/drivers/pci/pci-driver.c	Sun Nov 24 10:12:24 2002
+++ linux/drivers/pci/pci-driver.c	Thu May 15 12:58:56 2003
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/kallsyms.h>
 #include "pci.h"
 
 /*
@@ -183,7 +184,9 @@
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * pci_drv = to_pci_driver(drv);
 	const struct pci_device_id * ids = pci_drv->id_table;
-
+printk("pci_bus_match: pci_drv = %p", pci_drv);
+print_symbol(" (%s)", pci_drv);
+printk("\n");
 	if (!ids) 
 		return 0;
 


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

