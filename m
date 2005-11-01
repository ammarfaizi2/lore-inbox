Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVKAMEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVKAMEe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 07:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVKAMEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 07:04:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45016 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750766AbVKAMEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 07:04:33 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       Doug Thompson <dthompson@lnxi.com>
Subject: Re: PATCH: EDAC - clean up atomic stuff
References: <1129902050.26367.50.camel@localhost.localdomain>
	<m164rhbnyk.fsf@ebiederm.dsl.xmission.com>
	<1130772628.9145.35.camel@localhost.localdomain>
	<m1oe55abm4.fsf@ebiederm.dsl.xmission.com>
	<20051031120254.4579dc9a.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 01 Nov 2005 05:03:57 -0700
In-Reply-To: <20051031120254.4579dc9a.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 31 Oct 2005 12:02:54 -0800")
Message-ID: <m18xw88thu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
>>
>> Ok.  If I recall correctly atomic kmaps have the rule that they are
>>  per cpu, and you can't be interrupted when the map is taken, by
>>  something else that will use the map.  But they are safe to use from
>>  interrupt context.  As I recall the code needs to ensure that an
>>  interrupt handler doesn't use the same buffer and that it isn't
>>  preempted where another thread will use the buffer.  The preemption
>>  angle is new since that piece of code was written.
>
> Yes, a particular atomic kmap slot is simply a static, per-cpu scalar. 
> It's just like
>
> int foo[NR_CPUS];
>
> 	...
> 	foo(smp_processor_id());
>
> and all the same rules apply.
>
> The use of KM_BOUNCE_READ does appear to be incorrect.  bounce_copy_vec()
> will use KM_BOUNCE_READ from interrupt context, so if the EDAC code is
> interrupted by the block layer while it holds that kmap, it will find that
> it's suddenly diddling with a different physical page.
>
> So to use KM_BOUNCE_READ, the EDAC code nees to disable local interrupts,
> or to use a different (or new) slot.
>
> In what contexts is edac_mc_scrub_block() called?  If process context, then
> KM_USER0 would suit.

That function is very nice functionality but we could not implement it
properly outside of the kernel.  So the code has been disabled until
just recently. 

Hmm.  Looking at the patch it is most definitely being called from
process context.  Although I think the original was ok from interrupt
context as well.

> Ah, edac_mc_scrub_block() is passing the pageframe address to
> kunmap_atomic() - that's a common bug.  It needs to pass in the virtual
> address which kmap_atomic() returned.

Oops.  Although I am actually surprised kunmap_atomic even needs the address.
Although I can see the kmap type being equally redundant.

There is a much more serious bug there as well.  The code as it
exists is flatly impossible on x86_64 and some other architectures
as they do not support kmap.  It is also broken on x86 as grain can
easily be larger than page size, on old memory controllers where this
is most needed it is the frequently the size of a memory chip select
(aka the size of a single sided DIMM).

We need to do two things.
- Remove a factor from edac_mc_scrub_block (call it edac_mc_scrub_page)
  that simply scrubs a page or maybe a sub page.
- Place the edac_mc_scrub_page which does the kmap and a loop through
  the page contents in arch specific code.

Eric
