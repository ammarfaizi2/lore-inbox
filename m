Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVDEWNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVDEWNn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 18:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVDEWNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 18:13:42 -0400
Received: from smtpout.mac.com ([17.250.248.89]:56056 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261870AbVDEWLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 18:11:46 -0400
In-Reply-To: <09142f748cc6ad2bf4fffab7a5519226@xs4all.nl>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no> <524d7fda64be6a3ab66a192027807f57@xs4all.nl> <1112559934.5268.9.camel@tiger> <d5b47c419f6e5aa280cebd650e7f6c8f@mac.com> <3821024b00b47598e66f504c51437f72@xs4all.nl> <42511BD8.4060608@osvik.no> <c3057294a216d19047bdca201fc97e2f@xs4all.nl> <20050404205718.GZ8859@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.61.0504041718580.5550@chaos.analogic.com> <62f8215dd556d5a50b307f5b6d4f578b@mac.com> <d5803044b1c7dcc631eda71863d44fa2@xs4all.nl> <a2a171644af3ab214c5bc612eecc9167@mac.com> <09142f748cc6ad2bf4fffab7a5519226@xs4all.nl>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <18192dc3f079bc89f7028ed68a478f3c@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Linux kernel <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Use of C99 int types
Date: Tue, 5 Apr 2005 18:11:35 -0400
To: Renate Meijer <kleuske@xs4all.nl>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't remove Linux-Kernel from the CC, I think this is an
important discussion.

On Apr 05, 2005, at 15:17, Renate Meijer wrote:
>>> Strictly speaking, a definition starting with a double
>>> underscore is reserved for use by the compiler and associated
>>> libs
>>
>> Well, _strictly_speaking_, it's "implementation defined", where the
>> "implementation" includes the kernel (due to the syscall interface).
>
> Beg to differ. As far as i'm aware, the syscall interface is not part
> of C. Hence the kernel,  in compiler terms, is not part of "the
> implementation" of the compiler.

POSIX and such include information about signal handling and the
user-mode environment for C programs, both of which are completely
irrelevant from the compiler's point of view, including libc stuff.

>> But the C library is implicitly dependent on the kernel headers for
>> a wide variety of datatypes.
>
> Correct. It is, however, not only dependent on the definitions as
> provided by linux, but also of those provided by just about any other
> OS the compiler is running on. Which, by the last count, was a pretty
> impressive number.

I don't see how this applies.  We're only talking about the Linux
kernel here, right?

>> Well, Linus has supported that there is no standard, except where
>> ABI is concerned, there we must use __u32 so that it does not clash
>> with libc or user programs.
>
> The fact that there is no standard is not an argument against at
> least reaching some compromise. Surely 5 different names for a
> simple, generic 32-bit integer is a bit much.

Personally, I don't care what you feel like requiring for purely
in-kernel interfaces, but __{s,u}{8,16,32,64} must stay to avoid
namespace collisions with glibc in the kernel include files as used
by userspace.

>>> Especially the types with leading underscores look cool, but in
>>> reality may cause a conflict with compiler internals and should only
>>> be used when defining compiler libraries.
>>
>> It's "implementation" (kernel+libc+gcc) defined.
>
> I don't think the kernel has any place in that list.
>
> <quote>
>        3.10
>        [#1] implementation
>        a  particular  set  of  software,  running  in  a particular
>        translation environment under  particular  control  options,
>        that  performs  translation  of  programs  for, and supports
>        execution  of   functions   in,   a   particular   execution
>        environment
> </quote>

This is kinda arguing semantics, but:
A particular set of software (linux+libc+gcc), running in a particular
translation environment (userspace) under particular control options
(Signals, nice values, etc), that performs translation of programs for
(emulating missing instructions), and supports execution of functions
(syscalls) in, a particular execution environment (also userspace).

Without the kernel userspace wouldn't have anything, because anything
syscall-related (which is basically everything) involves the kernel.
Heck, the kernel and its ABI is _more_ a part of the implementation
than glibc is!  I can write an assembly program that doesn't link to
or use libc, but without using syscalls I can do nothing whatsoever.

That's not to say that I _like_ the way things are set up, but it's not
practical to change them at the moment.

<Wishful Thinking>
It would be nice if GCC provided a set of __gcc_foo inline definitions
for all sorts of useful functions and types, including various types of
memory barriers, sized types, etc and other platform-related garbage
that it would be good to have in the same place.  Then the kernel and
glibc could both just assume that they are there and not worry nearly
as much about what platform you're on.
</Wishful Thinking>

> But that goes only for those definitions that will eventually wind up
> in /usr/include/*, not any code internal to (say) a driver and only
> affects a minimal set of interfaces. That is, in comparison to
>
> renate@indigo:~/linux-2.6.11.6$ find . -name \*.h -exec grep __uint32 
> {} \; -print
>
> or worse
>
> renate@indigo:~/linux-2.6.11.6$ find . -name \*.c -exec grep __uint32 
> {} \; -print\
>
> On the bright side, most of it is in linux/fs/xfs so it's pretty
> localized, on the other side, none of it is related to the ABI in
> any way.

Uhh, how about:
	grep -rl __u32 . | egrep '[^:]+\.h:'
or:
	grep -rl __u32 . | egrep '[^:]+\.c:'

Both of those return a _LOT_ of stuff.

> Nope. The syscall interface is employed by the library, no more,
> no less. The C standard does not include *any* platform specific
> stuff.

Which is why it reserves __ for use by the implementation so it can
play wherever it wants.

> Quite on purpose, by the way. Not all the world is a linux machine
> and an AVR doesn't even have syscalls.

But when I write my framebuffer library, I do:
#include <linux/fb.h>
#include <stdlib.h>
And I expect it to work!  I want it to get the correct types, I
don't want it to clash with or require the libc types (My old
sources might redefine some stdint.h names, and I don't want it
to clash with my user-defined types.

> Anything you like. 'kernel_' or simply 'k_' would be appropriate.
> As long as you do not invade compiler namespace. It is separated
> and uglyfied for a purpose.

But the _entire_ non _ namespace is reserved for anything user
programs want to do with it.  I think most of the kernel types in
the current headers use __kernel_, which is safe enough.

> Does not work when you are touching externally defined interfaces
> in general, including that of a CPU.  There are places for uint32_t
> and friends and even for __uint32_t and it's kin, but abusing them
> will cause trouble in a world that is accommodating more than one
> register-size. This is all I am saying.

But in a world with more than one register size, you _must_ use them,
for example, the x86-64 code uses them to handle 32-bit backwards
compatibility, and the ppc64 code does likewise.  When a program
compiled as ppc32 gets run on my ppc64 box, the kernel understands
that anything pushed onto the stack as arguments is 32-bit, and must
use specifically sized types to handle that properly.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


