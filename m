Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVKXQvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVKXQvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 11:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVKXQvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 11:51:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35815 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932420AbVKXQvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 11:51:04 -0500
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <20051123165923.GJ20775@brahms.suse.de>
	<1132783243.13095.17.camel@localhost.localdomain>
	<20051124131310.GE20775@brahms.suse.de>
	<m1zmnugom7.fsf@ebiederm.dsl.xmission.com>
	<20051124133907.GG20775@brahms.suse.de>
	<1132842847.13095.105.camel@localhost.localdomain>
	<20051124142200.GH20775@brahms.suse.de>
	<1132845324.13095.112.camel@localhost.localdomain>
	<20051124145518.GI20775@brahms.suse.de>
	<m1psoqgk18.fsf@ebiederm.dsl.xmission.com>
	<20051124153635.GJ20775@brahms.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 24 Nov 2005 09:49:09 -0700
In-Reply-To: <20051124153635.GJ20775@brahms.suse.de> (Andi Kleen's message
 of "Thu, 24 Nov 2005 16:36:35 +0100")
Message-ID: <m1lkzegfei.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> At least the Lindenhurst (E7205) datasheet says the chipset can trigger
> MCEs in the CPU (using a MCEERR# pin). I don't know if it's always
> enabled, but the hardware seems to have the capability.
> That's the oldest Intel server chipset supported with EM64T CPUs.
>
> The threshold counters are not supported directly only.

I don't think that triggers on correctable errors, and I'm
not certain how useful the information reported it.  But it
should be at least as good as an NMI :)

Truthfully it really isn't just server chipsets that are interesting
either.  Anything that supports ECC or parity on memory is
interesting.

>> The current k8
>> code has been delayed for this reason.
>> 
>> Where the EDAC code goes beyond the current k8 facilities is the
>> decode to the dimm level so that the bad memory stick can be
>> easily identified.
>
> That would be nice to have agreed. But I don't really know
> how to do this without mainboard specific knowledge.
> If you have something usable it's best to port it to mce.c
> or perhaps mcelog

We do this for every memory controller EDAC supports, so yes
we know how to implement this.  Merging the non-controversial
bits is coming.  But it is certainly a goal to take the
best of the mce code and the EDAC code to generate a good
k8 driver.

Motherboard specific knowledge is really not required.  All that 
is really required is memory controller specific knowledge.  With that
you can decode to the chip select level on most memory controllers.

Then you need just a little extra code (probably in user space) to map
the chip select to which dimm socket they go to on the motherboard.

The memory controller knowledge pretty much needs to be a
kernel driver because reading the memory controller registers 
can be a non-trivial exercise at times.  At least one piece of
Intel seems to like recommending that BIOS developers turn off the PCI
device that has the registers.

> There is a clear case for being architecture specific here. Some 
> architectures - like PPC64 or IA64 - have good firmware support for it, so it's
> best to use these facilities. On others like i386 and
> x86-64 the x86-64 log architecture is good. I might be a bit
> biased but I think it's very good and should be used on i386
> at some point too. I don't see any need for more.

The implementation clearly should be architecture specific, and
it will take more feeling out before any work can be done
to even think about unify the interfaces.

Right now the goal is to simply get what has proven useful in the
real world merged.

Currently I do not see implementation problems but I do see
facilities not being as useful as they could be.  Getting little
things like decoding to the dimm sorted out removes hours of
work figuring out which dimm has problems.

I also see a large number of errors that the hardware can detect
that are going unreported because the code just isn't there.  There
are all kinds of bus errors that chipsets can report that are
just being ignored.

So now you know some of the hopes and dreams behind some of the EDAC
code and some more of the model.  Hopefully this will lead to productive
conversations as the code is merged.

Eric
