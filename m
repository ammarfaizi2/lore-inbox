Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWF1RiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWF1RiB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWF1RiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:38:01 -0400
Received: from mail.suse.de ([195.135.220.2]:26583 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751492AbWF1RiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:38:00 -0400
Date: Wed, 28 Jun 2006 10:34:48 -0700
From: Greg KH <gregkh@suse.de>
To: Rafa? Bilski <rafalbilski@interia.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA from Longhaul by rw semaphores
Message-ID: <20060628173448.GA2371@suse.de>
References: <44A28AA2.6060306@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A28AA2.6060306@interia.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 03:56:50PM +0200, Rafa? Bilski wrote:
> 	This patch will allow Longhaul cpufreq driver to change frequency
> without breaking BMDMA. In order to work properly it needs:
> - adding rw_semaphore to pci_device and bus structures - this is
> patch below,
> - Longhaul should find host bridge and lock write on bus before
> frequency change,

Eeek!  You mean the longhaul driver can change the frequency of the PCI
bus?  Oh, that's a recipe for disaster...

> - device driver support - device should lock read its bus before
> starting DMA transfer. I have curently implemented this for ide
> layer (tested with via82cxxx), libata (not tested, but this is similar
> code to ide) and VIA Rhine network card driver.
> 	I don't know if this is acceptable infrastructure, but I hope it is
> less horrible then last. Is this infrastructure at all?

No, it's a hack :)

No, this is not acceptable.  What exactly do you want to do here?  Make
sure the PCI drivers are not doing DMA when the longhaul driver wants to
change the pci bus speed?

How often will this bus change happen?

Does it really save battery?

Will all PCI devices work properly at different speeds from what they
originally thought they were running at?

And what about PCI devices that always do DMA?  (think USB controllers,
they can easily saturate the PCI bus all the time).

Why not just suspend all PCI devices make the bus change, and then
resume them?  That would require no PCI core, or driver changes.

thanks,

greg k-h
