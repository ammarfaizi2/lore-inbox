Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVAHBlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVAHBlR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 20:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVAHBlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 20:41:17 -0500
Received: from mail.tyan.com ([66.122.195.4]:3601 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261764AbVAHBjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 20:39:04 -0500
Message-ID: <3174569B9743D511922F00A0C943142307291362@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: jamesclv@us.ibm.com, Andi Kleen <ak@muc.de>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64
Date: Fri, 7 Jan 2005 17:50:33 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You already get boot_cpu_physical_apic_id and it is a MARCO = boot_cpu_id.
And it always is physical apic id.

Also you already got cpu_to_node array.

Also you already got x86_cpu_to_apicid array. ( physical apic id are stored
according to cpu num).

Here cpu are [0, NR_CPUS-1), and for 8 ways dual core system it should be
16.
And can get in context by smp_processor_id or safe_smp_processor_id ( it
need x86_cpu_to_apicid to be initialized at first)

Cpu_to_node is used for NUMA.

What is the usage for phys_pkg_id?

YH

-----Original Message-----
From: James Cleverdon [mailto:jamesclv@us.ibm.com] 
Sent: Friday, January 07, 2005 5:30 PM
To: Andi Kleen
Cc: YhLu; Matt Domsch; linux-kernel@vger.kernel.org; discuss@x86-64.org;
suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64

Andi has already dealt with some of the coding style issues elsewhere in 
the thread.

My comment:  This is playing with fire.  We've gone to considerable 
trouble to make the boot_cpu_id independent of the physical APIC ID 
(which is what hard_smp_processor_id() returns).  Different BIOSes and 
different CPU revisions can cause the boot processor to shift.

Examples:  We have a box where the boot CPU has an APIC ID of 3.  
Another system starts with the BSP == 3, but the BIOS renumbers it to 
zero after first reassigning the original 0 CPU.  So, the APIC IDs end 
up 0, 1, 2, 4.  Yet another system assigns the IDs:  0, 1, 6, 7.

We can expect even stranger numbering schemes in the future, given that 
dual core hyperthreaded CPUs are in the pipeline.  Creating any 
dependency between CPU number and APIC ID is a _bad_ idea.


On Friday 07 January 2005 04:24 am, Andi Kleen wrote:
> On Thu, Jan 06, 2005 at 06:53:11PM -0800, YhLu wrote:
> > static unsigned int phys_pkg_id(int index_msb)
> > {
> >         return hard_smp_processor_id() >> index_msb;
> > }
> >
> > In arch/x86_64/kernel/genapic_cluster.c
> >
> > Should be changed to
> >
> > static unsigned int phys_pkg_id(int index_msb)
> > {
> >         /* physical apicid, so we need to substract offset */
> >         return (hard_smp_processor_id() - boot_cpu_id) >>
> > index_msb; }
>
> Why?
>
> If you want a patch merged you need to supply some more explanation
> please.
>
> Also cc Suresh & James for comment.
>
> -Andi

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
