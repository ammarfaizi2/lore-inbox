Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318876AbSHQV00>; Sat, 17 Aug 2002 17:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318877AbSHQV00>; Sat, 17 Aug 2002 17:26:26 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:22454 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318876AbSHQV0Z>; Sat, 17 Aug 2002 17:26:25 -0400
Date: Sat, 17 Aug 2002 14:27:34 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: 32 bit arch with lots of RAM
Message-ID: <2218410796.1029594453@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.44.0208170953190.3062-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208170953190.3062-100000@home.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Assume 3 level page tables and a 3/1 user/kernel split for the sake 
>> of argument.
> 
> No, no, that's the wrong way to go about it. You have to show a 
> _portable_ way to do it, not a "if I assume this, I can do it".

All I was doing was trying to illustrate that it's actually possible.
I wasn't actually proposing doing it like this, there's probably 
better ways. Much less was I expecting you to like it - hell, I don't 
like it either ;-) So when I go on below to try to prove that it
does work ... don't think I'm trying to sell it ;-)

Maybe this was Washer's idea, maybe it wasn't ... we talked this
over a lot for NUMA kernel text replication and I can't remember 
who came up with it, to be perfectly honest. He might be happier 
denying it anyway ;-)

> Basic issue: if the VM's aren't _identical_ (in every way, including the 
> kernel one), they cannot share the page tables in an SMP environment with 
> two threads running on two CPU's at the same time.

True ... to an extent. They can't share PGDs.
 
> And once you cannot share the page tables, you're screwed. 

OK, firstly, I won't deny it's an arch specific hack. But ...

I don't think you're screwed, as long as you never have to update 
the part that's split. Under the ia32 PAE mode, that's pretty much 
going to be the case, as long as all PMDs are incarnated all the 
time, which they're going to be anyway - there's text segment in the 
first Gb, libraries in the second, stack in the third, and kernel 
in the fourth. If for some reason that wasn't true, you'd just 
create the blank PMD anyway.

So we have split the PGD per task, but the PMDs and PTEs for user
space are all still shared, which is all that matters, because 
that's all we ever have to update. The PMD for kernel space is not
shared, but we never update that either.

> For example, on x86 with the regular 2-level page tables, if you 
> want to have different kernel mappings, you have to copy the 
> page directory per-CPU, and then on task switch you have to change 
> the PGD appropriately.

Right, it doesn't work for 2 level pagetables very well. But I
can't see people without PAE actually wanting it. In fact, I don't
know of anyone but large ia32 PAE machines who'd want it ... would
be interested to hear about anyone else who's got this sort of
virtual address space pressure.

> Which, btw, means that you have to invalidate the TLB for that CPU, even
> if you would otherwise not have needed to. Look at how the lazy TLB
> switching works, and realize that two threads can _switch_ CPU's as things
> stand now, without ever a single TLB invalidate happening. They can take 
> over the TLB of the other thread when they move to another CPU. You'd 
> break that, horribly and fundamentally.

Yup, I know that, and I won't deny it's horrible ;-) Would be much
nicer if we had a flush_tlb_range that worked on that chip, but still.
Not good for heavy threading. But bear in mind the alternative we
were talking about (well, Ben was talking about, and you didn't want
to talk about ;-)) is TLB flushing every system call, not every
context switch between threads. Personally, I think that's worse.

> It just sounds really messy to me.

It is ;-) Implementing it vaguely cleanly would be hard. But I still
think it's an intriguing concept ... the other problem I've been 
looking at is kernel text replication for ia32, and that's hard too.
This actually solves both problems, which is probably the only feather
in its cap. If anyone has any other ways to solve the replication
problem I'd be most interested ... (people muttered things about using
segmentation once in a dark and dingy corner, but refuse to admit who
they were).

M.

