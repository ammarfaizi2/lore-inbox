Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUC1Bua (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 20:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbUC1Bua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 20:50:30 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:51924 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262052AbUC1BuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 20:50:25 -0500
Message-ID: <066b01c41464$7e0ec9c0$fc82c23f@pc21>
From: "Ivan Godard" <igodard@pacbell.net>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <048e01c413b3_3c3cae60_fc82c23f@pc21> <20040327103401.GA589@openzaurus.ucw.cz>
Subject: Re: Kernel support for peer-to-peer protection models...
Date: Sat, 27 Mar 2004 17:32:06 -0800
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

Interlinear

----- Original Message ----- 
From: "Pavel Machek" <pavel@ucw.cz>
To: "Ivan Godard" <igodard@pacbell.net>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Saturday, March 27, 2004 2:34 AM
Subject: Re: Kernel support for peer-to-peer protection models...


> Hi!
>
> > 1) had a large number of distinguishable address spaces
> > 2) any running code had two of these (code and data environment) it
could
> > use arbitrarily, but access to addresses in others was arbitrarily
protected
> > 3) flat, unified virtual addresses (64 bit) so that pointers, including
> > inter-space pointers, have the same representation in all spaces
>
> Hmm, will it be possible to have UML?

If by UML you mean Uniform Modelling Language, I don't understand where the
protection model has any impact. UML models flow, permissions are somewhat
superimposed, just like file permissions in a UML model on any machine.

> > 4) no "supervisor mode"
>
> Is all your i/o memory mapped?

Yes, and also those few machine operations that are "priveledged".

> > 5) inter-space references require grant of access (transitive) by the
> > accessed space; grants can be entire space or any contiguous subspace
> > 6) inter-space reference has same performance as intra-space
>
> Huh? Does it mean that all the accesses are horibly slow?

No, they run at full regular memory speed, at all levels of the memory
heirarchy.  Because of the flat unified address space, all caches can be in
virtual (this is common in 64-bit address systems) because a pointer means
the same thing no matter who uses it. A consequence is that you don't have
to cache scrub on task switch, which is a big time win.

> > 9) Hardware interrupts are involuntary inter-space calls. They do not
> > require locking (assuming the handler is re-entrant - and if not then
only
> > from themselves), nor task switch, nor disabling other interrupts. The
> > handler runs in the stack of whoever got interrupted, which (depending
on
> > interrupt priorities) could be another interrupt, on an interrupt, ...
on an
> > app, all mutually protected.
>
> How do you implement ptrace if apps are protected from kernel?

Anybody can make all or part of themselves visible to anybody else. If you
start up an app in your space, you can grant visibility to a debugger in
another space. But this applies only to you. For example, suppose that your
app calls a paranoid server DLL passing in a function, and the DLL in turn
calls back your function. Then your stack will have a hunk of you (that you
can see and expose to the debugger), then a hunk of DLL function activations
(which are opaque to you AND the debugger unless you can talk the DLL into
exposing itself), and then another hunk of you again (and again visible to
you and the debugger). The DLL and you (and your debugger) are mutually
protected.

To do this on a conventional system requires that the DLL runs as a server
process, and getting it to do something for you requires a roundtrip through
the dispatcher. For us it's a simple subroutine call, just as if the DLL
were un-paranoid and had been linked into your code. Clearer?

> > 10) Drivers can have their own individual space(s) distinct from those
of
> > the kernel and the apps. Buggy drivers cannot crash the kernel.
>
> Well... buggy drivers can usually program DMA to do crashing for them.

Nope. The DMA has the same permissions as the driver that starts it.

> How is your architecture called?

"Mill"

> > dealing with protection models, interrupts, trap handling and the like?
What
> > about partitioning the kernel into disjoint (and mutually protected)
> > components like IP stack, password/security, FS etc?
>
> That would be pretty big rewrite...
>
> Anyway, I believe you *do* want linux on it, if only as a test load.

We definitely want Linux. The question is whether Linux will want the result
of our port, or (in finer detail) what parts could we do in what way to be
useful to other people.

Ivan


