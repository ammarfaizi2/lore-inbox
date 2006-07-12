Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWGLGKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWGLGKG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 02:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWGLGKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 02:10:06 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31899 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932441AbWGLGKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 02:10:05 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Horms <horms@verge.net.au>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH] i386 kexec:  Allow the kexec on panic support to compile on voyager.
References: <20060711123017.5F15A3403D@koto.vergenet.net>
	<m1ejwrgb2b.fsf@ebiederm.dsl.xmission.com>
	<20060712010017.GC9591@verge.net.au>
Date: Wed, 12 Jul 2006 00:09:13 -0600
In-Reply-To: <20060712010017.GC9591@verge.net.au> (horms@verge.net.au's
	message of "Wed, 12 Jul 2006 10:00:19 +0900")
Message-ID: <m1y7uzcq2e.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horms <horms@verge.net.au> writes:

> On Tue, Jul 11, 2006 at 02:07:24PM -0600, Eric W. Biederman wrote:
>> Horms <horms@verge.net.au> writes:
>> 
>> > On Mon, 10 Jul 2006 16:37:49 -0600, Eric W. Biederman wrote:
>> >> 
>> >> This patch removes the foolish assumption that SMP implied local
>> >> apics.  That assumption is not-true on the Voyager subarch.  This
>> >> makes that dependency explicit, and allows the code to build.
>> >
>> > Doesn't only a small portion of the code in question rely
>> > on CONFIG_X86_LOCAL_APIC? Is just a workaround until proper
>> > voager support materialises?
>> 
>> Essentially, but it is correct for the code to stay this way.
>
> Is it neccessary for local apic to be present for all the code in the 
> ifdef to work? It seems to me that the register saving code
> could be made to work without it.

I don't know.  Is sending an NMI to all of the auxiliary processors
on the voyager subarch a sane thing todo?  Can we do that without a local
apic?

The only thing that really needs that tight of a guard to compile
is the disable apic code.

Basically explicitly depending on a local apic makes our true
assumptions and test cases visible in that code.

>> >> What gets disabled is just an optimization to get better crash
>> >> dumps so the support should work if there is a kernel that will
>> >> initialization on the voyager subarch under those harsh conditions.
>> >
>> > By that do you mean, a crash kernel that is able to boot even
>> > though the non-crashing CPUs have not been shutdown?
>> 
>> I simply mean a crash kernel that is able to boot.
>
> I was hoping for some more specific information than that.

I don't think anyone has tested any of this on voyager.  The hard
part is generally in the boot up code not the code on the kexec
path.

Since voyager is so weird I haven't a clue what the real state
of affairs is there.

>> >> Hopefully we can figure out how to initialize apics in init_IRQ
>> >> and remove the need to disable io_apics and this dependency.
>> >
>> > That does sound nice. Do you have any ideas on how that could be 
>> > made to happen?
>> 
>> My patch for that got reverted because it wouldn't boot on Linus's
>> SMP laptop.  It appeared to be some weird ACPI problem.  I didn't
>> receive any bug reports otherwise.
>
> Do you have a link to the patch, or a copy of it floating around?

The reverse commit was: 1e4c85f97fe26fbd70da12148b3992c0e00361fd

You should be able to dig the rest up from there.

> ACPI is the root of many evils, particularly as its bahaviour seems
> to effect many different systems, and it behaves differently on
> different machines. Perhaps the code could be cleaned up a little
> and incoporated into -mm. In my experience the best way to solve ACPI
> problems is to expose the code to as much hardware as possible.
>
>> So I suspect the steps are:
>> 1) Unify SMP and non-SMP apic initialization so it is the exact same
>>    code.
>> 2) Move the unified code up in the boot sequence into init_IRQs.
>> 
>> It is something that needs to be done very delicately.
>
> Yes undersandably so. Sounds quite tedious :(

More or less.  I don't think it is too bad it just requires a bit
of time to pursue it.  

Eric

