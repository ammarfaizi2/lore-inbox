Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVESA4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVESA4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 20:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbVESA4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 20:56:18 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:53935 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262431AbVESA4B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 20:56:01 -0400
Message-ID: <428BE417.4050402@us.ibm.com>
Date: Wed, 18 May 2005 17:55:51 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc4-mm2 build failure
References: <734820000.1116277209@flay> <Pine.LNX.4.62.0505161602460.20110@graphe.net> <428A8697.4010606@us.ibm.com> <Pine.LNX.4.62.0505171707100.18365@graphe.net> <428B7A5F.9090404@us.ibm.com> <Pine.LNX.4.62.0505181035140.6359@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0505181035140.6359@graphe.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 18 May 2005, Matthew Dobson wrote:
> 
> 
>>I think you explained it well yourself.  If another function needs to be
>>added for ALL ARCHES, then ALL ARCHES will need to add the function.  In
>>most cases there is no single function that is both CORRECT and GENERIC
>>across all arches.  The way that i386, ia64, ppc64, etc. will map PCI Buses
>>to Nodes (for instance) will NOT be the same.  Anyone who adds a new
>>topology function has the responsibility of
>>1) making sure it works for all arches which support topology, or
>>2) getting the arch maintainers involved and helping them make sure it
>>works for all arches.
> 
> 
> The topology function in generic may just do nothing
> if not defined by the arch like pcibus_to_node. If the arch does not
> define it return indeterminate and make all node specific allocations fall
> back to unspecific allocation. This works for all arches and preserves
> the existing behavior.

Which is the way it was designed.  Arches which just want a safe/sane
default (yet likely inefficient) topology behavior that makes the system
look like a UP/SMP box should include asm-generic/topology.h from their own
asm/topology.h.  Arches that want to provide a useful and accurate topology
behavior should define their own implementation of the functions in
asm/topology.h.

The compilation breakage from defining a new topology function for some
arches and using it in generic code without defining it for all arches that
implement topology was intentional.  It's a sign that whoever made that new
function should at least solicit some feedback from other arches to make
sure that they are doing something sane, and so that we just don't add new
topology functions on a whim.  It was hoped that this would encourage some
discussion amongst arches to come up with interfaces that would be usable
across multiple (all?) arches.


>>New topology functions don't really get added all that often.  We've got
>>the basics (CPU, Mem, I/O Buses, Nodes) mapped in various ways, so there
>>shouldn't be tons of new functions added.  If someone wants to add a new
>>function, it's their responsibility to make sure that it doesn't break
>>anyone's arch.
> 
> 
> Its best to have the kernel setup in such a way that functions can be 
> added without having to cause breakage.
> 
> It is imaginable that someone will add more hardware something to node
> functions in the near future given that pcibus_to_node is just for pci.

I agree.  The way (historically) to not cause breakage is to implement your
new topology function for arches that care, or just stick a sane default in
their topology.h.  Every arch does it the way I'm suggesting, except IA64 &
x86_64.

x86_64 surprisingly does define pcibus_to_cpumask, but NOT
pcibus_to_node().  That means when they unconditionally #include
<asm-generic/topology.h> at the bottom of asm-x86_64/topology.h they get a
confusing mish-mash of pcibus functions.  What I mean is, on x86_64
pcibus_to_cpumask will do the right thing but pcibus_to_node will not.
This is broken.  The correct thing to do would be to define pcibus_to_node
in asm-x86_64/topology.h and only include asm-generic/topology.h if
DISCONTIG/NUMA isn't defined.

IA64 seems to define all the topo functions except pcibus related ones.
They also include the generic topology functions, but at least their
pcibus_to_FOO functions are consistent.  Ideally, IA64 would also implement
a version of pcibus_to_FOO that does the right thing, but for now I guess
it isn't a priority for them.

Either way, I suppose it's not a terribly interesting argument.  Both of
our patches solve the build problem.  Whichever one Andrew wants is the fix
we'll go with.  I'd obviously prefer mine, since it remains consistent with
the way I designed the topology system in the first place, but since 2
other arches do it the way your patch does, I won't throw a fit if your
patch gets in.

-Matt
