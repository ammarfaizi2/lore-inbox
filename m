Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVJaScR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVJaScR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 13:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVJaScQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 13:32:16 -0500
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:64526 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S932434AbVJaScQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 13:32:16 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [Fastboot] [PATCH] i386: move apic init in init_IRQs
Date: Mon, 31 Oct 2005 12:31:56 -0600
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04E00@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Fastboot] [PATCH] i386: move apic init in init_IRQs
Thread-Index: AcXeR9HOfYwQ8F3PR3qgSOzP3sno/wAAMMSQ
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <vgoyal@in.ibm.com>, "Andrew Morton" <akpm@osdl.org>, <fastboot@osdl.org>,
       <linux-kernel@vger.kernel.org>, "Andi Kleen" <ak@suse.de>,
       "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 31 Oct 2005 18:31:57.0002 (UTC) FILETIME=[5FBB5AA0:01C5DE49]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> > Hi Eric,
> >
> > There is another problem with that patch - it broke ES7000, I kept 
> > getting timer panics. It turned out that check_timer() runs 
> before the 
> > actual APIC destination is set up. The IO-APIC uses 
> > cpu_to_logical_apicid to find the destination - which needs 
> > cpu_2_logical_apicid[] to be filled - which only happens after 
> > processors are booted. At the time when check_timer() runs, it will 
> > always be BAD_APICID (0xFF - broadcast) as the IO-APIC rte 
> destination 
> > for the timer, but ES7000 hardware happened not to support 
> 0xFF so it 
> > panics. I used bios_cpu_apicid[] to bring it up, but 
> > cpu_to_logical_apicid is the only one that is kept 
> up-to-date in the 
> > hotplug case, so I cannot replace it in the cpu_mask_to_apicid().
> >
> > There are probably some ways to fix this such as one below that I 
> > tried (in mpparse.c):
> >
> >         if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
> >                 Dprintk("    Bootup CPU\n");
> >                 boot_cpu_physical_apicid = m->mpc_apicid;
> > +               cpu_2_logical_apicid[num_processors] = 
> m->mpc_apicid;
> >         }
> > it  worked, but looks more like a kludge of course. I think IO-APIC 
> > setup has to happen after processors were brought online and so is 
> > check_timer(), if timer is connected through the IO-APIC.
> 
> The first cpu is brought online much earlier than the rest.  
> So we just need to setup a table for boot cpu earlier.  From 
> the looks of it mach-es700 won't work if you compile a 
> uniprocessor kernel for it right now.

Yea, I didn't even try this - but I think it will produce the same
result with regard to timer IOAPIC rte.

> We need to do this a little later than in mptable but this 
> should be a fairly simple one or two line change.

Yes, it is maybe something like running map_cpu_to_logical_apicid() from
APIC_init() just before the setup_IO_APIC().
Thanks,
--Natalie

> If people keep breaking the subarchitectures by accident we 
> might even inspire someone to make a comprehensible sub 
> architecture implentation on x86 one of these days.
> 
> 
> Eric
> 
