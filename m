Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318355AbSHKU1g>; Sun, 11 Aug 2002 16:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318356AbSHKU1f>; Sun, 11 Aug 2002 16:27:35 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:41665 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S318355AbSHKU1e>; Sun, 11 Aug 2002 16:27:34 -0400
Message-Id: <200208112031.g7BKVHQ209420@pimout1-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       oxymoron@waste.org (Oliver Xymoron)
Subject: Re: klibc development release
Date: Sun, 11 Aug 2002 11:31:13 -0400
X-Mailer: KMail [version 1.3.1]
Cc: hpa@zytor.com (H. Peter Anvin),
       linux-kernel@vger.kernel.org (linux-kernel)
References: <200208111820.g7BIKPd172856@saturn.cs.uml.edu>
In-Reply-To: <200208111820.g7BIKPd172856@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 August 2002 02:20 pm, Albert D. Cahalan wrote:
> Oliver Xymoron writes:
> > On Sun, 11 Aug 2002, Rob Landley wrote:
> >> How about partition detection?  When initramfs goes in that's one of the
> >> things they're threatening to move to userspace.  Also lots of the
> >> hardware detection and setup (ACPI, hotplug style PCI probing...)
>
> ...
>
> > It ought not be any more tightly bound than regular libc.

"Regular" libc being glibc?  Which still supports 2.0 kernels by sacrificing 
chickens in the preprocessor, takes an insanely long time to compile (and 
with an invocation that's just a touch more complicated than "configure; 
make; make install"), and statically links "hello world" to 1.6 megabytes?

The system's libc is the glue between userspace and kernel space.  Every time 
the kernel comes up with new functionality (thread groups, 32 bit uids, 64 
bit file access...), userspace can't access it until libc gets up to speed.  
Pretending your libc isn't related to the kernel at all and can easily port 
to HP-UX and netbsd is just a recipe for bloat if you ask me.  Sometimes, 
being too generic is a BAD thing.

Personally, I question the klibc work a bit because it's reinventing the 
wheel with projects like uclibc already mostly there.  But Al pointed out the 
license issue with static linking against LGPL libraries, and in any case a 
stripped down minimalist libc as a reference implementation for others to 
build on is probably a good thing.  My interest in the libc area is a bit off 
to one side: I'm not fond of glibc and am looking to replace it in my own 
system, but it hasn't made it to the top of my to-do list yet.  (Dietlibc is 
straight GPL: it can't even be the dynamic replacement for glibc in a real 
world linux distribution.  HPA suggested I look at newlibc, which I've added 
to my to-do list).

> Isn't that the
> > point? If it still depends on non-generic services in the kernel, then we
> > haven't succeeded in pulling it all the way into userspace.
>
> Klibc is a neat hack, but makes little sense. In the end we wind up
> with _more_ code to maintain, not less. The boot process becomes
> more complicated too.

>From one perspective a little more complicated, but from another perspective 
a lot more understandable.  A lot more people understand userspace than 
understand kernel space, and a LOT more people are competent to hack 
userspace than kernel space.  (100 times as many people, at LEAST.  Even 
pinning down the order of magnitude depends on your definition of 
"competent", on both sides...)

> A microkernel by any other name still smells. :-)

A microkernel has multiple processes committing incest (ahem, "cooperating") 
spending all their time passing messages to each other, racing, and 
deadlocking on their own attempts at communication and synchronization.

Initramfs has a bunch of userspace processes initializing the system, but 
they mostly run one after the other in series and don't have to communicate 
with each other any more than the components of your average shell script.  
Basically, it takes the concept of init scripts and puts some of them before 
"init".  That isn't microkernel thinking, shell scripts are bog standard unix 
philosophy.

> Not all of us have 2 GHz boxes BTW.

My 133 mhz Dell laptop recently died, and got replaced by a 366 mhz toshiba.  
Woo, blazing speed.  My home desktop's still a pentium pro 180.  (I LIKE 
developing on slow machines: it makes you notice inefficient code and care 
about fixing it.  I have a 700 mhz athlon at work.  It's a file server.)

I'm kind of surprised people think an ACPI interpreter is going to depend on 
completely generic userspace services, but I suppose it takes all kinds.  (I 
can't say I'm an expert on ACPI, but from what I understand neither is 
anybody else, including Intel.)  And of course if you write devicefs so you 
can expose your device tree largely for power management purposes, and then 
retroactively call it a standard userspace service so you don't feel guilty 
when your ACPI interpreter interacts with it...  I'm all for it, it's a 
better API overall, but there's a bit of putting Descartes before the horse 
in there somewhere saying ACPI in userspace depends on generic services that 
are generic and exposed to userspace in part because you wanted to put ACPI 
in userspace long before the infrastructure to do so existed... :)

> Moving partition code out of the kernel is just begging for bugs
> and limited functionality. The EVMS people have the right idea.
> Does anyone else remember the user-space isapnp disaster? I do.
> Users everywhere were screaming "my sound card won't work".

The external pcmcia add-on package wasn't much fun either, and that required 
building against your kernel source directory...

Define "out of the kernel".  Looking at it one way, the nvidia driver is "out 
of kernel", even though it's a driver.  Looking at it another way, menuconfig 
is in-kernel.  It's in the tarball...

Doing stuff in process context can be very nice.  We have plenty of hybrid 
kernel/userspace things already: anything that shows up in ps with square 
brackets around it.  Initramfs puts more of the init-time stuff in process 
context, and the real REASON for doing this is again: more people grok 
userspace than grok an environment with spinlocks and preemption counts, 
where scheduling and swapping are not your friend, your stack is tiny, it's 
difficult to access the filesystem, you have to worry about what operations 
might conceivably block, reference counting and race conditions abound, you 
have to care about the difference between a virtual address and a physical 
one and then there's highmem and mapping to a PCI bus address...

There's simply a lot less to screw up in userspace.

That said, decoupling the reference implementation of the initramfs boot 
scripts from the kernel tarball is a seperate issue.  Thinking "we don't have 
to maintain that stuff, when it breaks somebody else will fix it" sounds fun, 
but is not always the world's most effective strategy.  If it stops being 
broken on a regular basis by new development, fine.  But I for one would 
prefer to wait for it to stabilize BEFORE trying to fork it off too far.

Of course it's not my call...

Rob
