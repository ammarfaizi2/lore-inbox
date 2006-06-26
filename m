Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWFZLWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWFZLWO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 07:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWFZLWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 07:22:14 -0400
Received: from mx1.pretago.de ([89.110.132.150]:33710 "EHLO mx1.pretago.de")
	by vger.kernel.org with ESMTP id S965004AbWFZLWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 07:22:12 -0400
To: arjan@infradead.org
Subject: Re: ia32 binfmt problem with x86-64
From: lists@gammarayburst.de
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-MimeOLE: Produced by Confixx WebMail
X-Mailer: Confixx WebMail (like SquirrelMail)
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Message-Id: <20060626112210.307DB1A04006@prtg1.pretago.de>
Date: Mon, 26 Jun 2006 13:22:10 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2006-06-26 at 01:43 +0200, Markus Schoder wrote:
> > The 32 bit emulation for x86-64 has the following in
> > arch/x86_64/ia32/ia32_binfmt.c:
> >
> > #define elf_read_implies_exec(ex, have_pt_gnu_stack)	  \
> >   (!(have_pt_gnu_stack))
> >
> > I guess it should be same definition as in include/asm-i386/elf.h
and
> > include/asm-x86_64/elf.h instead:
> >
> > #define elf_read_implies_exec(ex, executable_stack) \
> >   (executable_stack != EXSTACK_DISABLE_X)
> >
> > >From the usage in fs/binfmt_elf.c it looks like the semantics of
that
> > macro changed slightly but was not fixed in all places (ia64 seems
to
> > have a similar problem from the looks of it).
> >
> > The current behavior leads to 32 bit executables not setting the
> > READ_IMPLIES_EXEC personality when they are marked as requiring an
> > executable stack (64 bit executables do however).
>
> Hi,
>
> regardless of the inconsistency you found; I think the behavior is
> correct. "Legacy" binaries get read-implies-exec (since that is the
old
> behavior), "new" binaries get "we honor the stack you set". Why should
> read-implies-exec be set when an application asks for an executable
> stack? I disagree that it should be set; the application should just
use
> the proper PROT_EXEC flags for its allocations; now it's not an option
> to fix legacy apps (the ones without the pt_gnu_stack marker), but for
> new things for sure is/was; this has been the case for the last... 3+
> years already.

This all makes sense. But 64 bit and 32 bit apps should get the same
treatment right? Currently 64 bit apps get read_implies_exec with
exec_stack but 32 bit apps do not. Obviously the 64 bit behaviour is the
intended one this is clear from the comments in the code for
elf_read_implies_exec.

I don't feel very strongly about which way it is fixed. Biggest problem
is probably that developers on non NX boxes do not even see a problem if
they get the exec flag wrong.

> So... fix the app ! (and.. which app is this ?)

It is the demo of the newly released game by linuxgamepublishing Gorky
17. Don't know wether it is in the full version as well but it seems
likely.

Anyway I care more about the kernel getting fixed.

I guess I can put a personality wrapper in place to force
read_implies_exec for individual apps anyway.

--
Markus


