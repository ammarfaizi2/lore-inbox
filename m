Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbVKXOAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVKXOAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 09:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVKXOAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 09:00:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46053 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751019AbVKXOAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 09:00:16 -0500
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
References: <437B5A83.8090808@suse.de> <438359D7.7090308@suse.de>
	<p7364qjjhqx.fsf@verdi.suse.de>
	<1132764133.7268.51.camel@localhost.localdomain>
	<20051123163906.GF20775@brahms.suse.de>
	<1132766489.7268.71.camel@localhost.localdomain>
	<20051123165923.GJ20775@brahms.suse.de>
	<1132783243.13095.17.camel@localhost.localdomain>
	<20051124131310.GE20775@brahms.suse.de>
	<m1zmnugom7.fsf@ebiederm.dsl.xmission.com>
	<20051124133907.GG20775@brahms.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 24 Nov 2005 06:58:52 -0700
In-Reply-To: <20051124133907.GG20775@brahms.suse.de> (Andi Kleen's message
 of "Thu, 24 Nov 2005 14:39:07 +0100")
Message-ID: <m1u0e2gnab.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>> I think I see the source of the confusion.  Scrubbing is the
>> process of taking data that is correctable and writing it back to
>> memory so that if a second correctable error occurs the net is still
>> corrected.
>
> That's supposed to be done by hardware, no? 
> At least the K8 has a hardware scrubber (although it's not always enabled)

Recent good implementations like the Opteron will do it for you.
Older or cheaper memory controllers will not.

Having an architecturally sane software scrubber as backup for
the hardware implementations is nice, and except in the cases
where someone disables the lock prefix it is takes very little
code on x86.

Even on the Opteron you could theoretically have the case of a brain-dead
external memory controller, although that is not likely.

>> Directed killing of processes is something that must be done
>> inside a synchronous exception (like a machine check) because otherwise
>> it is so racy you don't know who has seen the bad data.  
>
> If you try to do it this way then the code will become such
> a mess if not impossible to write that your changes to merge them
> and get it right are very slim. The only sane way to do all the locking etc. 
> is to hand over the handling to a thread. While that make the window
> of misusing the data wider it's the only sane alternative vs not
> doing it at all.
>
> Also due to the way hardware works with machine checks usually being
> async and not precise works you have that window anyways, so it's 
> not even worse. Also consider multiple CPUs.

First I don't have any code to do this, but I have though about it.
The races are the primary reason I have never pushed for something
like this.  With memory errors coming in as machine checks it is now
possible to do a correct version.

Essentially we are talking something with the complexity of a page
fault.  All that must happen synchronously is the task must
be stopped, and flagged.

As for races every cpu that accesses that data should take
a synchronous exception.  DMA should do something similar but I'm 
not as familiar with that side of the problem.  And because everything
takes an exception multiple cpu races are not a problem.

Of course there are still the memory errors that are so bad that
they don't even cause a machine check.  Those are a real pain
to debug, and fix.

In this latter case assuming the memory error is transient and
not hard using a write-combine memory attribute when you write
to re-initialize the ECC state is the way to go.  But remember
you most do it on the cpu that is part of the memory controller.
Otherwise something in the whole read/modify process will fail
to get the ECC state initialized properly on an Opteron.

Eric
