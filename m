Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268382AbRGXR2w>; Tue, 24 Jul 2001 13:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268381AbRGXR2m>; Tue, 24 Jul 2001 13:28:42 -0400
Received: from sncgw.nai.com ([161.69.248.229]:44247 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S268380AbRGXR2i>;
	Tue, 24 Jul 2001 13:28:38 -0400
Message-ID: <XFMail.20010724103157.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.33.0107240949460.29448-100000@penguin.transmeta.com>
Date: Tue, 24 Jul 2001 10:31:57 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: user-mode port 0.44-2.4.7
Cc: Andrea Arcangeli <andrea@suse.de>, Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jan Hubicka <jh@suse.cz>,
        Jonathan Lundell <jlundell@pobox.com>,
        Alexander Viro <viro@math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On 24-Jul-2001 Linus Torvalds wrote:
> But it shouldn't optimize it that way _every_ time. You only want the
> specific optimizations in specific places. Which is why you use
> "barrier()" or volatile in the _code_, not the data declaration.
> 
> For example, if you're holding a lock that protects it or you otherwise
> know that nothing is touching it at the same time, you do NOT want to have
> the compiler generate bad code.
> 
> And trust me, "volatile" generates _bad_ code a lot more often than it
> generates correct code.
> 
> Look at this:
> 
>       volatile int i;
>       int j;
> 
>       int main()
>       {
>               i++;
>               j++;
>       }
> 
> turning into this:
> 
>       main:
>               movl i,%eax
>               incl %eax
>               movl %eax,i
>               incl j
>               ret
> 
> Now, ask yourself why? The two _should_ be the same. Both do a
> read-modify-write cycle. But the fact is, that when you add "volatile" to
> the register, it really tells gcc "Be afraid.  Be very afraid. This user
> expects some random behaviour that is not actually covered by any
> standard, so just don't ever use this variable for any optimizations, even
> if they are obviously correct. That way he can't complain".

This is a too simple case, this is maybe better :

        mov homer, %edx
        ...
        ...
        ...
        ... ( 101 asm ins )
loop:
        cmp %edx, ...
        ja out
        ...
        inc %edx
        ...
        jmp loop

You're right, it might be optimized with a barrier() but it's all kind of how
much times you're going to need one behaviour or the other.
When I'll need most of my access to be "strict" I'd like to have a way that avoid
me to spread the code with barries()s.


> Also note how the "incl j" instruction is actually _better_ from a
> "atomicity" standpoint than the "load+inc+store" instruction. In this
> case, adding a "volatile" actually made the accesses to "i" be _less_
> likely to be correct - you could have had an interrupt happen in between
> that also updated "i", and got lost when we wrote the value back.

Not that much if you look at how incl is "decomposed" internally ( w/o LOCK )
by the CPU. If you really care about  j  you need an atomic op here, in any case.





- Davide

