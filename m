Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbSK0SoO>; Wed, 27 Nov 2002 13:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSK0SoO>; Wed, 27 Nov 2002 13:44:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7951 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262416AbSK0SoN>; Wed, 27 Nov 2002 13:44:13 -0500
Date: Wed, 27 Nov 2002 10:51:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: sfr@canb.auug.org.au, <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       <ak@muc.de>, <davidm@hpl.hp.com>, <schwidefsky@de.ibm.com>,
       <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] Start of compat32.h (again)
In-Reply-To: <20021126.235810.22015752.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0211271039350.15032-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Nov 2002, David S. Miller wrote:
> 
> Linus what is you big beef with the names used before, the "__kernel"
> part of the name?  We can't just use "u32" for ino_t althroughout the
> compat32 code or whatever your idea seems to be.

I have two _big_ beefs with the 

	__kernel_xxx_t32

naming:

 - the xxx_t naming is already ugly, but at least it's standard ("_t 
   stands for typedef"). No such case is true for _t32.

 - the __kernel_ naming is already ugly, but at least it has a _reason_ 
   for it, namely that we have to have __ to avoid polluting user-space
   headers with the _one_ thing that the kernel exports, namely
   architecture types. Again, this is _not_ true for the compat32 stuff, 
   since it's an ABI, not an API issue, and the types aren't exposed to
   user space headers.

In short, it's f*cking ugly, for no good reason.  That in itself is _way_ 
enough reason to say "No FRIGGING WAY!".

The original patch was worse by an order of magnitude for _another_ 
reason, which has nothing to do with naming:

Note that I'm not against having architecture-specific "compat32 types". 
HOWEVER, if they are architecture-specific, then they had better not be in 
a generic file. So it's just _fundamentally_ wrong to have a <linux/xxx.h> 
file that then has "architecture-specific" stuff in it. That's just CRAP.

So the naming is just ugly (but ugly enough that I don't want to see it). 
The real crap is having a architecture-independent file that defines 
non-generic types.

I suspect that the correct way to do things is:

 - have an <asm/compat32.h> for the types. The types _are_ different for 
   different architectures, even if 90% of them look really really 
   similar. It's just not worth it trying to share code that is not 
   fundamentally the same - and in this case it isn't.

   This fixes the fundamental objection I had to <linux/compat32.h>

 - use sane naming. Something like "compat32_nlink_t" is sane. Something 
   like "__kernel_nlink_t32" is not.

You might as well also discuss just dropping the "32" from "compat32"  
while you're at it. As far as I can tell the code and the fundamental
issue has nothing to do with 32-bitness per se. It has everything to do
with compatibility with an older ABI. The 32-bitness is a implementation
detail, there's nothing that fundamentally says the same compat code might
not work with a 64(user)->128(kernel) bit (or a 16->32 bit) compatibility
layer.

			Linus

