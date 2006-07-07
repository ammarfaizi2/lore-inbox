Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWGGUjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWGGUjj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 16:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWGGUjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 16:39:39 -0400
Received: from khc.piap.pl ([195.187.100.11]:31687 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932231AbWGGUji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 16:39:38 -0400
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <arjan@infradead.org>
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <20060705114630.GA3134@elte.hu>
	<20060705101059.66a762bf.akpm@osdl.org>
	<20060705193551.GA13070@elte.hu>
	<20060705131824.52fa20ec.akpm@osdl.org>
	<Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
	<20060705204727.GA16615@elte.hu>
	<Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
	<20060705214502.GA27597@elte.hu>
	<Pine.LNX.4.64.0607051458200.12404@g5.osdl.org>
	<Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
	<20060706081639.GA24179@elte.hu>
	<Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
	<Pine.LNX.4.64.0607060856080.12404@g5.osdl.org>
	<Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
	<Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
	<m34pxt8emn.fsf@defiant.localdomain>
	<Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 07 Jul 2006 22:39:35 +0200
In-Reply-To: <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com> (linux-os@analogic.com's message of "Fri, 7 Jul 2006 15:51:11 -0400")
Message-ID: <m3odw16tfc.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

>> 00000000 <funct>:
>>   0:   a1 00 00 00 00          mov    0x0,%eax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   5:   55                      push   %ebp
>>   6:   89 e5                   mov    %esp,%ebp
>>   8:   85 c0                   test   %eax,%eax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   a:   8d b6 00 00 00 00       lea    0x0(%esi),%esi
>>  10:   75 fe                   jne    10 <funct+0x10>
>>  12:   5d                      pop    %ebp
>>  13:   c3                      ret
>>
>> "0x0" is, of course, for relocation.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> So read the code; you have "10:   jne 10", jumping to itself
> forever, without even doing anything else to set the flags, much
> less reading a variable.

The variable is tested before entering the loop, of course. But
it _is_ tested and the initial state doesn't matter.
The "0x0" may be misleading so I added the note about relocation.

It _is_ BTW correct machine code.

>> 00000000 <funct>:
>>   0:   55                      push   %ebp
>>   1:   89 e5                   mov    %esp,%ebp
>>   3:   a1 00 00 00 00          mov    0x0,%eax
>>   8:   85 c0                   test   %eax,%eax
>>   a:   75 f7                   jne    3 <funct+0x3>
>>   c:   5d                      pop    %ebp
>>   d:   c3                      ret
>
> This is the only code that works. Guess why it worked? Because
> you declared the variable volatile.

Of course. But I don't see any address recalculations.

> Now Linus declares that instead of declaring an object volatile
> so that it is actually accessed every time it is referenced, he wants
> to use a GNU-ism with assembly that tells the compiler to re-read
> __every__ variable existing im memory, instead of just one. Go figure!

That's probably overkill, I can think of more cases where "volatile"
actually makes sense. Most are probably broken anyway, especially
those that aren't (guaranteed to be) atomic but the author uses them
as if they were.

BTW: barrier() isn't a lock.
-- 
Krzysztof Halasa
