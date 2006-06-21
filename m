Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWFUBDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWFUBDo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWFUBDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:03:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2241 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750863AbWFUBDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:03:42 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Len Brown <len.brown@intel.com>,
       Kimball Murray <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 9/25] irq: Add a dynamic irq creation API
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
	<11508425183073-git-send-email-ebiederm@xmission.com>
	<11508425191381-git-send-email-ebiederm@xmission.com>
	<11508425192220-git-send-email-ebiederm@xmission.com>
	<11508425191063-git-send-email-ebiederm@xmission.com>
	<1150842520235-git-send-email-ebiederm@xmission.com>
	<11508425201406-git-send-email-ebiederm@xmission.com>
	<1150842520775-git-send-email-ebiederm@xmission.com>
	<11508425213394-git-send-email-ebiederm@xmission.com>
	<115084252131-git-send-email-ebiederm@xmission.com>
	<1150847764.1901.64.camel@localhost.localdomain>
Date: Tue, 20 Jun 2006 19:01:52 -0600
In-Reply-To: <1150847764.1901.64.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Wed, 21 Jun 2006 09:56:04 +1000")
Message-ID: <m1veqvb9tr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2006-06-20 at 16:28 -0600, Eric W. Biederman wrote:
>> With the msi support comes a new concept in irq handling,
>> irqs that are created dynamically at run time.
>> 
>> Currently the msi code allocates irqs backwards.  First it
>> allocates a platform dependent routing value for an
>> interrupt the ``vector'' and then it figures out from the
>> vector which irq you are on.
>
> You may want to look at the work I'm currently doing for powerpc where
> we need a fully dynamic linux irq number allocation, completely separate
> spaces for hw numbers (vectors) and linux irq numbers for arbitrary PICs
> (and more than one in a given system) etc...
>
> I'll post a patch that shows the stuff I'm adding later today so you can
> have a look. There is some overlap with your dynamic irq stuff.
>
> I haven't completely ported all of powerpc to my new core yet which is
> why I haven't posted patches yet, but I'll have something out today.

Sure.  I know by the end of my patchset I have separated out hw numbers
from the linux irq numbers, so this should work for powerpc.
I would love to hear feedback on it though.

So to be very clear what we mean, because I have gotten bitten in the
past.  I understand the linux irq number to be:
a) An index in the irq_desc array.
b) An enumeration of the hardware interrupts sources.
c) Human visible so ideally it is neither arbitrary, nor
   very dynamic if the hardware is not.

Then there is the destination cookie (vector on x86) that is
available to the cpu when the interrupt is delivered.

I think we are on a similar track but I'm not at all certain I like
the idea of a fully dynamic linux irq number except in cases like MSI
where your sources are dynamic.   But I may be making the wrong
assumptions about what you are doing.

I think implementations where we expose the hardware cookie instead
of an enumeration of irq sources like ia64 does, impedes debugging
because the irq number will be different between boots, or loads
of the kernel module.  At the same time as long as we don't assume
the irq number is the hardware cookie I don't see any maintenance
problems with an implementation like that.

What I do know is that on x86_64 the multiple levels of translation
from the firmwares notion of the irq number to linux different
notion of the irq number made the code overly complex and fragile.
Which is one of the things I address in this patchset.

But I would be happy to have a look, and I very much
hope we can our implementations working together.

Eric
