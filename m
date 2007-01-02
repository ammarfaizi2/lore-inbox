Return-Path: <linux-kernel-owner+w=401wt.eu-S964823AbXABMW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbXABMW0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbXABMW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:22:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:56740 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964823AbXABMW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:22:26 -0500
In-Reply-To: <1167709992.6165.18.camel@localhost.localdomain>
References: <459714A6.4000406@firmworks.com> <20061230.211941.74748799.davem@davemloft.net> <459784AD.1010308@firmworks.com> <1167709992.6165.18.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <24a109a8fa0f45011daf3e2b55172392@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org,
       David Miller <davem@davemloft.net>, David Kahn <dmk@flex.com>,
       Mitch Bradley <wmb@firmworks.com>, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Tue, 2 Jan 2007 13:22:43 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Except that none of the powerpc platforms can keep OF alive after the
> kernel has booted, which is why we do an in-memory copy of the tree.

Adding that functionality hasn't gotten easier at all since
we use the flattened tree for everything, heh.

> We have well defined interfaces to access that copy and you should do
> the same on i386.

There should be a well-defined "C-style" interface, yes.  But it
does _not_ have to be a copy of the data and it does _not_ have
to be the same interface.

You also can't require "i386" to add that stuff right now, when
they only have one user (the fs code) that is perfectly happy
calling the low-level interface for the three or four calls it
needs.

> We also have defined mecanisms for non-OF firmwares to pass 
> device-trees
> that follow the OF defined bindings, mostly for embedded things (and
> there are already some of these on the field).

Yeah, and that's a great thing.  Any "unified" interface we
come up with should support both those "flat trees", and
"real OF trees", but also "real, still alive during kernel
run-time, OF".

> There are some performances advantages, when walking the tree later on,
> in not using direct OF accesses all the time (on platforms where that 
> is
> possible at all) too.

Yes.  A problem that can easily be solved by a little cache
thing (for the device nodes, not even the property data) if
it turns out to be a real advantage.

> In addition, the kernel implementation with the
> in-memory tree adds some refcounting and locking while I suspect that 
> to
> access a real OF, you have to hard-single-thread everything.

Not single thread -- but a "global OF lock" yes.  Not that
it matters too much, (almost) all property accesses are init
time anyway (which is effectively single threaded).

> Finally, you can't have something as simple as powerpc's get_property()
> (that just returns a pointer to the property content) with direct OF
> access unless you use some magic static buffer or some crap around 
> those
> lines, or add passing of a buffer in, so from a driver pointer of view,
> the interface provided by powerpc/sparc is nicer.

But since you have a _put() function anyway, for your reference
counting, having magic (automatically allocated, not static of
course) buffers works just fine.

> There are additional issues on various platforms related to actually
> passing buffers in/out OF, which cannot always access the full system
> memory (think about OF running in 32 bits mode on some machines 
> etc...).

Or simply using a 32-bit client interface, yes.  You can sidestep that
issue by not having OF around at all anymore by the time the kernel
proper starts, but that's not a good argument for not running with OF
still alive.

> I still don't agree with having yet another interface different to the
> existing ones.

Yes, the interfaces should be consolidated (at least as far as it
makes sense, and people can reach agreement) -- let's get there step
by step please, don't say "you can't do an OF interface in the kernel
since it's not identical to ours and you didn't do all the necessary
work to merge and fix everything up front" :-)

So let's decide on the text-vs.-binary fs thing first...


Segher

