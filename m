Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUH3VZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUH3VZZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 17:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUH3VZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 17:25:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:41933 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262062AbUH3VZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 17:25:21 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions
To: john stultz <johnstul@us.ibm.com>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [RFC][PATCH] fix target_cpus() for summit subarch
Date: Mon, 30 Aug 2004 14:24:54 -0700
User-Agent: KMail/1.5.4
Cc: lkml <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
References: <1093652688.14662.16.camel@cog.beaverton.ibm.com> <79750000.1093673866@[10.10.2.4]> <1093888987.14662.69.camel@cog.beaverton.ibm.com>
In-Reply-To: <1093888987.14662.69.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408301424.54418.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm fine with changing the delivery mode to dest_LowestPrio.  However, 
someone changed the default destination mask that target_cpus() returns 
from XAPIC_DEST_CPUS_MASK (0F) to APIC_ALL_CPUS (FF).  The latter value 
is a bad idea.  I'm unaware of anyone's hardware that will correctly 
arbitrate dest_LowestPrio among all CPUs of all clusters.  (Please 
correct me if I'm wrong.)  By chance, FF mostly works on IBM Summit 
(EXA) chips, but we can't rely on that in the future.

And if the delivery mode is dest_Fixed, then FF means "broadcast to all 
CPUs", which is plainly wrong too.

It would be safer to change back to some value whose behavior is well 
defined in Intel's docs, like XAPIC_DEST_CPUS_MASK or John's 
suggestion, cpumask_of_cpu(0).  Either one will cause almost all 
interrupts to land on CPU 0 for P4s.  IRQ balancing will shift them to 
other processors soon enough.

I note that in 2.6.8.1 the other clustered sub-arches do something 
similar to John's or my suggestion.  Only numaq uses APIC_ALL_CPUS, and 
it has special APIC cluster controllers.  (Even there, 0F is arguably 
clearer than FF, but the custom chips never route dest_LowestPrio 
interrupts outside of the local cluster, so the upper nibble doesn't 
matter.)

Alternative patch for include/asm-i386/mach-summit/mach_apic.h:
 
 static inline cpumask_t target_cpus(void)
 {
-	return CPU_MASK_ALL;
+	/* Start on cluster 0.  IRQ balancing will spread load soon. */
+	return XAPIC_DEST_CPUS_MASK;	
 } 
 #define TARGET_CPUS    (target_cpus())


On Monday 30 August 2004 11:03 am, john stultz wrote:
> On Fri, 2004-08-27 at 23:17, Martin J. Bligh wrote:
> > --john stultz <johnstul@us.ibm.com> wrote (on Friday, August 27, 
2004 17:24:48 -0700):
> > > I've been hunting down a bug affecting IBM x440/x445 systems
> > > where the floppy driver would get spurious interrupts and would
> > > not initialize properly.
> > >
> > > After digging James Cleverdon pointed out that target_cpus() is
> > > routing the interrupts to the clustered apic broadcast mask. This
> > > was causing multiple interrupts to show up, breaking the floppy
> > > init code.
> > >
> > > This one-liner fix simply routes interrupts to the first cpu to
> > > resolve this issue.
> >
> > I'd say that means your hardware is horribly broken ... but I guess
> > this might be a suitable workaround given we're going to reprogram
> > them all later.
>
> Ok, then my patch probably isn't correct. Let me grab James and we'll
> sit down and work this out later today.
>
> thanks
> -john

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm

