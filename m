Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267659AbUIPRTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267659AbUIPRTq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268215AbUIPRQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:16:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:8141 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268365AbUIPRPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:15:25 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm1
Date: Thu, 16 Sep 2004 10:14:59 -0700
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       len.brown@intel.com
References: <20040916024020.0c88586d.akpm@osdl.org>
In-Reply-To: <20040916024020.0c88586d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409161014.59686.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 16, 2004 2:40 am, Andrew Morton wrote:
>  bk-acpi.patch

Looks like some changes in this patch break sn2.  In particular, this hunk in 
acpi_pci_irq_enable():

-               if (dev->irq && (dev->irq <= 0xF)) {
+               if (dev->irq >= 0 && (dev->irq <= 0xF)) {
                        printk(" - using IRQ %d\n", dev->irq);
                        return_VALUE(dev->irq);
                }
                else {
                        printk("\n");
-                       return_VALUE(0);
+                       return_VALUE(-EINVAL);
                }

Now instead of returning 0, we'll get -EINVAL when a driver calls 
pci_enable_device.  This is arguably correct since there's no _PRT entry (and 
in fact no ACPI namespace on sn2), but shouldn't the code above be looking at 
the 'pin' value instead of dev->irq?  The sn2 specific PCI code sets up each 
dev->irq long before this with the correct values...

Thanks,
Jesse
