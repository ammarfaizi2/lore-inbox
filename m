Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317764AbSGKFF0>; Thu, 11 Jul 2002 01:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317765AbSGKFFZ>; Thu, 11 Jul 2002 01:05:25 -0400
Received: from h-64-105-137-27.SNVACAID.covad.net ([64.105.137.27]:51129 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317764AbSGKFFZ>; Thu, 11 Jul 2002 01:05:25 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 10 Jul 2002 22:07:32 -0700
Message-Id: <200207110507.WAA20797@adam.yggdrasil.com>
To: rusty@rustcop.com.au
Subject: Re: Rusty's module talk at the Kernel Summit
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-07-11 2:48:30, Rusty Russell <rusty@rustcorp.com.au> wrote:
>On Thu, 4 Jul 2002 10:24:11 -0700
>"Adam J. Richter" <adam@yggdrasil.com> wrote:
>>       The system that I am composing this email on has 1.1MB of
>> modules and does not have sound drivers loaded.  It has ipv4 and a
>> number of other facilities modularized that are not modules in the
>> stock kernels.  Every system that I use has a configuration like this.
>> With a lower per-module overhead, I would be more inclined to try to
>> modularize other facilities and break up some larger modules into
>> smaller ones, in the case where there is substantial code that is not
>> needed for some configurations.
>
>For God's sake, WHY?  Look at what you're doing to your TLB (and if you
>made IPv4 a removable module, I'll bet real money you have a bug unless
>you are *very* *very* clever).

	My motivation in modularizing ipv4 was to be able to sqeeze more
drivers onto a boot floppy for CD's or hard disks and have that kernel
still be able to continue on bring up networking later (and to avoid
maintaining a different kernel binary).  Ultimately, I would like to
see CONFIG_NET modularized, if only to reduce the time spent reading
the floppy.

	I have deliberately not fixed some reference count problems in
my ipv4.o module right now because I'm pretty sure lots of things would
break if I tried removing it.  I did write a module_exit function, but
I never tried turning off the reference counting and executing it.

	I also was under the impression that Dave Miller had a modularized
ipv4 in a "vger cvs" kernel (remember them?), so I assumed that some
modularization of ipv4 was working its way to Linus.

	About translation lookaside cache misses, I was considering
breaking down these large modules mostly after the optimizations that
I wishfully described later in my posting:

| Then somebody changes allocation of
| modules that are less than a page to use kmalloc(GFP_HIGHMEM) instead
| of vmalloc (~30% of modules on my system are already this small).
| Then somebody figures out a way to have vmalloc's larger than a page
| that do not need page alignment can sometimes start in the unused last
| page of another vmalloc.

	In that case, it's a much more emperical question about
whether eliminating large chunks of unused code brings the code that
does run into the same page more often than splitting the module
causes code that was in the same page to be split into two different
pages, especially if there is a reasoonable chance that that code is
going to be loaded into a location that shares a page that would already
be in the TLB.

	Come to think of it, if modules do not have to occupy full pages,
you could perhaps add a "module affinity" so that modules that reference
each other would be more likely to end up sharing a page.  Module loading
happens tens of times a day, if that.  Inter-module calls can happen a
zillion times per second.  So, who knows, it might be worth the complexity,
could be in insmod.

	Dave Miller's proposal to use 4MB pages for modules is an
interesting alternative, but, isn't kmalloc()'ed memory already
in the kernel's big page?  If so, then using that for small modules
would have the same effect for at least those modules, and I believe
that kmalloc is set up to handle up to 128kB.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
