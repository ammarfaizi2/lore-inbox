Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315754AbSGAQKl>; Mon, 1 Jul 2002 12:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSGAQKl>; Mon, 1 Jul 2002 12:10:41 -0400
Received: from h-64-105-34-244.SNVACAID.covad.net ([64.105.34.244]:12161 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315754AbSGAQKi>; Mon, 1 Jul 2002 12:10:38 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 1 Jul 2002 09:12:56 -0700
Message-Id: <200207011612.JAA01302@adam.yggdrasil.com>
To: kaos@ocs.com.au
Subject: Re: Rusty's module talk at the Kernel Summit
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
>Since modules are always allocated on page boundaries, discarding init
>sections is only a win if it reduces the final size of the module from
>m to m-n pages.  So far the pain of loading in multiple areas and
>adjusting the associated arch dependent tables after discard has
>outweighed any gain from discarding the init sections from modules.

	That would average out for modules larger than a page if the
distribution of the non-init sections modulo 4096 (or whatever
PAGE_CACHE_SIZE is on your architecture) is basically uniform.
You would be just as likely to free more bytes than the size of the .init
sections as a result of page granularity than to free fewer bytes.

	As an extereme illustration, imagine a module with 4095 bytes
of non-init data and 2 bytes of init data.  With the .init section loaded,
the module will occupy two pages.  Freeing the .init section will free
an entire page, making 4096 bytes available to the system, even though
only two bytes were in the .init section.

	On the linux-2.5.24 x86 machine on which I am composing this
email, 654 out of 983 modules (two thirds) have text+data+bss larger than
4096 bytes.  The byte count of these modules modulo 4096 is actually a bit
heavier on the low end, which bodes well for saving space by releasing .init
sections:

Module text+data+bss
size modulo 4096	 # of modules

0000...0511              102
0512...1023              108
1024...1535               81
1536...2047               76
2048...2559               71
2560...3071               90
3072...3583               69
3584...4095               57


	It would also be possible to achieve space savings for modules
with non-init text+data+bss sizes smaller than a page by allocating
their space with kmalloc(...,__GFP_HIGHMEM) instead of vmalloc.  This
would require loading the init and non-init parts as separate modules,
which would happen if this were implemented in what I regard as the
"easy" way, a way that would only delete lines from the current kernel
(but add code to insmod).

	Here is what I have in mind.  I believe that removal of .init
sections could be implemented entirely in user land (aside from
removing the include/inux/init.h code that disables init sections for
modules).  Insmod would allocate two kernel modules, one for the init
sections and the other for the regular sections.  Insmod would resolve
references between the two sections.  The temporary module for the
init sections would be loaded first, with no initialization routine.
The module with the real data would be loaded second, and would run
the initialization routine (even if the initialization routine were in
the temporary init module).  When the initialization routine
completed, regardless of sucess or failure, the temporary init module
would be unloaded.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
