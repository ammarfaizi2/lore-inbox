Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285290AbRLFXRK>; Thu, 6 Dec 2001 18:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285287AbRLFXRB>; Thu, 6 Dec 2001 18:17:01 -0500
Received: from rj.SGI.COM ([204.94.215.100]:8632 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S285288AbRLFXQt>;
	Thu, 6 Dec 2001 18:16:49 -0500
Date: Fri, 7 Dec 2001 10:15:17 +1100
From: Nathan Scott <nathans@sgi.com>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>,
        Andreas Gruenbacher <ag@bestbits.at>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: [PATCH] Revised extended attributes interface
Message-ID: <20011207101517.B46546@wobbly.melbourne.sgi.com>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <E16Boqr-0000m9-00@starship.berlin> <20011206164131.F50483@wobbly.melbourne.sgi.com> <E16C0PD-0000ot-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16C0PD-0000ot-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Dec 06, 2001 at 04:25:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Daniel,

On Thu, Dec 06, 2001 at 04:25:41PM +0100, Daniel Phillips wrote:
> On December 6, 2001 06:41 am, Nathan Scott wrote:
> > 
> > I guess it ultimately comes down to simplicity.  
> 
> Right now we have two namespaces, user and system.

Andreas and the security folk have long been investigating
"trusted" and "owner" namespaces too.  See Andreas' web pages
for more discussion on those.

I see no reason to impose such arbitrary restrictions as you
seem to be suggesting - if a filesystem does not want to or
cannot implement some particular namespace, then it shouldn't
be forced to.  eg. there is no reason why the user namespace
has to be implemented - Andreas patches for ext2/ext3 go so
far as to make this namespace compile-time conditional (and
his userspace tools just continue to work - its really quite
a nice design, IMO).

> That's one bit of 
> information, and the proposal is to represent it with 5-7 bytes, passing it 
> on every call, and decoding it with a memcmp or similar.  This is just extra 
> fluff as far as I can see,

I'd be interested in seeing exactly how you'd like to see the
interfaces changed - could you put forward some APIs?

<guessing here>
It sounds like you're suggesting a separate integer namespace
parameter to each syscall/vfs interface?  I think you'll find
this solves none of the problems you're describing, and makes
every operation more complex, and more difficult.  Worse, its
alot more open to abuse in the way the old command parameter
was than namespace-prefixed names are!  (there would probably
be some free high-order bits in there where I could sneak new
functionality in, right?)
</guessing here>

But perhaps I'm misunderstanding what you're suggesting - I
should wait to see your patch.

> and provides every bit as much opportunity for 
> implementing a private API as the original cmd parameter did, by encoding 
> whatever one pleases before the dot.

This is just not true - the API does not change at all if a new
namespace was needed for some reason.  Restricting namespaces by
using a binary namespace also doesn't help at all - the namespace
becomes obfuscated (strings are easier to grok than bitfields),
divorced from the name (which it clarifies, making life difficult
for the userspace tools) and doesn't even solve the "problem" -
someone could use new bits just as easily as use new namespace
strings.

> > (unless you go for a binary namespace representation, and that's a
> > real can of worms).
> 
> I'm suggesting we take a look at that.
> 

Andreas and I did have such an implementation, but we ditched it.
The CVS revision history of cmd/attr2/{set,get}fattr/*.c in the XFS
tree show the progression of user<->kernel interfaces which I tried
while Andreas and I were nutting out a clean solution that we both
could use.

Thar be dragons thar.  Big hairy ones.

> > [extended attributes on symlinks]
> 
> OK, well it looks like you're going a little overboard here in dividing out 
> the functionality.  What you're talking about is 'follow symlink or not', 
> right?  That really does sound to me as though it's naturally expressed with 
> a flag bit.  I really don't see a compelling reason to go beyond 8 syscalls:
> 
>   get, fget, set, fset, del, fdel, list, flist
> 

I'm not too fussed - the second draft patch I sent out did exactly
as you describe, in an attempt to cut down on syscalls.  This again
meant adding a "flags" field to each operation.  We also have stat/
lstat/fstat and chown/lchown/fchown - I was trying to be consistent
with those, and I still think that is the right thing to do.

cheers.

-- 
Nathan
