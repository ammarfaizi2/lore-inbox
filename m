Return-Path: <linux-kernel-owner+w=401wt.eu-S1755253AbXABDxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbXABDxa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 22:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755254AbXABDxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 22:53:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:46090 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755253AbXABDx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 22:53:29 -0500
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mitch Bradley <wmb@firmworks.com>
Cc: David Miller <davem@davemloft.net>, devel@laptop.org,
       linux-kernel@vger.kernel.org, jg@laptop.org, David Kahn <dmk@flex.com>
In-Reply-To: <459784AD.1010308@firmworks.com>
References: <459714A6.4000406@firmworks.com>
	 <20061230.211941.74748799.davem@davemloft.net>
	 <459784AD.1010308@firmworks.com>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 14:53:12 +1100
Message-Id: <1167709992.6165.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The base interface function is callofw(), which is effectively identical 
> to call_prom_ret() in  arch/powerpc/kernel/prom_init.c .  So it seems 
> that PowerPC could use it.  I suppose I could change the name of 
> callofw() to call_prom_ret(), thus making the base interface identical 
> to PowerPC's.  All it does is argument marshalling, translating between 
> C varargs argument lists and the OFW argarray format.

Except that none of the powerpc platforms can keep OF alive after the
kernel has booted, which is why we do an in-memory copy of the tree.

We have well defined interfaces to access that copy and you should do
the same on i386.

We also have defined mecanisms for non-OF firmwares to pass device-trees
that follow the OF defined bindings, mostly for embedded things (and
there are already some of these on the field).

> SPARC should be able to use that same base interface function directly.  
> It is written to the standard OFW client interface.  The x86 client 
> interface that I tested it on is essentially the same code that is in 
> OBP.  It wouldn't work on ancient Sun machines with the sunmon romvec 
> interface, but Sun stopped making such machines something like 16 years ago.

sparc64 also uses an in-memory copy of the tree nowadays.

   
> I did look at those files, until my eyes glazed over.  In powerpc land, 
> the files that are the underlayer for proc_devtree.c comprise 4700 lines 
> of code (the files you list plus prom_init.c).  In sparc land, it is 
> only 3200 lines (the files you list plus the prom interface library).  
> On top of that, proc_devtree.c is 233 lines.
>
> In contrast, ofw_fs.c is 261 lines, and the base interface function 
> callofw() is 97 lines (half of them comments).

I think the number of lines of code involved here is totally irrelevant.
Especially if you just add together all the stuff in prom.c which isn't
entirely related to simply accessing the device-tree. You are just
over-simplifying. (And in fact, powerpc also carries some earlier
version of the interfaces that is deprecated but that we haven't removed
yet).

> Admittedly, this is something of an apples-to-oranges comparison, 
> because ofw_fs only exports a read-only device tree and nothing else.  
> But in the case where that is all you need, a direct interface to OFW 
> that avoids the middleman seems like a good choice.

Except that your approach is only ever useable when there is a "live" OF
still present which isn't the case on powerpc.

> I did consider first creating a memory data structure identical to the 
> powerpc/sparc one, but that looked like it was going to be essentially 
> twice as much code for no extra capability.

The code to create it is fairly small and __init. Doesn't matter -that-
much.

> The code to traverse the 
> device tree and create the memory data structure is roughly the same as 
> the code to create the filesystem structure.  I just didn't see the 
> value of an intermediate representation for systems that don't otherwise 
> need it.  (A setup layer would have let me use proc_devtree.c directly, 
> so the total amount of new code would have been the same, but many 
> people told me that if I even suggested using procfs the kernel gurus 
> would blow me out of the water without bothering to blink.)

There are some performances advantages, when walking the tree later on,
in not using direct OF accesses all the time (on platforms where that is
possible at all) too. In addition, the kernel implementation with the
in-memory tree adds some refcounting and locking while I suspect that to
access a real OF, you have to hard-single-thread everything.

Finally, you can't have something as simple as powerpc's get_property()
(that just returns a pointer to the property content) with direct OF
access unless you use some magic static buffer or some crap around those
lines, or add passing of a buffer in, so from a driver pointer of view,
the interface provided by powerpc/sparc is nicer.

There are additional issues on various platforms related to actually
passing buffers in/out OF, which cannot always access the full system
memory (think about OF running in 32 bits mode on some machines etc...).

> In the SPARC and PowerPC spaces, Open Firmware is widespread, so it 
> makes sense for those kernels to use OFW extensively.  In x86 land, OFW 
> is far from being the dominant firmware, so the x86 kernel is unlikely 
> to depend on OFW services at a deep level.  That being the case, the 
> deep-integration features of the sparc and powerpc OFW interfaces are 
> not needed in x86 land.   But a lightweight interface to the device tree 
> is certainly useful for the platforms that do have OFW.  It might be 
> useful for other processors as well, especially on platforms that don't 
> need the deep configurability that drove the OFW design.

I still don't agree with having yet another interface different to the
existing ones.

Ben.


