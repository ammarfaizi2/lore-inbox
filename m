Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWCZPX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWCZPX2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 10:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWCZPX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 10:23:28 -0500
Received: from smtpout.mac.com ([17.250.248.85]:56033 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751319AbWCZPX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 10:23:27 -0500
In-Reply-To: <1143383968.3064.16.camel@laptopd505.fenrus.org>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <20060326065416.93d5ce68.mrmacman_g4@mac.com> <1143376351.3064.9.camel@laptopd505.fenrus.org> <A6491D09-3BCF-4742-A367-DCE717898446@mac.com> <1143383968.3064.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C01BCBB9-8A65-4602-A26E-4468062D6AA4@mac.com>
Cc: linux-kernel@vger.kernel.org, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI	header	infrastructure
Date: Sun, 26 Mar 2006 10:23:04 -0500
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2006, at 09:39:28, Arjan van de Ven wrote:
>> According to the various standards all symbols beginning with __  
>> are reserved for "The Implementation", including the compiler, the  
>> standard library, the kernel, etc.  In order to avoid clashing  
>> with any/all of those, I picked the __KABI_ and __kabi_ prefixes  
>> for uniqueness.  In theory I could just use __, but there are  
>> problems with that too.  For example, note how the current  
>> compiler.h files redefine __always_inline to mean something kinda  
>> different.
>
> well... the "problem" is there today, and... it's not much of a  
> problem if at all; there's just a few simple rules to keep it that  
> way which seem to work.

The current rules work for things kept completely private to the  
kernel.  If we start exporting things into the guts of libc, we can  
expect that those guys have _also_ been using all sorts of double- 
underscore symbols in conflicting ways.

> And your __alway_inline example.. that's something that really is  
> kernel internal and shouldn't be exposed to userland.

Yes, but it illustrates how a supposedly-innocuous double-underscore  
symbol actually conflicts with a GCC builtin, and that's just GCC!   
That's not including the massive "The Implementation" codebase that  
is GLIBC.

> 2) avoid including kernel headers in kernel headers as far as  
> possible.  This means, that if an application wants to use MTD  
> struct "struct mtd_foo" it will have to include the MTD header, but  
> that he otherwise never gets it. Eg all such symbols are in a "Yes  
> I really want it" header.

This is Hard(TM).  Take a look at the interdependent mess which is  
kernel.h, or sched.h.  Feel free to submit patches :-D  That's  
actually part of the reason why I'm trying this kabi/*.h bit.  I  
think that if I can pull out userspace-required struct definitions  
from the rest of the code, we'll notice that some of the header files  
don't need as many dependencies anymore and can be cleaned out a bit.

I've also been looking at GCC's "precompiled header" stuff.  I think  
that a single kabi.h file that includes all other kabi headers,  
precompiled to "kabi.h.gch", could potentially speed up a portion of  
the linux kernel build by removing a lot of text parsing.  I can't  
tell for sure till I've cleaned up more crap and done benchmarks, but  
I'm willing to give it a shot. :-D

Cheers,
Kyle Moffett

