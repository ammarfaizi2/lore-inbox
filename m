Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbSLTWtx>; Fri, 20 Dec 2002 17:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266353AbSLTWtw>; Fri, 20 Dec 2002 17:49:52 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:56475 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S266384AbSLTWtl>; Fri, 20 Dec 2002 17:49:41 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C1AEC73@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Cleverdon'" <jamesclv@us.ibm.com>,
       "'Pallipadi, Venkatesh'" <venkatesh.pallipadi@intel.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Martin Bligh'" <mbligh@us.ibm.com>,
       "'John Stultz'" <johnstul@us.ibm.com>,
       "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       "'Mallick, Asit K'" <asit.k.mallick@intel.com>,
       "'Saxena, Sunil'" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>
Cc: "'Andi Kleen'" <ak@suse.de>, "'Hubert Mantel'" <mantel@suse.de>
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with m
	ore than 8 CPUs
Date: Fri, 20 Dec 2002 16:57:28 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Dec 19, 2002 at 06:04:55PM -0800, James Cleverdon wrote:
> >>> A generic patch should also support Unisys' new box, the ES7000 or
> >>> some such.
> 
> On Fri, Dec 20, 2002 at 08:00:50AM +0000, Christoph Hellwig wrote:
> >> That box needs more changes than just the apic setup.  Unfortunately
> >> unisys thinks they shouldn't send their patches to lkml, but when you
see
> >> them e.g. in the suse tree it's a bit understandable that they don't
want
> >> anyone to really see their mess :)

Briefly, our ES7000 boxes are non-NUMA, but use clustered APICs (logical
with Cascades, and physical with Gallatins/Fosters). Our code is pretty much
within the clustered APIC code (when both physical and logical are
implemented). Even with NUMA that is forced in clustered APIC case, we are
usually OK as a single-node case.
There are only a few problems with porting the Linux kernel to the ES7000:
	we use 8-bit APIC IDs - this makes us use APIC_LDR instead of
APIC_ID throughout the code;
	we have special RTE destination values on IO-APIC - the "if" in the
programming IO-APIC line code;
	we introduce severe IRQ override case - we remap ISA interrupts to a
different interrupt range (all the "i < 16" clauses).

Also, I usually have to add things like XTPR mechanism for Fosters/Gallatins
and disable conventional IRQ balancing, since our IO-APIC doesn't work this
way... (All of the above is in the SuSE code base).

I worked with the SuSE tree which has clustered code (at the first glance)
close to the patch being discussed here.
The 2.5 tree gives us a benefit of the subarch that will accomodate
(hopefully) our special cases. 
But I may need to add more hooks.

>No need to sugar-coat anything :-)

>Natalie is the engineer who added support for the ES7000 to Linux.
>Fortunately she is in the cube next to me.

>She has sent the patches to SuSE/United Linux, and is in the final process
>of testing them on 2.5.5x before submitting them to LKML for comment.

> >> And btw, the box isn't that new, but three years ago or so when they
first
> >> showed it on cebit they even refused to talk about linux due to their
> >> restrictive agreements with Microsoft..
>
> On Fri, Dec 20, 2002 at 03:24:01AM -0800, William Lee Irwin III wrote:
> > Kevin, you're the only lkml-posting contact point I know of within
Unisys.
> > Is there any chance you could flag down some of the ia32 crew there for
> > some commentary on this stuff? (or do so yourself if you're in it)

I will be looking at the Intel patch submited against 2.4 with support for
the ES7000 in mind. I am trying to get the ES7000 patch for 2.5.x out
sometime next week (my boss won't let me have a life until I get ES7000
support in 2.5 (:-<)). At the same time, we are very interested in any
clustered APIC patch that goes in the 2.5 tree (sooner the better).  Having
physical cluster support in 2.5 would greatly reduce the size of diffs for
the ES7000.

>I mostly work on our 16-32p IA64 machines.  Natalie or someone else will
>have to comment on the clustered-apic code.

>I do know that a lot of the code for the ES7000 is optional, and only
>required to support value-added management functionality, which is
>especially useful if you are running more than one OS instance on the
>machine (it supports 8 fully-independent partitions).

>Also, as a clarification, our 32-processor systems are NOT NUMA: there
>is a full non-blocking crossbar to memory.  So clustered APIC support
>should not be dependant on NUMA.

>Kevin
