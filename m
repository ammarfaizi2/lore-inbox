Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbUCaXlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 18:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbUCaXlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 18:41:35 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:41402 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262068AbUCaXlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 18:41:32 -0500
Subject: Re: [PATCH] ibmvscsi driver - sixth version
From: James Bottomley <James.Bottomley@steeleye.com>
To: Dave Boutcher <sleddog@us.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <opr5q1enb6l6e53g@us.ibm.com>
References: <opr3u0ffo7l6e53g@us.ibm.com>
	<20040225134518.A4238@infradead.org>  <opr3xta6gbl6e53g@us.ibm.com>
	<1079027038.2820.57.camel@mulgrave> <opr5qwiyw4l6e53g@us.ibm.com>
	<406B3FDA.9010507@pobox.com>  <opr5q1enb6l6e53g@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 31 Mar 2004 18:39:57 -0500
Message-Id: <1080776399.11299.63.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-31 at 18:12, Dave Boutcher wrote:
> OK, two issues.  There are a bunch of SCSI LLDDs that use this same
> logic in abort and reset handlers to wait for adapter events to
> complete, so I think the logic is OK.  The issue of spin_lock_irq
> vs spin_lock is a good one...and points out that there are a bunch
> of LLDDs that are broke :-)  I'll resubmit without the _irq

Actually, no, with the irq is correct.  Wait_for_completion will sleep,
and sleeping with interrupts disabled is wrong.

The reason for this is that the error handler takes the host lock around
calls to the driver error handler functions.  The rationale was that
"simple" drivers didn't want to bother with locking, but it's obviously
causing more problems than it solves.

> > 14) why are you faking a PCI bus?  The following is very, very wrong:
> >
> > +static struct pci_dev iseries_vscsi_dev = {
> > +	.dev.bus = &pci_bus_type,
> > +	.dev.bus_id = "vscsi",
> > +	.dev.release = noop_release
> >
> > Did I mention "very" wrong?  :)
> Because for iseries it is implemented in the pci code.  While it may
> look wrong, it is actually correct.  Check out
> arch/ppc64/kernel/iSeries_iommu.c and arch/ppc64/kernel/dma.c.
> This device has to have dev->bus == &pci_bus_type otherwise the
> dma_mapping_foo functions won't work correctly.

Erm, something is very wrong in the iSeries code then.  This
iseries_vio_device is a struct device.  As such, it should contain all
the information it needs for the DMA API to act on it without performing
silly pci device tricks.

This looks like it's done because the iseries should be converted to the
generic device infrastructure, but in fact it's not.  Since the generic
API has been around for over a year and was designed to solve precisely
these very problems it needs fixing rather than trying to work around it
in a driver.

James


