Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVAHBgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVAHBgC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 20:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVAHBdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 20:33:55 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:45975 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261750AbVAHBaM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 20:30:12 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: Andi Kleen <ak@muc.de>
Subject: Re: 256 apic id for amd64
Date: Fri, 7 Jan 2005 17:30:09 -0800
User-Agent: KMail/1.7.1
Cc: YhLu <YhLu@tyan.com>, Matt Domsch <Matt_Domsch@dell.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       suresh.b.siddha@intel.com
References: <3174569B9743D511922F00A0C9431423072912FA@TYANWEB> <20050107122434.GA64665@muc.de>
In-Reply-To: <20050107122434.GA64665@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501071730.09615.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
