Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVEKLXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVEKLXJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 07:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVEKLXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 07:23:09 -0400
Received: from mx1.suse.de ([195.135.220.2]:692 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261966AbVEKLXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 07:23:01 -0400
Date: Wed, 11 May 2005 13:22:56 +0200
From: Andi Kleen <ak@suse.de>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: jamesclv@us.ibm.com, Andi Kleen <ak@suse.de>, akpm@osdl.org,
       zwane@arm.linux.org.uk, len.brown@intel.com,
       venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors in EM64T mode (x86_64)
Message-ID: <20050511112256.GU25612@wotan.suse.de>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B66@USRV-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B66@USRV-EXCH4.na.uis.unisys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 02:10:03AM -0500, Protasevich, Natalie wrote:
> I tried the following patch:
> 
> --- io_apic.c.orig      2005-05-11 03:42:40.000000000 -0400
> +++ io_apic.c   2005-05-11 03:44:28.000000000 -0400
> @@ -2427,12 +2427,13 @@ int __init io_apic_get_unique_id (int io
>         physid_mask_t tmp;
>         unsigned long flags;
>         int i = 0;
> +       static int no_ioapic_check;
> 
>         /* Don't check I/O APIC IDs for some xAPIC systems.  They have
>          * no meaning without the serial APIC bus.
>          */
> 
> -       if (NO_IOAPIC_CHECK)
> +       if (no_ioapic_check)
>                 return apic_id;
> 
>         /*
> @@ -2449,6 +2450,13 @@ int __init io_apic_get_unique_id (int io
>         reg_00.raw = io_apic_read(ioapic, 0);
>         spin_unlock_irqrestore(&ioapic_lock, flags);
> 
> +       if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
> +               (boot_cpu_data.x86 == 15)) {
> +               if (reg_00.bits.delivery_type)
> +                       no_ioapic_check = 1;
> +                       return apic_id;
> +       }
> +
>         if (apic_id >= get_physical_broadcast()) {
>                 printk(KERN_WARNING "IOAPIC[%d]: Invalid apic_id %d,
> trying "
>                         "%d\n", ioapic, apic_id, reg_00.bits.ID);
> 
>  
> To my surprise, it didn't work, and when I dumped the I/O APIC registers
> it turned out that on ES7000 the parallel delivery bit wasn't set!
> 
> <7>.... register #00: A4000000
> <7>.......    : physical APIC id: A4
> <7>.......    : Delivery Type: 0
> <7>.......    : LTS          : 0
> <7>.... register #01: 00170004
> <7>.......     : max redirection entries: 0017
> <7>.......     : PRQ implemented: 0
> <7>.......     : IO APIC version: 0004
> 
> Version number was not 0x11 as James mentioned, it was 4, and I couldn't
> find anything documented on the I/O xAPIC versioning.
> 
> Looks like the need in the unique id can only be keyed of the local APIC
> id, and probably it is a good idea to keep the NO_IOAPIC_CHECK for
> subarchs that can override the heuristics?

I prefer not to do that. How about a simple

if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && boot_cpu_data.x86 < 15)
	/* do uniqueness check */
else
	/* don't do it */

?		

Rationale is that P4s and newer and systems not from Intel don't have serial
APIC busses and don't need this uniqueness check.

-Andi
