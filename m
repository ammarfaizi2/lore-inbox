Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVFGKIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVFGKIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 06:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVFGKIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 06:08:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52650 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261821AbVFGKIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 06:08:34 -0400
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, greg@kroah.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Bodo Eggert <7eggert@gmx.de>,
       Dipankar Sarma <dipankar@in.ibm.com>, stern@rowland.harvard.edu,
       awilliam@fc.hp.com, bjorn.helgaas@hp.com
Subject: Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
References: <1118113637.42a50f65773eb@imap.linux.ibm.com>
	<20050607050727.GB12781@colo.lackof.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jun 2005 03:59:18 -0600
In-Reply-To: <20050607050727.GB12781@colo.lackof.org>
Message-ID: <m1slzuwkqx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler <grundler@parisc-linux.org> writes:

> On Mon, Jun 06, 2005 at 11:07:17PM -0400, Vivek Goyal wrote:
> >   So even if interrupts are disabled on PCI-PCI bridge, interrupts generated
> >   by PCI devices on secondary bus are not blocked and I hope device should
> >   be working fine.
> 
> How did you plan on disabling interrupts?
> Did you see the MSI discussion that going on now in linux-pci mailing list?
> 
> > But at the same time kdump kernels are not supposed to
> > do a great deal except capture and save the dump.
> 
> I'd think you want to stop DMA for all devices.
> Just to prevent them from messing more with memory
> that you want to dump - ie get a consistent snapshot.
> Leaving VGA devices alone should be safe.
> 
> > Disabling interrupts at PCI level should increase the reliability of capturing
> 
> > the dump on newer machines with hardware compliant with PCI 2.3 or higher. 
> 
> *lots* of PCI devices predate PCI2.3. Possibly even the majority.

In general generic hardware bits for disabling DMA, disabling interrupts
and the like are all advisory.  With the current architecture things
will work properly even if you don't manage to disable DMA (assuming
you don't reassign IOMMU entries at least).

Non-shared interrupts are not a problem as they can fairly safely
be disabled at the interrupt controller.

Shared interrupts are an interesting case.  The simplest solution I can
think of for a crash dump capture kernel is to periodically poll
the hardware, as if all interrupts are shared.  At that level
I think we could get away with ignoring all hardware interrupt sources.

Does anyone know of a anything that would break by always polling
the hardware?  I guess there could be a problem with drivers
that don't understand shared interrupts, are there enough of those
to be an issue.

Eric

