Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbTILTci (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 15:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbTILTci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 15:32:38 -0400
Received: from ns.suse.de ([195.135.220.2]:12962 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261809AbTILTcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 15:32:35 -0400
Date: Fri, 12 Sep 2003 21:30:16 +0200
From: Andi Kleen <ak@suse.de>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: bunk@fs.tum.de, jgarzik@pobox.com, ebiederm@xmission.com, akpm@osdl.org,
       richard.brunner@amd.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-Id: <20030912213016.47a4e5de.ak@suse.de>
In-Reply-To: <1063393505.3371.207.camel@workshop.saharacpt.lan>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>
	<20030911012708.GD3134@wotan.suse.de>
	<20030910184414.7850be57.akpm@osdl.org>
	<20030911014716.GG3134@wotan.suse.de>
	<3F60837D.7000209@pobox.com>
	<20030911162634.64438c7d.ak@suse.de>
	<3F6087FC.7090508@pobox.com>
	<m1vfrxlxol.fsf@ebiederm.dsl.xmission.com>
	<20030912195606.24e73086.ak@suse.de>
	<3F62098F.9030300@pobox.com>
	<20030912182216.GK27368@fs.tum.de>
	<20030912202851.3529e7e7.ak@suse.de>
	<1063393505.3371.207.camel@workshop.saharacpt.lan>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003 21:05:06 +0200
Martin Schlemmer <azarah@gentoo.org> wrote:


> Ok, so how many instructions was added by this ?  Or is it

None at all, Mr Inquisitor. It is all patched at early boot time.

> Ok, so maybe my opinion about X86_GENERIC is not as intended, but
> then IMHO, it should be 'fixed'.  I could not care less if my kernel
> only boot just on my box, never mind on another P4 - I just want
> the most optimised on possible.  Sure, some guys want a more generic
> kernel - get X86_GENERIC to work for them.  Same for distro's.

X86_GENERIC has nothing to do with all this. All it does is 
to always force the cache line padding to 128 byte. 

This means that when you have an SMP kernel, no matter compiled
for what CPU, it will not run like crap on a P4 Xeon based SMP system.
The cost is some more memory usage for more padding (Athlon is fine 
with 64 byte padding, P3 is fine with 32byte padding). If you don't
want that just don't enable it.
 
> I have long wondered if everything in arch/i386/kernel/cpu/ is
> really linked in (meaning with no #ifdef as it now looks to be
> at a quick peek), or if it was just easier to link them all,
> but have non generic stuff (amd/cyrix/whatever specific code)
> filtered by ifdef's.

It is (in MTRR drivers etc.), but the resulting overhead is small.

Currently I even link in Intel and Cyrix specific MTRR drivers on x86-64
just to keep the common code common and clean.

Really, when you want to save code size you should look elsewhere. All the 
CPU support code is pretty lean and in many cases is __init code anyways
(= is discarded after boot time) 

I can offer my old bloat-o-meter tool (ftp://ftp.firstfloor.org/pub/ak/perl/bloat-o-meter)
It is great to look for bloat. Just run it with a 2.4 kernel and 2.6 kernel and compare
the results. Then look at the top 50 bloat increasers. I bet with you that 
you won't find anything touched in this thread among them.

I suspect for example if you just worked on making sysfs optional you would
save a lot more.
 
> This is just me, but why then don't we then just drop the specific
> arch selection, and just have generics instead of pulling a sock
> over the user's eyes ?

It is doing a lot of optimizations for the specific CPU. For example
it tells gcc to compile for that CPU which can make a big difference (P4 prefers
very different code compared to P3 or Athlon). Or it sets the paddings correctly
for the CPU, which can make a very big difference in .text size. So when you
select CONFIG_MPENTIUM4 you will get a kernel that will perform optimally for P4.

To give a bit of perspective:

On 2.4 the situation was: 

- Athlon kernel would only boot on Athlon/K6 due to 3dnow prefetches
- P4 kernel would boot everywhere
- P3 kernel would boot everywhere

(ignoring really old CPUs or oddballs like C3 without CMOV support) 

(also note booting just means booting without oops, not being optimal for the specific CPU.
Being optimal is very different)

Then 2.6 added SSE1 prefetch support which made the P4 kernel not boot on
anything that didn't support SSE1 (like older Athlon before XP). I fixed
that then with dynamically patching the prefetches. The overhead at runtime
is zero because it is patched at boot, the .text overhead for the patch 
tables is minimal.

So basically the 2.6 alternative() stuff just restored the 2.4 de-facto situation 
in 2.6, and improved it slightly because the Athlon kernel also now works everywhere.

I think it's useful to keep kernels booting everywhere, it makes it a lot easier
to test a single kernel on multiple systems.

-Andi

