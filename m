Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWEMQVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWEMQVX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 12:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWEMQVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 12:21:23 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:51094 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S932472AbWEMQVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 12:21:22 -0400
Date: Sat, 13 May 2006 18:21:13 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Avi Kivity <avi@argo.co.il>
cc: Martin Mares <mj@ucw.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
In-Reply-To: <444DD0E7.5070005@argo.co.il>
Message-ID: <Pine.LNX.4.64.0605112329370.8568-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Apr 2006, Avi Kivity wrote:

> [...]
> Haskell is an excellent language, but it is not a system programming
> language. Kernel programming does not fit well into the functional model.

I find it really funny you say that. I have been thinking about what
language would be the most suitable for writing a kernel in and I find
that _functional_  languages ought to do the trick.

The essential thing about functional languages is that they use copy on
write. You never modify a piece of memory but make new copy with the
changes. Doesn't that remind you of RCU? Yes, you don't need locks! This
is essential when dealing with the future computers which will have lots
of CPU cores. Ofcourse, when accessing a piece of hardware you can't take
a copy and you would need a lock around the hardware access.
And ofcourse, you will need to make a small runtime system with
garbage-collection. The choice there would be C. So the kernel would
consist of assembler, C and an almost functional language like OCaml.
The strong typing and the lack of pointer arithmetic would also silence
any talks about microkernels.

But dreaming asside and back to the real world and the original thread:

I have experience with C and C++ at the system level and I do a little
Linux kernel hacking as a hobby. I want to push Linux in the embedded
system area because even the very high end RTOS we use at work sucks in
many ways.
But although that RTOS is written in C, it does have the ability to load
modules written in C++.  It doesn't have any userspace so every
application is loaded  directly into the kernel - and applications
are very often written in C++.

I think one ought to be able to write kernel modules in C++ as well. Many
companies now running their own home-made "OS"  - typically written in
assambler and C++ - are considering switching to  Linux. One of the
tumbling blocks is that they can not reuse their drivers as they would
have to be ported _back_ to C. A lot of people find that redicoulus and would
findanother OS just because of that. Remember that many, many people out there
think that when you say "C", you really mean C++. For them old flat C is
simply not existing anymore.

Now I don't think the main line kernel tree should include modules written
in C++. I have in the past "converted" a mud from being compiled with gcc
to being compiled with g++. It worked fine for me but after that it was
much harder for others to participate in the project. I wouldn't admit it
at that time; but now I see that it could very well have raised the level
of entry by a lot. C++ is simply very _hard_ to learn.

That said I have a lot of fun coding C++ at work. Many companies use
C++ because you really are more productive than in C. (Another reason is
that in the Windows world code generators like flex, rpcgen etc. are frowned
upon as they are not "standeard" and are hard to fit into build
environment. Therefore terrible stuff like Spirit is invented.
C++  hackers want to do everything within C++ and can't imagine writing
scripts and small code generators for generating all the trivial C code.
That latter often gives a better result, too, because you can only do 95%
with templates.)

But I find C++ basicly broken. It wants to be both high and lowlevel.
It doesn't have garbage collection; but it is almost impossible to make
the semi-manual memory management work 100%. It works 99.9% so it is
acceptable for most uses but not in a OS kernel.

And like Lisp wants to do with macros, C++ wants to make the coder create
his own syntax with operator overloading and templates. That often makes
the code totally unreadable for the causual reader. C++ encourages programmers
to do this stuff but 90% of the time it is done, it shouldn't have been
done. A language feature which is abused 90% of the time is bad no matter
what beautifull things can be done with it.
It is fine that you sort of can make your own "language" for your specific
perpose, but it is a huge mistake to mix the language definitions with the
actual program. It ought to be layered, so you first take your basic
compiler, make your extentions/modifications and then use that compiler on
your program. Then those modifications can be well thought over before
being applied.

And like in all OO languages you need a complete UML diagram before you can
read the code. In C I can usually find what I am looking for in even large
projects like Linux with just grep and less; but for OO languages you need
tools which can actually parse and understand the code to help you find
the relevvant functions/methods for you. grep can simply not do it because
a lot of functions/methods have identical names.

I understand why people are using C++, but I think it is a dead end. Stay
with C or go to a true highlevel language. Even Microsoft have figured
that out now; but because they have pushed C++ for years a lot of people
use C++ today without even thinking it is possible to use plain C - or
anything else. I think it is worth for the Linux community to meet them half
way and make it possible to compile C++ modules to the kernel, but
disallow actual C++ in the official kernel tree.

This his is how the RTOS I mentioned supports C++ modules by the way:

All public headers are wrapped with

#ifdef __cplusplus
extern "C" {
#endif
...
#ifdef __cplusplus
}
#endif

and no C++ keywords are used. No inline functions are present so no
actual code from the header files have to be compiled with the C++
compiler.

To initialize global and static constructors first the module is compiled
into a tmp.o. This is now searched for such constructors using nm. A
function which calls them all is now generated in a auto.c.
The final module is tmp.o and auto.o combined. The OS simply calls the
generated function if the module has successfully been linked.

Merging a patch fixing the header files and modifying modpost to also call
constructors wouldn't destroy anything for the Linux kernel and make it
possible to make C++ modules as long as one avoids exceptions.

Doing exceptions in the kernel would be much harder but doable - but it
might make a runtime overhead which isn't acceptable. But maybe a config
option enabling them could be tolerated.


Esben


