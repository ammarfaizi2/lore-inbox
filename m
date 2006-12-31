Return-Path: <linux-kernel-owner+w=401wt.eu-S933117AbWLaKX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933117AbWLaKX4 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 05:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933119AbWLaKX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 05:23:56 -0500
Received: from flex.com ([206.126.0.13]:57990 "EHLO flex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933117AbWLaKXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 05:23:55 -0500
X-Greylist: delayed 703 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Dec 2006 05:23:55 EST
Message-ID: <45978CE9.7090700@flex.com>
Date: Sun, 31 Dec 2006 02:11:53 -0800
From: David Kahn <dmk@flex.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: Mitch Bradley <wmb@firmworks.com>, devel@laptop.org,
       linux-kernel@vger.kernel.org, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
References: <459714A6.4000406@firmworks.com> <20061230.211941.74748799.davem@davemloft.net> <459784AD.1010308@firmworks.com>
In-Reply-To: <459784AD.1010308@firmworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Responding to two replies in one email ...


Mitch Bradley wrote:
> 
> David Miller wrote:
>> ...
>> Can we please not have N different interfaces to the open-firmware
>> calls so that perhaps powerpc and Sparc have a chance of using this
>> code too?

David,

I helped Mitch do this "port", so I'd like to chime in here.

Mitch and I both looked extensively at the powerpc and sparc
code that's there. There's an entire extra layer there that
isn't needed if all you want to do is expose the device
tree to userland via the file system, and that's all that was
needed in this case, plus, the desire is to keep OFW in memory
in this case, so caching of the device tree is unnecessary for
this simple implementation.

We didn't create a new interface here, all we did was
write code for the existing OFW client interface and call it
directly, rather than go through extra layers of code to do
that.Both the existing powerpc and sparc code seems to be
burdened with the use of legacy interfaces.



David Miller wrote:

> Please create explicit function calls for each operation, this
> way the caller is immune to open-firmware implementation details.

I did that initially, but Mitch and I agreed that it's just
a waste of more code for this case, where the majority of
i386 implementations are not going to use it.

The opportunity for layering an interface in between the kernel
and the firmware still exists with the trivial callofw interface.

> 
>> SPARC should be able to use that same base interface function directly.  
>> It is written to the standard OFW client interface.
> 
> Sparc 32-bit predates the OFW specification and does things differently.

15 year old 32-bit SPARC machines use a different interface.
None of those machines are even supported by Sun anymore
(hardware or software support in any form.) Nonetheless,
we haven't changed any of that.

And by the way, Mitch and I are intimately familiar with that
stuff from our days together at Sun. (I'm still at Sun.) Mitch
and I have worked together on these firmware interfaces for a long
time now.

> 
> Please use a functional interface using a C function for each device
> tree operation, then the implementation behind it doesn't matter.

The opportunity for layering a different interface in between the kernel
and the firmware already exists with the callofw and cif_handler interfaces.
In fact, before Mitch got the code working, I had written an entire
emulation layer to test the file system code out. All it did was hook
into that existing cif_handler interface, providing its own address
rather than using a cif handler address in the firmware. At the end of
the day, Mitch got the cif calls working to the actual firmware before
we tried the emulation layer, but the point is that it was fairly trivial
to implement.

>> It wouldn't work on ancient Sun machines with the sunmon romvec 
>> interface, but Sun stopped making such machines something like 16 years ago.
> 
> Yet we still support them in the 32-bit sparc port.  And it's so
> easy to support this properly, please use the clean stuff we've
> created for this.

We haven't changed the sparc implementation, it all still works.
All we've done is created a trivial implementation for exporting
the device tree to userland that isn't burdened by the powerpc
and sparc legacy code that's in there now.

> 
>> I did consider first creating a memory data structure identical to the 
>> powerpc/sparc one, but that looked like it was going to be essentially 
>> twice as much code for no extra capability.  The code to traverse the 
>> device tree and create the memory data structure is roughly the same as 
>> the code to create the filesystem structure.  I just didn't see the 
>> value of an intermediate representation for systems that don't otherwise 
>> need it.
> 
> Since we put it in memory, we have zero reason to call into the
> firmware for device tree access and this simplifies things a lot.

And it also wastes resources, if all you need is a read-only
view of the device tree in the filesystem.

-David
