Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261816AbSJIOnZ>; Wed, 9 Oct 2002 10:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261809AbSJIOnZ>; Wed, 9 Oct 2002 10:43:25 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10373 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261816AbSJIOnX>; Wed, 9 Oct 2002 10:43:23 -0400
Date: Wed, 9 Oct 2002 10:49:57 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "J.A. Magallon" <jamagallon@able.es>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Writable global section?
In-Reply-To: <20021009142458.GA2243@werewolf.able.es>
Message-ID: <Pine.LNX.3.95.1021009103521.3016B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, J.A. Magallon wrote:

> 
> On 2002.10.09 Richard B. Johnson wrote:
> >
> > 
> > When using shared libraries, is there a ".section" into which
> > I can put a variable that's writable? I note that when programs
> > that use shared libraries start, the pages are mprotect(ed)
> > PROT_READ|PROT_EXEC, but sometimes I see PROT_WRITE on some
> > pages.
> > 
> > I'd like to rip out a memory-mapped semiphore and put it directly
> > in a shared library if possible.
> > 
> 
> A library can define global variables visible to others, has its own BSS:
> 
> int x;
> 
> void f()
> {
> }
> 
> built with gcc -shared, and nm'ed gives:
> 
> 00000694 T f
> 000017f8 B x
> 000016f8 D y
> 
> from man nm:
>   "B" The symbol is in the uninitialized data section (known as BSS).
>   "D" The symbol is in the initialized data section.
>   "T" The symbol is in the text (code) section.
> 
> Was about this or I misunderstood you ?

No. You did not misunderstand. If I declare a variable and put it
into a shared library, I seem to get one of two different behaviors.

If the variable is initialized, it goes into the ".data" section.
If the variable is not initialized, it goes into the ".bss" section.
Non-writable strings go into ".rodata"

In the case of data in the .bss section, if one procedure writes to
this variable, it is not seen by other procedures that are linked
to the shared library. However it can write with no problem and it
can read what it wrote. Apparently ".bss" data are not really allocations
in shared memory, only a promise to allocate some data when the program
is loaded and this data is not shared, it's private to the process.

If a variable is in the ".data" section, it is "seen" by all procedures
that are linked to the shared library, but any attempt to write to this
variable will seg-fault the task that attempts to modify it.

I would like to be able to write to that variable and have it seen
by other tasks, since shared memory is shared memory. It's a shame
to mmap a shared library upon startup and then have to mmap some
additional shared memory for some inter-process communication.

So, is there a "section" that, when mmapped by the loader will
not protect it from writes?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

