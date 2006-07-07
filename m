Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWGGDvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWGGDvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 23:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWGGDvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 23:51:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22679 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751175AbWGGDvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 23:51:49 -0400
Date: Thu, 6 Jul 2006 20:51:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Brown, Len" <len.brown@intel.com>
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       linux-acpi@vger.kernel.org
Subject: Re: [BUG] sleeping function called from invalid context during
 resume
Message-Id: <20060706205141.a5dc98f4.akpm@osdl.org>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ECF303@hdsmsx411.amr.corp.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB6ECF303@hdsmsx411.amr.corp.intel.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006 23:10:08 -0400
"Brown, Len" <len.brown@intel.com> wrote:

> 
> >I got the following on my laptop w/ 2.6.18-rc1.
> >
> >thanks
> >-john
> >
> >Stopping tasks:
> >================================================================
> >=======================|
> >pnp: Device 00:0b disabled.
> >ACPI: PCI interrupt for device 0000:02:01.0 disabled
> >ACPI: PCI interrupt for device 0000:00:1f.5 disabled
> >ACPI: PCI interrupt for device 0000:00:1d.7 disabled
> >ACPI: PCI interrupt for device 0000:00:1d.2 disabled
> >ACPI: PCI interrupt for device 0000:00:1d.1 disabled
> >ACPI: PCI interrupt for device 0000:00:1d.0 disabled
> >Intel machine check architecture supported.
> >Intel machine check reporting enabled on CPU#0.
> >Back to C!
> >BUG: sleeping function called from invalid context at mm/slab.c:2882
> >in_atomic():0, irqs_disabled():1
> > [<c0103d59>] show_trace_log_lvl+0x149/0x170
> > [<c01052ab>] show_trace+0x1b/0x20
> > [<c01052d4>] dump_stack+0x24/0x30
> > [<c0116e51>] __might_sleep+0xa1/0xc0
> > [<c0165cb5>] kmem_cache_zalloc+0xa5/0xc0
> > [<c0264b5a>] acpi_os_acquire_object+0x11/0x41
> 
> yep, the new slab for objects makes this path immune to
> the acpi_in_resume hack in acpi_os_allocate()

hm.  Linus's new suspend/resume thing seems to have a two-phase suspend,
but not, afaict, a two-phase resume.  If it did, and if the second resume
phase were to run with IRQs enabled then we should be able to address this
appropriately.

> I think we need to get rid of the acpi_in_resume hack
> and use system_state != SYSTEM_RUNNING to address this.

Well if hacks are OK it'd actually be reliable to do

	/* comment goes here */
	kmalloc(size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);

because the irqs_disabled() thing happens for well-defined reasons. 
Certainly that's better than looking at system_state (and I don't think we
leave SYSTEM_RUNNING during suspend/resume anyway).

