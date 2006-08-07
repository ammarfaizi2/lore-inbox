Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWHGQc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWHGQc5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWHGQc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:32:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27570 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932215AbWHGQc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:32:56 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: Double the per cpu area size
References: <m1mzagfu03.fsf@ebiederm.dsl.xmission.com>
	<200608071730.47120.ak@suse.de>
Date: Mon, 07 Aug 2006 10:31:31 -0600
In-Reply-To: <200608071730.47120.ak@suse.de> (Andi Kleen's message of "Mon, 7
	Aug 2006 17:30:47 +0200")
Message-ID: <m1vep4ecd8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>>  
>>  #include <asm/pda.h>
>>  
>> +#define PERCPU_ENOUGH_ROOM 65536
>
> I would prefer if you didn't do that unconditionally. Can you make
> it dependent on NR_IRQS or so?  Can you add a test for CONFIG_TINY
> to make it smaller?

We already ignore this variable for the per cpu allocation if we
build a kernel wihtout module support.  I guess a good fix could
entail changing the concept to be how much per cpu room to reserve
for modules.

I'm a big believer in stupid and simple solutions for as long as
you can get away with it.  When people trip over this then 
it will be clear what the real problem is and we can fix it.

> Also longer term it should really properly fixed

Agreed.  But we need a solution that works now so we have a solution
for when the 2.6.19 window opens up.  There is no agreement on even
what a proper fix is, or even what it looks like.  Keeping the data
per cpu seems about as good as anything else for memory size savings,
as most systems don't have many cpus.

Throwing a few more bytes at the problem solves it today and for
all systems currently built.  This buys us time to look at and discuss
the problem.  With MSI starting to be useful I have no expectation
that we will stop here.

There are two fundamental problems that need to be fixed.
- Small size and static allocate of the per cpu area.
- Data structures that don't scale to large numbers of possible irqs.

Solving either of these two fundamental problems involves reexamining
some of our current trade offs in the kernel.

The proper fix for irqs is a refactoring of the data structures so
we can handle a 16 or better yet a 24 bit irq number, and only
allocate the pieces we need.  A proper fix needs to find someway
not to keep a counter for every cpu and irq pair, which no one has
the will to seriously consider right now.

The proper fix for the per cpu area size is much trickier.
Especially if we every reach the point of hotplug NUMA nodes.
One odd observation is that the amount of per cpu data we want
grows with the size of the system.  

Eric
