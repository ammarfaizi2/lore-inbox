Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVEKQYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVEKQYD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 12:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVEKQXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 12:23:39 -0400
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:21772 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S261991AbVEKQV1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 12:21:27 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors in EM64T mode (x86_64)
Date: Wed, 11 May 2005 11:21:15 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B67@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors in EM64T mode (x86_64)
Thread-Index: AcVWG7yZkDjRZp3FSGy517DslFXU2gAKBn0w
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <jamesclv@us.ibm.com>, <akpm@osdl.org>, <zwane@arm.linux.org.uk>,
       <len.brown@intel.com>, <venkatesh.pallipadi@intel.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 May 2005 16:21:15.0698 (UTC) FILETIME=[747C9120:01C55645]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Looks like the need in the unique id can only be keyed of the local 
> > APIC id, and probably it is a good idea to keep the NO_IOAPIC_CHECK 
> > for subarchs that can override the heuristics?
> 
> I prefer not to do that. How about a simple
> 
> if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && 
> boot_cpu_data.x86 < 15)
> 	/* do uniqueness check */
> else
> 	/* don't do it */
> 
> ?		
> 
> Rationale is that P4s and newer and systems not from Intel 
> don't have serial APIC busses and don't need this uniqueness check.
>

Yes, indeed this looks like the only undisputed (and sufficient)
criteria. I tried the below with Xeon box and it worked fine:

--- mpparse.c.orig	2005-05-11 02:10:35.000000000 -0400
+++ mpparse.c	2005-05-11 02:12:31.000000000 -0400
@@ -912,7 +913,15 @@ void __init mp_register_ioapic (
 	mp_ioapics[idx].mpc_apicaddr = address;
 
 	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
-	mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
(boot_cpu_data.x86 >= 15))
+		mp_ioapics[idx].mpc_apicid = id;
+	else
+		mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx,
id);
 	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);
 	
 	/* 

I am going to test this with Potomacs tonight to be sure, and then can
send the final patch. Does the format look OK?

Thanks,
--Natalie 
