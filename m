Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUC1Uql (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbUC1UqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:46:19 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:21728 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262208AbUC1Uns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:43:48 -0500
Message-ID: <07b501c41502$48bd4d20$fc82c23f@pc21>
From: "Ivan Godard" <igodard@pacbell.net>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
References: <048e01c413b3$3c3cae60$fc82c23f@pc21.suse.lists.linux.kernel> <p73y8pm951k.fsf@nielsen.suse.de>
Subject: Re: Kernel support for peer-to-peer protection models...
Date: Sun, 28 Mar 2004 12:21:36 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Andi Kleen" <ak@suse.de>
To: "Ivan Godard" <igodard@pacbell.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, March 26, 2004 10:29 PM
Subject: Re: Kernel support for peer-to-peer protection models...


> "Ivan Godard" <igodard@pacbell.net> writes:
>
> > We're a processor startup with a new architecture that we will be
porting
> > Linux to. The bulk of the port will be straightforward (well, you know
what
> > I mean), except for the protection model supported by the hardware.  How
> > would you extend/mod the kernel if you had hardware that:
> >
> > 1) had a large number of distinguishable address spaces
>
> Large or unlimited? If not unlimited you may still run into
> problems when you give each process such an address space.
> Limiting the number of processes is probably not an option.

Large but not unlimited - tens of thousands. Think PIDs. The number of
threads (sharing common address spaces) is not limited.

> > 2) any running code had two of these (code and data environment) it
could
> > use arbitrarily, but access to addresses in others was arbitrarily
protected
> > 3) flat, unified virtual addresses (64 bit) so that pointers, including
> > inter-space pointers, have the same representation in all spaces
>
> You mean Address 0 is only accessible from Address space 0, but not
> from Space 1 ?

A field in a (64 bit) pointer gives the address space number. Each space has
an "address 0" which is actually the zeroth byte *in that space* - an actual
pointer is a space number and an index in that space. You (i.e. a process)
run with a native space that determines your priveledges. If you are running
as space 0 then you may or may not be able to address space 1 - it depends
on the access you inherited or have obtained. Think mmap. You (almost)
always can address all your native space, although there might not be
anything there.

> Maybe you can give each process an different address range, but AFAIK
> the only people who have done this before are users of non MMU
architectures.
> It will probably require som changes in the portable part of the code.
> Also porting glibc's ld.so to this will be likely no-fun.

Each process gets a different range because each process gets a different
native space. Within that space processes can use the same offsets, and
typically will so as to avoid pointless relocation.

> > 4) no "supervisor mode"
> > 5) inter-space references require grant of access (transitive) by the
> > accessed space; grants can be entire space or any contiguous subspace
>
> Sounds like the only sane way to handle (4) would be to give the kernel
> an own address space with the necessary grants to access everything.
> However this will require an address space switch for every system call.
> But there is no way around it, linux requires a "shared" kernel mapping
> at least for part of the kernel memory ("lowmem")

We could (trivially) emulate a monolithic kernel in a single space. But that
loses the reliability improvement available if the kernel subsystens ran in
their own spaces with grants of access to those common structures they
individually needed. BTW, there's nothing to be gained by minimizing address
switches - it's in hardware, and inter-space references and calls run at the
same speed as same-space references and calls.

> Overall it sounds like your architecture is not very well suited to
> run Linux.

We believe we can adopt the Linux protection model (i.e. the 386 protection
model) with no more work than any other port to a new architectire (ahem).
But the result would also be as prone to bugs and exploits as a 386 too.

> > 10) Drivers can have their own individual space(s) distinct from those
of
> > the kernel and the apps. Buggy drivers cannot crash the kernel.
>
> At least you would need to use your own drivers (I believe the IBM
> iSeries and s390/VM port does it kind of). If your CPU has generic PCI
> slots this will be a lot of work. Without it it will be lots of work too,
> but at least the number of drivers required is limited.

So long as 1) a driver has a driver-load-time defined region of working data
space; 2) has a defined code region; 3) gets its buffer addresses etc. as
arguments; 4) calls defined OS APIs; and 5) never touches anything except
its private code and data, its arguments, and syscalls then it can run in
one of our protected environments and be none the wiser. That is, if the
driver has been coded to look like a well behaved server process then all is
well. If it has hard references to shared kernel data structures then it
will break, because those shared spaces are not visible and must be accessed
through a service call to someone who owns that structure.

> > Is this model so alien to the existing Kernel that the best approach is
to
>
> It is definitely alien.

You don't know the half of it! This is just the protection model :-)

Ivan


