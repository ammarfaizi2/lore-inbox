Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbUC2Icq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 03:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUC2Icq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 03:32:46 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:44979 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262751AbUC2Icn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 03:32:43 -0500
Message-ID: <083001c41565$2844e360$fc82c23f@pc21>
From: "Ivan Godard" <igodard@pacbell.net>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
References: <048e01c413b3$3c3cae60$fc82c23f@pc21.suse.lists.linux.kernel><p73y8pm951k.fsf@nielsen.suse.de><07b501c41502$48bd4d20$fc82c23f@pc21> <20040329011416.591ad315.ak@suse.de>
Subject: Re: Kernel support for peer-to-peer protection models...
Date: Mon, 29 Mar 2004 00:09:22 -0800
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

interlinear

----- Original Message ----- 
From: "Andi Kleen" <ak@suse.de>
To: "Ivan Godard" <igodard@pacbell.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, March 28, 2004 3:14 PM
Subject: Re: Kernel support for peer-to-peer protection models...


> On Sun, 28 Mar 2004 12:21:36 -0800
> "Ivan Godard" <igodard@pacbell.net> wrote:
>
> >
> > > Maybe you can give each process an different address range, but AFAIK
> > > the only people who have done this before are users of non MMU
> > architectures.
> > > It will probably require som changes in the portable part of the code.
> > > Also porting glibc's ld.so to this will be likely no-fun.
> >
> > Each process gets a different range because each process gets a
different
> > native space. Within that space processes can use the same offsets, and
> > typically will so as to avoid pointless relocation.
>
> fork() will be hard and/or inefficient this way.

Why? The load image for the new process does not require relocation, so all
that's necessary to spawn a process is to allocate a spaceID, map the
excutable to that ID in the page tables, push one entry into the TLB, set a
couple of hardware registers, and insert it into the readyq. When it get's
control it will prompty fault in its code pages (if not already present),
and execution from there on is normal. This process is essentially identical
to what happens on a conventional, except because there is no aliasing of
addreses (flat unified 64-bit model) you don't have to scrub the cache or
TLB.

> > > Overall it sounds like your architecture is not very well suited to
> > > run Linux.
> >
> > We believe we can adopt the Linux protection model (i.e. the 386
protection
> > model) with no more work than any other port to a new architectire
(ahem).
>
> Just FYI - Linux has been ported to several architectures with similar
SASOS
> capabilities in hardware (IA64 or ppc64 on iseries) and they have all
opted to use
> an conventional protection model.

Do you know why? Can you point me to the people who did these ports so I can
ask?

> > So long as 1) a driver has a driver-load-time defined region of working
data
> > space; 2) has a defined code region; 3) gets its buffer addresses etc.
as
>
> Just (1) alone is a illusion - linux drivers generally work on the shared
> page pool, just like all other subsystems.

In 1) I'm talking about the driver's local state, not the pages it's trying
to fill. That local state will be in the driver's space, and protected from
interference by everybody else.

The pages (I assume) are arguments to the driver, i.e. "Fill *here*", and
the owner of the page will have exposed the page to the driver before or as
part of making the call. Or the call was "Fill some page and return it", and
the driver calls the physmem manager who allocates the page, exposes it to
the driver, and reurns the address to the driver. When the driver is done it
will hand off ownership of the page to the client.  I fully expect that the
present code for this mechanism will have to be mangled, but I suspect that
the kernel already implements some concept of "owner" for a physpage and we
can hook the ownership transfer into our model.

I hope :-)

Ivan


