Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261863AbSJECPo>; Fri, 4 Oct 2002 22:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261887AbSJECPo>; Fri, 4 Oct 2002 22:15:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51981 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261863AbSJECPn>; Fri, 4 Oct 2002 22:15:43 -0400
Date: Fri, 4 Oct 2002 19:22:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: viro@math.psu.edu, <linux-kernel@vger.kernel.org>
Subject: Re: oops in bk pull (oct 03)
In-Reply-To: <20021004.190053.69975722.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0210041913340.1253-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Oct 2002, David S. Miller wrote:
>    
>    I think that is the real issue. We're mapping something - probably a host
>    bridge - at address 0, and then accessing RAM (which is also is mapped at 
>    PCI address 0) and the host bridge is unhappy.
> 
> We're current blindly putting ~0 in there, how can that be any
> better? :-)

Oh, ~0 is better for a lot of reasons:

 - it doesn't clash with RAM on any normal platform, the there is no 
   confusion in the host bridge where a regular RAM access should go.

   Even PC's with 4GB+ of RAM always leave the top of the 32-bit 
   address space for PCI mappings (ie they explicitly leave a hole in the 
   RAM mapping there, exactly so that 32-bit PCI cards can work)

 - it doesn't clash with ISA mappings either

 - it is the standard way of probing sizes, so unlike writing 0, this is 
   stuff that BIOS writers and system designers have actually seen in real 
   life, and tested against (since Windows also has to be doing it this
   way, and it's in all the example books about PCI programming)

 - it is - partly for the same previous reason - pretty much guaranteed to
   be one of the few areas that won't even clash with other PCI mappings. 

 - Finally, on regular PC's the high 32-bit region is almost always 
   reserved for other things anyway, ie the APICs are mapped there (and
   that mapping won't conflict with a host bridge, since APIC mappings 
   will be resolved on the CPU and never even hit the hostbridge world, 
   unlike RAM accesses).

So 0 and ~0 are quite fundamentally different here.

> And putting ~0 there is ok?

See above.
 
> From what you're saying, that whole routine is fundamentally broken.

No, the "write ~0, read it back, write the old value" is part of standard
PCI probing (there isn't any other way to figure out the size of these
ranges).

It's just that Ivan tried to extend it, and that _extension_ doesn't work.

		Linus

