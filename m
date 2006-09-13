Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWIMWF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWIMWF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 18:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWIMWF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 18:05:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29164 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751217AbWIMWF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 18:05:58 -0400
Date: Wed, 13 Sep 2006 15:05:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael A Fetterman <Michael.Fetterman@cl.cam.ac.uk>
Subject: Re: Assignment of GDT entries
In-Reply-To: <45087C78.20308@goop.org>
Message-ID: <Pine.LNX.4.64.0609131454480.4388@g5.osdl.org>
References: <450854F3.20603@goop.org> <Pine.LNX.4.64.0609131358090.4388@g5.osdl.org>
 <45087C78.20308@goop.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Sep 2006, Jeremy Fitzhardinge wrote:
> 
> So does this mean that moving the user-visible cs/ds isn't likely to break
> stuff, if it has been done before?

Yes. I _think_ we could do it. It's been done before, and nobody noticed.

That said, it may actually be that programs have since become much more 
aware of segments, for a rather perverse reason: the TLS stuff. Old 
programs are all very much coded and compiled for a totally flat model, 
and as such they really don't know _anything_ about segments. But with 
more TLS stuff, it's possible that a modern threded program is at least 
aware of _some_ of it. 

In other words - I _suspect_ we can move things around, but it would 
require some rather heavy testing, at least. Especially programs like Wine 
might react badly.

> > And segment #8 (ie 0x40) is special (TLS segment #3), of course. Anybody who
> > wants to emulate windows or use the BIOS needs to use that for their "common
> > BIOS area" thing, iirc.
> 
> Do you mean that something like dosemu/Wine needs to be able to use GDT #8?
> Or is it only used in kernel code?

Both. I think the APM BIOS callbacks use GDT#8 too. As long as it's not 
one of the really _core_ kernel segments, that's ok (you can swap it 
around and nobody will care). But it would be a total disaster (I suspect) 
if GDT#8 was the kernel code segment, for example. Suddenly the "switch 
things around temporarily" is not as trivial any more, and involves nasty 
nasty things.

[ BUT! I haven't ever really had much to do with those BIOS callbacks, and 
  I'm too lazy to check, so this is all from memory. ]

> > See above. The kernel and user segments have to be moved as a block of four,
> > and obviously we'd like to keep them in the same cacheline too. Also, the
> > cacheline that contains segment #8/0x40 is not available,
> 
> Why's that?  That cacheline (assuming 64 byte line size) already contains the
> user/kernel/cs/ds descriptors.

Right. That's what I'm saying. We should move them all together, and we 
should keep them as aligned as they are now. 

> I'm thinking of putting together a patch to change the descriptor use to:
> 
>    8  - TLS #1
>    9  - TLS #2
>    10 - TLS #3

So I'd not be surprised if movign the TLS segments around would break 
something. 

>    11 - Kernel PDA

But you keep the four basic ones in the same place:

>    12 - Kernel CS
>    13 - Kernel DS
>    14 - User CS
>    15 - User DS

So that's obviously ok at least for _those_.

> Alternatively, maybe:
> 
>    0  - NULL
>    1  - Kernel PDA
>    2  - Kernel CS
>    3  - Kernel DS
>    4  - User CS
>    5  - User DS
>    6  - TLS #1
>    7  - TLS #2
>      
> which moves the user cs/ds, but avoids #8.

I don't like that one, exactly because now the four most common segments 
(which get accessed for all system calls) are no longer in the same 
32-byte cacheline.

[ Unless we start playing games with offsetting the GDT or something.. 
  Quite frankly, I'd rather keep it simple and obvious. ]

Now, most systems have a 64-byte cacheline these days (and some have a 
split 128-byte one), and maybe we'll never go back to the "good old days" 
with 32-byte lines, so maybe this is a total non-issue. But fitting in the 
same 32-byte aligned thing would still count as a "good thing" in my book.

That said, numbers talk, bullshit walks. If the above just works a lot 
better for all modern CPU's that all have 64-byte cachelines (because now 
_everything_ is in that bigger cacheline), and if you can show that with 
numbers, and nothing breaks in practice, then hey..

			Linus
