Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVELCWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVELCWc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 22:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVELCWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 22:22:32 -0400
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:23312 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S261302AbVELCW3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 22:22:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors in EM64T mode (x86_64)
Date: Wed, 11 May 2005 21:22:13 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B6A@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors in EM64T mode (x86_64)
Thread-Index: AcVWXtEiqwhh9gTfTHOWiZ1p9nTEdgAOSKQQ
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <jamesclv@us.ibm.com>, <akpm@osdl.org>, <zwane@arm.linux.org.uk>,
       <len.brown@intel.com>, <venkatesh.pallipadi@intel.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 May 2005 02:22:13.0463 (UTC) FILETIME=[6896DE70:01C55699]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, May 11, 2005 at 11:21:15AM -0500, Protasevich, Natalie wrote:
> > > > Looks like the need in the unique id can only be keyed of the 
> > > > local APIC id, and probably it is a good idea to keep the 
> > > > NO_IOAPIC_CHECK for subarchs that can override the heuristics?
> > > 
> > > I prefer not to do that. How about a simple
> > > 
> > > if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
> > > boot_cpu_data.x86 < 15)
> > > 	/* do uniqueness check */
> > > else
> > > 	/* don't do it */
> > > 
> > > ?		
> > > 
> > > Rationale is that P4s and newer and systems not from Intel don't 
> > > have serial APIC busses and don't need this uniqueness check.
> > >
> > 
> > Yes, indeed this looks like the only undisputed (and sufficient) 
> > criteria. I tried the below with Xeon box and it worked fine:
> > 
> > --- mpparse.c.orig	2005-05-11 02:10:35.000000000 -0400
> > +++ mpparse.c	2005-05-11 02:12:31.000000000 -0400
> > @@ -912,7 +913,15 @@ void __init mp_register_ioapic (
> >  	mp_ioapics[idx].mpc_apicaddr = address;
> >  
> >  	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
> > -	mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
> > +	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
> > (boot_cpu_data.x86 >= 15))
> > +		mp_ioapics[idx].mpc_apicid = id;
> > +	else
> 
> That's still wrong because it does not trigger on AMD 
> systems. 

So no AMD systems need that check? OK, I'll change it as below.

> Please make it
> 
> 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && 
> boot_cpu_data.x86 < 15)
> 		mp_ioapics[idx].mpc_apicid = 
> io_apic_get_unique_id(idx,id);
> 	else
> 		mp_ioapics[idx].mpc_apicid = id;
> 
