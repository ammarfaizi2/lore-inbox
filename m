Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVEKTWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVEKTWs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 15:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVEKTWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 15:22:47 -0400
Received: from cantor.suse.de ([195.135.220.2]:62627 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262024AbVEKTWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 15:22:45 -0400
Date: Wed, 11 May 2005 21:22:33 +0200
From: Andi Kleen <ak@suse.de>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: Andi Kleen <ak@suse.de>, jamesclv@us.ibm.com, akpm@osdl.org,
       zwane@arm.linux.org.uk, len.brown@intel.com,
       venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors in EM64T mode (x86_64)
Message-ID: <20050511192233.GB11200@wotan.suse.de>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B67@USRV-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B67@USRV-EXCH4.na.uis.unisys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 11:21:15AM -0500, Protasevich, Natalie wrote:
> > > Looks like the need in the unique id can only be keyed of the local 
> > > APIC id, and probably it is a good idea to keep the NO_IOAPIC_CHECK 
> > > for subarchs that can override the heuristics?
> > 
> > I prefer not to do that. How about a simple
> > 
> > if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && 
> > boot_cpu_data.x86 < 15)
> > 	/* do uniqueness check */
> > else
> > 	/* don't do it */
> > 
> > ?		
> > 
> > Rationale is that P4s and newer and systems not from Intel 
> > don't have serial APIC busses and don't need this uniqueness check.
> >
> 
> Yes, indeed this looks like the only undisputed (and sufficient)
> criteria. I tried the below with Xeon box and it worked fine:
> 
> --- mpparse.c.orig	2005-05-11 02:10:35.000000000 -0400
> +++ mpparse.c	2005-05-11 02:12:31.000000000 -0400
> @@ -912,7 +913,15 @@ void __init mp_register_ioapic (
>  	mp_ioapics[idx].mpc_apicaddr = address;
>  
>  	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
> -	mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
> +	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
> (boot_cpu_data.x86 >= 15))
> +		mp_ioapics[idx].mpc_apicid = id;
> +	else

That's still wrong because it does not trigger on AMD systems. Please make it

	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && boot_cpu_data.x86 < 15)
		mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx,id);
	else
		mp_ioapics[idx].mpc_apicid = id;


-Andi		
