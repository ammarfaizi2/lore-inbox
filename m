Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbULLJsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbULLJsr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 04:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbULLJsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 04:48:47 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:62835 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262064AbULLJse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 04:48:34 -0500
Message-ID: <41BC13ED.8020809@yahoo.com.au>
Date: Sun, 12 Dec 2004 20:48:29 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Christoph Lameter <clameter@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
    tests
References: <Pine.LNX.4.44.0412120914190.3476-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0412120914190.3476-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Sun, 12 Dec 2004, Nick Piggin wrote:
> 
>>Christoph Lameter wrote:
>>
>>>On Thu, 9 Dec 2004, Hugh Dickins wrote:
>>
>>>>probably others (harder to think through).  Your 4/7 patch for i386 has
>>>>an unused atomic get_64bit function from Nick, I think you'll have to
>>>>define a get_pte_atomic macro and use get_64bit in its 64-on-32 cases.
>>>
>>>That would be a performance issue.
>>
>>Problems were pretty trivial to reproduce here with non atomic 64-bit
>>loads being cut in half by atomic 64 bit stores. I don't see a way
>>around them, unfortunately.
> 
> 
> Of course, it'll only be a performance issue in the 64-on-32 cases:
> the 64-on-64 and 32-on-32 macro should reduce to exactly the present
> "entry = *pte".
> 

That's right, yep. There is no ordering requirement, only that
the actual store and load be atomic.

> I've had the impression that Christoph and SGI have to care a great
> deal more about ia64 than the others; and as x86_64 advances, so
> i386 PAE grows less important.  Just so long as a get_64bit there
> isn't a serious degradation from present behaviour, it's okay.
> 

I don't think it was particularly serious for PAE. Probably not
worth holding off until 2.7. We'll see.

> Oh, hold on, isn't handle_mm_fault's pmd without page_table_lock
> similarly racy, in both the 64-on-32 cases, and on architectures
> which have a more complex pmd_t (sparc, m68k, h8300)?  Sigh.
> 

Can't comment on a specific architecture... some may have problems.
I think i386 prepopulates pmds, so it is no problem; but generally:

I think you can get away with it if you write the "unimportant"
word(s) first, do a wmb(), then write the word containing the
present bit. I guess this has to be done this way otherwise the
hardware walker will blow up...

Of course, the hardware walker would be doing either atomic or
correctly ordered reads, while a plain dereference doesn't
guarantee anything.

I'm not sure of the history behind the code, but I would be in
favour of making _all_ pagetable access go through accessor
functions, even if nobody quite needs them yet.
