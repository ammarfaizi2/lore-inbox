Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272060AbTHDSKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272073AbTHDSKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:10:37 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:38603 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S272060AbTHDSKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:10:34 -0400
Date: Mon, 4 Aug 2003 11:10:33 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: davidm@hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: milstone reached: ia64 linux builds out of Linus' tree
Message-ID: <20030804181033.GA17265@lucon.org>
References: <200308041737.h74HbdCf015443@napali.hpl.hp.com> <20030804175308.GB16804@lucon.org> <20030804180015.GA543@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804180015.GA543@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 11:00:16AM -0700, Jesse Barnes wrote:
> On Mon, Aug 04, 2003 at 10:53:08AM -0700, H. J. Lu wrote:
> > On Mon, Aug 04, 2003 at 10:37:39AM -0700, David Mosberger wrote:
> > > As of this morning, Linus's current bk tree
> > > (http://linux.bkbits.net:8080/linux-2.5) builds and works out of the
> > > box for ia64!
> > > 
> > 
> > Does it work on bigsur? Does it support kernel modules?
> 
> I just tried the latest on my big sur, and though I think modules work
> (at least they build for other machines), big sur is broken because
> non-ACPI based PCI enumeration has been removed from the tree.
> 

Can you try this patch for bigsur?


H.J.
---
--- linux/drivers/acpi/osl.c.acpi	Mon Jul 28 11:41:53 2003
+++ linux/drivers/acpi/osl.c	Mon Jul 28 15:12:44 2003
@@ -250,7 +250,12 @@ acpi_os_install_interrupt_handler(u32 ir
 	irq = acpi_fadt.sci_int;
 
 #ifdef CONFIG_IA64
-	irq = gsi_to_vector(irq);
+	irq = acpi_irq_to_vector (irq);
+	if (irq < 0) {
+		printk(KERN_ERR PREFIX "SCI (IRQ%d/%d) not registerd\n",
+		       irq, acpi_fadt.sci_int);
+		return AE_OK;
+	}
 #endif
 	acpi_irq_irq = irq;
 	acpi_irq_handler = handler;
