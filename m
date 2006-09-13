Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWIMAMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWIMAMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 20:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030421AbWIMAMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 20:12:31 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:45283 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030417AbWIMAMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 20:12:31 -0400
In-Reply-To: <1158096125.3337.14.camel@localhost.localdomain>
References: <1157947414.31071.386.camel@localhost.localdomain> <1157965071.23085.84.camel@localhost.localdomain> <1157966269.3879.23.camel@localhost.localdomain> <1157969261.23085.108.camel@localhost.localdomain> <m1pse17hzi.fsf@ebiederm.dsl.xmission.com> <1158040605.15465.70.camel@localhost.localdomain> <m1d5a17g5u.fsf@ebiederm.dsl.xmission.com> <1158045200.15465.94.camel@localhost.localdomain> <8A2F9DF4-1A17-454C-8243-8F86CF04F763@kernel.crashing.org> <1158096125.3337.14.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3F3A70F8-3DEE-4B1D-9C49-7A2EBC50156C@kernel.crashing.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] MMIO accessors & barriers documentation
Date: Wed, 13 Sep 2006 02:12:09 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Or you do the sane thing and just not allow two threads of execution
>> access to the same I/O device at the same time.
>
> Why ? Some devices are designed to be able to handle that...

Sure, but not many -- and even then, you normally get a separate
MMIO area to write to for each thread.  Not really differrnt.

>> Now compare this with the similar scenario for "normal" MMIO, where
>> we do store;sync (or sync;store or even sync;store;sync) for every
>> writel() -- exactly the same problem.
>
> What problem ? "Normal" MMIO doesn't get combined, thus there is no
> problem. Of course there is no guarantee of ordering of the stores  
> from
> the 2 CPUs unless there is a spinlock etc etc... but we are talking
> about a case where that is acceptable here. Howver, combining is not.

As an example, the first access might set off a DMA, and the 2nd MMIO
interferes.  That's not necessarily acceptable.  Now you might point
me to the spinlock again, but I'll just point you right back to your
original example, because that's my whole point.

>> Better lock at a higher level than just per instruction.
>>
>> Some devices that want to support multiple clients at the same time
>> have multiple identical "register files", one for each client, to
>> prevent this and other problems (and it's useful anyway).
>
> Yes, they do, and what happen if those register "files" happen to be
> consecutive in the address space and the CPU suddenly combines a store
> to the last register of one "file" and an unrelated store from another
> thread to the first register of the other ?

That's why those devices rely on the CPU's not combining over the edges
of (typically) 4kB pages.

> This is a very specific problem that has nothing to do with your  
> "grand
> general case"

Oh I have no "grand general case", my main argument still is to have
accessors _per bus_ (per bus type really, archs can make it more  
specific
if they want).

In the "grand general case", you have to do lowest-common-denominator
for everything, and you're increasingly forcing yourself into that
corner.

>>> Anyway, let's not pollute this discussion with that too much now :)
>>
>> Au contraire -- if you're proposing to hugely invasively change some
>> core interface, and add millions of little barriers(*), you better
>> explain how this is going to help us tackle the problems (like WC)  
>> that
>> we are starting to see already, and that will be a big deal in the
>> near future.
>
> No, this is totally irrelevant.

"The (near) future [and it's only not right now because Linux is  
dragging
behind] is totally irrelevant, only my current this-second itch is?"

> I'm proposing a simple change (nothing
> invasive there) to the MMIO accessors of weakly ordered platforms  
> only,
> to make them guarantee ordering like x86 etc...

Please explain what drivers will need changes because of this.  Not just
the few you really care about, but _all_ that could be plugged into  
PowerPC
machines' PCI busses, and might need changes because of changing the
ordering semantics of readX()/writeX() from the supposed standard Linux
semantics (i.e., the x86 semantics).

> and I'm proposing the
> -addition- (which is not something I would cause invasive) of -one-
> class of partially relaxed accessors and the -few- (damn, there are  
> only
> 4 of them) barriers that precisely match the semantics that drivers
> need. Oh, and make sure those semantics are well defined or they are
> useless.

Erm, wait a minute, I might start to understand now...  You want all
drivers that you care about to be converted to use __readX()/__writeX()
instead?  How is this going to help, exactly?

> This has strictly nothing to do with WC and mixing things up will only
> confuse the discussion and guarantee that we'll never get anything  
> done.

No, it _has_ to do with WC.  If the Linux I/O API is going to be  
changed/
amended/expanded/mot du jour, we better do it in such a way that we will
get a positive outlook on the problems that we will have to face next  
(or
in this case, that we should be handling already really).

> <snip useless digression>

Very constructive.


Segher

