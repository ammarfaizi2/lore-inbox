Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUC1GvS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 01:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbUC1GvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 01:51:18 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:34956 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262079AbUC1GvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 01:51:12 -0500
Message-ID: <06ea01c4148e$67436c80$fc82c23f@pc21>
From: "Ivan Godard" <igodard@pacbell.net>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <048e01c413b3_3c3cae60_fc82c23f@pc21> <20040327103401.GA589@openzaurus.ucw.cz> <066b01c41464$7e0ec9c0$fc82c23f@pc21> <20040328062422.GB307@elf.ucw.cz>
Subject: Re: Kernel support for peer-to-peer protection models...
Date: Sat, 27 Mar 2004 22:32:06 -0800
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
From: "Pavel Machek" <pavel@ucw.cz>
To: "Ivan Godard" <igodard@pacbell.net>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Saturday, March 27, 2004 10:24 PM
Subject: Re: Kernel support for peer-to-peer protection models...


> Hi!
>
> On So 27-03-04 17:32:06, Ivan Godard wrote:
> > > > 1) had a large number of distinguishable address spaces
> > > > 2) any running code had two of these (code and data environment) it
> > could
> > > > use arbitrarily, but access to addresses in others was arbitrarily
> > protected
> > > > 3) flat, unified virtual addresses (64 bit) so that pointers,
including
> > > > inter-space pointers, have the same representation in all spaces
> > >
> > > Hmm, will it be possible to have UML?
> >
> > If by UML you mean Uniform Modelling Language, I don't understand where
the
> > protection model has any impact. UML models flow, permissions are
somewhat
> > superimposed, just like file permissions in a UML model on any
> > machine.
>
> I meant "User Mode Linux" == linux running under linux. Someone
> probably has an URL.

Sorry - I plead ignorance :-)  As the protection is recursive and
transitive, I suppose that you could do this. When the UMK (user mode
kernel) went to change the "real" machine it would get a protection fault
that would be handled by the KMK, emulating the effect. Getting it right and
also performant would be tricky though - is UML a necessary feature?

> > > > 9) Hardware interrupts are involuntary inter-space calls. They do
not
> > > > require locking (assuming the handler is re-entrant - and if not
then
> > only
> > > > from themselves), nor task switch, nor disabling other interrupts.
The
> > > > handler runs in the stack of whoever got interrupted, which
(depending
> > on
> > > > interrupt priorities) could be another interrupt, on an interrupt,
...
> > on an
> > > > app, all mutually protected.
> > >
> > > How do you implement ptrace if apps are protected from kernel?
> >
> > Anybody can make all or part of themselves visible to anybody else. If
you
> > start up an app in your space, you can grant visibility to a debugger in
> > another space. But this applies only to you. For example, suppose that
your
> > app calls a paranoid server DLL passing in a function, and the DLL in
turn
> > calls back your function. Then your stack will have a hunk of you (that
you
> > can see and expose to the debugger), then a hunk of DLL function
activations
> > (which are opaque to you AND the debugger unless you can talk the DLL
into
> > exposing itself), and then another hunk of you again (and again visible
to
> > you and the debugger). The DLL and you (and your debugger) are mutually
> > protected.
> >
> > To do this on a conventional system requires that the DLL runs as a
server
> > process, and getting it to do something for you requires a roundtrip
through
> > the dispatcher. For us it's a simple subroutine call, just as if the DLL
> > were un-paranoid and had been linked into your code. Clearer?
>
> Strange system.... If an application does not grant kernel access to
> its space, how is kernel supposed to do its job? For example, that
> "paranoid DLL" becomes unswappable, then?

Pretection is in the *virtual* space, not physical. The physical-page
manager (who has the TLB and underlying mapping tables in its space) can see
and deal with any physical address, which in turn has the usual aliasing
relationship with virtual addresses. Of course, physical is just one of the
virtual spaces (and is distinguished solely by the one-to-one
virtual-physical mapping). So the protection can be penetrated by anyone who
can see the underlying physical page - but that's always true.


> If you have "enough" paranoid DLLs, you can then bring the machine
> down due to lack of real memory :-).

No.

> > > > 10) Drivers can have their own individual space(s) distinct from
those
> > of
> > > > the kernel and the apps. Buggy drivers cannot crash the kernel.
> > >
> > > Well... buggy drivers can usually program DMA to do crashing for them.
> >
> > Nope. The DMA has the same permissions as the driver that starts it.
>
> So normal PCI cards are not allowed, or do you have some kind of
> IOMMU?

Nope. Apertures in the memory controller. We looked at doing I/O in virtual,
but the extra traffic on the pins was too expensive (although it did permit
I/O onto paged memory). But it's easy to give each IO its own aperture base,
just by adding a few more high-order bits to the address, and the controller
can make sure that each DMA stays in its aperture. Sort of a poor-man's MMU
:-)

> > > That would be pretty big rewrite...
> > >
> > > Anyway, I believe you *do* want linux on it, if only as a test load.
> >
> > We definitely want Linux. The question is whether Linux will want the
result
> > of our port, or (in finer detail) what parts could we do in what way to
be
> > useful to other people.
>
> If most changes are in arch/, it should be acceptable...

I fear that it might be more extensive than that :-)

Ivan


